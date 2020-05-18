#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2020 Marcel Renner
# 
# This file is part of ALX.
# 
# ALX is free software: you can redistribute it and/or modify it under the 
# terms of the GNU General Public License as published by the Free Software 
# Foundation, either version 3 of the License, or (at your option) any later 
# version.
# 
# ALX is distributed in the hope that it will be useful, but WITHOUT ANY 
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more 
# details.
# 
# You should have received a copy of the GNU General Public License along with 
# ALX. If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle global system settings.
SYS.configure do |_s|

#------------------------------------------------------------------------------
# ALX
#------------------------------------------------------------------------------

  # Path to 'build' directory
  _s.build_dir      = expand('build')
  # Path to 'share' directory
  _s.share_dir      = expand('share')
  # Path to 'thirdparty' directory
  _s.thirdparty_dir = expand('thirdparty')

  # Required version of Ruby
  _s.ruby_version = '2.7.0'

  # Enables or disables the use of snapshots. If you disable the use of 
  # snapshots, snapshots will not be loaded and differences will not be 
  # detected, which enormously increases the total runtime.
  _s.snapshot_cache = true
  
#------------------------------------------------------------------------------
# Logging
#------------------------------------------------------------------------------

  # Enables or disables logging.
  _s.log       = true
  # Path to 'log' directory
  _s.log_dir   = expand('log')
  # Number of log files per command
  _s.log_keep  = 3
  # Severity level for log messages
  _s.log_level = 'info'
  
#------------------------------------------------------------------------------
# Game paths
#------------------------------------------------------------------------------

  # Path to 'archive' directory relative to game root
  _s.archive_dir  = 'archive'
  # Path to 'database' directory relative to game root
  _s.data_dir     = 'database'
  # Path to 'gameroot' directory relative to game root
  _s.root_dir     = 'gameroot'
  # Path to 'snapshot' directory relative to game root
  _s.snapshot_dir = 'snapshot'

  # Path to BNR file relative to game root.
  _s.bnr_file = join(_s.root_dir, 'opening.bnr')
  # Path to HDR file relative to game root.
  _s.hdr_file = join(_s.root_dir, '&&systemdata/ISO.hdr')
  # Path to IP.BIN file relative to game root.
  _s.ip_file  = join(_s.root_dir, 'IP.BIN')
  
  # Path to executable file relative to game root.
  _s.exec_file = {
    'DC' => join(_s.root_dir, '{ARES,ETERNAL,1ST_READ}.BIN'),
    'GC' => join(_s.root_dir, '&&systemdata/Start.dol'     ),
  }
  
  # Path to level data file relative to game root.
  _s.level_file = {
    'DC' => join(_s.root_dir, 'BATTLE/LEVELUP.DAT'),
    'GC' => join(_s.root_dir, 'battle/first.lmt'  ),
  }
  # Path to German SOT file relative to game root (PAL-E only).
  _s.sot_file_de = {
    'DC' => join(_s.root_dir, 'GERMAN.SOT'),
    'GC' => join(_s.root_dir, 'german.sot'),
  }
  # Path to Spanish SOT file relative to game root (PAL-E only).
  _s.sot_file_es = {
    'DC' => join(_s.root_dir, 'SPANISH.SOT'),
    'GC' => join(_s.root_dir, 'spanish.sot'),
  }
  # Path to French SOT file relative to game root (PAL-E only).
  _s.sot_file_fr = {
    'DC' => join(_s.root_dir, 'FRENCH.SOT'),
    'GC' => join(_s.root_dir, 'french.sot'),
  }
  # Path to English SOT file relative to game root (PAL-E only).
  _s.sot_file_gb = {
    'DC' => join(_s.root_dir, 'ENGLISH.SOT'),
    'GC' => join(_s.root_dir, 'english.sot'),
  }
  # Path to boss data files relative to game root. The single asterisk must be 
  # used.
  _s.eb_file = {
    'DC' => glob(_s.root_dir, 'BATTLE/EBINIT*.DAT'),
    'GC' => glob(_s.root_dir, 'battle/ebinit*.dat'),
  }
  # Path to enemy data files relative to game root. The single asterisk must 
  # be used.
  _s.ec_file = {
    'DC' => glob(_s.root_dir, 'BATTLE/ECINIT*.DAT'),
    'GC' => glob(_s.root_dir, 'battle/ecinit*.dat'),
  }
  # Path to enemy encounter files relative to game root. The single asterisk 
  # must be used.
  _s.enp_file = {
    'DC' => glob(_s.root_dir, 'FIELD/*_EP.BIN'),
    'GC' => glob(_s.root_dir, 'field/*_ep.enp'),
  }
  # Path to enemy event file relative to game root.
  _s.evp_file = {
    'DC' => join(_s.root_dir, 'BATTLE/EPEVENT.BIN'),
    'GC' => join(_s.root_dir, 'battle/epevent.evp'),
  }
  # Path to enemy ship task files relative to game root. The single asterisk 
  # must be used.
  _s.tec_file = {
    'DC' => glob(_s.root_dir, 'FIELD/R*.BIN'),
    'GC' => glob(_s.root_dir, 'field/r*.tec'),
  }

#------------------------------------------------------------------------------
# CSV paths
#------------------------------------------------------------------------------

  # Path to CSV file of accessories relative to game root
  _s.accessory_csv_file            = "#{_s.data_dir}/accessories.csv"
  # Path to CSV file of armors relative to game root
  _s.armor_csv_file                = "#{_s.data_dir}/armors.csv"
  # Path to CSV file of characters relative to game root
  _s.character_csv_file            = "#{_s.data_dir}/characters.csv"
  # Path to CSV file of character magics relative to game root
  _s.character_magic_csv_file      = "#{_s.data_dir}/charactermagics.csv"
  # Path to CSV file of character skills relative to game root
  _s.character_super_move_csv_file = "#{_s.data_dir}/charactersupermoves.csv"
  # Path to CSV file of crew members relative to game root
  _s.crew_member_csv_file          = "#{_s.data_dir}/crewmembers.csv"
  # Path to CSV file of defined strings relative to game root
  _s.defined_string_csv_file       = "#{_s.data_dir}/definedstrings.csv"
  # Path to CSV file of enemy database relative to game root
  _s.enemy_csv_file                = "#{_s.data_dir}/enemies.csv"
  # Path to CSV file of enemy events relative to game root
  _s.enemy_event_csv_file          = "#{_s.data_dir}/enemyevents.csv"
  # Path to CSV file of enemy encounters relative to game root
  _s.enemy_encounter_csv_file      = "#{_s.data_dir}/enemyencounters.csv"
  # Path to CSV file of enemy instructions relative to game root
  _s.enemy_instruction_csv_file    = "#{_s.data_dir}/enemyinstructions.csv"
  # Path to CSV file of enemy magics relative to game root
  _s.enemy_magic_csv_file          = "#{_s.data_dir}/enemymagics.csv"
  # Path to CSV file of enemy ships relative to game root
  _s.enemy_ship_csv_file           = "#{_s.data_dir}/enemyships.csv"
  # Path to CSV file of enemy ship tasks relative to game root
  _s.enemy_ship_task_csv_file      = "#{_s.data_dir}/enemyshiptasks.csv"
  # Path to CSV file of enemy skills relative to game root
  _s.enemy_super_move_csv_file     = "#{_s.data_dir}/enemysupermoves.csv"
  # Path to CSV file of enemy skills relative to game root
  _s.enemy_super_move_csv_file     = "#{_s.data_dir}/enemysupermoves.csv"
  # Path to CSV file of EXP curves relative to game root
  _s.exp_curve_csv_file            = "#{_s.data_dir}/expcurves.csv"
  # Path to CSV file of magic EXP curves relative to game root
  _s.magic_exp_curve_csv_file      = "#{_s.data_dir}/magicexpcurves.csv"
  # Path to CSV file of playable ships relative to game root
  _s.playable_ship_csv_file        = "#{_s.data_dir}/playableships.csv"
  # Path to CSV file of ship accessories relative to game root
  _s.ship_accessory_csv_file       = "#{_s.data_dir}/shipaccessories.csv"
  # Path to CSV file of ship cannons relative to game root
  _s.ship_cannon_csv_file          = "#{_s.data_dir}/shipcannons.csv"
  # Path to CSV file of ship items relative to game root
  _s.ship_item_csv_file            = "#{_s.data_dir}/shipitems.csv"
  # Path to CSV file of shops relative to game root
  _s.shop_csv_file                 = "#{_s.data_dir}/shops.csv"
  # Path to CSV file of special items relative to game root
  _s.special_item_csv_file         = "#{_s.data_dir}/specialitems.csv"
  # Path to CSV file of spirit curves relative to game root
  _s.spirit_curve_csv_file         = "#{_s.data_dir}/spiritcurves.csv"
  # Path to CSV file of treasure chests relative to game root
  _s.treasure_chest_csv_file       = "#{_s.data_dir}/treasurechests.csv"
  # Path to CSV file of usable items relative to game root
  _s.usable_item_csv_file          = "#{_s.data_dir}/usableitems.csv"
  # Path to CSV file of weapons relative to game root
  _s.weapon_csv_file               = "#{_s.data_dir}/weapons.csv"

#------------------------------------------------------------------------------
# TPL paths
#------------------------------------------------------------------------------

  # Path to TPL file of accessories relative to 'share' directory
  _s.accessory_tpl_file            = 'accessories.tpl.csv'
  # Path to TPL file of armors relative to 'share' directory
  _s.armor_tpl_file                = 'armors.tpl.csv'
  # Path to TPL file of characters relative to 'share' directory
  _s.character_tpl_file            = 'characters.tpl.csv'
  # Path to TPL file of character magics relative to 'share' directory
  _s.character_magic_tpl_file      = 'charactermagics.tpl.csv'
  # Path to TPL file of character skills relative to 'share' directory
  _s.character_super_move_tpl_file = 'charactersupermoves.tpl.csv'
  # Path to TPL file of crew members relative to 'share' directory
  _s.crew_member_tpl_file          = 'crewmembers.tpl.csv'
  # Path to TPL file of enemy database relative to 'share' directory
  _s.enemy_tpl_file                = 'enemies.tpl.csv'
  # Path to TPL file of enemy events relative to 'share' directory
  _s.enemy_event_tpl_file          = 'enemyevents.tpl.csv'
  # Path to TPL file of enemy encounters relative to 'share' directory
  _s.enemy_encounter_tpl_file      = 'enemyencounters.tpl.csv'
  # Path to CSV file of enemy instructions relative to game root
  _s.enemy_instruction_tpl_file    = 'enemyinstructions.tpl.csv'
  # Path to TPL file of enemy magics relative to 'share' directory
  _s.enemy_magic_tpl_file          = 'enemymagics.tpl.csv'
  # Path to TPL file of enemy ships relative to 'share' directory
  _s.enemy_ship_tpl_file           = 'enemyships.tpl.csv'
  # Path to TPL file of enemy ship tasks relative to 'share' directory
  _s.enemy_ship_task_tpl_file      = 'enemyshiptasks.tpl.csv'
  # Path to TPL file of enemy skills relative to 'share' directory
  _s.enemy_super_move_tpl_file     = 'enemysupermoves.tpl.csv'
  # Path to TPL file of EXP curves relative to 'share' directory
  _s.exp_curve_tpl_file            = 'expcurves.tpl.csv'
  # Path to TPL file of magic EXP curves relative to 'share' directory
  _s.magic_exp_curve_tpl_file      = 'magicexpcurves.tpl.csv'
  # Path to TPL file of playable ships relative to 'share' directory
  _s.playable_ship_tpl_file        = 'playableships.tpl.csv'
  # Path to TPL file of ship accessories relative to 'share' directory
  _s.ship_accessory_tpl_file       = 'shipaccessories.tpl.csv'
  # Path to TPL file of ship cannons relative to 'share' directory
  _s.ship_cannon_tpl_file          = 'shipcannons.tpl.csv'
  # Path to TPL file of ship items relative to 'share' directory
  _s.ship_item_tpl_file            = 'shipitems.tpl.csv'
  # Path to TPL file of shops relative to 'share' directory
  _s.shop_tpl_file                 = 'shops.tpl.csv'
  # Path to TPL file of special items relative to 'share' directory
  _s.special_item_tpl_file         = 'specialitems.tpl.csv'
  # Path to TPL file of spirit curves relative to 'share' directory
  _s.spirit_curve_tpl_file         = 'spiritcurves.tpl.csv'
  # Path to TPL file of treasure chests relative to game root
  _s.treasure_chest_tpl_file       = 'treasurechests.tpl.csv'
  # Path to TPL file of usable items relative to 'share' directory
  _s.usable_item_tpl_file          = 'usableitems.tpl.csv'
  # Path to TPL file of weapons relative to 'share' directory
  _s.weapon_tpl_file               = 'weapons.tpl.csv'

#------------------------------------------------------------------------------
# Game root
#------------------------------------------------------------------------------

  # Platform files
  _s.platform_files        = {
    'DC' => [_s.exec_file['DC'], _s.ip_file              ],
    'GC' => [_s.exec_file['GC'], _s.bnr_file, _s.hdr_file],
  }
  # Platform endianness
  _s.platform_endianness   = {
    'DC' => :le,
    'GC' => :be,
  }
  # Platform compressions
  _s.platform_compressions = {
    'DC' => 'ALX::BinaryFile',
    'GC' => 'ALX::AklzFile'  ,
  }

  # Product IDs
  _s.product_ids   = {
    'DC' => Regexp.union(
      /^(6107110 06|6107810|8320062 50)$/,
      /^(HDR-0076|HDR-0119|IGN9|MK-51052)$/
    ),
    'GC' => Regexp.union(
      /^GEA$/
    ),
  }
  # Product Names
  _s.product_names = {
    'DC' => Regexp.union(
      /^(DREAMON 20|DREAMCAST EXPRESS VOL6)$/           ,
      /^ETERNAL ARCADIA( KEY VERSION| KUZOKUBAN)?$/     ,
      /^OFFICIAL SEGA DREAMCAST MAGAZINE DECEMBER 2000$/,
      /^SKIES OF ARCADIA( DISC\s?(1|2))?$/
    ),
    'GC' => Regexp.union(
      /^(Skies of|Eternal) Arcadia Legends$/,
      /^ｴﾀｰﾅﾙｱﾙｶﾃﾞｨｱ ﾚｼﾞｪﾝﾄﾞ$/
    ),
  }
    
  # Region IDs
  _s.region_ids = {
    'DC-E'  => 'PAL-E' ,
    'DC-J'  => 'NTSC-J',
    'DC-U'  => 'NTSC-U',
    'DC-UE' => 'PAL-E' ,
    'GC-E'  => 'NTSC-U',
    'GC-J'  => 'NTSC-J',
    'GC-P'  => 'PAL-E' ,
  }

  # Country IDs
  _s.country_ids = {
    'DC-E'  => 'EU',
    'DC-J'  => 'JP',
    'DC-U'  => 'US',
    'DC-UE' => 'EU',
    'GC-E'  => 'US',
    'GC-J'  => 'JP',
    'GC-P'  => 'EU',
  }

  # Maker IDs
  _s.maker_ids   = {
    'DC' => /^SEGA ENTERPRISES$/,
    'GC' => /^8P$/              ,
  }
  # Maker Names
  _s.maker_names = {
    'DC' => /^SEGA ENTERPRISES$/,
    'GC' => /^(SEGA|セガ)$/      ,
  }

#------------------------------------------------------------------------------
# Accessory data
#------------------------------------------------------------------------------

  # Range of accessory IDs
  _s.accessory_id_range = rng(0xa0...0xf0)

  # Offset ranges of accessory data
  _s.accessory_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x35f1ec...0x35faac),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b6890...0x3b7150),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35d14c...0x35da0c),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35cb44...0x35d968),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35c2c4...0x35d0e8),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3407a0...0x341420),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x344da8...0x345a28),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x338c40...0x339a64),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x33e6f0...0x33f370),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f3a68...0x2f4328),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c3308...0x2c3f88),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c3e10...0x2c4a90),
  }
  
  # Offset ranges of accessory names
  _s.accessory_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1a675...0x1aae1),
      rd(_s.sot_file_es['DC'], 0x1a35f...0x1a7fc),
      rd(_s.sot_file_fr['DC'], 0x1a6ad...0x1ab76),
      rd(_s.sot_file_gb['DC'], 0x19f12...0x1a393),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x19f98...0x1a419),
      rd(_s.sot_file_es['DC'], 0x1a441...0x1a8d9),
      rd(_s.sot_file_fr['DC'], 0x1a86b...0x1ad34),
      rd(_s.sot_file_gb['DC'], 0x19f68...0x1a3e9),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x19f98...0x1a419),
      rd(_s.sot_file_es['DC'], 0x1a441...0x1a8d9),
      rd(_s.sot_file_fr['DC'], 0x1a86b...0x1ad34),
      rd(_s.sot_file_gb['DC'], 0x19f98...0x1a419),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1a466...0x1a8d2),
      rd(_s.sot_file_es['DC'], 0x1a32f...0x1a7ce),
      rd(_s.sot_file_fr['DC'], 0x1a61d...0x1aae6),
      rd(_s.sot_file_gb['DC'], 0x19f03...0x1a384),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1d6aa...0x1db1c),
      rd(_s.sot_file_es['GC'], 0x1d39e...0x1d83d),
      rd(_s.sot_file_fr['GC'], 0x1d5d7...0x1daa2),
      rd(_s.sot_file_gb['GC'], 0x1cd13...0x1d194),
    ],
  }
  
  # Offset ranges of accessory descriptions
  _s.accessory_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x12543...0x13ad7),
      rd(_s.sot_file_es['DC'], 0x121e9...0x136b6),
      rd(_s.sot_file_fr['DC'], 0x1227f...0x138a5),
      rd(_s.sot_file_gb['DC'], 0x1200c...0x134c5),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x12061...0x1351a),
      rd(_s.sot_file_es['DC'], 0x12134...0x1364f),
      rd(_s.sot_file_fr['DC'], 0x122e9...0x13969),
      rd(_s.sot_file_gb['DC'], 0x12031...0x134ea),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x12061...0x1351a),
      rd(_s.sot_file_es['DC'], 0x12134...0x1364f),
      rd(_s.sot_file_fr['DC'], 0x122e9...0x13969),
      rd(_s.sot_file_gb['DC'], 0x12061...0x1351a),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x12352...0x138e9),
      rd(_s.sot_file_es['DC'], 0x121c3...0x13690),
      rd(_s.sot_file_fr['DC'], 0x121f0...0x13817),
      rd(_s.sot_file_gb['DC'], 0x11fff...0x134b8),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2afae4...0x2afe30, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2af400...0x2af74c, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x3370f0...0x3387d4
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x33b6f8...0x33cddc
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x33356c...0x3338a4, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x335548...0x33693c
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x153d7...0x16979),
      rd(_s.sot_file_es['GC'], 0x1502e...0x1652e),
      rd(_s.sot_file_fr['GC'], 0x15017...0x16635),
      rd(_s.sot_file_gb['GC'], 0x14c6f...0x1613d),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2ca370...0x2cba54
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2ca880...0x2cbc88
    ),
  }

