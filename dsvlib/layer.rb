class Layer
  class LayerReadError < StandardError ; end
  
  attr_reader :room,
              :fs
              
  attr_accessor :layer_list_entry_ram_pointer,
                :layer_metadata_ram_pointer,
                :z_index,
                :scroll_mode,
                :opacity,
                :main_gfx_page_index,
                :bg_control,
                :visual_effect,
                :tileset_type,
                :width,
                :height,
                :tileset_pointer,
                :collision_tileset_pointer,
                :layer_tiledata_ram_start_offset,
                :tiles
  
  def initialize(room, layer_list_entry_ram_pointer, fs)
    @room = room
    @layer_list_entry_ram_pointer = layer_list_entry_ram_pointer
    @fs = fs
  end
    
  def read_from_rom
    read_from_layer_list_entry()
    read_from_layer_metadata()
    read_from_layer_tiledata()
  end
  
  def read_from_layer_list_entry
    if SYSTEM == :nds
      @z_index, @scroll_mode, @opacity, _, _, 
        @main_gfx_page_index, _, _, _,
        @layer_metadata_ram_pointer = fs.read(layer_list_entry_ram_pointer, 16).unpack("CCCCVCCCCV")
    elsif GAME == "aos"
      @z_index, @scroll_mode, @bg_control, 
        @main_gfx_page_index, _, _, _,
        @layer_metadata_ram_pointer = fs.read(layer_list_entry_ram_pointer, 12).unpack("CCvCCCCV")
      @opacity = 0x1F
    elsif GAME == "hod"
      @z_index, @visual_effect, @bg_control,
        @layer_metadata_ram_pointer = fs.read(layer_list_entry_ram_pointer, 8).unpack("CCvV")
      @main_gfx_page_index = 0 # TODO
      @scroll_mode = 0 # TODO
      @opacity = 0x1F
      if visual_effect == 0xD
        @opacity = 0x0F
      end
    end
  end
  
  def read_from_layer_metadata
    if layer_metadata_ram_pointer == 0
      # Empty GBA layer.
      @width = @height = 1
      @tileset_type =
        @tileset_pointer =
        @collision_tileset_pointer = 0
      @layer_tiledata_ram_start_offset = nil
      return
    end
    
    @width, @height, @tileset_type,
      @tileset_pointer,
      @collision_tileset_pointer,
      @layer_tiledata_ram_start_offset = fs.read(layer_metadata_ram_pointer, 16).unpack("CCvVVV")
    
    if width > 15 || height > 15
      raise LayerReadError.new("Invalid layer size: #{width}x#{height}")
    end
  end
  
  def read_from_layer_tiledata
    if layer_tiledata_ram_start_offset.nil? || layer_tiledata_ram_start_offset == 0
      # Empty GBA layer.
      @tiles = []
      (@height*SCREEN_HEIGHT_IN_TILES*@width*SCREEN_WIDTH_IN_TILES).times do
        @tiles << LayerTile.new.from_game_data(0)
      end
      return
    end
    
    tile_data_string = fs.read(layer_tiledata_ram_start_offset, SIZE_OF_A_SCREEN_IN_BYTES*width*height)
    @tiles = tile_data_string.unpack("v*").map do |tile_data|
      LayerTile.new.from_game_data(tile_data)
    end
  end
  
  def write_to_rom
    room.sector.load_necessary_overlay()
    
    # Clamp width/height to valid values.
    @width = [@width, 15].min
    @width = [@width, 1].max
    @height = [@height, 15].min
    @height = [@height, 1].max
    
    if layer_metadata_ram_pointer == 0
      # Empty GBA layer.
      old_width = old_height = 1
      
      all_tiles_blank = @tiles.all?{|tile| tile.to_tile_data == 0}
      
      # First detect if the user has changed this layer in a way that it actually needs to have free space assigned for the tile list.
      if @width == old_width && @height == old_height && @tileset_type == 0 && @tileset_pointer == 0 && @collision_tileset_pointer == 0 && @layer_tiledata_ram_start_offset == nil && all_tiles_blank
        # No changes made that require free space. Just write changes to the layer list entry and return.
        write_layer_list_entry_to_rom()
        return
      else
        # Assign layer metadata in free space.
        @layer_metadata_ram_pointer = fs.get_free_space(16, nil)
        
        if tileset_pointer == 0 && !all_tiles_blank
          # The user added tiles to this layer in Tiled but did not set the tileset pointer manually.
          # So we automatically set the tileset pointer to the first non-blank tileset in this room.
          first_layer_with_valid_tileset = room.layers.find{|layer| layer.tileset_pointer != 0}
          @tileset_pointer = first_layer_with_valid_tileset.tileset_pointer
          @tileset_type = first_layer_with_valid_tileset.tileset_type
        end
      end
    else
      old_width, old_height = fs.read(layer_metadata_ram_pointer, 2).unpack("C*")
    end
    
    if layer_tiledata_ram_start_offset.nil?
      # This is a newly added layer (or a previously empty GBA layer).
      new_tiledata_length = width * height * SIZE_OF_A_SCREEN_IN_BYTES
      
      new_tiledata_ram_pointer = fs.get_free_space(new_tiledata_length, room.overlay_id)
      
      fs.write(layer_metadata_ram_pointer+12, [new_tiledata_ram_pointer].pack("V"))
      @layer_tiledata_ram_start_offset = new_tiledata_ram_pointer
    elsif (width*height) > (old_width*old_height)
      # Size of layer was increased. Repoint to free space so nothing is overwritten.
      
      old_tiledata_length = old_width * old_height * SIZE_OF_A_SCREEN_IN_BYTES
      new_tiledata_length = width * height * SIZE_OF_A_SCREEN_IN_BYTES
      
      new_tiledata_ram_pointer = fs.free_old_space_and_find_new_free_space(layer_tiledata_ram_start_offset, old_tiledata_length, new_tiledata_length, room.overlay_id)
      
      fs.write(layer_metadata_ram_pointer+12, [new_tiledata_ram_pointer].pack("V"))
      @layer_tiledata_ram_start_offset = new_tiledata_ram_pointer
    elsif (width*height) < (old_width*old_height)
      old_tiledata_length = old_width * old_height * SIZE_OF_A_SCREEN_IN_BYTES
      new_tiledata_length = width * height * SIZE_OF_A_SCREEN_IN_BYTES
      
      fs.free_unused_space(layer_tiledata_ram_start_offset + new_tiledata_length, old_tiledata_length - new_tiledata_length)
    end
    
    if width != old_width || height != old_height
      old_width_in_blocks = old_width * SCREEN_WIDTH_IN_TILES
      width_in_blocks = width * SCREEN_WIDTH_IN_TILES
      height_in_blocks = height * SCREEN_HEIGHT_IN_TILES
      
      if old_width_in_blocks == 0
        # New layer.
        tile_rows = []
      else
        tile_rows = tiles.each_slice(old_width_in_blocks).to_a
      end
      
      # Truncate the layer vertically if the layer's height was decreased.
      tile_rows = tile_rows[0, height_in_blocks]
      
      (height_in_blocks - tile_rows.length).times do
        # Pad the layer with empty blocks vertically if layer's height was increased.
        new_row = []
        width_in_blocks.times do
          new_row << LayerTile.new.from_game_data(0)
        end
        tile_rows << new_row
      end
      
      tile_rows.map! do |row|
        # Truncate the layer horizontally if the layer's width was decreased.
        row = row[0, width_in_blocks]
        
        (width_in_blocks - row.length).times do
          # Pad the layer with empty blocks horizontally if layer's width was increased.
          row << LayerTile.new.from_game_data(0)
        end
        
        row
      end
      
      @tiles = tile_rows.flatten
    end
    
    fs.write(layer_metadata_ram_pointer, [width, height, tileset_type].pack("CCv"))
    fs.write(layer_metadata_ram_pointer+4, [tileset_pointer, collision_tileset_pointer].pack("VV"))
    write_layer_list_entry_to_rom()
    
    tile_data = tiles.map(&:to_tile_data).pack("v*")
    fs.write(layer_tiledata_ram_start_offset, tile_data)
  end
  
  def write_layer_list_entry_to_rom
    fs.write(layer_list_entry_ram_pointer, [z_index].pack("C"))
    if SYSTEM == :nds
      fs.write(layer_list_entry_ram_pointer+1, [scroll_mode].pack("C"))
      fs.write(layer_list_entry_ram_pointer+2, [opacity].pack("C"))
      fs.write(layer_list_entry_ram_pointer+6, [height*0xC0].pack("v")) if GAME == "dos"
      fs.write(layer_list_entry_ram_pointer+8, [main_gfx_page_index].pack("C"))
      fs.write(layer_list_entry_ram_pointer+12, [layer_metadata_ram_pointer].pack("V"))
    elsif GAME == "aos"
      fs.write(layer_list_entry_ram_pointer+1, [scroll_mode].pack("C"))
      fs.write(layer_list_entry_ram_pointer+2, [bg_control].pack("v"))
      #fs.write(layer_list_entry_ram_pointer+6, [height*0x100].pack("v")) # Unlike in DoS this doesn't seem necessary for jumpthrough platforms to work, but do it anyway.
      fs.write(layer_list_entry_ram_pointer+4, [main_gfx_page_index].pack("C"))
      fs.write(layer_list_entry_ram_pointer+8, [layer_metadata_ram_pointer].pack("V"))
    else # HoD
      fs.write(layer_list_entry_ram_pointer+1, [visual_effect].pack("C"))
      fs.write(layer_list_entry_ram_pointer+2, [bg_control].pack("v"))
      fs.write(layer_list_entry_ram_pointer+4, [layer_metadata_ram_pointer].pack("V"))
    end
  end
  
  def self.layer_list_entry_size
    if SYSTEM == :nds
      16
    elsif GAME == "aos"
      12
    else # HoD
      8
    end
  end
  
  def opacity
    if GAME == "aos"
      layer_index = room.layers.index(self)
      if room.color_effects & 0xC0 == 0x40 && room.color_effects & 1<<(layer_index+1) > 0
        0x0F
      else
        0x1F
      end
    elsif GAME == "hod"
      layer_index = room.layers.index(self)
      layer_controlling_visual_effect = room.layers.select{|layer| [0x0D, 0x0F].include?(layer.visual_effect)}.last
      if layer_controlling_visual_effect
        if layer_controlling_visual_effect.visual_effect == 0x0D && layer_index == 1
          0x0F
        elsif layer_controlling_visual_effect.visual_effect == 0x0F && layer_index == 0
          0x0F
        else
          0x1F
        end
      else
        0x1F
      end
    else # NDS
      @opacity
    end
  end
  
  def colors_per_palette
    if SYSTEM == :nds
      main_gfx_page = room.gfx_pages[main_gfx_page_index]
      
      if main_gfx_page
        main_gfx_page.colors_per_palette
      else
        16
      end
    else
      if bg_control & 0x80 > 0
        256
      else
        16
      end
    end
  end
  
  def tileset_filename
    if tileset_pointer == 0
      # Empty GBA layer.
      return nil
    end
    
    "%08X-%08X_%08X-%02X_%08X" % [tileset_pointer, collision_tileset_pointer, room.palette_wrapper_pointer || 0, room.palette_page_index, @room.gfx_list_pointer]
  end
end

class LayerTile
  attr_accessor :index_on_tileset,
                :horizontal_flip,
                :vertical_flip
  
  def from_game_data(tile_data)
    @index_on_tileset = (tile_data & 0b0011111111111111)
    @horizontal_flip  = (tile_data & 0b0100000000000000) != 0
    @vertical_flip    = (tile_data & 0b1000000000000000) != 0
    
    return self
  end
  
  def to_tile_data
    tile_data = index_on_tileset
    tile_data |= 0b0100000000000000 if horizontal_flip
    tile_data |= 0b1000000000000000 if vertical_flip
    tile_data
  end
end
