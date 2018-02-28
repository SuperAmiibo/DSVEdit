
GAME = "aos"
REGION = :usa
LONG_GAME_NAME = "Aria of Sorrow"

AREA_LIST_RAM_START_OFFSET = 0x08001990 # Technically not a list, this points to code that has the the area hard coded, since AoS only has one area.

AREA_INDEX_TO_OVERLAY_INDEX = {
  0 => {
     0 => nil,
     1 => nil,
     2 => nil,
     3 => nil,
     4 => nil,
     5 => nil,
     6 => nil,
     7 => nil,
     8 => nil,
     9 => nil,
    10 => nil,
    11 => nil,
    12 => nil,
  }
}

AREAS_OVERLAY = nil

AREA_INDEX_TO_AREA_NAME = {
   0 => "Dracula's Castle"
}

SECTOR_INDEX_TO_SECTOR_NAME = {
   0 => {
     0 => "Castle Corridor",
     1 => "Chapel",
     2 => "Study",
     3 => "Dance Hall",
     4 => "Inner Quarters",
     5 => "Floating Garden",
     6 => "Clock Tower",
     7 => "Underground Reservoir",
     8 => "The Arena",
     9 => "Top Floor",
    10 => "Forbidden Area",
    11 => "Chaotic Realm",
    12 => "Hardcoded rooms",
  }
}

HARDCODED_ROOM_IDS = [
  0x085236A4, # bad end

  0x085247B4,
  0x0852484C,
  0x085248E4,
  0x0852497C,
  0x08524A24,
  0x08524ABC,
  0x08524B54,
  0x08524BEC,
  0x08524CA4,
  0x08524D3C,
  0x08524DD4,
  0x08524E5C
]

NOTHING_ENTITY_TYPE = 0
ENEMY_ENTITY_TYPE = 1
SPECIAL_OBJECT_ENTITY_TYPE = 2
CANDLE_ENTITY_TYPE = 3
PICKUP_ENTITY_TYPE = 4
PICKUP_ENTITY_GOOD_END_TYPE = 5
PICKUP_ENTITY_ALL_SOUL_TYPE = 6

ENTITY_TYPE_DESCRIPTIONS = {
  0 => "Nothing",
  1 => "Enemy",
  2 => "Special object",
  3 => "Candle",
  4 => "Pickup",
  5 => "Hard mode pickup",
  6 => "All-souls-found pickup",
}

ENEMY_IDS = (0x00..0x70).to_a
COMMON_ENEMY_IDS = (0x00..0x69).to_a
BOSS_IDS = (0x6A..0x70).to_a

BOSS_DOOR_SUBTYPE = 0x02
BOSS_ID_TO_BOSS_INDEX = {
  0x21 => 0x0B, # Creaking Skull
  0x36 => 0x0A, # Manticore
  0x3C => 0x0F, # Great Armor
  0x45 => 0x0C, # Big Golem
  0x6A => 0x04, # Headhunter
  0x6B => 0x01, # Death
  0x6C => 0x05, # Legion
  0x6D => 0x06, # Balore
  0x6E => 0x02, # Belmont
  0x6F => 0x00, # Graham
  0x70 => 0x07, # Chaos
}

WOODEN_DOOR_SUBTYPE = 0x00

AREA_NAME_SUBTYPE = nil

SAVE_POINT_SUBTYPE = 0x1C

COLOR_OFFSETS_PER_256_PALETTE_INDEX = 16

ENEMY_DNA_RAM_START_OFFSET = 0x080E9644
ENEMY_DNA_FORMAT = [
  # length: 36
  [4, "Create Code"],
  [4, "Update Code"],
  [2, "Item 1"],
  [2, "Item 2"],
  [2, "HP"],
  [2, "MP"],
  [2, "EXP"],
  [1, "Soul Rarity"],
  [1, "Attack"],
  [1, "Defense"],
  [1, "Item 1 Rarity"],
  [1, "Item 2 Rarity"],
  [1, "Soul Type"],
  [1, "Soul"],
  [1, "Unknown 11"],
  [2, "Weaknesses", :bitfield],
  [2, "Resistances", :bitfield],
  [2, "Unknown 12"],
  [2, "Unknown 13"],
  [2, "Unknown 14"],
]
ENEMY_DNA_BITFIELD_ATTRIBUTES = {
  "Weaknesses" => [
    "Slash",
    "Flame",
    "Water",
    "Thunder",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Stone",
    "Weakness 10",
    "Weakness 11",
    "Killer Mantle",
    "Weakness 13",
    "Weakness 14",
    "Weakness 15",
    "Weakness 16",
  ],
  "Resistances" => [
    "Slash",
    "Flame",
    "Water",
    "Thunder",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Stone",
    "Resistance 10",
    "Time Stop",
    "Resistance 12",
    "Resistance 13",
    "Resistance 14",
    "Resistance 15",
    "Resistance 16",
  ],
}