#------------------------------------------------------------------------------
# Armor data
#------------------------------------------------------------------------------

  # Range of armor IDs
  _s.armor_id_range = rng(0x50...0xa0)
  
  # Offset ranges of armor data
  _s.armor_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x35e92c...0x35f1ec),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b5fd0...0x3b6890),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35c88c...0x35d14c),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35bec4...0x35cb44),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35b644...0x35c2c4),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x33fb20...0x3407a0),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x344128...0x344da8),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x337fc0...0x338c40),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x33da70...0x33e6f0),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f31a8...0x2f3a68),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c2688...0x2c3308),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c3190...0x2c3e10),
  }
  
  # Offset ranges of armor names
  _s.armor_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1a279...0x1a675),
      rd(_s.sot_file_es['DC'], 0x19f07...0x1a35f),
      rd(_s.sot_file_fr['DC'], 0x1a265...0x1a6ad),
      rd(_s.sot_file_gb['DC'], 0x19b20...0x19f12),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x19ba6...0x19f98),
      rd(_s.sot_file_es['DC'], 0x19fe3...0x1a441),
      rd(_s.sot_file_fr['DC'], 0x1a423...0x1a86b),
      rd(_s.sot_file_gb['DC'], 0x19b76...0x19f68),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x19ba6...0x19f98),
      rd(_s.sot_file_es['DC'], 0x19fe3...0x1a441),
      rd(_s.sot_file_fr['DC'], 0x1a423...0x1a86b),
      rd(_s.sot_file_gb['DC'], 0x19ba6...0x19f98),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1a06a...0x1a466),
      rd(_s.sot_file_es['DC'], 0x19ed7...0x1a32f),
      rd(_s.sot_file_fr['DC'], 0x1a1d5...0x1a61d),
      rd(_s.sot_file_gb['DC'], 0x19b11...0x19f03),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1d289...0x1d6aa),
      rd(_s.sot_file_es['GC'], 0x1cf43...0x1d39e),
      rd(_s.sot_file_fr['GC'], 0x1d18e...0x1d5d7),
      rd(_s.sot_file_gb['GC'], 0x1c921...0x1cd13),
    ],
  }
  
  # Offset ranges of armor descriptions
  _s.armor_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x111d9...0x12543),
      rd(_s.sot_file_es['DC'], 0x10faa...0x121e9),
      rd(_s.sot_file_fr['DC'], 0x11008...0x1227f),
      rd(_s.sot_file_gb['DC'], 0x10db1...0x1200c),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x10e06...0x12061),
      rd(_s.sot_file_es['DC'], 0x10e97...0x12134),
      rd(_s.sot_file_fr['DC'], 0x11002...0x122e9),
      rd(_s.sot_file_gb['DC'], 0x10dd6...0x12031),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x10e06...0x12061),
      rd(_s.sot_file_es['DC'], 0x10e97...0x12134),
      rd(_s.sot_file_fr['DC'], 0x11002...0x122e9),
      rd(_s.sot_file_gb['DC'], 0x10e06...0x12061),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x10fec...0x12352),
      rd(_s.sot_file_es['DC'], 0x10f83...0x121c3),
      rd(_s.sot_file_fr['DC'], 0x10f79...0x121f0),
      rd(_s.sot_file_gb['DC'], 0x10da4...0x11fff),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2af878...0x2afae4, excl: [0x59, 0x5b..0x70]
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2af194...0x2af400, excl: [0x59, 0x5b..0x70]
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x335b4c...0x3370f0
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x33a154...0x33b6f8
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x33337c...0x33356c, excl: [0x59, 0x5b..0x70]
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x3343f8...0x335548
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x14060...0x153d7),
      rd(_s.sot_file_es['GC'], 0x13dc4...0x1502e),
      rd(_s.sot_file_fr['GC'], 0x13da3...0x15017),
      rd(_s.sot_file_gb['GC'], 0x139f6...0x14c6f),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c8ddc...0x2ca370
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c9714...0x2ca880
    ),
  }

#------------------------------------------------------------------------------
# Character magic data
#------------------------------------------------------------------------------

  # Range of character magic IDs
  _s.character_magic_id_range = 0x0...0x24
  
  # Offset ranges of character magic data
  _s.character_magic_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x35da34...0x35df44),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b50d8...0x3b55e8),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35b994...0x35bea4),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35a924...0x35afe4),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35a0a4...0x35a764),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x33e580...0x33ec40),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x342b88...0x343248),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x336a20...0x3370e0),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x33c4d0...0x33cb90),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f22b0...0x2f27c0),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c10e8...0x2c17a8),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c1bf0...0x2c22b0),
  }
  
  # Offset ranges of character magic names
  _s.character_magic_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x19c2a...0x19d38),
      rd(_s.sot_file_es['DC'], 0x19854...0x19963),
      rd(_s.sot_file_fr['DC'], 0x19bde...0x19cec),
      rd(_s.sot_file_gb['DC'], 0x194f2...0x19600),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x19578...0x19686),
      rd(_s.sot_file_es['DC'], 0x1992a...0x19a38),
      rd(_s.sot_file_fr['DC'], 0x19d9c...0x19eaa),
      rd(_s.sot_file_gb['DC'], 0x19548...0x19656),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x19578...0x19686),
      rd(_s.sot_file_es['DC'], 0x1992a...0x19a38),
      rd(_s.sot_file_fr['DC'], 0x19d9c...0x19eaa),
      rd(_s.sot_file_gb['DC'], 0x19578...0x19686),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x19a1b...0x19b29),
      rd(_s.sot_file_es['DC'], 0x19825...0x19933),
      rd(_s.sot_file_fr['DC'], 0x19b4e...0x19c5c),
      rd(_s.sot_file_gb['DC'], 0x194e3...0x195f1),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1cc3a...0x1cd48),
      rd(_s.sot_file_es['GC'], 0x1c88d...0x1c99b),
      rd(_s.sot_file_fr['GC'], 0x1cafd...0x1cc0b),
      rd(_s.sot_file_gb['GC'], 0x1c2f4...0x1c402),
    ],
  }
  
  # Offset ranges of character magic descriptions
  _s.character_magic_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0xe17f...0xeeb1),
      rd(_s.sot_file_es['DC'], 0xdf7f...0xec98),
      rd(_s.sot_file_fr['DC'], 0xe016...0xed74),
      rd(_s.sot_file_gb['DC'], 0xdd50...0xeab1),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0xdda5...0xeb06),
      rd(_s.sot_file_es['DC'], 0xde1e...0xeb37),
      rd(_s.sot_file_fr['DC'], 0xdfe9...0xed47),
      rd(_s.sot_file_gb['DC'], 0xdd75...0xead6),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0xdda5...0xeb06),
      rd(_s.sot_file_es['DC'], 0xde1e...0xeb37),
      rd(_s.sot_file_fr['DC'], 0xdfe9...0xed47),
      rd(_s.sot_file_gb['DC'], 0xdda5...0xeb06),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0xe00e...0xed40),
      rd(_s.sot_file_es['DC'], 0xdf58...0xec71),
      rd(_s.sot_file_fr['DC'], 0xdf86...0xece4),
      rd(_s.sot_file_gb['DC'], 0xdd43...0xeaa4),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2ae5e4...0x2aefa4
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2adf00...0x2ae8c0
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x332934...0x3336a8
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x336f3c...0x337cb0
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x3320b4...0x332ab8
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x3313b4...0x332120
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x11025...0x11d53),
      rd(_s.sot_file_es['GC'], 0x10d2f...0x11a56),
      rd(_s.sot_file_fr['GC'], 0x10d3c...0x11a9a),
      rd(_s.sot_file_gb['GC'], 0x1093f...0x116a9),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c5b60...0x2c68d4
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c6668...0x2c73e0
    ),
  }
  
  # Offset ranges of character magic ship descriptions
  _s.character_magic_ship_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x185e8...0x1906c),
      rd(_s.sot_file_es['DC'], 0x18246...0x18c3b),
      rd(_s.sot_file_fr['DC'], 0x184ca...0x18f52),
      rd(_s.sot_file_gb['DC'], 0x17f49...0x18964),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x17f97...0x189b2),
      rd(_s.sot_file_es['DC'], 0x182ea...0x18d16),
      rd(_s.sot_file_fr['DC'], 0x18685...0x19147),
      rd(_s.sot_file_gb['DC'], 0x17f67...0x18982),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x17f97...0x189b2),
      rd(_s.sot_file_es['DC'], 0x182ea...0x18d16),
      rd(_s.sot_file_fr['DC'], 0x18685...0x19147),
      rd(_s.sot_file_gb['DC'], 0x17f97...0x189b2),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x183d9...0x18e5d),
      rd(_s.sot_file_es['DC'], 0x18219...0x18c0e),
      rd(_s.sot_file_fr['DC'], 0x1843a...0x18ebf),
      rd(_s.sot_file_gb['DC'], 0x17f3a...0x18955),
    ],
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x33d1a0...0x33d9e0, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x3417a8...0x341fe8, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x335c10...0x3363c4, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x33b104...0x33ba34, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1b603...0x1c085),
      rd(_s.sot_file_es['GC'], 0x1b23a...0x1bc6f),
      rd(_s.sot_file_fr['GC'], 0x1b3e9...0x1be6e),
      rd(_s.sot_file_gb['GC'], 0x1ad4b...0x1b766),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2d058c...0x2d0dcc, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2d05c4...0x2d0ef4, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
  }

#------------------------------------------------------------------------------
# Character data
#------------------------------------------------------------------------------

  # Range of character IDs
  _s.character_id_range = 0x0...0x6
  
  # Offset ranges of character data
  _s.character_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x335aa4...0x335e68),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x361bbc...0x361f4c),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x333a38...0x333dc8),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35a594...0x35a924),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x359d14...0x35a0a4),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x33e1F0...0x33e580),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x3427f8...0x342b88),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x336690...0x336a20),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x33c140...0x33c4d0),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2c2ff0...0x2c3380),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c0d58...0x2c10e8),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c1860...0x2c1bf0),
  }

#------------------------------------------------------------------------------
# Character super move data
#------------------------------------------------------------------------------

  # Range of character super move IDs
  _s.character_super_move_id_range = 0x24...0x3e
  
  # Offset ranges of character super move data
  _s.character_super_move_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x35df44...0x35e2ec),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b55e8...0x3b5990),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35bea4...0x35c24c),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35afe4...0x35b4c4),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35a764...0x35ac44),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x33ec40...0x33f120),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x343248...0x343728),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x3370e0...0x3375c0),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x33cb90...0x33d070),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f27c0...0x2f2b68),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c17a8...0x2c1c88),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c22b0...0x2c2790),
  }
  
  # Offset ranges of character super move names
  _s.character_super_move_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x19d38...0x19e83),
      rd(_s.sot_file_es['DC'], 0x19963...0x19ac8),
      rd(_s.sot_file_fr['DC'], 0x19cec...0x19e68),
      rd(_s.sot_file_gb['DC'], 0x19600...0x19753),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x19686...0x197d9),
      rd(_s.sot_file_es['DC'], 0x19a38...0x19b9d),
      rd(_s.sot_file_fr['DC'], 0x19eaa...0x1a026),
      rd(_s.sot_file_gb['DC'], 0x19656...0x197a9),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x19686...0x197d9),
      rd(_s.sot_file_es['DC'], 0x19a38...0x19b9d),
      rd(_s.sot_file_fr['DC'], 0x19eaa...0x1a026),
      rd(_s.sot_file_gb['DC'], 0x19686...0x197d9),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x19b29...0x19c74),
      rd(_s.sot_file_es['DC'], 0x19933...0x19a98),
      rd(_s.sot_file_fr['DC'], 0x19c5c...0x19dd8),
      rd(_s.sot_file_gb['DC'], 0x195f1...0x19744),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1cd48...0x1ce93),
      rd(_s.sot_file_es['GC'], 0x1c99b...0x1cb04),
      rd(_s.sot_file_fr['GC'], 0x1cc0b...0x1cd83),
      rd(_s.sot_file_gb['GC'], 0x1c402...0x1c555),
    ],
  }
  
  # Offset ranges of character super move descriptions
  _s.character_super_move_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0xeeb1...0xf842),
      rd(_s.sot_file_es['DC'], 0xec98...0xf63e),
      rd(_s.sot_file_fr['DC'], 0xed74...0xf726),
      rd(_s.sot_file_gb['DC'], 0xeab1...0xf45e),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0xeb06...0xf4b3),
      rd(_s.sot_file_es['DC'], 0xeb37...0xf4e4),
      rd(_s.sot_file_fr['DC'], 0xed47...0xf6fd),
      rd(_s.sot_file_gb['DC'], 0xead6...0xf483),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0xeb06...0xf4b3),
      rd(_s.sot_file_es['DC'], 0xeb37...0xf4e4),
      rd(_s.sot_file_fr['DC'], 0xed47...0xf6fd),
      rd(_s.sot_file_gb['DC'], 0xeb06...0xf4b3),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0xed40...0xf6d1),
      rd(_s.sot_file_es['DC'], 0xec71...0xf617),
      rd(_s.sot_file_fr['DC'], 0xece4...0xf696),
      rd(_s.sot_file_gb['DC'], 0xeaa4...0xf451),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2aefa4...0x2af590, excl: [0x31]
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2ae8c0...0x2aeeac, excl: [0x31]
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x3336a8...0x334094
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x337cb0...0x33869c
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x332ab8...0x333110, excl: [0x31]
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x332120...0x332ad8
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x11d53...0x126e4),
      rd(_s.sot_file_es['GC'], 0x11a56...0x12410),
      rd(_s.sot_file_fr['GC'], 0x11a9a...0x1244e),
      rd(_s.sot_file_gb['GC'], 0x116a9...0x12056),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c68d4...0x2c72c0
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c73e0...0x2c7d9c
    ),
  }

#------------------------------------------------------------------------------
# Crew member data
#------------------------------------------------------------------------------

  # Range of crew member IDs
  _s.crew_member_id_range = 0x0...0x16
  
  # Offset ranges of crew member data
  _s.crew_member_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x362708...0x362918),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b9dac...0x3b9fbc),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x360668...0x360878),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x36186c...0x361b2c),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x360fec...0x3612ac),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3457c4...0x345adc),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x349dcc...0x34a0e4),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33dc64...0x33df7c),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x343714...0x343a2c),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f8a4c...0x2f8c5c),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2d5aa4...0x2d5dbc),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2d5e64...0x2d617c),
  }
  
  # Offset ranges of crew member names
  _s.crew_member_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1bc84...0x1bd1a),
      rd(_s.sot_file_es['DC'], 0x1ba79...0x1bb0f),
      rd(_s.sot_file_fr['DC'], 0x1bdad...0x1be43),
      rd(_s.sot_file_gb['DC'], 0x1b527...0x1b5bd),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1b5c2...0x1b658),
      rd(_s.sot_file_es['DC'], 0x1bace...0x1bb64),
      rd(_s.sot_file_fr['DC'], 0x1bf81...0x1c017),
      rd(_s.sot_file_gb['DC'], 0x1b592...0x1b628),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1b5c2...0x1b658),
      rd(_s.sot_file_es['DC'], 0x1bace...0x1bb64),
      rd(_s.sot_file_fr['DC'], 0x1bf81...0x1c017),
      rd(_s.sot_file_gb['DC'], 0x1b5c2...0x1b658),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1ba76...0x1bb0c),
      rd(_s.sot_file_es['DC'], 0x1ba43...0x1bad9),
      rd(_s.sot_file_fr['DC'], 0x1bd1a...0x1bdb0),
      rd(_s.sot_file_gb['DC'], 0x1b51f...0x1b5b5),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1ed75...0x1ee0b),
      rd(_s.sot_file_es['GC'], 0x1eb78...0x1ec0e),
      rd(_s.sot_file_fr['GC'], 0x1ed91...0x1ee27),
      rd(_s.sot_file_gb['GC'], 0x1e3dd...0x1e473),
    ],
  }
  
  # Offset ranges of crew member descriptions
  _s.crew_member_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1906c...0x1979b),
      rd(_s.sot_file_es['DC'], 0x18c3b...0x193a9),
      rd(_s.sot_file_fr['DC'], 0x18f4f...0x196db),
      rd(_s.sot_file_gb['DC'], 0x18964...0x19061),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x189b2...0x190af),
      rd(_s.sot_file_es['DC'], 0x18d16...0x19487),
      rd(_s.sot_file_fr['DC'], 0x19147...0x198d3),
      rd(_s.sot_file_gb['DC'], 0x18982...0x1907f),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x189b2...0x190af),
      rd(_s.sot_file_es['DC'], 0x18d16...0x19487),
      rd(_s.sot_file_fr['DC'], 0x19147...0x198d3),
      rd(_s.sot_file_gb['DC'], 0x189b2...0x190af),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x18e5d...0x1958c),
      rd(_s.sot_file_es['DC'], 0x18c0e...0x1937a),
      rd(_s.sot_file_fr['DC'], 0x18ebf...0x1964b),
      rd(_s.sot_file_gb['DC'], 0x18955...0x19052),
    ],
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x33d9e0...0x33e1f0
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x341fe8...0x3427f8
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x3363c4...0x336690, excl: [0x9, 0xf]
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x33ba34...0x33c140
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1c085...0x1c7ab),
      rd(_s.sot_file_es['GC'], 0x1bc6f...0x1c3da),
      rd(_s.sot_file_fr['GC'], 0x1be6e...0x1c5fa),
      rd(_s.sot_file_gb['GC'], 0x1b766...0x1be63),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2d0dcc...0x2d15dc
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2d0ef4...0x2d1600
    ),
  }

#------------------------------------------------------------------------------
# Defined string data
#------------------------------------------------------------------------------

  # Enables or disables the cache for defined strings. If you enable the 
  # cache, all valid strings are cached even before the filter 
  # +SYS.defined_string_filters+ is applied. This cache will be used later to 
  # skip the entire string detection in future runs. This can be useful, for 
  # example, to quickly check the effects of filter changes without scanning 
  # the whole file again.
  _s.defined_string_cache         = true
  # Enables or disables the filter avoidance. If you enable the filter 
  # avoidance, no filters are applied.
  _s.defined_string_ignore_filter = false
  # Enables or disables the filter inversion. If you enable the filter 
  # inversion, only the rejected strings will be collected.
  _s.defined_string_invert_filter = false
  # Enables or disables the appending of filters. If you enable the appending 
  # of filters, the applied filters will also be stored. This can be useful, 
  # for example, to determine which filter of +SYS.defined_string_filters+ has 
  # been finally selected.
  _s.defined_string_append_filter = false
  # Enables or disables the diff utility support. If you enable the diff 
  # utility support, even empty and rejected strings will also be collected. 
  # This can be useful, for example, to compare the impact of filter changes 
  # with a diff utility.
  _s.defined_string_diff_support  = false

  # Alignment requirement for the begin of defined strings
  _s.defined_string_beg_alignment = 1
  # Alignment requirement for the end of defined strings
  _s.defined_string_end_alignment = 1
  # Minimum byte size of defined strings
  _s.defined_string_min_byte_size = 2
  # Minimum character size of defined strings
  _s.defined_string_min_char_size = 1

  # Offset ranges of defined string data
  _s.defined_string_data_files = {
    'DC'                       => rd(_s.exec_file['DC'], 0x0..),
    'DC-EU-8320062 50'         => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x0057cc...0x00580e, 0x005cc8...0x005f92,
      0x007de8...0x007ded, 0x33236c...0x33c385, 0x33cfc0...0x33d2df,
      0x33e6b0...0x33e771, 0x33e7bc...0x33e7c3, 0x33e831...0x3464ba,
      0x347648...0x34bebc, 0x350444...0x351002, 0x35d9d4...0x35da32,
      0x365ae4...0x366a46, 0x36c7e0...0x36e7c8, 0x3717e4...0x3717f0,
      0x37330c...0x3750d9, 0x37dc94...0x4a376f,
    ]),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x00577c...0x0057a8, 0x005d88...0x005d8d,
      0x35b1c0...0x369265, 0x369ea0...0x36a177, 0x36b548...0x373366,
      0x3744f4...0x37a102, 0x37e794...0x37eb2f, 0x39eb88...0x39f382,
      0x3a3408...0x3a35e9, 0x3ac01c...0x3b50d6, 0x3bd188...0x3be0ea,
      0x3c2c88...0x3c2c93, 0x3c3ef8...0x3c5ee8, 0x3c8f04...0x3c8f10,
      0x3caa2c...0x3d038d, 0x3d89f0...0x4feacf,
    ]),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x00577c...0x0057a8, 0x005d88...0x005d8d,
      0x330300...0x33a325, 0x33af60...0x33b27f, 0x33c650...0x34445a,
      0x3455e8...0x349dd6, 0x34e5b0...0x34ef62, 0x363a44...0x3649a6,
      0x36a74c...0x36c734, 0x36f750...0x36f75c, 0x371278...0x3735a1,
      0x37bc04...0x4a16ef,
    ]),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x004c68...0x004c6d, 0x2aba68...0x2b32f4,
      0x2b348c...0x2b442c, 0x2b5590...0x2bbe3c, 0x2c025c...0x2c12c5,
      0x2c1b24...0x2c22d9, 0x353c18...0x361b13, 0x362b50...0x363768,
      0x3875d8...0x3876ab, 0x38ddd4...0x38de59, 0x3b7ef4...0x3bcf09,
      0x3c48b4...0x3c53c6, 0x3c5aca...0x3c5acf, 0x3ce094...0x3ce5f6,
    ]),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x004c68...0x004c6d, 0x2ab384...0x2b3b7c,
      0x2b4ce0...0x2bb5cc, 0x2bf9ec...0x2c0a55, 0x2c12a4...0x2c1a59,
      0x353398...0x361293, 0x3622d0...0x362ee8, 0x386d58...0x386e2b,
      0x38d554...0x38d5d9, 0x3b7674...0x3bc689, 0x3c4034...0x3c4b42,
      0x3c5242...0x3c5247, 0x3cd808...0x3cdd6a,
    ]),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x00577c...0x0057a8, 0x005d88...0x005d8d,
      0x32e380...0x34a5a5, 0x34b1e0...0x34b4b3, 0x34c880...0x35548d,
      0x356a08...0x35daea, 0x3622c4...0x362c3d, 0x3ec0a4...0x3ec1d5,
      0x3f4ad4...0x3f4c1e, 0x3f7614...0x3f8576, 0x3fb6bc...0x3fd14c,
      0x3fead0...0x3feadb, 0x3ffdd0...0x401d88, 0x404c68...0x404c74,
      0x404f80...0x408889, 0x410eec...0x5369cf,
    ]),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x006960...0x0069ff, 0x006fe8...0x006fed,
      0x332960...0x34eba5, 0x34f7e0...0x34fab3, 0x350e80...0x359a8d,
      0x35b008...0x362408, 0x366990...0x367325, 0x3f078c...0x3f08bd,
      0x3f9284...0x3f93ce, 0x3fbdc4...0x3fcd26, 0x3ffe6c...0x4018fc,
      0x403280...0x40328b, 0x404580...0x406538, 0x409418...0x409424,
      0x409730...0x40d081, 0x415708...0x53b1ef,
    ]),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x005e6c...0x005ede, 0x0063b4...0x00667e,
      0x0084c8...0x0084cd, 0x32d940...0x342c85, 0x3438c0...0x343b97,
      0x344fcc...0x34d8b1, 0x34ee2c...0x355f5e, 0x35a738...0x35b09d,
      0x3eff4c...0x3f0eae, 0x3f3ff4...0x3f5a94, 0x3f7418...0x3f7423,
      0x3f8718...0x3f9690, 0x3fc4ec...0x3fc4f8, 0x3fc804...0x40010d,
      0x408770...0x52e24f,
    ]),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], [
      0x000030...0x000041, 0x00577c...0x0057a8, 0x005d88...0x005d8d,
      0x32cc20...0x3485e5, 0x349220...0x3494f7, 0x34a92c...0x353b92,
      0x354d20...0x35bb66, 0x360340...0x360c9d, 0x3f5d90...0x3f6cf2,
      0x3f9e38...0x3fb7d9, 0x3fd160...0x3fd16b, 0x3fe460...0x400430,
      0x403310...0x40331c, 0x403628...0x406f31, 0x40f594...0x53506f,
    ]),
    'GC'                      => rd(_s.exec_file['GC'], 0x0..),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], [
      0x0003fc...0x00042a, 0x2ad120...0x2b2927, 0x2b2980...0x2b2de2,
      0x2b3f70...0x2b4852, 0x2b4938...0x2d467d, 0x2d731c...0x2d8639,
      0x2de460...0x2df2c9, 0x2e0930...0x2e093c, 0x2e1b28...0x2e1b33,
      0x2e5598...0x2e6cbf, 0x2e79a0...0x2e79b0, 0x2ea348...0x2eaac5,
      0x2f1f50...0x2f204a, 0x2f9a20...0x2fcefb, 0x303118...0x3034e0,
      0x3036c8...0x303a97, 0x303c4c...0x303fef, 0x304318...0x304338,
      0x30472c...0x304731, 0x304aa8...0x304ab1, 0x304db4...0x304e46,
      0x305094...0x3051ac, 0x305924...0x30592c, 0x305c70...0x305c74,
      0x305ee0...0x306018, 0x3062a4...0x30630f, 0x306800...0x306877,
      0x306918...0x306a30, 0x306b50...0x306b7c, 0x306c70...0x306cc0,
      0x306e20...0x306e81, 0x306f54...0x306f8c, 0x30705c...0x307186,
      0x3073c8...0x3075e5, 0x307788...0x307cdf, 0x307e80...0x308076
    ]),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], [
      0x0003fc...0x00042a, 0x2a92e0...0x2b183a, 0x2b29c8...0x2b3448,
      0x2b42e8...0x2b432d, 0x2b4700...0x2d70cd, 0x2d9d5c...0x2db079,
      0x2df3a8...0x2e0211, 0x2e1790...0x2e179c, 0x2e2988...0x2e2993,
      0x2e6158...0x2e7ca1, 0x2e8748...0x2e8b07, 0x2eb280...0x2eba0d,
      0x2f2d4c...0x2f44af, 0x2f5e80...0x2f931b, 0x2ff510...0x2ff8c8,
      0x2ffab0...0x2ffe7f, 0x300034...0x300287, 0x3005a0...0x3005c0,
      0x3009b4...0x3009b9, 0x300fd8...0x3010c5, 0x301314...0x30142c,
      0x302158...0x302250, 0x3024dc...0x30251f, 0x302a10...0x302be8,
      0x302d08...0x302e36, 0x302f98...0x302fdf, 0x3030b4...0x303267,
      0x3032d8...0x3032e6, 0x3035d0...0x3036fd, 0x3038b0...0x303b99, 
      0x303d58...0x303edd,
    ]),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], [
      0x0003fc...0x00042a, 0x2a9820...0x2b1dda, 0x2b2f68...0x2b39e8,
      0x2b4c64...0x2d7595, 0x2da23c...0x2db559, 0x2df888...0x2e06f1,
      0x2e1c70...0x2e1c7c, 0x2e2e68...0x2e2e73, 0x2e5f60...0x2e807f,
      0x2e8b20...0x2e8ea3, 0x2eb618...0x2ebdad, 0x2f30ec...0x2f47d1,
      0x2f63f8...0x2f989b, 0x2ffa90...0x2ffe40, 0x300028...0x300091,
      0x3002b0...0x3003f7, 0x3005ac...0x3005b1, 0x3006f8...0x3007de,
      0x300af8...0x300b18, 0x301288...0x301291, 0x301530...0x301626,
      0x301874...0x301884, 0x301960...0x30198c, 0x3026e8...0x302766,
      0x302a6c...0x302ab7, 0x302fa8...0x302fb6, 0x3030c0...0x30311d,
      0x303170...0x3031b4, 0x3032d0...0x3032fc, 0x3033f0...0x30340e,
      0x303570...0x3035d1, 0x303784...0x30389e, 0x303ad8...0x303ce5,
      0x303e98...0x303f39, 0x303fc0...0x304183, 0x304340...0x304355,
      0x3044ae...0x3044ee
    ]),
  }

  # Character Code Table (CCT) for defined strings
  _s.defined_string_char_table = [
     0x0009               ,  0x000a               ,  0x000d               ,
    (0x0020...0x007f).to_a,  0x0085               , (0x00a1...0x0100).to_a,
    (0x8140...0x817f).to_a, (0x8180...0x81ad).to_a, (0x81b8...0x81c0).to_a,
    (0x81c8...0x81cf).to_a, (0x81da...0x81e9).to_a, (0x81f0...0x81f8).to_a,
     0x81fc               , (0x824f...0x8259).to_a, (0x8260...0x827a).to_a,
    (0x8281...0x829b).to_a, (0x829f...0x82f2).to_a, (0x8340...0x837f).to_a,
    (0x8380...0x8397).to_a, (0x839f...0x83b7).to_a, (0x83bf...0x83d7).to_a,
    (0x8440...0x8461).to_a, (0x8470...0x8492).to_a, (0x849f...0x84bf).to_a,
    (0x889f...0x88fd).to_a, (0x8940...0x897f).to_a, (0x8980...0x89fd).to_a,
    (0x8a40...0x8a7f).to_a, (0x8a80...0x8afd).to_a, (0x8b40...0x8b7f).to_a,
    (0x8b80...0x8bfd).to_a, (0x8c40...0x8c7f).to_a, (0x8c80...0x8cfd).to_a,
    (0x8d40...0x8d7f).to_a, (0x8d80...0x8dfd).to_a, (0x8e40...0x8e7f).to_a,
    (0x8e80...0x8efd).to_a, (0x8f40...0x8f7f).to_a,  0x8f80               ,
    (0x8f80...0x8f82).to_a, (0x8f81...0x8f83).to_a, (0x8f82...0x8f84).to_a,
    (0x8f83...0x8f85).to_a, (0x8f84...0x8f86).to_a, (0x8f85...0x8f87).to_a,
    (0x8f86...0x8f88).to_a, (0x8f87...0x8f89).to_a, (0x8f88...0x8f8a).to_a,
    (0x8f89...0x8f8b).to_a, (0x8f8a...0x8f8c).to_a, (0x8f8b...0x8f8d).to_a,
    (0x8f8c...0x8f8e).to_a, (0x8f8d...0x8f8f).to_a, (0x8f8e...0x8f90).to_a,
    (0x8f8f...0x8f91).to_a, (0x8f90...0x8f92).to_a, (0x8f91...0x8f93).to_a,
    (0x8f92...0x8f94).to_a, (0x8f93...0x8f95).to_a, (0x8f94...0x8f96).to_a,
    (0x8f95...0x8f97).to_a, (0x8f96...0x8f98).to_a, (0x8f97...0x8f99).to_a,
    (0x8f98...0x8f9a).to_a, (0x8f99...0x8f9b).to_a, (0x8f9a...0x8f9c).to_a,
    (0x8f9b...0x8f9d).to_a, (0x8f9c...0x8ffd).to_a, (0x9040...0x907f).to_a,
    (0x9080...0x90fd).to_a, (0x9140...0x917f).to_a, (0x9180...0x91fd).to_a,
    (0x9240...0x927f).to_a, (0x9280...0x92fd).to_a, (0x9340...0x937f).to_a,
    (0x9380...0x93fd).to_a, (0x9440...0x947f).to_a, (0x9480...0x94fd).to_a,
    (0x9540...0x957f).to_a, (0x9580...0x95fd).to_a, (0x9640...0x967f).to_a,
    (0x9680...0x96fd).to_a, (0x9740...0x977f).to_a, (0x9780...0x97fd).to_a,
    (0x9840...0x9873).to_a, (0x989f...0x98fd).to_a, (0x9940...0x997f).to_a,
    (0x9980...0x99fd).to_a, (0x9a40...0x9a7f).to_a, (0x9a80...0x9afd).to_a,
    (0x9b40...0x9b7f).to_a, (0x9b80...0x9bfd).to_a, (0x9c40...0x9c7f).to_a,
    (0x9c80...0x9cfd).to_a, (0x9d40...0x9d7f).to_a, (0x9d80...0x9dfd).to_a,
    (0x9e40...0x9e7f).to_a, (0x9e80...0x9efd).to_a, (0x9f40...0x9f7f).to_a,
    (0x9f80...0x9ffd).to_a, (0xe040...0xe07f).to_a, (0xe080...0xe0fd).to_a,
    (0xe140...0xe17f).to_a, (0xe180...0xe1fd).to_a, (0xe240...0xe27f).to_a,
    (0xe280...0xe2fd).to_a, (0xe340...0xe37f).to_a, (0xe380...0xe3fd).to_a,
    (0xe440...0xe47f).to_a, (0xe480...0xe4fd).to_a, (0xe540...0xe57f).to_a,
    (0xe580...0xe5fd).to_a, (0xe640...0xe67f).to_a, (0xe680...0xe6fd).to_a,
    (0xe740...0xe77f).to_a, (0xe780...0xe7fd).to_a, (0xe840...0xe87f).to_a,
    (0xe880...0xe8fd).to_a, (0xe940...0xe97f).to_a, (0xe980...0xe9fd).to_a,
    (0xea40...0xea7f).to_a, (0xea80...0xeaa5).to_a,
  ].flatten!

  # Character encodings for defined strings
  _s.defined_string_char_encodings = {
    'Windows-1252' => gs(/\A
      (?=.*(?>
        {blkw}{ldia}{blkw}|
        {ldia}{lwrw}|
        {udia}{lwrw}|
        {lwrw}{ldia}|
        {uprw}{ldia}
      ).*)
      {anyw}+
    \z/mnx),
    'Shift_JIS'    => gs(/\A{anyj}+\z/n),
  }

  # Filters for defined strings
  _s.defined_string_filters = [
    # Invalid strings
    gs(/\A\(21\)\z/n),
    gs(/\A\x40\x96\x40\x96\xbf\z/n),
    gs(/\A\x40\x98\x40\x98r\z/n),
    gs(/\A\x81\x40\z/n),
    gs(/\A\x82\xd0\z/n),
    gs(/\A\x82\xe8\z/n),
    gs(/\A\x83\xb0\z/n),
    gs(/\A\x84\x60\z/n),
    gs(/\A\x84\x78\z/n),
    gs(/\A\x88\xc4\z/n),
    gs(/\A\x89\xc3\z/n),
    gs(/\A\x89\xe4\z/n),
    gs(/\A\x89\xf0\z/n),
    gs(/\A\x8a\xb8\z/n),
    gs(/\A\x8a\xc4\z/n),
    gs(/\A\x8b\x40\z/n),
    gs(/\A\x8b\x8c\z/n),
    gs(/\A\x8b\x98\z/n),
    gs(/\A\x8c\x6e\xb0\z/n),
    gs(/\A\x8c\xa0\z/n),
    gs(/\A\x8c\xa0\z/n),
    gs(/\A\x8d\x42\z/n),
    gs(/\A\x8d\x8c\z/n),
    gs(/\A\x8d\xc3\z/n),
    gs(/\A\x8e\xac\z/n),
    gs(/\A\x8f\x80\z/n),
    gs(/\A\x8f\xc2\xf5\xbd\z/n),
    gs(/\A\x8f\xe6\z/n),
    gs(/\A\x8f\xfc\z/n),
    gs(/\A\x90\x41\n\z/n),
    gs(/\A\x90\x42\z/n),
    gs(/\A\x90\xa0\z/n),
    gs(/\A\x91\x44\z/n),
    gs(/\A\x91\x74\z/n),
    gs(/\A\x91\xd2\z/n),
    gs(/\A\x91\xf0\z/n),
    gs(/\A\x92\x43\z/n),
    gs(/\A\x92\x80\z/n),
    gs(/\A\x93\x6c\z/n),
    gs(/\A\x93\xac\z/n),
    gs(/\A\x93\xe4\z/n),
    gs(/\A\x94\x70\z/n),
    gs(/\A\x94\xe4\z/n),
    gs(/\A\x94\xf0\z/n),
    gs(/\A\x95\x49\z/n),
    gs(/\A\x95\x80\z/n),
    gs(/\A\x96\x42\z/n),
    gs(/\A\x96\x80\z/n),
    gs(/\A\x96\x98\z/n),
    gs(/\A\x96\xc3\z/n),
    gs(/\A\x96\xd8\z/n),
    gs(/\A\x97\x54\z/n),
    gs(/\A\x97\xac\z/n),
    gs(/\A\x98\x41\n\z/n),
    gs(/\A\x98\x41\z/n),
    gs(/\A\x98\x41\z/n),
    gs(/\A\x98\x44\z/n),
    gs(/\A\x98\x4f\z/n),
    gs(/\A\x99\x48\z/n),
    gs(/\A\x99\x54\z/n),
    gs(/\A\x99\x9a\?\z/n),
    gs(/\A\x99\x9a\x9b\xb8\xb9\xba\xbb\z/n),
    gs(/\A\x99\x9a\z/n),
    gs(/\A\x9a\x54\z/n),
    gs(/\A\x9a\x84\z/n),
    gs(/\A\x9a\x99\x99\x40\z/n),
    gs(/\A\x9a\xf0\z/n),
    gs(/\A\x9a\xfc\z/n),
    gs(/\A\x9b\x43\z/n),
    gs(/\A\x9b\xc4\z/n),
    gs(/\A\x9c\x98\z/n),
    gs(/\A\x9d\x6c\z/n),
    gs(/\A\x9d\xe0\z/n),
    gs(/\A\x9e\xa8\z/n),
    gs(/\A\x9e\xb4\z/n),
    gs(/\A\x9f\x7c\z/n),
    gs(/\A\x9f\x80\xb5\z/n),
    gs(/\A\x9f\x88\z/n),
    gs(/\A\x9f\xd8\z/n),
    gs(/\A\xab\x0a\z/n),
    gs(/\A\xae\xc3\x81\x7e\z/n),
    gs(/\A\xb0\x8f\x40\x8f\x4f\z/n),
    gs(/\A\xc0\xda\z/n),
    gs(/\A\xc0\xe4\z/n),
    gs(/\A\xc1\xc0\z/n),
    gs(/\A\xc1\xc8\z/n),
    gs(/\A\xc1\xd0\z/n),
    gs(/\A\xc1\xdc\z/n),
    gs(/\A\xc1\xe4\z/n),
    gs(/\A\xc1\xf0\z/n),
    gs(/\A\xc1\xfc\z/n),
    gs(/\A\xc2\xc0\z/n),
    gs(/\A\xc2\xc8\z/n),
    gs(/\A\xc2\xd8\z/n),
    gs(/\A\xc2\xfa\z/n),
    gs(/\A\xc3\x89\x80\z/n),
    gs(/\A\xc3\xc4\z/n),
    gs(/\A\xc3\xc8\z/n),
    gs(/\A\xc3\xe1\z/n),
    gs(/\A\xc3\xfa\z/n),
    gs(/\A\xc4\x9d\x80\z/n),
    gs(/\A\xc4\xc3\z/n),
    gs(/\A\xc4\xfa\z/n),
    gs(/\A\xc5\x83\x40\z/n),
    gs(/\A\xc5\x89\x80\z/n),
    gs(/\A\xc5\x8a\x5c\z/n),
    gs(/\A\xc5\x8a\x84\z/n),
    gs(/\A\xc5\x8c\xa0\z/n),
    gs(/\A\xc5\x8f\xc0\z/n),
    gs(/\A\xc5\x91\x50\z/n),
    gs(/\A\xc5\x92\xe0\z/n),
    gs(/\A\xc5\x94\x70\z/n),
    gs(/\A\xc6\xe0\z/n),
    gs(/\A\xc7\xc0\z/n),
    gs(/\A\xc8\xc2\z/n),
    gs(/\A\xc8\xc3\z/n),
    gs(/\A\xc8\xd4\z/n),
    gs(/\A\xc8\xf4\z/n),
    gs(/\A\xc8\xff\z/n),
    gs(/\A\xc9\xd4\z/n),
    gs(/\A\xc9\xe0\z/n),
    gs(/\A\xcb\xc0\z/n),
    gs(/\A\xcc\xcd\z/n),
    gs(/\A\xcc\xfc\z/n),
    gs(/\A\xcc\xfc\z/n),
    gs(/\A\xcd\xcc\x8c\x40\z/n),
    gs(/\A\xcd\xcc\x9c\xc0\z/n),
    gs(/\A\xcd\xd8\z/n),
    gs(/\A\xce\xa5\z/n),
    gs(/\A\xce\xfc\z/n),
    gs(/\A\xcf\x83\x40\x83\xaa\z/n),
    gs(/\A\xd2\xcc\z/n),
    gs(/\A\xd2\xe4\z/n),
    gs(/\A\xd4\xc3\z/n),
    gs(/\A\xd5\xc4\z/n),
    gs(/\A\xd8\xf0\z/n),
    gs(/\A\xd9\xf0\z/n),
    gs(/\A\xd9\xfc\z/n),
    gs(/\A\xda\xc4\z/n),
    gs(/\A\xda\xc8\z/n),
    gs(/\A\xda\xcc\z/n),
    gs(/\A\xdb\xc4\z/n),
    gs(/\A\xdb\xd8\z/n),
    gs(/\A\xdb\xe4\z/n),
    gs(/\A\xdc\xc1\z/n),
    gs(/\A\xdc\xe4\z/n),
    gs(/\A\xde\xf0\z/n),
    gs(/\A\xe0\xff\z/n),
    gs(/\A\xe1\x88\x90\x89\?\z/n),
    gs(/\A\xe1\xc3\z/n),
    gs(/\A\xe2\xec\z/n),
    gs(/\A\xe5\x88\z/n),
    gs(/\A\xe5\xf8\z/n),
    gs(/\A\xe8\xff\z/n),
    gs(/\A\xed\xc3\z/n),
    gs(/\A\xef\xe0\z/n),
    gs(/\A\xf1\xe0\z/n),
    gs(/\A\xf1\xf8\z/n),
    gs(/\A\xf4\xec\z/n),
    gs(/\A\xf6\xff\xf6\xff\x8a\xbf\z/n),
    gs(/\A\xfa\xc2\z/n),
    gs(/\A\xfa\xc3\z/n),
    gs(/\A\xff\x20\x8c\x44\z/n),
    gs(/\A<=>\?@ABC.*\z/mn),
    gs(/\A0\x8b\x40\x8b\xcf\z/n),
    gs(/\AAH\z/n),
    gs(/\AAp\z/n),
    gs(/\AAP\z/n),
    gs(/\ABd\z/n),
    gs(/\ABH\z/n),
    gs(/\ABh\z/n),
    gs(/\ABL\z/n),
    gs(/\ABp\z/n),
    gs(/\ABP\z/n),
    gs(/\ABt\z/n),
    gs(/\ABX\z/n),
    gs(/\ACa\z/n),
    gs(/\ACd\z/n),
    gs(/\ACh\z/n),
    gs(/\ACH\z/n),
    gs(/\ACL\z/n),
    gs(/\ACl\z/n),
    gs(/\ACn\z/n),
    gs(/\ACN\z/n),
    gs(/\ACp\z/n),
    gs(/\ACT\z/n),
    gs(/\ACV\z/n),
    gs(/\ACX\z/n),
    gs(/\ACx\z/n),
    gs(/\ACz\z/n),
    gs(/\AddD0\z/n),
    gs(/\AddF3\z/n),
    gs(/\AddF3d\z/n),
    gs(/\AddFL\z/n),
    gs(/\AddFLd\z/n),
    gs(/\AddJK\z/n),
    gs(/\ADy\xc0\z/n),
    gs(/\Aff@fff\z/n),
    gs(/\AGH\z/n),
    gs(/\AHB\z/n),
    gs(/\AIt\z/n),
    gs(/\AJj\z/n),
    gs(/\ALB\z/n),
    gs(/\Alz\z/n),
    gs(/\ANl\z/n),
    gs(/\Aop\z/n),
    gs(/\AOr\z/n),
    gs(/\AOro\z/n),
    gs(/\APF\z/n),
    gs(/\Aql\z/n),
    gs(/\Arz\z/n),
    gs(/\Auz\z/n),
    gs(/\AVU\z/n),
    gs(/\AWl\z/n),
    gs(/\AXB\z/n),
    gs(/\Axi\z/n),
    gs(/\AXU\z/n),
    gs(/\AYF\z/n),
    gs(/\AZh\z/n),
    gs(/\Azl\z/n),

    # Valid strings
    gs(/\A(-->)\z/n, '\1'),
    gs(/\A(-?inf)\z/n, '\1'),
    gs(/\A(-?INF)\z/n, '\1'),
    gs(/\A(-?nan)\z/n, '\1'),
    gs(/\A(-?NAN)\z/n, '\1'),
    gs(/\A(-{2,})\z/n, '\1'),
    gs(/\A(?!.*({lwrw})\1{2,})(_{lwrw}{3,})\z/n, '\2'),
    gs(/\A(?!.*({lwrw})\1{2,})({lwrw}{2,3}_)\z/n, '\2'),
    gs(/\A(?!.*({lwrw})\1{2,})({lwrw}+(?>_{lwrw}+)+)\z/n, '\2'),
    gs(/\A(?!.*({uprw})\1)(_{uprw}{3,})\z/n, '\2'),
    gs(/\A(?!.*({uprw})\1)({uprw}{2,3}_)\z/n, '\2'),
    gs(/\A(?!.*({uprw})\1|.*({uprw}).\2.\2)({uprw}+(_{uprw}+)+)\z/n, '\3'),
    gs(/\A((?!{anyw}){jap}(?>\n|{finj}))\z/n, '\1'),
    gs(/\A((?!{anyw}){jap}({blk})\2*:\2*)\z/n, '\1'),
    gs(/\A((?!{anyw}){jap}({blk})\2*(?!{anyw}){jap})\z/n, '\1'),
    gs(/\A((?!{anyw}){jap}{2,}{uprj}{2})\z/n, '\1'),
    gs(/\A((?!{anyw}){jap}{3,}{dgt})\z/n, '\1'),
    gs(/\A((?!{anyw}){jap}{3,}{dgt}{3}{alp})\z/n, '\1'),
    gs(/\A((?!{anyw}){jap}{3,}{upr})\z/n, '\1'),
    gs(/\A((?!{anyw}){jap}+\((?!{anyw}){jap}+\))\z/n, '\1'),
    gs(/\A((?=.{5,})\/BCHARA)\z/n, '\1'),
    gs(/\A((?=.{5,})\/BEFF)\z/n, '\1'),
    gs(/\A((?=.{5,})\/manifest)\z/n, '\1'),
    gs(/\A((?=.{5,})\\BCHARA)\z/n, '\1'),
    gs(/\A((?=.{5,})\\BEFF)\z/n, '\1'),
    gs(/\A((?=.{5,})\\manifest)\z/n, '\1'),
    gs(/\A((?=.{8,}){file})\z/n, '\1'),
    gs(/\A((?=.{8,})\/{file})\z/n, '\1'),
    gs(/\A((?=.{8,})\/{path})\z/n, '\1'),
    gs(/\A((?=.{8,})\\{file})\z/n, '\1'),
    gs(/\A((?=.{8,})\\{path})\z/n, '\1'),
    gs(/\A((?=[Ee]ff_{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=Display{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=effect){funct})\z/n, '\1'),
    gs(/\A((?=esa{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=event){funct})\z/n, '\1'),
    gs(/\A((?=fld{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=go{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=hasigo){funct})\z/n, '\1'),
    gs(/\A((?=house){funct})\z/n, '\1'),
    gs(/\A((?=khouse){funct})\z/n, '\1'),
    gs(/\A((?=kyori){funct})\z/n, '\1'),
    gs(/\A((?=lock){funct})\z/n, '\1'),
    gs(/\A((?=mot(?!ion){alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=Mtrain){funct})\z/n, '\1'),
    gs(/\A((?=NoPutfld{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=obj{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=pchar){funct})\z/n, '\1'),
    gs(/\A((?=pla{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=revent){funct})\z/n, '\1'),
    gs(/\A((?=roll){funct})\z/n, '\1'),
    gs(/\A((?=rope){funct})\z/n, '\1'),
    gs(/\A((?=sal{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=sb_{alp}{3,}){funct})\z/n, '\1'),
    gs(/\A((?=scpt{sng}{10,}){funct}.*?)\z/n, '\1'),
    gs(/\A((?=smoke){funct})\z/n, '\1'),
    gs(/\A((?=stage){funct})\z/n, '\1'),
    gs(/\A((?=tevent){funct})\z/n, '\1'),
    gs(/\A((?=train){funct})\z/n, '\1'),
    gs(/\A((?=wall){funct})\z/n, '\1'),
    gs(/\A((?=Wdisk){funct})\z/n, '\1'),
    gs(/\A((?>(\n|{blkw})+{alp}){2,}\2*{alp}?)\z/n, '\1'),
    gs(/\A((?>(\n|{blkw})+{jap}){2,}\2*{jap}?)\z/n, '\1'),
    gs(/\A((?>{alp}(\n|{blkw})+){2,}\2*{alp}?)\z/n, '\1'),
    gs(/\A((?>{jap}(\n|{blkw})+){2,}\2*{jap}?)\z/n, '\1'),
    gs(/\A((?>\?{blkw}){8})\z/n, '\1'),
    gs(/\A((?>\n|{blkw})*{upr}+:(?>\n|{blkw})*)\z/n, '\1'),
    gs(/\A((?>\n|{blkw})*{uprw2}{dgtw}-{dgtw2}(?>\(B\))?:{blkw}*)\z/n, '\1'),
    gs(/\A((?>\x81\x48){3})\z/n, '\1'),
    gs(/\A((?>\x81\x48){8})\z/n, '\1'),
    gs(/\A((?>A|B|CR|G|MFB){blkw}+{sprntf})\z/n, '\1'),
    gs(/\A(({blkw}){dgtw}{uprw}\2*:\2*)\z/n, '\1'),
    gs(/\A(({blkw}){uprw}{dgtw}\2*:\2*)\z/n, '\1'),
    gs(/\A([0-1]{dgtw}{2}{alpw}(?>_{dgtw}{2})?)\z/n, '\1'),
    gs(/\A([A-D][0-2])\z/n, '\1', platform: 'DC'),
    gs(/\A([ab]\.mld)\z/n, '\1'),
    gs(/\A({blkw}*(?>2D|3D){blkw}*)\z/n, '\1'),
    gs(/\A({blkw}*(?>All|ON|OFF){blkw}*)\z/n, '\1'),
    gs(/\A({blkw}*{uprw2}{lwrw}+(2D|3D))\z/n, '\1'),
    gs(/\A({blkw}*0{blkw}+\.{blkw}+-{blkw}+E{blkw}*)\z/n, '\1'),
    gs(/\A({blkw}*1{blkw}+2{blkw}+3{blkw}+I\/D{blkw}*)\z/n, '\1'),
    gs(/\A({blkw}*4{blkw}+5{blkw}+6{blkw}+R{blkw}*)\z/n, '\1'),
    gs(/\A({blkw}*7{blkw}+8{blkw}+9{blkw}+C)\z/n, '\1'),
    gs(/\A({blkw}*A{blkw}+B{blkw}+C{blkw}+\*\*\*{blkw}*)\z/n, '\1'),
    gs(/\A({blkw}*D{blkw}+E{blkw}+F{blkw}+\*\*\*{blkw}*)\z/n, '\1'),
    gs(/\A({blkw}*S{blkw}+U{blkw}+H{blkw}+F{blkw}*)\z/n, '\1'),
    gs(/\A({dgtj})\z/n, '\1'),
    gs(/\A({dgtw}{3}_?{lwrw}?(?>\.{lwrw}{3}|\.p{dgtw}{2}))\z/n, '\1'),
    gs(/\A({dgtw}{3}_?{uprw}?(?>\.{uprw}{3}|\.P{dgtw}{2}))\z/n, '\1'),
    gs(/\A({dgtw}{uprw}({blkw})\2*:\2*)\z/n, '\1'),
    gs(/\A({dgtw}+\.{uprw}{3})\z/n, '\1'),
    gs(/\A({dgtw}+\.{uprw}{3})\z/n, '\1'),
    gs(/\A({lwrw}+{dgtw}+\.{lwrw}{3})\z/n, '\1'),
    gs(/\A({lwrw}+\.{lwrw}{3})\z/n, '\1'),
    gs(/\A({prg})\z/nx, '\1'),
    gs(/\A({sprntf}+)\z/n, '\1'),
    gs(/\A({uprj}{2}{jap}{2,}{dgtj})\z/n, '\1'),
    gs(/\A({uprw}{dgtw}?({blkw})\2*(:\2*))\z/n, '\1'),
    gs(/\A({uprw}{lwrw}+[\-']{lwrw}+)\z/n, '\1'),
    gs(/\A({uprw}{lwrw}+{finw})\z/n, '\1'),
    gs(/\A({uprw}+{dgtw}+\.{uprw}{3})\z/n, '\1'),
    gs(/\A({uprw}+\.{uprw}{3})\z/n, '\1'),
    gs(/\A({wrd}(?>{spc}{wrd})*{spc}?\({wrd}(?>{spc}{wrd})*\))\z/nx, '\1'),
    gs(/\A(\?(?>{blkw}\?){2})\z/n, '\1'),
    gs(/\A(\?(?>{blkw}\?){7})\z/n, '\1'),
    gs(/\A(\?{3})\z/n, '\1'),
    gs(/\A(\?{6})\z/n, '\1'),
    gs(/\A(\.{alpw}{dgtw}{2})\z/n, '\1'),
    gs(/\A(\.{lwrw}{3})\z/n, '\1'),
    gs(/\A(\.{uprw}{3})\z/n, '\1'),
    gs(/\A(\.\.)\z/n, '\1'),
    gs(/\A(\.sd)\z/n, '\1'),
    gs(/\A(\({wrd}(?>{spc}{wrd})*\))\z/nx, '\1'),
    gs(/\A(\(c\)CRI)\z/n, '\1'),
    gs(/\A(\[{sprntf}\].*?)\z/mn, '\1'),
    gs(/\A(\*{8,}\n)\z/n, '\1'),
    gs(/\A(\x81\x9b)\z/n, '\1'),
    gs(/\A(\x81\x9b)\z/n, '\1'),
    gs(/\A(\x81\x9c)\z/n, '\1'),
    gs(/\A(\x81\x9c)\z/n, '\1'),
    gs(/\A(\x81\xa8)\z/n, '\1'),
    gs(/\A(\x82\x64)\z/n, '\1'),
    gs(/\A(\x82\x77)\z/n, '\1'),
    gs(/\A(%s%dx%d)\z/n, '\1'),
    gs(/\A(={3,}\n?)\z/n, '\1'),
    gs(/\A(0123456789)\z/n, '\1'),
    gs(/\A(099a(?>_{dgtw}{2})?)\z/in, '\1'),
    gs(/\A(6107810{spc}*)\z/n, '\1'),
    gs(/\A(8320062 50{spc}*)\z/n, '\1'),
    gs(/\A(a{dgtw}{3}{lwrw}*{dgtw}*_?{lwrw}*(?>\.{lwrw}{3})?)\z/in, '\1'),
    gs(/\A(A{dgtw}{3}{uprw}*{dgtw}*_?{uprw}*(?>\.{uprw}{3})?)\z/in, '\1'),
    gs(/\A(append)\z/n, '\1'),
    gs(/\A(b{dgtw}{4}(?>\.{lwrw}{3})?)\z/in, '\1'),
    gs(/\A(B{dgtw}{4}(?>\.{uprw}{3})?)\z/in, '\1'),
    gs(/\A(b{dgtw}{7}_?{lwrw}?(?>\.{lwrw}{3,4}|\.p{dgtw}{2})?)\z/in, '\1'),
    gs(/\A(B{dgtw}{7}_?{uprw}?(?>\.{uprw}{3,4}|\.P{dgtw}{2})?)\z/in, '\1'),
    gs(/\A(camera)\z/n, '\1'),
    gs(/\A(CD00{dgtw})\z/n, '\1'),
    gs(/\A(change)\z/n, '\1'),
    gs(/\A(chgptnmat)\z/n, '\1'),
    gs(/\A(cr{dgtw}{3,4}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(CR{dgtw}{3,4}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(deformv)\z/n, '\1'),
    gs(/\A(deformv)\z/n, '\1'),
    gs(/\A(door1)\z/n, '\1'),
    gs(/\A(door2)\z/n, '\1'),
    gs(/\A(doorwall)\z/n, '\1'),
    gs(/\A(drop)\z/n, '\1'),
    gs(/\A(E{dgtw}{7}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(e{dgtw}{7}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(e{dgtw}{alpw}{dgtw}{3}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(E{dgtw}{uprw}{dgtw}{3}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(eff_?{wrdw}+{dgtw}*)\z/mn, '\1'),
    gs(/\A(esea{dgtw}{4}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(ESEA{dgtw}{4}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(f{dgtw}{7}_?{lwrw}?(?>\.{lwrw}{3,4}|\.p{dgtw}{2})?)\z/n, '\1'),
    gs(/\A(F{dgtw}{7}_?{uprw}?(?>\.{uprw}{3,4}|\.P{dgtw}{2})?)\z/n, '\1'),
    gs(/\A(fmt)\z/n, '\1'),
    gs(/\A(fscranim)\z/n, '\1'),
    gs(/\A(fstone)\z/n, '\1'),
    gs(/\A(ground)\z/n, '\1'),
    gs(/\A(hasi)\z/n, '\1'),
    gs(/\A(HDR-{dgtw}{4}{spc}*)\z/n, '\1'),
    gs(/\A(hload)\z/n, '\1'),
    gs(/\A(housi)\z/n, '\1'),
    gs(/\A(IGN{dgtw}{spc}*)\z/n, '\1'),
    gs(/\A(k{dgtw}{4}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(K{dgtw}{4}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(k{dgtw}{6}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(K{dgtw}{6}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(k{dgtw}{7}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(K{dgtw}{7}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(kagi)\z/n, '\1'),
    gs(/\A(kdoor1)\z/n, '\1'),
    gs(/\A(kisiue)\z/n, '\1'),
    gs(/\A(kisiue})\z/n, '\1'),
    gs(/\A(kmap)\z/n, '\1'),
    gs(/\A(kmap)\z/n, '\1'),
    gs(/\A(kmodel)\z/n, '\1'),
    gs(/\A(ko{dgtw}{4}_?{lwrw}?(?>\.{lwrw}{3}|\.p{dgtw}{2})?)\z/n, '\1'),
    gs(/\A(KO{dgtw}{4}_?{uprw}?(?>\.{uprw}{3}|\.P{dgtw}{2})?)\z/n, '\1'),
    gs(/\A(kse{dgtw}{3}{lwrw}{dgtw}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(KSE{dgtw}{3}{uprw}{dgtw}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(linePut)\z/n, '\1'),
    gs(/\A(m{dgtw}{2}_?{lwrw}?(?>\.{lwrw}{3,4}|\.p{dgtw}{2})?)\z/n, '\1'),
    gs(/\A(M{dgtw}{2}_?{uprw}?(?>\.{uprw}{3,4}|\.P{dgtw}{2})?)\z/n, '\1'),
    gs(/\A(m{dgtw}{2}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(M{dgtw}{2}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(m{dgtw}{4}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(M{dgtw}{4}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(m{dgtw}{7}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(M{dgtw}{7}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(man)\z/n, '\1'),
    gs(/\A(me{dgtw}{3}{lwrw}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(ME{dgtw}{3}{uprw}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(ME{dgtw}{3}{uprw}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(MK-{dgtw}{5}{spc}*)\z/n, '\1'),
    gs(/\A(MK-{dgtw}{5}{spc}*)\z/n, '\1'),
    gs(/\A(mod2p)\z/n, '\1'),
    gs(/\A(mse{dgtw}{3}{lwrw}{dgtw}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(MSE{dgtw}{3}{uprw}{dgtw}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(nametag)\z/n, '\1'),
    gs(/\A(noritama)\z/n, '\1'),
    gs(/\A(onepic)\z/n, '\1'),
    gs(/\A(POF[01])\z/n, '\1'),
    gs(/\A(pushwall)\z/n, '\1'),
    gs(/\A(pushwall)\z/n, '\1'),
    gs(/\A(r{dgtw}{3}{lwrw}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(R{dgtw}{3}{uprw}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(roll)\z/n, '\1'),
    gs(/\A(S{dgtw}{7}(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(s{dgtw}{7}(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(sb_?{wrdw}+{dgtw}*)\z/mn, '\1'),
    gs(/\A(stv{dgtw}{3}(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(STV{dgtw}{3}(?>\.{uprw}{3,4})?)\z/n, '\1'),
    gs(/\A(tamaoti)\z/n, '\1'),
    gs(/\A(tamaue)\z/n, '\1'),
    gs(/\A(tflag)\z/n, '\1'),
    gs(/\A(TONE(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(tone(?>\.{lwrw}{3,4})?)\z/n, '\1'),
    gs(/\A(treasure)\z/n, '\1'),
    gs(/\A(treasure)\z/n, '\1'),
    gs(/\A(ts{dgtw}{6}{lwrw}?(?>\.{lwrw}{3})?)\z/n, '\1'),
    gs(/\A(TS{dgtw}{6}{uprw}?(?>\.{uprw}{3})?)\z/n, '\1'),
    gs(/\A(TW{dgtw}{6})\z/n, '\1'),
    gs(/\A(tw{dgtw}{6})\z/n, '\1'),
    gs(/\A(untei)\z/n, '\1'),
    gs(/\A(vn8)\z/n, '\1'),
    gs(/\A(vnn)\z/n, '\1'),
    gs(/\A(wall)\z/n, '\1'),
    gs(/\A(yuki)\z/n, '\1'),
    gs(/\A{pct}+{alp}(\r\n(?={sng}{10,}){wrdgrpw}+.*?)\z/mn, '\1'),

    # Trim first invalid characters
    gs(/\A.*?{dia}+(\/{dir}\/)\z/mn, '\1'),
    gs(/\A.*?{ext}((?=.{10,})\\{path})\z/n, '\1'),
    gs(/\A.*?{sng}\x8c({dbl}+)\z/mn, '\1'),
    gs(/\A.*?\x8c((?=.{10,})\\{path})\z/mn, '\1'),
    gs(/\A.*?\x8c((?=.{8,}){file})\z/mn, '\1'),
    gs(/\A.*?\x8c((?={sng}{10,}){funct}.*?)\z/mn, '\1'),
    gs(/\A.*?\x8c((?={sng}{3,}){wrdw}:)\z/mn, '\1'),
    gs(/\A.*?\x8c((?={sng}{5,}){wrdgrpw}.*?)\z/mn, '\1'),
    gs(/\A.*?\x8c((?={sng}{7,}){wrdw})\z/n, '\1'),
    gs(/\A.*?\x8c({uprw}{3,})\z/mn, '\1'),
    gs(/\A.*?\x8c({uprw}{lwrw}{3,})\z/mn, '\1'),
    gs(/\A.*?\x8c(\\field)\z/mn, '\1'),
    gs(/\A.*?\x94((?={sng}{7,}){wrdgrpw}.*?)\z/mn, '\1'),
    gs(/\A.+(_L\.dsp)\z/n, '\1'),
    gs(/\A.+(_R\.dsp)\z/n, '\1'),
    gs(/\A.+((?=[Ee]ff_{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A.+((?=advertise){funct})\z/mn, '\1'),
    gs(/\A.+((?=eff_SS_){funct})\z/mn, '\1'),
    gs(/\A.+((?=eff){funct})\z/mn, '\1'),
    gs(/\A.+((?=effect){funct})\z/mn, '\1'),
    gs(/\A.+((?=esa{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A.+((?=go{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A.+((?=hakken){funct})\z/mn, '\1'),
    gs(/\A.+((?=hasigo){funct})\z/mn, '\1'),
    gs(/\A.+((?=khouse){funct})\z/mn, '\1'),
    gs(/\A.+((?=kyori){funct})\z/mn, '\1'),
    gs(/\A.+((?=lock){funct})\z/mn, '\1'),
    gs(/\A.+((?=Mtrain){funct})\z/mn, '\1'),
    gs(/\A.+((?=obj{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A.+((?=Pad){funct})\z/mn, '\1'),
    gs(/\A.+((?=pchange){funct})\z/mn, '\1'),
    gs(/\A.+((?=pchar){funct})\z/mn, '\1'),
    gs(/\A.+((?=revent){funct})\z/mn, '\1'),
    gs(/\A.+((?=sb_{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A.+((?=smoke){funct})\z/mn, '\1'),
    gs(/\A.+((?=stage){funct})\z/mn, '\1'),
    gs(/\A.+((?=tevent){funct})\z/mn, '\1'),
    gs(/\A.+((?=timing){funct})\z/mn, '\1'),
    gs(/\A.+((?=Wdisk){funct})\z/mn, '\1'),
    gs(/\A.+(\.mpb)\z/mn, '\1'),
    gs(/\A.+(%s\.STD)\z/mn, '\1'),
    gs(/\A.+(<< (?={sng}{10,}){wrdgrpw}.*?)\z/mn, '\1'),
    gs(/\A.+(abgABG)\z/mn, '\1'),
    gs(/\A.+(append)\z/mn, '\1'),
    gs(/\A.+(camera)\z/mn, '\1'),
    gs(/\A.+(chgptnmat)\z/mn, '\1'),
    gs(/\A.+(deformv)\z/mn, '\1'),
    gs(/\A.+(deformv)\z/mn, '\1'),
    gs(/\A.+(door2)\z/mn, '\1'),
    gs(/\A.+(doorwall)\z/mn, '\1'),
    gs(/\A.+(drop)\z/mn, '\1'),
    gs(/\A.+(dvd\.c)\z/mn, '\1'),
    gs(/\A.+(fscranim)\z/mn, '\1'),
    gs(/\A.+(fstone)\z/mn, '\1'),
    gs(/\A.+(hasi)\z/mn, '\1'),
    gs(/\A.+(hikaritubu)\z/mn, '\1'),
    gs(/\A.+(hload)\z/mn, '\1'),
    gs(/\A.+(housi)\z/mn, '\1'),
    gs(/\A.+(kagi)\z/mn, '\1'),
    gs(/\A.+(kdoor1)\z/mn, '\1'),
    gs(/\A.+(kisiue)\z/mn, '\1'),
    gs(/\A.+(kisiue})\z/mn, '\1'),
    gs(/\A.+(kmap)\z/mn, '\1'),
    gs(/\A.+(kmodel)\z/mn, '\1'),
    gs(/\A.+(linePut)\z/mn, '\1'),
    gs(/\A.+(mod2p)\z/mn, '\1'),
    gs(/\A.+(moonfish)\z/mn, '\1'),
    gs(/\A.+(nametag)\z/mn, '\1'),
    gs(/\A.+(noritama)\z/mn, '\1'),
    gs(/\A.+(onemotion)\z/mn, '\1'),
    gs(/\A.+(onepic)\z/mn, '\1'),
    gs(/\A.+(promi)\z/mn, '\1'),
    gs(/\A.+(pushwall)\z/mn, '\1'),
    gs(/\A.+(stormgrd)\z/mn, '\1'),
    gs(/\A.+(tama)\z/mn, '\1'),
    gs(/\A.+(tamaoti)\z/mn, '\1'),
    gs(/\A.+(tamaue)\z/mn, '\1'),
    gs(/\A.+(tflag)\z/mn, '\1'),
    gs(/\A.+(treasure)\z/mn, '\1'),
    gs(/\A.+(tw{dgtw}{6})\z/n, '\1'),
    gs(/\A.+(untei)\z/mn, '\1'),
    gs(/\A.+(vi\.c)\z/mn, '\1'),
    gs(/\A.+(vn8)\z/mn, '\1'),
    gs(/\A.+(vnn)\z/mn, '\1'),
    gs(/\A.+(yuki)\z/mn, '\1'),
    gs(/\A.+(zzzz)\z/mn, '\1'),
    gs(/\A(?!{spc}){sng}((?!{spc}+){dbl}{2,})\z/n, '\1'),
    gs(/\A(?!{spc}|.{alpw}){dbl}((?={sng}{7,}){wrdgrpw}+.*?)\z/n, '\1'),
    gs(/\A(?>(?![rt]event).)+((?=event){funct})\z/mn, '\1'),
    gs(/\A(?>(?!Basal).)+((?=sal{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A(?>(?!controll|Scroll).)+((?=roll){funct})\z/mn, '\1'),
    gs(/\A(?>(?!disk).)+(change)\z/mn, '\1'),
    gs(/\A(?>(?!Display).)+((?=pla{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A(?>(?!door|push).)+((?=wall){funct})\z/mn, '\1'),
    gs(/\A(?>(?!DVD).)+((?=DVD{alp}{5,}){funct}.*?)\z/mn, '\1'),
    gs(/\A(?>(?!eff).)+((?=mot(?!ion){alp}{2,}){funct})\z/mn, '\1'),
    gs(/\A(?>(?!fld).)+((?=General){funct})\z/mn, '\1'),
    gs(/\A(?>(?!Helmsman|Osman).)+(man)\z/mn, '\1'),
    gs(/\A(?>(?!khouse).)+((?=house){funct})\z/mn, '\1'),
    gs(/\A(?>(?!kmodel).)+((?=mod){funct})\z/mn, '\1'),
    gs(/\A(?>(?!lWmap).)+((?=map){funct})\z/mn, '\1'),
    gs(/\A(?>(?!Mtrain).)+((?=train){funct})\z/mn, '\1'),
    gs(/\A(?>(?!NJ).)+(NJBM.*?)\z/mn, '\1'),
    gs(/\A(?>(?!NJ).)+(NJCM.*?)\z/mn, '\1'),
    gs(/\A(?>(?!NoPut).)+((?=fld{alp}{3,}){funct})\z/mn, '\1'),
    gs(/\A(?>(?!Prope).)+((?=rope){funct})\z/mn, '\1'),
    gs(/\A(?>(?!Underground).)+(ground)\z/mn, '\1'),
    gs(/\A(?>{spc}+\xff+)+((?!{spc}+){dbl}{2,}.*?)\z/n, '\1'),
    gs(/\A(?>{spc}+\xff+)+((?!{spc}+){dbl}+)\z/n, '\1'),
    gs(/\A(?>{spc}+\xff+)+((?={sng}{7,}){funct})\z/n, '\1'),
    gs(/\A(?>{spc}+\xff+)+((?={sng}{7,}){wrdgrpw}.*?)\z/n, '\1'),
    gs(/\A[\x9b\x9e]({uprw}{lwrw}{3,})\z/n, '\1'),
    gs(/\A[\xfd-\xff]+((?={sng}{10,}){wrdgrpw})\z/n, '\1'),
    gs(/\A[\xfd-\xff]+((?={sng}{10,}){wrdw}, {wrdgrpw})\z/n, '\1'),
    gs(/\A[\xfd-\xff]+((?={sng}{7,}){wrdw})\z/n, '\1'),
    gs(/\A[\xfe-\xff]+((?={sng}{7,}){wrdgrpw})\z/n, '\1'),
    gs(/\A{alp}{spc}+((?>(?={jap}){dbl}){2,})\z/mn, '\1'),
    gs(/\A{alpw}((?=.{10,})\\{path})\z/n, '\1'),
    gs(/\A{alpw}((?={uprw}{lwrw}{2,}){wrdw})\z/n, '\1'),
    gs(/\A{alpw}((?={uprw}{lwrw}{sng}{8,}){wrdgrpw})\z/n, '\1'),
    gs(/\A{alpw}(\*{8,}\n)\z/n, '\1'),
    gs(/\A{dbl}({uprw}{7,})\z/n, '\1'),
    gs(/\A{dgt}+((?={sng}{7,}){wrdgrpw})\z/n, '\1'),
    gs(/\A{dgt}+((?={uprw}{lwrw}{2,}){wrdw})\z/n, '\1'),
    gs(/\A{dia}((?=.{7,}){wrdgrpw}+.*?)\z/mn, '\1'),
    gs(/\A{dia}{3,}((?={sng}{7,}){wrdgrpw})\z/n, '\1'),
    gs(/\A{dia}{uprw}(?={uprw}{lwrw})((?={sng}{10,}){wrdgrpw}.*?)\z/mn, '\1'),
    gs(/\A{dia}+(icon3%02d)\z/n, '\1'),
    gs(/\A{dia}+{alpw}((?!{spc}+){dbl}+)\z/n, '\1'),
    gs(/\A{ext}+((?!{spc}+){dbl}+)\z/n, '\1'),
    gs(/\A{ext}+({uprw}{lwrw}{2,})\z/n, '\1'),
    gs(/\A{jap}{alp}{pct}+((?={uprw}{sng}{5,}){wrdgrpw}.*?)\z/mn, '\1'),
    gs(/\A{lwrw}({uprw}+(?>_{uprw}+)+.*?)\z/n, '\1'),
    gs(/\A{lwrw}{uprw}({dbl}{3,})\z/n, '\1'),
    gs(/\A{pct}{dia}({dgtj})\z/n, '\1'),
    gs(/\A{pct}*\?((?={sng}{7,}){wrdgrpw}+.*?)\z/mn, '\1'),
    gs(/\A{pct}+((?={sng}{10,})man.*?)\z/mn, '\1'),
    gs(/\A{pct}+((?={sng}{7,}){wrdgrpw})\z/n, '\1'),
    gs(/\A{pct}+((?=sbScene{sng}{10,}){funct}.*?)\z/mn, '\1'),
    gs(/\A{pct}+((?=scpt{sng}{10,}){funct}.*?)\z/mn, '\1'),
    gs(/\A{pct}+((?>(?={jap}){dbl}){3,})\z/n, '\1'),
    gs(/\A{pct}+((?>(?={jap}){dbl}){3,}{dgt}+)\z/n, '\1'),
    gs(/\A{pct}+({lwrw}{7,})\z/n, '\1'),
    gs(/\A{pct}+({uprw}{3,})\z/n, '\1'),
    gs(/\A{pct}+(CR{blkw}+{sprntf})\z/mn, '\1'),
    gs(/\A{pct}+{alp}(\r\n(?={sng}{10,}){wrdgrpw}+.*?)\z/mn, '\1'),
    gs(/\A{pct}+{alp}{dia}+((?>(?={jap}){dbl}){2,})\z/n, '\1'),
    gs(/\A{pct}+{alp}{dia}+((?>(?={jap}){dbl}){2,}{upr})\z/n, '\1'),
    gs(/\A{pct}+{alp}{dia}+({uprw}{lwrw}{3,})\z/mn, '\1'),
    gs(/\A{pct}+{alp}{pct}+((?>(?={jap}){dbl}){2,})\z/n, '\1'),
    gs(/\A{pct}+{alpw}((?={uprw}{lwrw}{sng}{5,}){wrdgrpw})\z/n, '\1'),
    gs(/\A{pct}+{dbl}(%s\n)\z/n, '\1'),
    gs(/\A{pct}+{dgt}+{pct}+((?=.{10,})\\{path})\z/n, '\1'),
    gs(/\A{pct}+{dia}+((?={sng}{10,}){wrdgrpw})\z/n, '\1'),
    gs(/\A{pct}+{dia}+{spc}+(%s\n)\z/n, '\1'),
    gs(/\A{sng}+\x8c((?!{spc}+){dbl}+)\z/n, '\1'),
    gs(/\A{spc}+((?={sng}{5,}){wrdw})\z/n, '\1'),
    gs(/\A{spc}+((?>(?={jap}){dbl}){3,})\z/n, '\1'),
    gs(/\A{spc}+((?>(?={jap}){dbl}){3,}{dgt}+)\z/n, '\1'),
    gs(/\A{spc}+((?>\/{dir})+{sprntf})\z/n, '\1'),
    gs(/\A{spc}+{alpw}((?>(?={jap}){dbl}){3,})\z/n, '\1'),
    gs(/\A\?((?=.{10,})\\{path})\z/n, '\1'),
    gs(/\A\?((?={alp}{3,}){funct})\z/n, '\1'),
    gs(/\A\?((?={sng}{10,}){funct}.*?)\z/mn, '\1'),
    gs(/\A\?({sprntf}:{sprntf}.*?)\z/mn, '\1'),
    gs(/\A\?(\[{sprntf}\].*?)\z/mn, '\1'),
    gs(/\A\n((?={sng}{7,}){wrdgrpw})\z/n, '\1'),
    gs(/\A\x8c((?={sng}{3,}){funct})\z/n, '\1'),
    gs(/\A\x94({lwrw}{7,})\z/n, '\1'),
    gs(/\A\xff(\n(?={sng}{7,}){funct}.*?)\z/mn, '\1'),
    gs(/\A\xff+({uprw}{3,}.*?)\z/mn, '\1'),
    gs(/\Ax((?={sng}{3,}){funct})\z/n, '\1'),

    # Garbage strings
    gs(/\A(?!{spc}+){dbl}{8,}{ext}{8,}{dbl}{6,}{ext}{6,}\z/n),
    gs(/\A(?>{alp}{dgt}+{jap})+{pct}+{dia}+\z/n),
    gs(/\A(?>{alp}{pct}+)+{alp2}{dia}+\z/n),
    gs(/\A(?>{alp}{pct}+{jap})+{alp}\z/n),
    gs(/\A(?>{alp}|{dia}){spc}\z/n),
    gs(/\A(?>{dgt}*{jap3}?{alp}{pct}+){2,}{jap3}\z/n),
    gs(/\A(?>{dgt}+{jap2}){2,}\z/n),
    gs(/\A(?>{dia}+{dgt}+{jap})+\z/n),
    gs(/\A(?>{dia}+{pct}+{jap})+\z/n),
    gs(/\A(?>{dia}+{spc}+)+{dia}+{pct}+{spc}+{dia}+\z/n),
    gs(/\A(?>{dia2}{upr}{pct}+)+\z/n),
    gs(/\A(?>{pct}+{alp})+{dia}+{pct}+\z/n),
    gs(/\A(?>{pct}+{alp}{jap})+{pct}+{alp}{pct}+\z/n),
    gs(/\A(?>{pct}+{alp}{jap})+{pct}+{alp}\z/n),
    gs(/\A(?>{pct}+{dgt}+)+{pct}+\z/n),
    gs(/\A(?>{pct}+{dgt}+)+\z/n),
    gs(/\A(?>{pct}+{dia}+)+\z/n),
    gs(/\A(?>{pct}+{dia}+{jap})+{pct}+{dia}+{alp}\z/n),
    gs(/\A(?>{pct}+{jap}){3,}\z/n),
    gs(/\A(?>{pct}+{jap})+{alp}\z/n),
    gs(/\A(?>{pct}+{jap})+{pct}+{dia}+\z/n),
    gs(/\A(?>{spc}|{pct}){2,}\z/n),
    gs(/\A(.)\1+\z/mn),
    gs(/\A({alp})\1{3,}{alp}\z/n),
    gs(/\A{alp}{dgt}+{alp}{fpct}+{alp}\z/n),
    gs(/\A{alp}{dgt}+{alp2}{pct}+\z/n),
    gs(/\A{alp}{dgt}+{fspc}+{alp}{pct}+\z/n),
    gs(/\A{alp}{dgt}+{pct}+{alp}\z/n),
    gs(/\A{alp}{dgt}+{pct}+\z/n),
    gs(/\A{alp}{dgt}+{spc}+{pct}+{alp}\z/n),
    gs(/\A{alp}{dgt}+{spc}+\z/n),
    gs(/\A{alp}{dgt}+\z/n),
    gs(/\A{alp}{dia}+{alp}{pct}+{dia}+\z/n),
    gs(/\A{alp}{dia}+{alp}{pct}+\z/n),
    gs(/\A{alp}{dia}+{dgt}+{jap}\z/n),
    gs(/\A{alp}{dia}+{dgt}+\z/n),
    gs(/\A{alp}{dia}+{pct}+{alp}\z/n),
    gs(/\A{alp}{dia}+{pct}+{dgt}+\z/n),
    gs(/\A{alp}{dia}+\z/n),
    gs(/\A{alp}{fpct}+{alp}\z/n),
    gs(/\A{alp}{fspc}+\z/n),
    gs(/\A{alp}{jap}{fspc}+\z/n),
    gs(/\A{alp}{pct}+{alp}{jap2}\z/n),
    gs(/\A{alp}{pct}+{dia}+{alp}{dia}+\z/n),
    gs(/\A{alp}{pct}+{jap}{alp}{pct}+{jap}\z/n),
    gs(/\A{alp}{pctw}+{alp}{jap}{dia}+{spc}+\z/n),
    gs(/\A{alp}{pctw}+{dgt}+{jap}\z/n),
    gs(/\A{alp}{spc}+{alp}{dgt}+{alp2}{pct}+\z/n),
    gs(/\A{alp}{spc}+{alp}\z/n),
    gs(/\A{alp}{spc}+{dia}+\z/n),
    gs(/\A{alp}{upr}{dia}+\z/n),
    gs(/\A{alp2}{dgt}+\z/n),
    gs(/\A{alp2}{fpct}+{alp}{dia}+\z/n),
    gs(/\A{alp2}{fpct}+{alp}\z/n),
    gs(/\A{alp2}{pct}+{alp}{dgt}+\z/n),
    gs(/\A{alp2}{pct}+{dgt}+\z/n),
    gs(/\A{alp2}{pct}+{dia}+\z/n),
    gs(/\A{alp2}{pct}+{jap}{alp}{pct}+{jap}\z/n),
    gs(/\A{alp2}{pct}+{jap}{pct}+{jap}\z/n),
    gs(/\A{alp2}{pct}+{spc}+\z/n),
    gs(/\A{alp3}{dgt}+{jap}{alp2}{dia2}{alp2}\z/n),
    gs(/\A{alp3}{fpct}+{alp}\z/n),
    gs(/\A{alp3}{pct}+{dgt}+{aljap3}{pct}+{aljap2}{pct}+{dgt}+{alp}{pct}+\z/n),
    gs(/\A{alp3}{pct}+{dgt}+{jap3}{alp3}{pct}+\z/n),
    gs(/\A{alp3}{pct}+{dia}+\z/n),
    gs(/\A{alp3}{pct}+\z/n),
    gs(/\A{alpw}{jap}{alpw}\z/n),
    gs(/\A{alpw}{jap}\z/n),
    gs(/\A{alpw2}{dia}+{pct}+\z/n),
    gs(/\A{dgt}{lwr}\z/n),
    gs(/\A{dgt}+(?>{pct}+{dia}+)+{pct}+\z/n),
    gs(/\A{dgt}+(?>{pct}+{dia}+)+\z/n),
    gs(/\A{dgt}+{alp}{dgt}+{dia}+{spc}+{alp}\z/n),
    gs(/\A{dgt}+{alp}{dgt}+{dia}+{spc}+{dia}+\z/n),
    gs(/\A{dgt}+{alp}{dgt}+{pct}+\z/n),
    gs(/\A{dgt}+{alp}{dia}+{alp}{pct}+{dia}+\z/n),
    gs(/\A{dgt}+{alp}{dia}+\z/n),
    gs(/\A{dgt}+{alp}{jap2}(?>{pct}+{alp}){2,}{jap2}\z/n),
    gs(/\A{dgt}+{alp}{jap2}{pct}+{alp}{jap4}\z/n),
    gs(/\A{dgt}+{alp}{pct}+{dia}+{pct}+\z/n),
    gs(/\A{dgt}+{alp}{pct}+{dia}+{spc}+{alp}\z/n),
    gs(/\A{dgt}+{alp}{pct}+{dia}+{spc}+{dia}+\z/n),
    gs(/\A{dgt}+{alp}{pct}+{jap}{alp}{pct}+{jap}\z/n),
    gs(/\A{dgt}+{alp}{pct}+\z/n),
    gs(/\A{dgt}+{alp}\z/n),
    gs(/\A{dgt}+{alp2}{dia}+{pct}+\z/n),
    gs(/\A{dgt}+{alp2}\z/n),
    gs(/\A{dgt}+{alp3}{pct}+{jap3}\z/n),
    gs(/\A{dgt}+{dia}+{alp}\z/n),
    gs(/\A{dgt}+{dia}+{dgt}+{jap}\z/n),
    gs(/\A{dgt}+{dia}+{jap}{pct}+{dia}+\z/n),
    gs(/\A{dgt}+{dia}+{pct}+\z/n),
    gs(/\A{dgt}+{dia}+\z/n),
    gs(/\A{dgt}+{fpct}+{spc}+{alp}{pct}+\z/n),
    gs(/\A{dgt}+{fpct}+{spc}+{dia}+{alp}{pct}+\z/n),
    gs(/\A{dgt}+{jap}{dia}+{dgt}+{jap}\z/n),
    gs(/\A{dgt}+{jap}\z/n),
    gs(/\A{dgt}+{jap3}({alp}{fpct}+{dgt}*)+\z/n),
    gs(/\A{dgt}+{pct}+{alp}{dia}+{pct}+{alp}{dgt}+\z/n),
    gs(/\A{dgt}+{pct}+{alp}{jap}\z/n),
    gs(/\A{dgt}+{pct}+{dgt}+{jap}\z/n),
    gs(/\A{dgt}+{pct}+{dgt}+{spc}+{alp}{pct}+\z/n),
    gs(/\A{dgt}+{pct}+{dgt}+{spc}+{pct}+{alp}\z/n),
    gs(/\A{dgt}+{pct}+{dgt}+{spc}+\z/n),
    gs(/\A{dgt}+{pct}+{dgt}+\z/n),
    gs(/\A{dgt}+{pct}+{dgt}+\z/n),
    gs(/\A{dgt}+{pct}+{dia}+{pct}+{alp}{pct}+\z/n),
    gs(/\A{dgt}+{pct}+{dia}+{pct}+\z/n),
    gs(/\A{dgt}+{pct}+{dia}+\z/n),
    gs(/\A{dgt}+{pct}+{spc}+{dia}+{pct}+{alp}\z/n),
    gs(/\A{dgt}+{pct}+{spc}+{pct}+{alp}\z/n),
    gs(/\A{dgt}+{pct}+{spc}+\z/n),
    gs(/\A{dgt}+{pct}+\z/mn),
    gs(/\A{dgt}+{spc}+{alp}{dia}+{pct}+\z/n),
    gs(/\A{dgt}+{spc}+{dgt}+{dia}+{pct}+\z/n),
    gs(/\A{dgt}+{spc}+{dgt}+\z/n),
    gs(/\A{dgt}+{spc}+{pct}+{dia}+{pct}+\z/n),
    gs(/\A{dgt}+{spc}+{pct}+\z/n),
    gs(/\A{dgt}+{spc}+{pct}+\z/n),
    gs(/\A{dgt}+{spc}+\z/n),
    gs(/\A{dgt}+\z/n),
    gs(/\A{dia}{3,}\z/n),
    gs(/\A{dia}+(?>{pct}+{alp})+\z/n),
    gs(/\A{dia}+{alp}{dia}{2,}\z/n),
    gs(/\A{dia}+{alp}{pct}+{jap}{alp}{pct}+{jap}\z/n),
    gs(/\A{dia}+{alp}{pct}+\z/n),
    gs(/\A{dia}+{alp}{spc}+{alp}\z/n),
    gs(/\A{dia}+{alp}{spc}+\z/n),
    gs(/\A{dia}+{alp}\z/n),
    gs(/\A{dia}+{dgt}+{jap}\z/n),
    gs(/\A{dia}+{dgt}+{pct}+\z/n),
    gs(/\A{dia}+{dgt}+{spc}+{alp}\z/n),
    gs(/\A{dia}+{dgt}+\z/n),
    gs(/\A{dia}+{fspc}+{dia}\z/n),
    gs(/\A{dia}+{fspc}+\z/n),
    gs(/\A{dia}+{jap}{dia}+{jap}{pct}+{dia}+\z/n),
    gs(/\A{dia}+{jap}{pct}+\z/n),
    gs(/\A{dia}+{pct}+{dgt}+{jap}\z/n),
    gs(/\A{dia}+{pct}+{dia}+{pct}+{dia}+{alp}{dia}+\z/n),
    gs(/\A{dia}+{pct}+{jap}\z/n),
    gs(/\A{dia}+{pct}+{spc}+{dia}+{alp}\z/n),
    gs(/\A{dia}+{pctw}+{jap}{pctw}+\z/n),
    gs(/\A{dia}+{upr}{dia}+\z/n),
    gs(/\A{ext}+(?!{spc}){dbl}{ext}+\z/n),
    gs(/\A{fpct}+{alp}{spc}+\z/n),
    gs(/\A{fpct}+{alp3}{pct}+\z/n),
    gs(/\A{fspc}+{alp}{pct}+{jap}{alp}{pct}+{jap}\z/n),
    gs(/\A{fspc}+{alp}\z/n),
    gs(/\A{fspc}+{dgt}+\z/n),
    gs(/\A{fspc}+{dia}+{alp}{dia}+{pct}+\z/n),
    gs(/\A{fspc}+{dia}+{fspc}+\z/n),
    gs(/\A{fspc}+{dia}+\z/n),
    gs(/\A{jap}{alp2}{dia2}\z/n),
    gs(/\A{jap}{alpw}\z/n),
    gs(/\A{jap}{dgt}+{jap}\z/n),
    gs(/\A{jap}{pct}+{dgt}+\z/n),
    gs(/\A{jap}{pct}+{jap}{pct}+{jap}\z/n),
    gs(/\A{jap2}{alp}{pct}+\z/n),
    gs(/\A{ldia}+{udia}+{alp2}\z/n),
    gs(/\A{ldia2}{udia2}\z/n),
    gs(/\A{ldia2}{upr2}\z/n),
    gs(/\A{lwr}\xff{alp}\z/n),
    gs(/\A{lwr2}{upr2}{dia}+\z/n),
    gs(/\A{lwrw}{uprw}\z/n),
    gs(/\A{pct}+(?>{alp}{dgt}+{jap})+\z/n),
    gs(/\A{pct}+(?>{alp}{pct}+{jap}){2,}{dia}{jap4}{pct}+\z/n),
    gs(/\A{pct}+(?>{alp}{pct}+{jap})+{pct}+\z/n),
    gs(/\A{pct}+(?>{dia}+{dgt}+{jap})+\z/n),
    gs(/\A{pct}+{alp}{dgt}+{alp}{dgt}+\z/n),
    gs(/\A{pct}+{alp}{dgt}+{pct}+\z/n),
    gs(/\A{pct}+{alp}{dgt}+\z/n),
    gs(/\A{pct}+{alp}{dia}+{alp}{dgt}+\z/n),
    gs(/\A{pct}+{alp}{dia}+{alp}{dgt}+\z/n),
    gs(/\A{pct}+{alp}{dia}+{alp}{pct}+\z/n),
    gs(/\A{pct}+{alp}{dia}+{alp}\z/n),
    gs(/\A{pct}+{alp}{dia}+{pct}+{alp}{dia}+{pct}+{dia}+{pct}+\z/n),
    gs(/\A{pct}+{alp}{dia}+{pct}+{alp}\z/n),
    gs(/\A{pct}+{alp}{dia}+{pct}+{dia}+{alp}{dgt}+\z/n),
    gs(/\A{pct}+{alp}{dia}+\z/n),
    gs(/\A{pct}+{alp}{dia2}{alp2}\z/n),
    gs(/\A{pct}+{alp}{jap}{pct}+{alp}\z/n),
    gs(/\A{pct}+{alp}{jap}{pct}+{spc}+{dgt}+\z/n),
    gs(/\A{pct}+{alp}{pct}+(?>{dbl}{sng}?{pct}+)+\z/n),
    gs(/\A{pct}+{alp}{pct}+{dgt}+\z/n),
    gs(/\A{pct}+{alp}{pct}+{jap}{pct}+{jap}\z/n),
    gs(/\A{pct}+{alp}{pct}+{jap}\z/n),
    gs(/\A{pct}+{alp}{pct}+\z/n),
    gs(/\A{pct}+{alp2}{dia}+{alp}{pct}+{dia}+\z/n),
    gs(/\A{pct}+{alp2}{jap}{pct}+{alp}{jap2}\z/n),
    gs(/\A{pct}+{alp2}{pct}+{dia}+\z/n),
    gs(/\A{pct}+{alp2}\z/n),
    gs(/\A{pct}+{alp3}{pct}+{alp}{dia}+{pct}+\z/n),
    gs(/\A{pct}+{alp3}{pct}+{jap}{alp}{pct}+{dgt}+{jap}\z/n),
    gs(/\A{pct}+{dgt}+{dia}+\z/n),
    gs(/\A{pct}+{dgt}+{fspc}+{dgt}+\z/n),
    gs(/\A{pct}+{dgt}+{jap3}{pct}+\z/n),
    gs(/\A{pct}+{dgt}+{pct}+{alp}\z/n),
    gs(/\A{pct}+{dgt}+{pct}+{jap}{dia}+{pct}+{dia}+{alp}{pct}+\z/n),
    gs(/\A{pct}+{dgt}+{pct}+{spc}+\z/n),
    gs(/\A{pct}+{dgt}+{pct}+\z/n),
    gs(/\A{pct}+{dgt}+{pct}+\z/n),
    gs(/\A{pct}+{dgt}+{spc}+{pct}+\z/n),
    gs(/\A{pct}+{dgt}+{spc}+\z/n),
    gs(/\A{pct}+{dia}+{alp}{dia}+\z/n),
    gs(/\A{pct}+{dia}+{alp}{pct}+\z/n),
    gs(/\A{pct}+{dia}+{dgt}+{fspc}+\z/n),
    gs(/\A{pct}+{dia}+{dgt}+{jap}\z/n),
    gs(/\A{pct}+{dia}+{dgt}+\z/n),
    gs(/\A{pct}+{dia}+{jap}{pct}+{dia}+{pct}+\z/n),
    gs(/\A{pct}+{dia}+{jap}{pct}+{dia2}\z/n),
    gs(/\A{pct}+{dia}+{pct}+{dgt}+\z/n),
    gs(/\A{pct}+{dia3}{alp}{spc}+\z/n),
    gs(/\A{pct}+{ext}{jap}{pct}+{ext}\z/n),
    gs(/\A{pct}+{jap}{alp}{dia}+\z/n),
    gs(/\A{pct}+{jap}{alp}\z/n),
    gs(/\A{pct}+{jap}{dia}+{alp}{pct}+\z/n),
    gs(/\A{pct}+{jap}{dia}+{alp}\z/n),
    gs(/\A{pct}+{jap}{dia}+\z/n),
    gs(/\A{pct}+{jap}{pct}+{jap}{pct}+\z/n),
    gs(/\A{pct}+{jap}{pct}+\z/n),
    gs(/\A{pct}+{jap}\z/n),
    gs(/\A{pct}+{jap2}{alp}\z/n),
    gs(/\A{pct}+{jap2}{dia}+\z/n),
    gs(/\A{pct}+{spc}+{alp}{dia}+\z/n),
    gs(/\A{pct}+{spc}+{dia}+{alp}\z/n),
    gs(/\A{pct}+\x99+{jap}{alp2}\z/n),
    gs(/\A{pct}+\x99+{jap}{pct}+\z/n),
    gs(/\A{pctj}+{pctw}+{dgt}+{jap}\z/n),
    gs(/\A{pctj}+{pctw}+{dgt}+{jap}\z/n),
    gs(/\A{pctw}{spcw}\z/n),
    gs(/\A{pctw}+(?>{dia}+{pct}+{jap})+\z/n),
    gs(/\A{pctw}+{alp}{jap}{dia}+\z/n),
    gs(/\A{pctw}+{alp}{pctw}+{jap}{dgt}+{pctw}+\z/n),
    gs(/\A{pctw}+{dgt}+{jap}\z/n),
    gs(/\A{pctw}+{dia}+{alp}\z/n),
    gs(/\A{pctw}+{jap}{pctw}+\z/n),
    gs(/\A{spc}(?>{alp}|{dia})\z/n),
    gs(/\A{spc}+{alp}{dgt}+{alp2}{pct}+\z/n),
    gs(/\A{spc}+{alp}{dgt}+{pct}+\z/n),
    gs(/\A{spc}+{alp}{dgt}+\z/n),
    gs(/\A{spc}+{alp}{dia}+\z/n),
    gs(/\A{spc}+{alp}{pct}+\z/n),
    gs(/\A{spc}+{dgt}+{alp}{dia}+\z/n),
    gs(/\A{spc}+{dgt}+{dia}+{alp}\z/n),
    gs(/\A{spc}+{dgt}+{pct}+{spc}+\z/n),
    gs(/\A{spc}+{dgt}+{pct}+\z/n),
    gs(/\A{spc}+{dgt}+{spc}+\z/n),
    gs(/\A{spc}+{dia}+{alp}{spc}+{alp}\z/n),
    gs(/\A{spc}+{dia}+{alp}\z/n),
    gs(/\A{spc}+{dia}+{spc}+{alp}\z/n),
    gs(/\A{spc}+{pct}+{alp}{dia}+\z/n),
    gs(/\A{spc}+{pct}+{dia}+{alp}\z/n),
    gs(/\A{spc}+{pct}+{jap}\z/n),
    gs(/\A{udia2}{alp2}\z/n),
    gs(/\A{upr}({lwr})\1{2,}{pct}\z/n),
    gs(/\A{upr}{ldia}{upr}{dia}+\z/n),
    gs(/\A\x8c{anyw}\z/n),
    gs(/\A\xff+{dia}+\z/n),
  ]

#------------------------------------------------------------------------------
# Enemy encounter data
#------------------------------------------------------------------------------

  # Maximum number of enemies in enemy encounter data
  _s.enemy_encounter_num_enemies = {
    '*'                => 84,
    'DC-JP-6107110 06' => 50,
    'DC-JP-6107810'    => 50,
  }
  
  # Maximum number of encounters in enemy encounter data
  _s.enemy_encounter_num_encounters = 32

#------------------------------------------------------------------------------
# Enemy event data
#------------------------------------------------------------------------------

  # Maximum number of enemies in enemy event data
  _s.enemy_event_num_enemies = {
    'DC'               =>  84,
    'DC-JP-6107110 06' =>  50,
    'DC-JP-6107810'    =>  50,
    'GC'               => 200,
  }
  
  # Maximum number of events in enemy event data
  _s.enemy_event_num_events = {
    'DC'               =>  80,
    'DC-JP-6107110 06' =>  11,
    'DC-JP-6107810'    =>  11,
    'GC'               => 250,
  }

  # Range of enemy event BGM IDs
  _s.enemy_event_bgm_id_range = 0x0...0x59
  
  # Offset ranges of enemy event BGMs
  _s.enemy_event_bgm_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x364c0c...0x364c47),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3bc2b0...0x3bc2eb),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x362b6c...0x362ba7),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3f673c...0x3f6777),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x3c5a0b...0x3c5a14),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x3c5187...0x3c5190),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x3faeec...0x3faf27),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x3ef074...0x3ef0af),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x3f4eb8...0x3f4ef3),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2e03a0...0x2e03db),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2e1200...0x2e123b),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2e16e0...0x2e171b),
  }

#------------------------------------------------------------------------------
# Enemy data
#------------------------------------------------------------------------------

  # Enables or disables the summary of enemy filters. If you enable the 
  # summary of enemy filters, the longest filter of the same enemy line 
  # will be summarized with an asterisk.
  _s.enemy_summarize_filter = true

#------------------------------------------------------------------------------
# Enemy instruction data
#------------------------------------------------------------------------------

  # Enables or disables the summary of enemy instruction filters. If you 
  # enable the summary of enemy instruction filters, the longest filter of 
  # the same enemy instruction line will be summarized with an asterisk.
  _s.enemy_instruction_summarize_filter = true
  
  # Maximum number of instructions in enemy instruction data
  _s.enemy_instruction_num_instructions = {
    '*'                => 64,
    'DC-JP-6107110 06' => 32,
    'DC-JP-6107810'    => 32,
  }

#------------------------------------------------------------------------------
# Enemy magic data
#------------------------------------------------------------------------------

  # Range of enemy magic IDs
  _s.enemy_magic_id_range = 0x0...0x24
  
  # Offset ranges of enemy magic data
  _s.enemy_magic_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x371af8...0x371dc8),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3c9218...0x3c94e8),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x36fa64...0x36fd34),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x3b83a8...0x3b88b8),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x3b7b28...0x3b8038),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x358bd8...0x3590e8),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x35d1d8...0x35d6e8),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x350fe4...0x3514f4),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x356c30...0x357140),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2d9398...0x2d9668),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2a9ee8...0x2aa3f8),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2aa440...0x2aa950),
  }
  
  # Offset ranges of enemy magic names
  _s.enemy_magic_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x12b6...0x13c4),
      rd(_s.sot_file_es['DC'], 0x12a9...0x13b7),
      rd(_s.sot_file_fr['DC'], 0x12ac...0x13ba),
      rd(_s.sot_file_gb['DC'], 0x12a6...0x13b4),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1276...0x1384),
      rd(_s.sot_file_es['DC'], 0x1279...0x1387),
      rd(_s.sot_file_fr['DC'], 0x127c...0x138a),
      rd(_s.sot_file_gb['DC'], 0x1246...0x1354),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1276...0x1384),
      rd(_s.sot_file_es['DC'], 0x1279...0x1387),
      rd(_s.sot_file_fr['DC'], 0x127c...0x138a),
      rd(_s.sot_file_gb['DC'], 0x1276...0x1384),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x12b6...0x13c4),
      rd(_s.sot_file_es['DC'], 0x12a9...0x13b7),
      rd(_s.sot_file_fr['DC'], 0x12ac...0x13ba),
      rd(_s.sot_file_gb['DC'], 0x12a6...0x13b4),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x13d6...0x14e4),
      rd(_s.sot_file_es['GC'], 0x13c9...0x14d7),
      rd(_s.sot_file_fr['GC'], 0x13cb...0x14d9),
      rd(_s.sot_file_gb['GC'], 0x13c6...0x14d4),
    ],
  }

#------------------------------------------------------------------------------
# Enemy ship data
#------------------------------------------------------------------------------

  # Range of enemy ship IDs
  _s.enemy_ship_id_range = 0x0...0x2d
  
  # Offset ranges of enemy ship data
  _s.enemy_ship_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x360890...0x361ad8),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b7f34...0x3b917c),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35e7f0...0x35fa38),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35f3dc...0x3604bc),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35eb5c...0x35fc3c),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3430dc...0x3445f4),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x3476e4...0x348bfc),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33b57c...0x33ca94),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x34102c...0x342544),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f6d14...0x2f7f5c),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2d3574...0x2d4a8c),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2d3934...0x2d4e4c),
  }
  
  # Offset ranges of enemy ship names
  _s.enemy_ship_name_files     = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1b54a...0x1b71f),
      rd(_s.sot_file_es['DC'], 0x1b2b4...0x1b489),
      rd(_s.sot_file_fr['DC'], 0x1b612...0x1b7e7),
      rd(_s.sot_file_gb['DC'], 0x1adcf...0x1afa4),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1ae6a...0x1b03f),
      rd(_s.sot_file_es['DC'], 0x1b373...0x1b548),
      rd(_s.sot_file_fr['DC'], 0x1b7ed...0x1b9c2),
      rd(_s.sot_file_gb['DC'], 0x1ae3a...0x1b00f),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1ae6a...0x1b03f),
      rd(_s.sot_file_es['DC'], 0x1b373...0x1b548),
      rd(_s.sot_file_fr['DC'], 0x1b7ed...0x1b9c2),
      rd(_s.sot_file_gb['DC'], 0x1ae6a...0x1b03f),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1b335...0x1b50a),
      rd(_s.sot_file_es['DC'], 0x1b27e...0x1b453),
      rd(_s.sot_file_fr['DC'], 0x1b581...0x1b756),
      rd(_s.sot_file_gb['DC'], 0x1adc0...0x1af95),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1e635...0x1e809),
      rd(_s.sot_file_es['GC'], 0x1e3a6...0x1e57b),
      rd(_s.sot_file_fr['GC'], 0x1e5f7...0x1e7cc),
      rd(_s.sot_file_gb['GC'], 0x1dc7e...0x1de53),
    ],
  }
  
  # Offset ranges of enemy ship armament names
  _s.enemy_ship_arm_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1bd1a...0x1c2f3),
      rd(_s.sot_file_es['DC'], 0x1bb0f...0x1c0eb),
      rd(_s.sot_file_fr['DC'], 0x1be43...0x1c415),
      rd(_s.sot_file_gb['DC'], 0x1b5bd...0x1bb57),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1b658...0x1bbf2),
      rd(_s.sot_file_es['DC'], 0x1bb64...0x1c0fe),
      rd(_s.sot_file_fr['DC'], 0x1c017...0x1c5ce),
      rd(_s.sot_file_gb['DC'], 0x1b628...0x1bbc2),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1b658...0x1bbf2),
      rd(_s.sot_file_es['DC'], 0x1bb64...0x1c0fe),
      rd(_s.sot_file_fr['DC'], 0x1c017...0x1c5ce),
      rd(_s.sot_file_gb['DC'], 0x1b658...0x1bbf2),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1bb0c...0x1c0e5),
      rd(_s.sot_file_es['DC'], 0x1bad9...0x1c0b5),
      rd(_s.sot_file_fr['DC'], 0x1bdb0...0x1c382),
      rd(_s.sot_file_gb['DC'], 0x1b5b5...0x1bb4f),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1ee0b...0x1f3e5),
      rd(_s.sot_file_es['GC'], 0x1ec0e...0x1f1da),
      rd(_s.sot_file_fr['GC'], 0x1ee27...0x1f3f9),
      rd(_s.sot_file_gb['GC'], 0x1e473...0x1ea0d),
    ],
  }

#------------------------------------------------------------------------------
# Enemy ship task data
#------------------------------------------------------------------------------

  _s.enemy_ship_tasks     = Hash.new
  _s.enemy_ship_tasks[ 0] = [554]
  _s.enemy_ship_tasks[ 1] = [553, 555, 560, 564]
  _s.enemy_ship_tasks[ 2] = [501]
  _s.enemy_ship_tasks[ 3] = [556]
  _s.enemy_ship_tasks[ 4] = [510, 518, 542, 557, 558, 562]
  _s.enemy_ship_tasks[ 5] = [543, 563, 569]
  _s.enemy_ship_tasks[ 6] = [567, 574]
  _s.enemy_ship_tasks[ 7] = [566, 575]
  _s.enemy_ship_tasks[ 8] = [544]
  _s.enemy_ship_tasks[ 9] = [520]
  _s.enemy_ship_tasks[10] = [521]
  _s.enemy_ship_tasks[11] = [507]
  _s.enemy_ship_tasks[12] = [509]
  _s.enemy_ship_tasks[13] = [514]
  _s.enemy_ship_tasks[14] = [540, 541]
  _s.enemy_ship_tasks[16] = [522]
  _s.enemy_ship_tasks[17] = [530]
  _s.enemy_ship_tasks[18] = [545]
  _s.enemy_ship_tasks[21] = [503, 550, 551, 552]
  _s.enemy_ship_tasks[22] = [559, 565, 568, 572]
  _s.enemy_ship_tasks[23] = [500]
  _s.enemy_ship_tasks[24] = [506]
  _s.enemy_ship_tasks[25] = [515]
  _s.enemy_ship_tasks[26] = [531]
  _s.enemy_ship_tasks[27] = [535]
  _s.enemy_ship_tasks[28] = [547]
  _s.enemy_ship_tasks[29] = [524]
  _s.enemy_ship_tasks[30] = [537]
  _s.enemy_ship_tasks[31] = [538]
  _s.enemy_ship_tasks[32] = [523, 577]
  _s.enemy_ship_tasks[35] = [513, 576]
  _s.enemy_ship_tasks[36] = [527, 578]
  _s.enemy_ship_tasks[37] = [532, 579]
  _s.enemy_ship_tasks[38] = [519]
  _s.enemy_ship_tasks[40] = [580, 582, 583]
  _s.enemy_ship_tasks[41] = [581]
  _s.enemy_ship_tasks[43] = [573]
  _s.enemy_ship_tasks[44] = [525]

#------------------------------------------------------------------------------
# Enemy super move data
#------------------------------------------------------------------------------

  # Range of enemy super move IDs
  _s.enemy_super_move_id_range = {
    'DC' => 0x0...0x110,
    'GC' => 0x0...0x135,
  }
  
  # Offset ranges of enemy super move data
  _s.enemy_super_move_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x371dc8...0x373308),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3c94e8...0x3caa28),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x36fd34...0x371274),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x3b88b8...0x3baef8),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x3b8038...0x3ba678),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3590e8...0x35b728),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x35d6e8...0x35fd28),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x3514f4...0x353b34),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x357140...0x359780),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2d9668...0x2dae8c),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2aa3f8...0x2acf6c),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2aa950...0x2ad4c4),
  }
  
  # Offset ranges of enemy super move names
  _s.enemy_super_move_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x13c4...0x1dc3),
      rd(_s.sot_file_es['DC'], 0x13b7...0x1e6c),
      rd(_s.sot_file_fr['DC'], 0x13ba...0x1e25),
      rd(_s.sot_file_gb['DC'], 0x13b4...0x1d37),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1384...0x1d07),
      rd(_s.sot_file_es['DC'], 0x1387...0x1e3e),
      rd(_s.sot_file_fr['DC'], 0x138a...0x1df6),
      rd(_s.sot_file_gb['DC'], 0x1354...0x1cd7),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1384...0x1d07),
      rd(_s.sot_file_es['DC'], 0x1387...0x1e3e),
      rd(_s.sot_file_fr['DC'], 0x138a...0x1df6),
      rd(_s.sot_file_gb['DC'], 0x1384...0x1d07),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x13c4...0x1dc3),
      rd(_s.sot_file_es['DC'], 0x13b7...0x1e6c),
      rd(_s.sot_file_fr['DC'], 0x13ba...0x1e25),
      rd(_s.sot_file_gb['DC'], 0x13b4...0x1d37),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x14e4...0x2079),
      rd(_s.sot_file_es['GC'], 0x14d7...0x215d),
      rd(_s.sot_file_fr['GC'], 0x14d9...0x211a),
      rd(_s.sot_file_gb['GC'], 0x14d4...0x1ff8),
    ],
  }