TEXT_LIST_START_OFFSET = 0x08506B38
TEXT_RANGE = (0..0xB4E)
TEXT_REGIONS = {
  "Character Names" => (0..0xA),
  "Events" => (0xB..0x5A),
  "Item Names" => (0x5B..0xE2),
  "Red Soul Names" => (0xE3..0x119),
  "Unused Blue Soul Name" => (0x11A..0x11A),
  "Blue Soul Names" => (0x11B..0x132),
  "Yellow Soul Names" => (0x133..0x155),
  "Ability Soul Names" => (0x156..0x15B),
  "Item Descriptions" => (0x15C..0x1E3),
  "Red Soul Descriptions" => (0x1E4..0x21A),
  "Unused Blue Soul Description" => (0x21B..0x21B),
  "Blue Soul Descriptions" => (0x21C..0x233),
  "Yellow Soul Descriptions" => (0x234..0x256),
  "Ability Soul Descriptions" => (0x257..0x25C),
  "Enemy Names" => (0x25D..0x2CD),
  "Enemy Descriptions" => (0x2CE..0x33E),
  "Menus" => (0x33F..0x392),
  "Music Names" => (0x393..0x3AF),
  "Menus 2" => (0x3B0..0x3B6),
  "Uncategorized" => (0x3B7..0x3C3),
  "French" => (0x3C4..0xB87),
  "German" => (0x788..0xB4B),
  "Language Names" => (0xB4C..0xB4E),
}
TEXT_REGIONS_OVERLAYS = {
  "Character Names" => nil,
  "Events" => nil,
  "Item Names" => nil,
  "Red Soul Names" => nil,
  "Unused Blue Soul Name" => nil,
  "Blue Soul Names" => nil,
  "Yellow Soul Names" => nil,
  "Ability Soul Names" => nil,
  "Item Descriptions" => nil,
  "Red Soul Descriptions" => nil,
  "Unused Blue Soul Description" => nil,
  "Blue Soul Descriptions" => nil,
  "Yellow Soul Descriptions" => nil,
  "Ability Soul Descriptions" => nil,
  "Enemy Names" => nil,
  "Enemy Descriptions" => nil,
  "Menus" => nil,
  "Music Names" => nil,
  "Menus 2" => nil,
  "Uncategorized" => nil,
  "French" => nil,
  "German" => nil,
  "Language Names" => nil,
}
STRING_DATABASE_START_OFFSET = 0x080EA72C
STRING_DATABASE_ORIGINAL_END_OFFSET = 0x0811664E
STRING_DATABASE_ALLOWABLE_END_OFFSET = STRING_DATABASE_ORIGINAL_END_OFFSET
TEXT_COLOR_NAMES = {
  0x00 => "TRANSPARENT",
  0x01 => "WHITE",
  0x02 => "GREY",
  0x03 => "PINK",
  0x04 => "BROWN",
  0x05 => "AZURE",
  0x06 => "DARKBLUE",
  0x07 => "YELLOW",
  0x08 => "ORANGE",
  0x09 => "LIGHTGREEN",
  0x0A => "GREEN",
  0x0B => "BRIGHTPINK",
  0x0C => "PURPLE",
  0x0D => "BROWN2",
  0x0E => "BLACK",
  0x0F => "BLACK2",
}

SPECIAL_OBJECT_IDS = (0..0x37)
SPECIAL_OBJECT_CREATE_CODE_LIST = 0x084F0DF8
SPECIAL_OBJECT_UPDATE_CODE_LIST = 0x084F0ED8