#------------------------------------------------------------------------------
# EXP curve data
#------------------------------------------------------------------------------

  # Range of EXP curve IDs
  _s.exp_curve_id_range = 0x0...0x6
  
  # Offset ranges of EXP curve data
  _s.exp_curve_data_files = {
    'DC' => rd(_s.level_file['DC'], 0x0...0x948),
    'GC' => rd(_s.level_file['GC'], 0x0...0x948),
  }

#------------------------------------------------------------------------------
# Magic EXP curve data
#------------------------------------------------------------------------------

  # Range of magic EXP curve IDs
  _s.magic_exp_curve_id_range = 0x0...0x6
  
  # Offset ranges of magic EXP curve data
  _s.magic_exp_curve_data_files = {
    'DC' => rd(_s.level_file['DC'], 0x948...0xaf8),
    'GC' => rd(_s.level_file['GC'], 0x948...0xaf8),
  }

#------------------------------------------------------------------------------
# Playable ship data
#------------------------------------------------------------------------------

  # Range of playable ship IDs
  _s.playable_ship_id_range = {
    '*'                => 0x0...0x5,
    'DC-JP-6107110 06' => 0x0...0x6,
    'DC-JP-6107810'    => 0x0...0x6,
  }

  # Offset ranges of playable ship data
  _s.playable_ship_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x3606ec...0x360890),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b7d90...0x3b7f34),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35e64c...0x35e7f0),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35f28c...0x35f3dc),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35ea0c...0x35eb5c),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x342ee8...0x3430dc),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x3474f0...0x3476e4),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33b388...0x33b57c),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x340e38...0x34102c),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f6b70...0x2f6d14),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2d3380...0x2d3574),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2d3740...0x2d3934),
  }
  
  # Offset ranges of playable ship names
  _s.playable_ship_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1b514...0x1b54a),
      rd(_s.sot_file_es['DC'], 0x1b27e...0x1b2b4),
      rd(_s.sot_file_fr['DC'], 0x1b5dc...0x1b612),
      rd(_s.sot_file_gb['DC'], 0x1ad99...0x1adcf),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1ae34...0x1ae6a),
      rd(_s.sot_file_es['DC'], 0x1b33d...0x1b373),
      rd(_s.sot_file_fr['DC'], 0x1b7b7...0x1b7ed),
      rd(_s.sot_file_gb['DC'], 0x1ae04...0x1ae3a),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1ae34...0x1ae6a),
      rd(_s.sot_file_es['DC'], 0x1b33d...0x1b373),
      rd(_s.sot_file_fr['DC'], 0x1b7b7...0x1b7ed),
      rd(_s.sot_file_gb['DC'], 0x1ae34...0x1ae6a),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1b2ff...0x1b335),
      rd(_s.sot_file_es['DC'], 0x1b248...0x1b27e),
      rd(_s.sot_file_fr['DC'], 0x1b54b...0x1b581),
      rd(_s.sot_file_gb['DC'], 0x1ad8a...0x1adc0),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1e5ff...0x1e635),
      rd(_s.sot_file_es['GC'], 0x1e370...0x1e3a6),
      rd(_s.sot_file_fr['GC'], 0x1e5c1...0x1e5f7),
      rd(_s.sot_file_gb['GC'], 0x1dc48...0x1dc7e),
    ],
  }

#------------------------------------------------------------------------------
# Ship accessory data
#------------------------------------------------------------------------------

  # Range of ship accessory IDs
  _s.ship_accessory_id_range = 0x1b8...0x1e0
  
  # Offset ranges of ship accessory data
  _s.ship_accessory_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x361f38...0x362438),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b95dc...0x3b9adc),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35fe98...0x360398),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x360cdc...0x3613bc),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x36045c...0x360b3c),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x344c34...0x345314),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x34923c...0x34991c),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33d0d4...0x33d7b4),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x342b84...0x343264),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f831c...0x2f877c),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2d502c...0x2d566c),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2d53ec...0x2d5a2c),
  }
  
  # Offset ranges of ship accessory names
  _s.ship_accessory_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1b923...0x1bb24),
      rd(_s.sot_file_es['DC'], 0x1b697...0x1b8d2),
      rd(_s.sot_file_fr['DC'], 0x1b9ec...0x1bc1e),
      rd(_s.sot_file_gb['DC'], 0x1b1b0...0x1b3c7),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1b24b...0x1b462),
      rd(_s.sot_file_es['DC'], 0x1b757...0x1b96e),
      rd(_s.sot_file_fr['DC'], 0x1bbc0...0x1bdf2),
      rd(_s.sot_file_gb['DC'], 0x1b21b...0x1b432),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1b24b...0x1b462),
      rd(_s.sot_file_es['DC'], 0x1b757...0x1b96e),
      rd(_s.sot_file_fr['DC'], 0x1bbc0...0x1bdf2),
      rd(_s.sot_file_gb['DC'], 0x1b24b...0x1b462),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1b715...0x1b916),
      rd(_s.sot_file_es['DC'], 0x1b661...0x1b89c),
      rd(_s.sot_file_fr['DC'], 0x1b95b...0x1bb8d),
      rd(_s.sot_file_gb['DC'], 0x1b1a8...0x1b3bf),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1ea14...0x1ec15),
      rd(_s.sot_file_es['GC'], 0x1e789...0x1e9cd),
      rd(_s.sot_file_fr['GC'], 0x1e9d1...0x1ec03),
      rd(_s.sot_file_gb['GC'], 0x1e066...0x1e27d),
    ],
  }
  
  # Offset ranges of ship accessory descriptions
  _s.ship_accessory_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x16e58...0x17b9e),
      rd(_s.sot_file_es['DC'], 0x16b19...0x177fe),
      rd(_s.sot_file_fr['DC'], 0x16d44...0x17a79),
      rd(_s.sot_file_gb['DC'], 0x168a6...0x1758a),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x168f4...0x175d8),
      rd(_s.sot_file_es['DC'], 0x16baa...0x178a4),
      rd(_s.sot_file_fr['DC'], 0x16eff...0x17c34),
      rd(_s.sot_file_gb['DC'], 0x168c4...0x175a8),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x168f4...0x175d8),
      rd(_s.sot_file_es['DC'], 0x16baa...0x178a4),
      rd(_s.sot_file_fr['DC'], 0x16eff...0x17c34),
      rd(_s.sot_file_gb['DC'], 0x168f4...0x175d8),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x16c49...0x1798f),
      rd(_s.sot_file_es['DC'], 0x16aec...0x177d1),
      rd(_s.sot_file_fr['DC'], 0x16cb4...0x179e9),
      rd(_s.sot_file_gb['DC'], 0x16897...0x1757b),
    ],
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x33bb44...0x33c86c
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x34014c...0x340e74
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x334cdc...0x3355a8
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x339a38...0x33a730
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x19e71...0x1abb8),
      rd(_s.sot_file_es['GC'], 0x19b0f...0x1a7f2),
      rd(_s.sot_file_fr['GC'], 0x19c5d...0x1a998),
      rd(_s.sot_file_gb['GC'], 0x196a8...0x1a38c),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2cef30...0x2cfc58
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2ceef8...0x2cfbf0
    ),
  }