ITEM_LOCAL_ID_RANGES = {
  0x02 => (0x00..0x1F), # consumable
  0x03 => (0x00..0x3A), # weapon
  0x04 => (0x00..0x2C), # armor
}
ITEM_GLOBAL_ID_RANGE = (0..0x87)
SKILL_GLOBAL_ID_RANGE = (0x88..0xFA)
SKILL_LOCAL_ID_RANGE = nil # souls in AoS are split into multiple different types.
PICKUP_GLOBAL_ID_RANGE = (0..0xFA)

PICKUP_SUBTYPES_FOR_ITEMS = (0x02..0x04)
PICKUP_SUBTYPES_FOR_SKILLS = (0x05..0xFF)

NEW_GAME_STARTING_AREA_INDEX_OFFSET = nil
NEW_GAME_STARTING_SECTOR_INDEX_OFFSET = 0x084F0D8C
NEW_GAME_STARTING_ROOM_INDEX_OFFSET = 0x084F0D8D
NEW_GAME_STARTING_X_POS_OFFSET = 0x084F0D92
NEW_GAME_STARTING_Y_POS_OFFSET = 0x084F0D94

GAME_TRANSMIT_ROOM_OFFSET = 0x080B6F30

TRANSITION_ROOM_LIST_POINTER = 0x0850E968
FAKE_TRANSITION_ROOMS = []

ITEM_ICONS_PALETTE_POINTER = 0x082099FC
GLYPH_ICONS_PALETTE_POINTER = nil
ITEM_ICONS_GFX_POINTERS = [0x081C5E00, 0x081C7E04, 0x081C9E08]

CONSUMABLE_FORMAT = [
  # length: 16
  [2, "Item ID"],
  [2, "Icon"],
  [4, "Price"],
  [1, "Type"],
  [1, "Unknown 1"],
  [2, "Var A"],
  [4, "Unused"],
]
WEAPON_FORMAT = [
  # length: 28
  [2, "Item ID"],
  [2, "Icon"],
  [4, "Price"],
  [1, "Attack Type"],
  [1, "Unknown 1"],
  [1, "Attack"],
  [1, "Defense"],
  [1, "Strength"],
  [1, "Constitution"],
  [1, "Intelligence"],
  [1, "Luck"],
  [2, "Effects & Modifiers", :bitfield],
  [1, "GFX Index"],
  [1, "Sprite Index"],
  [1, "Unknown 2"],
  [1, "Palette"],
  [1, "Swing Anim"],
  [1, "IFrames"],
  [2, "Swing Sound"],
  [2, "Unknown 3"],
]
ARMOR_FORMAT = [
  # length: 20
  [2, "Item ID"],
  [2, "Icon"],
  [4, "Price"],
  [1, "Type"],
  [1, "Unknown 1"],
  [1, "Attack"],
  [1, "Defense"],
  [1, "Strength"],
  [1, "Constitution"],
  [1, "Intelligence"],
  [1, "Luck"],
  [2, "Resistances", :bitfield],
  [1, "Unknown 2"],
  [1, "Unknown 3"],
]
RED_SOUL_FORMAT = [
  # length: 16
  [4, "Code"],
  [2, "Use anim"],
  [2, "Mana cost"],
  [1, "Max at once"],
  [1, "Unknown 1"],
  [2, "DMG multiplier"],
  [2, "Effects & Modifiers", :bitfield],
  [2, "Var A"],
]
BLUE_SOUL_FORMAT = [
  # length: 12
  [4, "Code"],
  [1, "Mana cost"],
  [1, "Hold or Press R"],
  [2, "Unknown 1"],
  [4, "Player effect/Varies"],
]
YELLOW_SOUL_FORMAT = [
  # length: 12
  [4, "Code"],
  [2, "Unknown 1"],
  [2, "Stat to raise"],
  [4, "Player effect/Stat pts"],
]
JULIUS_SKILL_FORMAT = RED_SOUL_FORMAT
ITEM_TYPES = [
  {
    name: "Consumables",
    list_pointer: 0x08505B3C,
    count: 0x20,
    format: CONSUMABLE_FORMAT # length 16
  },
  {
    name: "Weapons",
    list_pointer: 0x08505D3C,
    count: 0x3B,
    format: WEAPON_FORMAT # length 28
  },
  {
    name: "Armor",
    list_pointer: 0x085063B0,
    count: 0x2D,
    format: ARMOR_FORMAT # length 20
  },
  {
    name: "Red Souls",
    list_pointer: 0x080E1598,
    count: 0x38,
    kind: :skill,
    format: RED_SOUL_FORMAT # length: 16
  },
  {
    name: "Blue Souls",
    list_pointer: 0x080E192C,
    count: 0x19,
    kind: :skill,
    format: BLUE_SOUL_FORMAT # length: 12
  },
  {
    name: "Yellow Souls",
    list_pointer: 0x080E1B08,
    count: 0x24,
    kind: :skill,
    format: YELLOW_SOUL_FORMAT # length: 12
  },
  {
    name: "Julius Skills",
    list_pointer: 0x080E1ED8,
    count: 0x4,
    kind: :skill,
    format: JULIUS_SKILL_FORMAT # length: 16
  },
]
ITEM_BITFIELD_ATTRIBUTES = {
  "Effects & Modifiers" => [
    "Slash",
    "Flame",
    "Water",
    "Thunder",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Stone",
    "Unknown 10",
    "Unknown 11",
    "Killer Mantle",
    "Half damage",
    "No interrupt on land",
    "Unknown 15",
    "Unknown 16",
  ],
  "Resistances" => [
    "Slash",
    "Flame",
    "Water",
    "Thunder",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Stone",
    "Unknown 10",
    "Unknown 11",
    "Unknown 12",
    "Unknown 13",
    "Unknown 14",
    "Unknown 15",
    "Unknown 16",
  ],
}