#------------------------------------------------------------------------------
# Ship cannon data
#------------------------------------------------------------------------------

  # Range of ship cannon IDs
  _s.ship_cannon_id_range = 0x190...0x1b8
  
  # Offset ranges of ship cannon data
  _s.ship_cannon_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x361ad8...0x361f38),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b917c...0x3b95dc),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35fa38...0x35fe98),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x3604bc...0x360cdc),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35fc3c...0x36045c),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3445f4...0x344c34),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x348bfc...0x34923c),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33ca94...0x33d0d4),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x342544...0x342b84),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f7f5c...0x2f831c),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2d4a8c...0x2d502c),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2d4e4c...0x2d53ec),
  }
  
  # Offset ranges of ship cannon names
  _s.ship_cannon_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1b71f...0x1b923),
      rd(_s.sot_file_es['DC'], 0x1b489...0x1b697),
      rd(_s.sot_file_fr['DC'], 0x1b7e7...0x1b9ec),
      rd(_s.sot_file_gb['DC'], 0x1afa4...0x1b1b0),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1b03f...0x1b24b),
      rd(_s.sot_file_es['DC'], 0x1b548...0x1b757),
      rd(_s.sot_file_fr['DC'], 0x1b9c2...0x1bbc0),
      rd(_s.sot_file_gb['DC'], 0x1b00f...0x1b21b),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1b03f...0x1b24b),
      rd(_s.sot_file_es['DC'], 0x1b548...0x1b757),
      rd(_s.sot_file_fr['DC'], 0x1b9c2...0x1bbc0),
      rd(_s.sot_file_gb['DC'], 0x1b03f...0x1b24b),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1b50a...0x1b715),
      rd(_s.sot_file_es['DC'], 0x1b453...0x1b661),
      rd(_s.sot_file_fr['DC'], 0x1b756...0x1b95b),
      rd(_s.sot_file_gb['DC'], 0x1af95...0x1b1a8),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1e809...0x1ea14),
      rd(_s.sot_file_es['GC'], 0x1e57b...0x1e789),
      rd(_s.sot_file_fr['GC'], 0x1e7cc...0x1e9d1),
      rd(_s.sot_file_gb['GC'], 0x1de53...0x1e066),
    ],
  }
  
  # Offset ranges of ship cannon descriptions
  _s.ship_cannon_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x16170...0x16e58),
      rd(_s.sot_file_es['DC'], 0x15dce...0x16b19),
      rd(_s.sot_file_fr['DC'], 0x15fd4...0x16d44),
      rd(_s.sot_file_gb['DC'], 0x15bdd...0x168a6),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x15c2b...0x168f4),
      rd(_s.sot_file_es['DC'], 0x15e5e...0x16baa),
      rd(_s.sot_file_fr['DC'], 0x1619f...0x16eff),
      rd(_s.sot_file_gb['DC'], 0x15bfb...0x168c4),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x15c2b...0x168f4),
      rd(_s.sot_file_es['DC'], 0x15e5e...0x16baa),
      rd(_s.sot_file_fr['DC'], 0x1619f...0x16eff),
      rd(_s.sot_file_gb['DC'], 0x15c2b...0x168f4),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x15f61...0x16c49),
      rd(_s.sot_file_es['DC'], 0x15da3...0x16aec),
      rd(_s.sot_file_fr['DC'], 0x15f44...0x16cb4),
      rd(_s.sot_file_gb['DC'], 0x15bce...0x16897),
    ],
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x33aec8...0x33bb44
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x33f4d0...0x34014c
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x334340...0x334cdc
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x338d64...0x339a38
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1918c...0x19e71),
      rd(_s.sot_file_es['GC'], 0x18dd2...0x19b0f),
      rd(_s.sot_file_fr['GC'], 0x18ef6...0x19c5d),
      rd(_s.sot_file_gb['GC'], 0x189df...0x196a8),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2ce2b4...0x2cef30
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2ce220...0x2ceef8
    ),
  }