OVERLAY_FILE_FOR_ENEMY_AI = {}
REUSED_ENEMY_INFO = {
  0x07 => {init_code: 0x08070AC4}, # killer fish
  0x08 => {init_code: 0x081193DC}, # bone pillar
  0x0B => {init_code: 0x08077C40}, # white dragon
  0x0F => {init_code: 0x08075660, palette_offset: 1}, # siren -> harpy
  0x10 => {palette_offset: 1}, # tiny devil
  0x11 => {init_code: 0x08093178}, # durga -> curly
  0x12 => {palette_offset: 1}, # rock armor
  0x13 => {init_code: 0x0807E2CC}, # giant ghost
  0x15 => {init_code: 0x080B0AD4}, # minotaur
  0x17 => {init_code: 0x0807A970}, # arachne
  0x19 => {palette_offset: 1}, # evil butcher
  0x1C => {init_code: 0x08089A50, palette_offset: 1}, # catoblepas
  0x21 => {init_code: 0x08098E00}, # creaking skull
  0x22 => {init_code: 0x08081128, palette_offset: 2, gfx_sheet_ptr_index: 1, ignore_part_gfx_page: true}, # wooden golem
  0x25 => {palette_offset: 1}, # lilith -> succubus
  0x2B => {palette_offset: 1}, # curly
  0x2D => {palette_offset: 1}, # red crow -> blue crow
  0x2E => {init_code: 0x080BBFF0}, # cockatrice
  0x30 => {init_code: 0x08091430, palette_offset: 2}, # devil
  0x35 => {init_code: 0x08081128, gfx_sheet_ptr_index: 1, ignore_part_gfx_page: true}, # golem
  0x36 => {init_code: 0x0807406C}, # manticore
  0x37 => {init_code: 0x080864A0, palette_offset: 1}, # gremlin => gargoyle
  0x3C => {init_code: 0x0808E024}, # great armor
  0x3E => {init_code: 0x080AD7F0}, # giant worm
  0x41 => {init_code: 0x081193EC}, # fish head
  0x43 => {init_code: 0x08087D24}, # triton
  0x45 => {init_code: 0x080AD1D0}, # big golem
  0x47 => {init_code: 0x080AD7F0, palette_offset: 1}, # poison worm
  0x48 => {init_code: 0x08091430}, # arc demon
  0x49 => {init_code: 0x080B7E80, sprite: 0x0824A334}, # cagnazzo
  0x4A => {palette_offset: 1}, # ripper
  0x4B => {init_code: 0x0807968C}, # werejaguar
  0x50 => {init_code: 0x08081128, palette_offset: 3, ignore_part_gfx_page: true}, # flesh golem
  0x54 => {init_code: 0x0807968C, palette_offset: 1}, # weretiger
  0x58 => {init_code: 0x080B0AD4, palette_offset: 1}, # red minotaur
  0x5B => {init_code: 0x080B7E80, palette_offset: 2, sprite: 0x0824A8E0}, # skull millione
  0x5C => {init_code: 0x08098E00, palette_offset: 1}, # giant skeleton
  0x5D => {init_code: 0x080A1BEC}, # gladiator
  0x60 => {init_code: 0x08099430}, # mimic
  0x61 => {init_code: 0x0809C4E4}, # stolas
  0x62 => {init_code: 0x0806E714, palette_offset: 1}, # erinys -> valkyrie
  0x63 => {init_code: 0x080B7E80, palette_offset: 1, sprite: 0x0824A334}, # lubicant
  0x64 => {init_code: 0x080BBFF0, palette_offset: 1}, # basilisk
  0x65 => {init_code: 0x08081128, palette_offset: 1, gfx_sheet_ptr_index: 1, ignore_part_gfx_page: true}, # iron golem
  0x66 => {init_code: 0x08091430, palette_offset: 1}, # demon lord
  0x67 => {init_code: 0x0808E024, palette_offset: 1}, # final guard
  0x68 => {init_code: 0x08091430, palette_offset: 3}, # flame demon
  0x69 => {init_code: 0x0808E024, palette_offset: 2}, # shadow knight
  0x6A => {gfx_wrapper: 0x08118F00, sprite: 0x0821C190, palette: 0x0820A780}, # headhunter
  0x6B => {gfx_wrapper: 0x08119498}, # death
  0x6C => {gfx_wrapper: 0x081190C0, sprite: 0x082258fc, palette: 0x0820AC4C}, # legion
  0x6D => {gfx_wrapper: 0x081193FC, sprite: 0x08244220}, # balore
  0x6E => {gfx_wrapper: 0x08119520}, # julius
  0x6F => {init_code: 0x0811870C}, # graham
  0x70 => {gfx_wrapper: 0x081191CC, palette: 0x0820AD70}, # chaos
}
ENEMY_FILES_TO_LOAD_LIST = nil
BEST_SPRITE_FRAME_FOR_ENEMY = {
  0x00 => 0x03,
  0x01 => 0x06,
  0x06 => 0x11,
  0x07 => 0x08,
  0x0E => 0x07,
  0x10 => 0x04,
  0x16 => 0x10,
  0x17 => 0x1D,
  0x21 => 0x16,
  0x22 => 0x01,
  0x2A => 0x07,
  0x30 => 0x05,
  0x36 => 0x03,
  0x3C => 0x0E,
  0x3D => 0x08,
  0x3E => 0x07,
  0x48 => 0x07,
  0x4D => 0x0A,
  0x50 => 0x10,
  0x51 => 0x09,
  0x5C => 0x16,
  0x60 => 0x0D,
  0x65 => 0x02,
  0x66 => 0x08,
  0x67 => 0x11,
  0x68 => 0x05,
  0x69 => 0x12,
  0x6A => 0x02,
  0x6B => 0x33,
  0x6C => 0x34,
  0x70 => 0x02,
}
BEST_SPRITE_OFFSET_FOR_ENEMY = {}

COMMON_SPRITE = {desc: "Common", sprite: 0x0820ED60, gfx_files: [0x081C15F4], palette: 0x082099FC, palette_offset: 3}

OVERLAY_FILE_FOR_SPECIAL_OBJECT = {}
REUSED_SPECIAL_OBJECT_INFO = {
  0x00 => {init_code: 0x0804D8F0}, # wooden door
  0x01 => {init_code: 0x08033254}, # pushable crate TODO: sprite file can't be found, gfx and palette are fine
  0x02 => COMMON_SPRITE.merge(palette_offset: 2),
  0x03 => COMMON_SPRITE.merge(palette_offset: 2),
  0x04 => COMMON_SPRITE.merge(palette_offset: 2),
  0x05 => COMMON_SPRITE,
  0x06 => {init_code:         -1}, # darkness door
  0x07 => {init_code:         -1},
  0x08 => {init_code: 0x08526004},
  0x09 => {init_code: 0x08526004},
  0x0C => {init_code:         -1},
  0x0E => {init_code: 0x08526214}, # destructible
  0x0F => COMMON_SPRITE,
  0x12 => {init_code:         -1}, # multiple different background visuals
  0x1C => {palette_offset: 1},
  0x1F => {init_code: 0x08055BE0, palette_offset: 2},
  0x20 => {init_code:         -1},
  0x29 => {init_code: 0x085264D0, palette_offset: 6},
  0x2A => {init_code: 0x085264D0, palette_offset: 6},
  0x2D => {palette_offset: 2},
  0x2E => {palette_offset: 5},
  0x32 => {palette_offset: 1},
  0x34 => {palette_offset: 2},
  0x36 => {init_code:         -1},
}
SPECIAL_OBJECT_FILES_TO_LOAD_LIST = nil
BEST_SPRITE_FRAME_FOR_SPECIAL_OBJECT = {
  0x00 => 0x01,
  0x02 => 0x3F,
  0x03 => 0x3F,
  0x04 => 0x3F,
  0x05 => 0x7D,
  0x0F => 0x4A,
  0x1B => 0x02,
  0x1C => 0x0C,
  0x1D => 0x0B,
  0x1F => 0x0A,
  0x24 => 0x05,
  0x26 => 0x02,
  0x34 => 0x03,
}
BEST_SPRITE_OFFSET_FOR_SPECIAL_OBJECT = {
  0x00 => {x: -8},
}