#------------------------------------------------------------------------------
# Ship item data
#------------------------------------------------------------------------------

  # Range of ship item IDs
  _s.ship_item_id_range = 0x1e0...0x1fe
  
  # Offset ranges of ship item data
  _s.ship_item_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x362438...0x362708),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b9adc...0x3b9dac),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x360398...0x360668),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x3613bc...0x36186c),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x360b3c...0x360fec),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x345314...0x3457c4),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x34991c...0x349dcc),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33d7b4...0x33dc64),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x343264...0x343714),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f877c...0x2f8a4c),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2d566c...0x2d5aa4),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2d5a2c...0x2d5e64),
  }
  
  # Offset ranges of ship item names
  _s.ship_item_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1bb24...0x1bc84),
      rd(_s.sot_file_es['DC'], 0x1b8d2...0x1ba79),
      rd(_s.sot_file_fr['DC'], 0x1bc1e...0x1bdad),
      rd(_s.sot_file_gb['DC'], 0x1b3c7...0x1b527),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1b462...0x1b5c2),
      rd(_s.sot_file_es['DC'], 0x1b96e...0x1bace),
      rd(_s.sot_file_fr['DC'], 0x1bdf2...0x1bf81),
      rd(_s.sot_file_gb['DC'], 0x1b432...0x1b592),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1b462...0x1b5c2),
      rd(_s.sot_file_es['DC'], 0x1b96e...0x1bace),
      rd(_s.sot_file_fr['DC'], 0x1bdf2...0x1bf81),
      rd(_s.sot_file_gb['DC'], 0x1b462...0x1b5c2),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1b916...0x1ba76),
      rd(_s.sot_file_es['DC'], 0x1b89c...0x1ba43),
      rd(_s.sot_file_fr['DC'], 0x1bb8d...0x1bd1a),
      rd(_s.sot_file_gb['DC'], 0x1b3bf...0x1b51f),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1ec15...0x1ed75),
      rd(_s.sot_file_es['GC'], 0x1e9cd...0x1eb78),
      rd(_s.sot_file_fr['GC'], 0x1ec03...0x1ed91),
      rd(_s.sot_file_gb['GC'], 0x1e27d...0x1e3dd),
    ],
  }
  
  # Offset ranges of ship item descriptions
  _s.ship_item_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x17b9e...0x185e8),
      rd(_s.sot_file_es['DC'], 0x177fe...0x18246),
      rd(_s.sot_file_fr['DC'], 0x17a79...0x184ca),
      rd(_s.sot_file_gb['DC'], 0x1758a...0x17f49),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x175d8...0x17f97),
      rd(_s.sot_file_es['DC'], 0x178a4...0x182ea),
      rd(_s.sot_file_fr['DC'], 0x17c34...0x18685),
      rd(_s.sot_file_gb['DC'], 0x175a8...0x17f67),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x175d8...0x17f97),
      rd(_s.sot_file_es['DC'], 0x178a4...0x182ea),
      rd(_s.sot_file_fr['DC'], 0x17c34...0x18685),
      rd(_s.sot_file_gb['DC'], 0x175d8...0x17f97),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1798f...0x183d9),
      rd(_s.sot_file_es['DC'], 0x177d1...0x18219),
      rd(_s.sot_file_fr['DC'], 0x179e9...0x1843a),
      rd(_s.sot_file_gb['DC'], 0x1757b...0x17f3a),
    ],
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x33c86c...0x33d1a0
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x340e74...0x3417a8
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x3355a8...0x335c10
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x33a730...0x33b104
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1abb8...0x1b603),
      rd(_s.sot_file_es['GC'], 0x1a7f2...0x1b23a),
      rd(_s.sot_file_fr['GC'], 0x1a998...0x1b3e9),
      rd(_s.sot_file_gb['GC'], 0x1a38c...0x1ad4b),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2cfc58...0x2d058c
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2cfbf0...0x2d05c4
    ),
  }