OTHER_SPRITES = [
  COMMON_SPRITE,
  
  # soma sprite 080E11C4
  # soma gfx 081717CC or maybe 081674B8 or maybe 081664B4
  # soma's gfx list is around 080E11E0?
  # palette is either 082097D4 (his palette is also the first in 0820B164 but that's not used?)
  
  {desc: "Breakable walls 1", pointer: 0x08526004},
  {desc: "Breakable walls 2", pointer: 0x08526010},
  {desc: "Breakable walls 3", pointer: 0x0852601C},
  {desc: "Breakable walls 4", pointer: 0x08526028},
  {desc: "Breakable walls 5", pointer: 0x08526034},
  {desc: "Breakable walls 6", pointer: 0x08526040},
  {desc: "Breakable walls 7", pointer: 0x0852604C},
  {desc: "Breakable walls 8", pointer: 0x08526058},
  
  {desc: "Destructible 0", pointer: 0x08526214},
  {desc: "Destructible 1", pointer: 0x08526220},
  {desc: "Destructible 2", pointer: 0x0852622C},
  {desc: "Destructible 3", pointer: 0x08526238},
  {desc: "Destructible 4", pointer: 0x08526244},
  {desc: "Destructible 5", pointer: 0x08526250},
  {desc: "Destructible 6", pointer: 0x0852625C},
  {desc: "Destructible 7", pointer: 0x08526268},
  {desc: "Destructible 8", pointer: 0x08526274},
  {desc: "Destructible 9", pointer: 0x08526280},
  {desc: "Destructible A", pointer: 0x0852628C},
  {desc: "Destructible B", pointer: 0x08526298},
  {desc: "Destructible C", pointer: 0x085262A4},
  {desc: "Destructible D", pointer: 0x085262B0},
  
  {desc: "Background window", pointer: 0x085263A8},
  {desc: "Background rushing water", pointer: 0x085263C0},
  {desc: "Background moon", pointer: 0x085263D8},
  
  {desc: "unknown", pointer: 0x085264D0},
  {desc: "unknown", pointer: 0x085264E0},
  {desc: "unknown", pointer: 0x085264F0},
  {desc: "unknown", pointer: 0x08526500},
  {desc: "unknown", pointer: 0x08526510},
  {desc: "unknown", pointer: 0x08526520},
  {desc: "unknown", pointer: 0x08526530},
  {desc: "unknown", pointer: 0x08526540},
  {desc: "unknown", pointer: 0x08526550},
  
  {desc: "xxxxxx", pointer: 0x081186C4},
  {desc: "xxxxxx", pointer: 0x081186D0},
  {desc: "Mina event actor", pointer: 0x081186DC},
  {desc: "Arikado event actor", pointer: 0x081186E8},
  {desc: "Yoko event actor", pointer: 0x081186F4},
  {desc: "Hammer event actor", pointer: 0x08118700},
  {desc: "Graham event actor", pointer: 0x08118718},
  {desc: "J", pointer: 0x08118724},
  {desc: "J 2", sprite: 0x08252748, palette: 0x0820C028, gfx_files: [0x081F42A4, 0x081F52A8, 0x081F62AC, 0x081F72B0]},
  {desc: "xxxxxx", pointer: 0x0811873C},
  {desc: "xxxxxx", pointer: 0x08118748},
  {desc: "xxxxxx", pointer: 0x08118754},
  {desc: "Somacula event actor", pointer: 0x08118760},
  
  {desc: "Giant Bat", pointer: 0x080B5C38, gfx_wrapper: 0x0811940C},
  {desc: "Chaos 2", gfx_wrapper: 0x08119224, palette: 0x0820AD70, sprite: 0x08226B58},
]

CANDLE_FRAME_IN_COMMON_SPRITE = 0x1E
MONEY_FRAME_IN_COMMON_SPRITE = 0x21
CANDLE_SPRITE = COMMON_SPRITE.merge(palette_offset: 3)
MONEY_SPRITE = COMMON_SPRITE.merge(palette_offset: 2)

WEAPON_GFX_LIST_START = 0x084F10C0
WEAPON_GFX_COUNT = 0x2F
WEAPON_SPRITES_LIST_START = 0x084F117C
WEAPON_PALETTE_LIST = 0x082098B8
SKILL_GFX_LIST_START = 0x080E13BC
SKILL_GFX_COUNT = 0x22
RED_SOUL_INDEX_TO_SKILL_GFX_INDEX = {
  0x00 => nil,
  0x01 => 0x00,
  0x02 => 0x03,
  0x03 => 0x07,
  0x04 => 0x00,
  0x05 => 0x00,
  0x06 => 0x12,
  0x07 => 0x0B,
  0x08 => 0x1F,
  0x09 => 0x07,
  0x0A => 0x15,
  0x0B => 0x00,
  0x0C => 0x15,
  0x0D => 0x18,
  0x0E => 0x00,
  0x0F => 0x04,
  0x10 => 0x10,
  0x11 => 0x14,
  0x12 => 0x01,
  0x13 => 0x01,
  0x14 => 0x0A,
  0x15 => 0x11,
  0x16 => 0x1B,
  0x17 => 0x0E,
  0x18 => 0x18,
  0x19 => 0x00,
  0x1A => 0x0C,
  0x1B => 0x20,
  0x1C => 0x16,
  0x1D => 0x11,
  0x1E => 0x07,
  0x1F => 0x17,
  0x20 => 0x21,
  0x21 => 0x0D,
  0x22 => 0x01,
  0x23 => 0x08,
  0x24 => 0x08,
  0x25 => 0x0F,
  0x26 => 0x19,
  0x27 => 0x13,
  0x28 => 0x07,
  0x29 => 0x12,
  0x2A => 0x18,
  0x2B => 0x1C,
  0x2C => 0x11,
  0x2D => 0x09,
  0x2E => 0x02,
  0x2F => 0x00,
  0x30 => 0x05,
  0x31 => 0x1D,
  0x32 => 0x1E,
  0x33 => 0x06,
  0x34 => 0x15,
  0x35 => 0x1A,
  0x36 => 0x1B,
  0x37 => 0x01,
}
BLUE_SOUL_REUSED_SPRITE_INFO = {
  0x00 => {init_code: -1}, # ---
  0x02 => {init_code: -1}, # giant bat
  0x03 => {init_code: -1}, # black panther
  0x04 => {init_code: 0x0802FE02}, # buer
  0x06 => {init_code: 0x0802FAC0}, # giant ghost
  0x0F => {init_code: -1}, # medusa head
  0x12 => {init_code: 0x0802ECFE}, # devil
  0x13 => {init_code: 0x0802ECFE}, # manticore
  0x14 => {init_code: 0x08031949}, # curly
}

MAP_TILE_METADATA_LIST_START_OFFSET = nil
MAP_TILE_METADATA_START_OFFSET = 0x08116650
MAP_TILE_LINE_DATA_LIST_START_OFFSET = nil
MAP_TILE_LINE_DATA_START_OFFSET = 0x08117DD0
MAP_LENGTH_DATA_START_OFFSET = nil
MAP_NUMBER_OF_TILES = 3008
MAP_SECRET_DOOR_LIST_START_OFFSET = nil
MAP_SECRET_DOOR_DATA_START_OFFSET = 0x081183B0
MAP_SECRET_ROOM_DATA_START_OFFSET = nil
MAP_DRAW_X_OFFSET_LOCATION = nil
MAP_DRAW_Y_OFFSET_LOCATION = nil
ABYSS_MAP_TILE_METADATA_START_OFFSET = nil
ABYSS_MAP_TILE_LINE_DATA_START_OFFSET = nil
ABYSS_MAP_NUMBER_OF_TILES = nil
ABYSS_MAP_SECRET_DOOR_DATA_START_OFFSET = nil
ABYSS_MAP_DRAW_X_OFFSET_LOCATION = nil
ABYSS_MAP_DRAW_Y_OFFSET_LOCATION = nil