#------------------------------------------------------------------------------
# Shop data
#------------------------------------------------------------------------------

  # Range of shop IDs
  _s.shop_id_range = {
    '*'                => 0x0...0x2b,
    'DC-JP-6107810'    => 0x0...0x3 ,
    'DC-JP-6107110 06' => 0x0...0x3 ,
    'DC-US-IGN9'       => 0x0...0x3 ,
  }

  # Offset ranges of shop data
  _s.shop_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x36c8f0...0x36da68),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3c4010...0x3c5188),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x36a85c...0x36b9d4),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x3b1828...0x3b1960),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x3b0fa8...0x3b10e0),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3ffec0...0x401038),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x404670...0x4057e8),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x3f8808...0x3f8940),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x3fe558...0x3ff6d0),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2e7dd4...0x2e8f4c),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2e8d08...0x2e9e80),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2e90a0...0x2ea218),
  }
  
  # Offset ranges of shop descriptions
  _s.shop_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0xddc2...0xe045),
      rd(_s.sot_file_es['DC'], 0xdbaf...0xde55),
      rd(_s.sot_file_fr['DC'], 0xdc61...0xdf06),
      rd(_s.sot_file_gb['DC'], 0xd99d...0xdc48),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0xd9f2...0xdc9d),
      rd(_s.sot_file_es['DC'], 0xda6b...0xdd16),
      rd(_s.sot_file_fr['DC'], 0xdc36...0xdee1),
      rd(_s.sot_file_gb['DC'], 0xd9c2...0xdc6d),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0xd9f2...0xdc9d),
      rd(_s.sot_file_es['DC'], 0xda6b...0xdd16),
      rd(_s.sot_file_fr['DC'], 0xdc36...0xdee1),
      rd(_s.sot_file_gb['DC'], 0xd9f2...0xdc9d),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0xdc6e...0xdef1),
      rd(_s.sot_file_es['DC'], 0xdb92...0xde38),
      rd(_s.sot_file_fr['DC'], 0xdbe3...0xde88),
      rd(_s.sot_file_gb['DC'], 0xd990...0xdc3b),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2b571c...0x2b5750, msgtbl: true
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2b4e6c...0x2b4ea0, msgtbl: true
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x34e0f0...0x34e2dc, msgtbl: true
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x3526f8...0x3528e4, msgtbl: true
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x34679c...0x3467d4, msgtbl: true
     ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x34c034...0x34c210, msgtbl: true
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x10c7c...0x10f00),
      rd(_s.sot_file_es['GC'], 0x1095d...0x10c03),
      rd(_s.sot_file_fr['GC'], 0x10993...0x10c38),
      rd(_s.sot_file_gb['GC'], 0x10580...0x1082b),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2b6158...0x2b6344, msgtbl: true
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2b6554...0x2b6730, msgtbl: true
    ),
  }

#------------------------------------------------------------------------------
# Special item data
#------------------------------------------------------------------------------

  # Range of special item IDs
  _s.special_item_id_range = 0x140...0x190
  
  # Offset ranges of special item data
  _s.special_item_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x36022c...0x3605ec),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b78d0...0x3b7c90),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35e18c...0x35e54c),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35e4a8...0x35eb88),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35dc28...0x35e308),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x342104...0x3427e4),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x34670c...0x346dec),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33a5a4...0x33ac84),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x340054...0x340734),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f4aa8...0x2f4e68),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c4c6c...0x2c534c),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c5774...0x2c5e54),
  }
  
  # Offset ranges of special item names
  _s.special_item_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1aea0...0x1b271),
      rd(_s.sot_file_es['DC'], 0x1ac18...0x1afde),
      rd(_s.sot_file_fr['DC'], 0x1afa5...0x1b372),
      rd(_s.sot_file_gb['DC'], 0x1a752...0x1ab27),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1a7d8...0x1abad),
      rd(_s.sot_file_es['DC'], 0x1acf8...0x1b0be),
      rd(_s.sot_file_fr['DC'], 0x1b163...0x1b530),
      rd(_s.sot_file_gb['DC'], 0x1a7a8...0x1ab7d),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1a7d8...0x1abad),
      rd(_s.sot_file_es['DC'], 0x1acf8...0x1b0be),
      rd(_s.sot_file_fr['DC'], 0x1b163...0x1b530),
      rd(_s.sot_file_gb['DC'], 0x1a7d8...0x1abad),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1ac8f...0x1b060),
      rd(_s.sot_file_es['DC'], 0x1abe8...0x1afab),
      rd(_s.sot_file_fr['DC'], 0x1af13...0x1b2e1),
      rd(_s.sot_file_gb['DC'], 0x1a741...0x1ab16),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1dede...0x1e2b1),
      rd(_s.sot_file_es['GC'], 0x1dc62...0x1e028),
      rd(_s.sot_file_fr['GC'], 0x1ded3...0x1e2a2),
      rd(_s.sot_file_gb['GC'], 0x1d556...0x1d929),
    ],
  }
  
  # Offset ranges of special item descriptions
  _s.special_item_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x153d2...0x16170),
      rd(_s.sot_file_es['DC'], 0x14ffa...0x15dce),
      rd(_s.sot_file_fr['DC'], 0x151ca...0x15fd4),
      rd(_s.sot_file_gb['DC'], 0x14d83...0x15bdd),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x14dd0...0x15c2b),
      rd(_s.sot_file_es['DC'], 0x14faa...0x15e5e),
      rd(_s.sot_file_fr['DC'], 0x152b2...0x1619f),
      rd(_s.sot_file_gb['DC'], 0x14da0...0x15bfb),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x14dd0...0x15c2b),
      rd(_s.sot_file_es['DC'], 0x14faa...0x15e5e),
      rd(_s.sot_file_fr['DC'], 0x152b2...0x1619f),
      rd(_s.sot_file_gb['DC'], 0x14dd0...0x15c2b),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x151e2...0x15f61),
      rd(_s.sot_file_es['DC'], 0x14fd2...0x15da3),
      rd(_s.sot_file_fr['DC'], 0x1513a...0x15f44),
      rd(_s.sot_file_gb['DC'], 0x14d74...0x15bce),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2b06dc...0x2b09f8, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2afff8...0x2b0314, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x33a3c4...0x33aec8, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x33e9cc...0x33f4d0, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x334034...0x334340, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
     ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x3381a4...0x338d64, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x18262...0x1918c),
      rd(_s.sot_file_es['GC'], 0x17e6f...0x18dd2),
      rd(_s.sot_file_fr['GC'], 0x17f59...0x18ef6),
      rd(_s.sot_file_gb['GC'], 0x179f9...0x189df),
    ],
    'GC-JP-GEA'                        => rd(
      _s.exec_file['GC'], 0x2cd644...0x2ce2b4, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'GC-US-GEA'                        => rd(
      _s.exec_file['GC'], 0x2cd4ec...0x2ce220, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
  }

#------------------------------------------------------------------------------
# Spirit curve data
#------------------------------------------------------------------------------

  # Range of spirit curve IDs
  _s.spirit_curve_id_range = 0x0...0x6
  
  # Offset ranges of spirit curve data
  _s.spirit_curve_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x335fd8...0x33647c),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3620f0...0x362594),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x333f6c...0x334410),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35eda8...0x35f24c),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35e528...0x35e9cc),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x342a04...0x342ea8),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x34700c...0x3474b0),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x33aea4...0x33b348),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x340954...0x340df8),
    'GC-EU'                   => rd(_s.exec_file['GC'], 0x2c4aa0...0x2c4f44),
    'GC-JP'                   => rd(_s.exec_file['GC'], 0x2c567c...0x2c5b20),
    'GC-US'                   => rd(_s.exec_file['GC'], 0x2c6184...0x2c6628),
  }

#------------------------------------------------------------------------------
# Treasure chest data
#------------------------------------------------------------------------------

  # Range of treasure chest IDs
  _s.treasure_chest_id_range = {
    '*'                => 0x0...0x77,
    'DC-JP-6107110 06' => 0x0...0x6,
    'DC-JP-6107810'    => 0x0...0x6,
  }

  # Offset ranges of treasure chest data
  _s.treasure_chest_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x334928...0x334ce0),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x35f370...0x35f728),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x3328bc...0x332c74),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x34c7f8...0x34c810),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x34bf78...0x34bf90),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3308dc...0x330c94),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x334ee4...0x33529c),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x330148...0x330500),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x32f3b0...0x32f768),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2d1610...0x2d19c8),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2d26d0...0x2d2a88),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2d29e8...0x2d2da0),
  }

#------------------------------------------------------------------------------
# Usable item data
#------------------------------------------------------------------------------

  # Range of usable item IDs
  _s.usable_item_id_range = 0xf0...0x140
  
  # Offset ranges of usable item data
  _s.usable_item_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x35faac...0x36022c),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b7150...0x3b78d0),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35da0c...0x35e18c),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35d968...0x35e4a8),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35d0e8...0x35dc28),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x3415c4...0x342104),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x345bcc...0x34670c),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x339a64...0x33a5a4),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x33f514...0x340054),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f4328...0x2f4aa8),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c412c...0x2c4c6c),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c4c34...0x2c5774),
  }
  
  # Offset ranges of usable item names
  _s.usable_item_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x1aae1...0x1aea0),
      rd(_s.sot_file_es['DC'], 0x1a7fc...0x1ac18),
      rd(_s.sot_file_fr['DC'], 0x1ab76...0x1afa5),
      rd(_s.sot_file_gb['DC'], 0x1a393...0x1a752),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1a419...0x1a7d8),
      rd(_s.sot_file_es['DC'], 0x1a8d9...0x1acf8),
      rd(_s.sot_file_fr['DC'], 0x1ad34...0x1b163),
      rd(_s.sot_file_gb['DC'], 0x1a3e9...0x1a7a8),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1a419...0x1a7d8),
      rd(_s.sot_file_es['DC'], 0x1a8d9...0x1acf8),
      rd(_s.sot_file_fr['DC'], 0x1ad34...0x1b163),
      rd(_s.sot_file_gb['DC'], 0x1a419...0x1a7d8),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x1a8d2...0x1ac8f),
      rd(_s.sot_file_es['DC'], 0x1a7ce...0x1abe8),
      rd(_s.sot_file_fr['DC'], 0x1aae6...0x1af13),
      rd(_s.sot_file_gb['DC'], 0x1a384...0x1a741),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1db1c...0x1dede),
      rd(_s.sot_file_es['GC'], 0x1d83d...0x1dc62),
      rd(_s.sot_file_fr['GC'], 0x1daa2...0x1ded3),
      rd(_s.sot_file_gb['GC'], 0x1d194...0x1d556),
    ],
  }
  
  # Offset ranges of usable item descriptions
  _s.usable_item_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x13ad7...0x153d2),
      rd(_s.sot_file_es['DC'], 0x136b6...0x14ffa),
      rd(_s.sot_file_fr['DC'], 0x138a5...0x151ca),
      rd(_s.sot_file_gb['DC'], 0x134c5...0x14d83),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x1351a...0x14dd0),
      rd(_s.sot_file_es['DC'], 0x1364f...0x14faa),
      rd(_s.sot_file_fr['DC'], 0x13969...0x152b2),
      rd(_s.sot_file_gb['DC'], 0x134ea...0x14da0),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x1351a...0x14dd0),
      rd(_s.sot_file_es['DC'], 0x1364f...0x14faa),
      rd(_s.sot_file_fr['DC'], 0x13969...0x152b2),
      rd(_s.sot_file_gb['DC'], 0x1351a...0x14dd0),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x138e9...0x151e2),
      rd(_s.sot_file_es['DC'], 0x13690...0x14fd2),
      rd(_s.sot_file_fr['DC'], 0x13817...0x1513a),
      rd(_s.sot_file_gb['DC'], 0x134b8...0x14d74),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2afe30...0x2b06dc, excl: [
        0x100, 0x101, 0x10c..0x11a
      ]
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2af74c...0x2afff8, excl: [
        0x100, 0x101, 0x10c..0x11a
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x3387d4...0x33a3c4, excl: [
        0x12e..0x130
      ]
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x33cddc...0x33e9cc, excl: [
        0x12e..0x130
      ]
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x3338a4...0x334034, excl: [
        0x100..0x101, 0x10c..0x11a
      ]
     ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x33693c...0x3381a4, excl: [
        0x12d..0x130
      ]
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x16979...0x18262),
      rd(_s.sot_file_es['GC'], 0x1652e...0x17e6f),
      rd(_s.sot_file_fr['GC'], 0x16635...0x17f59),
      rd(_s.sot_file_gb['GC'], 0x1613d...0x179f9),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2cba54...0x2cd644, excl: [
        0x12e..0x130
      ]
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2cbc88...0x2cd4ec, excl: [
        0x12d..0x130
      ]
    ),
  }

#------------------------------------------------------------------------------
# Weapon data
#------------------------------------------------------------------------------

  # Range of weapon IDs
  _s.weapon_id_range = 0x0...0x50
  
  # Offset ranges of weapon data
  _s.weapon_data_files = {
    'DC-EU-8320062 50'        => rd(_s.exec_file['DC'], 0x35e2ec...0x35e92c),
    'DC-EU-MK-51052-20001115' => rd(_s.exec_file['DC'], 0x3b5990...0x3b5fd0),
    'DC-EU-MK-51052-20010306' => rd(_s.exec_file['DC'], 0x35c24c...0x35c88c),
    'DC-JP-6107110 06'        => rd(_s.exec_file['DC'], 0x35b4c4...0x35bec4),
    'DC-JP-6107810'           => rd(_s.exec_file['DC'], 0x35ac44...0x35b644),
    'DC-JP-HDR-0076'          => rd(_s.exec_file['DC'], 0x33f120...0x33fb20),
    'DC-JP-HDR-0119'          => rd(_s.exec_file['DC'], 0x343728...0x344128),
    'DC-US-IGN9'              => rd(_s.exec_file['DC'], 0x3375c0...0x337fc0),
    'DC-US-MK-51052'          => rd(_s.exec_file['DC'], 0x33d070...0x33da70),
    'GC-EU-GEA'               => rd(_s.exec_file['GC'], 0x2f2b68...0x2f31a8),
    'GC-JP-GEA'               => rd(_s.exec_file['GC'], 0x2c1c88...0x2c2688),
    'GC-US-GEA'               => rd(_s.exec_file['GC'], 0x2c2790...0x2c3190),
  }
  
  # Offset ranges of weapon names
  _s.weapon_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0x19e83...0x1a279),
      rd(_s.sot_file_es['DC'], 0x19ac8...0x19f07),
      rd(_s.sot_file_fr['DC'], 0x19e68...0x1a265),
      rd(_s.sot_file_gb['DC'], 0x19753...0x19b20),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0x197d9...0x19ba6),
      rd(_s.sot_file_es['DC'], 0x19b9d...0x19fe3),
      rd(_s.sot_file_fr['DC'], 0x1a026...0x1a423),
      rd(_s.sot_file_gb['DC'], 0x197a9...0x19b76),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0x197d9...0x19ba6),
      rd(_s.sot_file_es['DC'], 0x19b9d...0x19fe3),
      rd(_s.sot_file_fr['DC'], 0x1a026...0x1a423),
      rd(_s.sot_file_gb['DC'], 0x197d9...0x19ba6),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0x19c74...0x1a06a),
      rd(_s.sot_file_es['DC'], 0x19a98...0x19ed7),
      rd(_s.sot_file_fr['DC'], 0x19dd8...0x1a1d5),
      rd(_s.sot_file_gb['DC'], 0x19744...0x19b11),
    ],
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x1ce93...0x1d289),
      rd(_s.sot_file_es['GC'], 0x1cb04...0x1cf43),
      rd(_s.sot_file_fr['GC'], 0x1cd83...0x1d18e),
      rd(_s.sot_file_gb['GC'], 0x1c555...0x1c921),
    ],
  }
  
  # Offset ranges of weapon descriptions
  _s.weapon_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(_s.sot_file_de['DC'], 0xf842...0x111d9),
      rd(_s.sot_file_es['DC'], 0xf63e...0x10faa),
      rd(_s.sot_file_fr['DC'], 0xf726...0x11008),
      rd(_s.sot_file_gb['DC'], 0xf45e...0x10db1),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(_s.sot_file_de['DC'], 0xf4b3...0x10e06),
      rd(_s.sot_file_es['DC'], 0xf4e4...0x10e97),
      rd(_s.sot_file_fr['DC'], 0xf6fd...0x11002),
      rd(_s.sot_file_gb['DC'], 0xf483...0x10dd6),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(_s.sot_file_de['DC'], 0xf4b3...0x10e06),
      rd(_s.sot_file_es['DC'], 0xf4e4...0x10e97),
      rd(_s.sot_file_fr['DC'], 0xf6fd...0x11002),
      rd(_s.sot_file_gb['DC'], 0xf4b3...0x10e06),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(_s.sot_file_de['DC'], 0xf6d1...0x10fec),
      rd(_s.sot_file_es['DC'], 0xf617...0x10f83),
      rd(_s.sot_file_fr['DC'], 0xf696...0x10f79),
      rd(_s.sot_file_gb['DC'], 0xf451...0x10da4),
    ],
    'DC-JP-6107110 06'                  => rd(
      _s.exec_file['DC'], 0x2af590...0x2af878, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-JP-6107810'                     => rd(
      _s.exec_file['DC'], 0x2aeeac...0x2af194, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      _s.exec_file['DC'], 0x334094...0x335b4c
    ),
    'DC-JP-HDR-0119'                    => rd(
      _s.exec_file['DC'], 0x33869c...0x33a154
    ),
    'DC-US-IGN9'                        => rd(
      _s.exec_file['DC'], 0x333110...0x33337c, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-US-MK-51052'                    => rd(
      _s.exec_file['DC'], 0x332ad8...0x3343f8
    ),
    'GC-EU-GEA'                         => [
      rd(_s.sot_file_de['GC'], 0x126e4...0x14060),
      rd(_s.sot_file_es['GC'], 0x12410...0x13dc4),
      rd(_s.sot_file_fr['GC'], 0x1244e...0x13da3),
      rd(_s.sot_file_gb['GC'], 0x12056...0x139f6),
    ],
    'GC-JP-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c72c0...0x2c8ddc
    ),
    'GC-US-GEA'                         => rd(
      _s.exec_file['GC'], 0x2c7d9c...0x2c9714
    ),
  }

end # class SYS

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