WARP_ROOM_LIST_START = 0x08525FBC
WARP_ROOM_COUNT = 8

MAP_FILL_COLOR = [0, 0, 224, 255]
MAP_SAVE_FILL_COLOR = [248, 0, 0, 255]
MAP_WARP_FILL_COLOR = [248, 248, 8, 255]
MAP_SECRET_FILL_COLOR = [0, 128, 0, 255]
MAP_ENTRANCE_FILL_COLOR = [0, 0, 0, 0] # Area entrances don't exist in AoS.
MAP_LINE_COLOR = [248, 248, 248, 255]
MAP_DOOR_COLOR = [0, 200, 200, 255]
MAP_DOOR_CENTER_PIXEL_COLOR = MAP_DOOR_COLOR
MAP_SECRET_DOOR_COLOR = [248, 248, 0, 255]

AREA_MUSIC_LIST_START_OFFSET = nil
SECTOR_MUSIC_LIST_START_OFFSET = 0x084F106C
AVAILABLE_BGM_POOL_START_OFFSET = nil
SONG_INDEX_TO_TEXT_INDEX = [
  "Silence",
  0x393,
  0x394,
  0x395,
  0x396,
  0x397,
  0x398,
  0x399,
  0x39A,
  0x39B,
  0x39C,
  0x39D,
  0x39E,
  0x39F,
  0x3A0,
  0x3A1,
  0x3A2,
  0x3A3,
  0x3A4,
  0x3A5,
  0x3A7,
  0x3A8,
  0x3A9,
  "Premonition (Duplicate)",
  0x3AD,
  "Premonition (Duplicate 2)",
  0x3AB,
  0x3AC,
  "Forbidden Area (Duplicate)",
  "Prologue(Theme of Mina) (Duplicate)",
  "Hammer's Shop (Duplicate)",
  0x3A6,
  0x3AA,
  0x3AE,
  "Dracula's fate (Duplicate)",
  0x3AF,
  "You're Not Alone (Duplicate)",
  "Ambience",
  "Ambience (Duplicate)",
  "Rushing Water Ambience",
  "Ambience (Legion?)",
  "Ambience (Legion)",
  "Ambience (???)",
  "Ambience (??? 2)",
  "Ambience (??? 3)",
  "Ambience (Before Chaos)",
]

NEW_OVERLAY_ID = nil
NEW_OVERLAY_FREE_SPACE_START = nil
NEW_OVERLAY_FREE_SPACE_MAX_SIZE = nil
ASSET_MEMORY_START_HARDCODED_LOCATION = nil

ROM_FREE_SPACE_START = 0x651170
ROM_FREE_SPACE_SIZE = 0x1AEE90

TEST_ROOM_SAVE_FILE_INDEX_LOCATION = 0x08002B56
TEST_ROOM_AREA_INDEX_LOCATION      = nil
TEST_ROOM_SECTOR_INDEX_LOCATION    = 0x08002B5C
TEST_ROOM_ROOM_INDEX_LOCATION      = 0x08002B5E
TEST_ROOM_X_POS_LOCATION           = 0x08002B80
TEST_ROOM_Y_POS_LOCATION           = 0x08002B84
TEST_ROOM_OVERLAY = nil

SHOP_ITEM_POOL_LIST = 0x08526C6C
SHOP_ITEM_POOL_COUNT = 3
SHOP_ALLOWABLE_ITEMS_LIST = 0x085269FC
SHOP_NUM_ALLOWABLE_ITEMS = 0x82
SHOP_ITEM_POOL_REQUIRED_EVENT_FLAG_HARDCODED_LOCATIONS = [nil, 0x080673D2, 0x080673E4]

FAKE_FREE_SPACES = []

MAGIC_SEAL_COUNT = 0
MAGIC_SEAL_LIST_START = nil
MAGIC_SEAL_FOR_BOSS_LIST_START = nil
