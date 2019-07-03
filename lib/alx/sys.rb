#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
  _s.build_dir      = _s.expand('build')
  # Path to 'share' directory
  _s.share_dir      = _s.expand('share')
  # Path to 'thirdparty' directory
  _s.thirdparty_dir = _s.expand('thirdparty')

  # Required version of Ruby
  _s.ruby_version = '2.4.0'

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
  _s.log_dir   = _s.expand('log')
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
  _s.bnr_file = _s.join(_s.root_dir, 'opening.bnr')
  # Path to HDR file relative to game root.
  _s.hdr_file = _s.join(_s.root_dir, '&&systemdata/ISO.hdr')
  # Path to IP.BIN file relative to game root.
  _s.ip_file  = _s.join(_s.root_dir, 'IP.BIN')
  
  # Path to executable file relative to game root.
  _s.exec_file = {
    'DC' => _s.join(_s.root_dir, '{ARES,ETERNAL,1ST_READ}.BIN'),
    'GC' => _s.join(_s.root_dir, '&&systemdata/Start.dol'     ),
  }
  
  # Path to level data file relative to game root.
  _s.level_file = {
    'DC' => _s.join(_s.root_dir, 'BATTLE/LEVELUP.DAT'),
    'GC' => _s.join(_s.root_dir, 'battle/first.lmt'  ),
  }
  # Path to German SOT file relative to game root (PAL-E only).
  _s.sot_file_de = {
    'DC' => _s.join(_s.root_dir, 'GERMAN.SOT'),
    'GC' => _s.join(_s.root_dir, 'german.sot'),
  }
  # Path to Spanish SOT file relative to game root (PAL-E only).
  _s.sot_file_es = {
    'DC' => _s.join(_s.root_dir, 'SPANISH.SOT'),
    'GC' => _s.join(_s.root_dir, 'spanish.sot'),
  }
  # Path to French SOT file relative to game root (PAL-E only).
  _s.sot_file_fr = {
    'DC' => _s.join(_s.root_dir, 'FRENCH.SOT'),
    'GC' => _s.join(_s.root_dir, 'french.sot'),
  }
  # Path to English SOT file relative to game root (PAL-E only).
  _s.sot_file_gb = {
    'DC' => _s.join(_s.root_dir, 'ENGLISH.SOT'),
    'GC' => _s.join(_s.root_dir, 'english.sot'),
  }
  # Path to boss data files relative to game root. The single asterisk must be 
  # used.
  _s.eb_file = {
    'DC' => _s.glob(_s.root_dir, 'BATTLE/EBINIT*.DAT'),
    'GC' => _s.glob(_s.root_dir, 'battle/ebinit*.dat'),
  }
  # Path to enemy data files relative to game root. The single asterisk must 
  # be used.
  _s.ec_file = {
    'DC' => _s.glob(_s.root_dir, 'BATTLE/ECINIT*.DAT'),
    'GC' => _s.glob(_s.root_dir, 'battle/ecinit*.dat'),
  }
  # Path to enemy encounter files relative to game root. The single asterisk 
  # must be used.
  _s.enp_file = {
    'DC' => _s.glob(_s.root_dir, 'FIELD/*_EP.BIN'),
    'GC' => _s.glob(_s.root_dir, 'field/*_ep.enp'),
  }
  # Path to enemy event file relative to game root.
  _s.evp_file = {
    'DC' => _s.join(_s.root_dir, 'BATTLE/EPEVENT.BIN'),
    'GC' => _s.join(_s.root_dir, 'battle/epevent.evp'),
  }
  # Path to enemy ship task files relative to game root. The single asterisk 
  # must be used.
  _s.tec_file = {
    'DC' => _s.glob(_s.root_dir, 'FIELD/R*.BIN'),
    'GC' => _s.glob(_s.root_dir, 'field/r*.tec'),
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
    'DC-E' => 'PAL-E' ,
    'DC-J' => 'NTSC-J',
    'DC-U' => 'NTSC-U',
    'GC-E' => 'NTSC-U',
    'GC-J' => 'NTSC-J',
    'GC-P' => 'PAL-E' ,
  }

  # Country IDs
  _s.country_ids = {
    'DC-E' => 'EU',
    'DC-J' => 'JP',
    'DC-U' => 'US',
    'GC-E' => 'US',
    'GC-J' => 'JP',
    'GC-P' => 'EU',
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
  _s.accessory_id_range = 0xa0...0xf0
  
  # Offset ranges of accessory data
  _s.accessory_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35d14c...0x35da0c),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x35f1ec...0x35faac),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35c2c4...0x35d0e8),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3407a0...0x341420),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x344da8...0x345a28),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x338c40...0x339a64),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33e6f0...0x33f370),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f3a68...0x2f4328),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c3308...0x2c3f88),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c3e10...0x2c4a90),
  }
  
  # Offset ranges of accessory names
  _s.accessory_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1a466...0x1a8d2),
      _s.dr(_s.sot_file_es['DC'], 0x1a32f...0x1a7ce),
      _s.dr(_s.sot_file_fr['DC'], 0x1a61d...0x1aae6),
      _s.dr(_s.sot_file_gb['DC'], 0x19f03...0x1a384),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1a675...0x1aae1),
      _s.dr(_s.sot_file_es['DC'], 0x1a35f...0x1a7fc),
      _s.dr(_s.sot_file_fr['DC'], 0x1a6ad...0x1ab76),
      _s.dr(_s.sot_file_gb['DC'], 0x19f12...0x1a393),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1d6aa...0x1db1c),
      _s.dr(_s.sot_file_es['GC'], 0x1d39e...0x1d83d),
      _s.dr(_s.sot_file_fr['GC'], 0x1d5d7...0x1daa2),
      _s.dr(_s.sot_file_gb['GC'], 0x1cd13...0x1d194),
    ],
  }
  
  # Offset ranges of accessory descriptions
  _s.accessory_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x12352...0x138e9),
      _s.dr(_s.sot_file_es['DC'], 0x121c3...0x13690),
      _s.dr(_s.sot_file_fr['DC'], 0x121f0...0x13817),
      _s.dr(_s.sot_file_gb['DC'], 0x11fff...0x134b8),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x12543...0x13ad7),
      _s.dr(_s.sot_file_es['DC'], 0x121e9...0x136b6),
      _s.dr(_s.sot_file_fr['DC'], 0x1227f...0x138a5),
      _s.dr(_s.sot_file_gb['DC'], 0x1200c...0x134c5),
    ],
    'DC-JP-6107810'    => _s.dr(
      _s.exec_file['DC'], 0x2af400...0x2af74c,
      exclusions: [
        0xa1, (0xa3..0xa7).to_a, (0xa9..0xaf).to_a, (0xb1..0xb5).to_a, 
        (0xb8..0xbf).to_a, (0xc1..0xc8).to_a, 0xcb, 0xce, 0xd0, 0xd2, 
        0xd3
      ].flatten!
    ),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3370f0...0x3387d4),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x33b6f8...0x33cddc),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x33356c...0x3338a4,
      exclusions: [
        0xa1, (0xa3..0xa7).to_a, (0xa9..0xaf).to_a, (0xb1..0xb5).to_a, 
        (0xb8..0xbf).to_a, (0xc1..0xc8).to_a, 0xcb, 0xce, 0xd0, 0xd2, 
        0xd3
      ].flatten!
     ),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x335548...0x33693c),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x153d7...0x16979),
      _s.dr(_s.sot_file_es['GC'], 0x1502e...0x1652e),
      _s.dr(_s.sot_file_fr['GC'], 0x15017...0x16635),
      _s.dr(_s.sot_file_gb['GC'], 0x14c6f...0x1613d),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2ca370...0x2cba54),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2ca880...0x2cbc88),
  }

#------------------------------------------------------------------------------
# Armor data
#------------------------------------------------------------------------------

  # Range of armor IDs
  _s.armor_id_range = 0x50...0xa0
  
  # Offset ranges of armor data
  _s.armor_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35c88c...0x35d14c),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x35e92c...0x35f1ec),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35b644...0x35c2c4),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33fb20...0x3407a0),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x344128...0x344da8),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x337fc0...0x338c40),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33da70...0x33e6f0),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f31a8...0x2f3a68),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c2688...0x2c3308),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c3190...0x2c3e10),
  }
  
  # Offset ranges of armor names
  _s.armor_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1a06a...0x1a466),
      _s.dr(_s.sot_file_es['DC'], 0x19ed7...0x1a32f),
      _s.dr(_s.sot_file_fr['DC'], 0x1a1d5...0x1a61d),
      _s.dr(_s.sot_file_gb['DC'], 0x19b11...0x19f03),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1a279...0x1a675),
      _s.dr(_s.sot_file_es['DC'], 0x19f07...0x1a35f),
      _s.dr(_s.sot_file_fr['DC'], 0x1a265...0x1a6ad),
      _s.dr(_s.sot_file_gb['DC'], 0x19b20...0x19f12),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1d289...0x1d6aa),
      _s.dr(_s.sot_file_es['GC'], 0x1cf43...0x1d39e),
      _s.dr(_s.sot_file_fr['GC'], 0x1d18e...0x1d5d7),
      _s.dr(_s.sot_file_gb['GC'], 0x1c921...0x1cd13),
    ],
  }
  
  # Offset ranges of armor descriptions
  _s.armor_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x10fec...0x12352),
      _s.dr(_s.sot_file_es['DC'], 0x10f83...0x121c3),
      _s.dr(_s.sot_file_fr['DC'], 0x10f79...0x121f0),
      _s.dr(_s.sot_file_gb['DC'], 0x10da4...0x11fff),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x111d9...0x12543),
      _s.dr(_s.sot_file_es['DC'], 0x10faa...0x121e9),
      _s.dr(_s.sot_file_fr['DC'], 0x11008...0x1227f),
      _s.dr(_s.sot_file_gb['DC'], 0x10db1...0x1200c),
    ],
    'DC-JP-6107810'    => _s.dr(
      _s.exec_file['DC'], 0x2af194...0x2af400,
      exclusions: [0x59, (0x5b..0x70).to_a].flatten!
    ),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x335b4c...0x3370f0),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x33a154...0x33b6f8),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x33337c...0x33356c,
      exclusions: [0x59, (0x5b..0x70).to_a].flatten!
     ),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x3343f8...0x335548),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x14060...0x153d7),
      _s.dr(_s.sot_file_es['GC'], 0x13dc4...0x1502e),
      _s.dr(_s.sot_file_fr['GC'], 0x13da3...0x15017),
      _s.dr(_s.sot_file_gb['GC'], 0x139f6...0x14c6f),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c8ddc...0x2ca370),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c9714...0x2ca880),
  }

#------------------------------------------------------------------------------
# Character magic data
#------------------------------------------------------------------------------

  # Range of character magic IDs
  _s.character_magic_id_range = 0x0...0x24
  
  # Offset ranges of character magic data
  _s.character_magic_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35b994...0x35bea4),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x35da34...0x35df44),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35a0a4...0x35a764),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33e580...0x33ec40),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x342b88...0x343248),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x336a20...0x3370e0),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33c4d0...0x33cb90),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f22b0...0x2f27c0),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c10e8...0x2c17a8),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c1bf0...0x2c22b0),
  }
  
  # Offset ranges of character magic names
  _s.character_magic_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x19a1b...0x19b29),
      _s.dr(_s.sot_file_es['DC'], 0x19825...0x19933),
      _s.dr(_s.sot_file_fr['DC'], 0x19b4e...0x19c5c),
      _s.dr(_s.sot_file_gb['DC'], 0x194e3...0x195f1),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x19c2a...0x19d38),
      _s.dr(_s.sot_file_es['DC'], 0x19854...0x19963),
      _s.dr(_s.sot_file_fr['DC'], 0x19bde...0x19cec),
      _s.dr(_s.sot_file_gb['DC'], 0x194f2...0x19600),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1cc3a...0x1cd48),
      _s.dr(_s.sot_file_es['GC'], 0x1c88d...0x1c99b),
      _s.dr(_s.sot_file_fr['GC'], 0x1cafd...0x1cc0b),
      _s.dr(_s.sot_file_gb['GC'], 0x1c2f4...0x1c402),
    ],
  }
  
  # Offset ranges of character magic descriptions
  _s.character_magic_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0xe00e...0xed40),
      _s.dr(_s.sot_file_es['DC'], 0xdf58...0xec71),
      _s.dr(_s.sot_file_fr['DC'], 0xdf86...0xece4),
      _s.dr(_s.sot_file_gb['DC'], 0xdd43...0xeaa4),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0xe17f...0xeeb1),
      _s.dr(_s.sot_file_es['DC'], 0xdf7f...0xec98),
      _s.dr(_s.sot_file_fr['DC'], 0xe016...0xed74),
      _s.dr(_s.sot_file_gb['DC'], 0xdd50...0xeab1),
    ],
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x2adf00...0x2ae8c0),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x332934...0x3336a8),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x336f3c...0x337cb0),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x3320b4...0x332ab8),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x3313b4...0x332120),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x11025...0x11d53),
      _s.dr(_s.sot_file_es['GC'], 0x10d2f...0x11a56),
      _s.dr(_s.sot_file_fr['GC'], 0x10d3c...0x11a9a),
      _s.dr(_s.sot_file_gb['GC'], 0x1093f...0x116a9),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c5b60...0x2c68d4),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c6668...0x2c73e0),
  }
  
  # Offset ranges of character magic ship descriptions
  _s.character_magic_ship_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x183d9...0x18e5d),
      _s.dr(_s.sot_file_es['DC'], 0x18219...0x18c0e),
      _s.dr(_s.sot_file_fr['DC'], 0x1843a...0x18ebf),
      _s.dr(_s.sot_file_gb['DC'], 0x17f3a...0x18955),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x185e8...0x1906c),
      _s.dr(_s.sot_file_es['DC'], 0x18246...0x18c3b),
      _s.dr(_s.sot_file_fr['DC'], 0x184ca...0x18f52),
      _s.dr(_s.sot_file_gb['DC'], 0x17f49...0x18964),
    ],
    'DC-JP-HDR-0076'   => _s.dr(
      _s.exec_file['DC'], 0x33d1a0...0x33d9e0,
      exclusions: [0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'DC-JP-HDR-0119'   => _s.dr(
      _s.exec_file['DC'], 0x3417a8...0x341fe8,
      exclusions: [0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x335c10...0x3363c4,
      exclusions: [0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'DC-US-MK-51052'   => _s.dr(
      _s.exec_file['DC'], 0x33b104...0x33ba34,
      exclusions: [0x8, 0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1b603...0x1c085),
      _s.dr(_s.sot_file_es['GC'], 0x1b23a...0x1bc6f),
      _s.dr(_s.sot_file_fr['GC'], 0x1b3e9...0x1be6e),
      _s.dr(_s.sot_file_gb['GC'], 0x1ad4b...0x1b766),
    ],
    'GC-JP-GEA'        => _s.dr(
      _s.exec_file['GC'], 0x2d058c...0x2d0dcc,
      exclusions: [0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'GC-US-GEA'        => _s.dr(
      _s.exec_file['GC'], 0x2d05c4...0x2d0ef4,
      exclusions: [0x8, 0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
  }

#------------------------------------------------------------------------------
# Character data
#------------------------------------------------------------------------------

  # Range of character IDs
  _s.character_id_range = 0x0...0x6
  
  # Offset ranges of character data
  _s.character_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x333a38...0x337ed4),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x335aa4...0x335e68),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x359d14...0x35a0a4),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33e1F0...0x33e580),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x3427f8...0x342b88),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x336690...0x336a20),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33c140...0x33c4d0),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c2ff0...0x2c3380),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c0d58...0x2c10e8),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c1860...0x2c1bf0),
  }

#------------------------------------------------------------------------------
# Character super move data
#------------------------------------------------------------------------------

  # Range of character super move IDs
  _s.character_super_move_id_range = 0x24...0x3e
  
  # Offset ranges of character super move data
  _s.character_super_move_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35bea4...0x35c24c),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x35df44...0x35e2ec),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35a764...0x35ac44),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33ec40...0x33f120),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x343248...0x343728),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x3370e0...0x3375c0),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33cb90...0x33d070),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f27c0...0x2f2b68),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c17a8...0x2c1c88),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c22b0...0x2c2790),
  }
  
  # Offset ranges of character super move names
  _s.character_super_move_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x19b29...0x19c74),
      _s.dr(_s.sot_file_es['DC'], 0x19933...0x19a98),
      _s.dr(_s.sot_file_fr['DC'], 0x19c5c...0x19dd8),
      _s.dr(_s.sot_file_gb['DC'], 0x195f1...0x19744),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x19d38...0x19e83),
      _s.dr(_s.sot_file_es['DC'], 0x19963...0x19ac8),
      _s.dr(_s.sot_file_fr['DC'], 0x19cec...0x19e68),
      _s.dr(_s.sot_file_gb['DC'], 0x19600...0x19753),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1cd48...0x1ce93),
      _s.dr(_s.sot_file_es['GC'], 0x1c99b...0x1cb04),
      _s.dr(_s.sot_file_fr['GC'], 0x1cc0b...0x1cd83),
      _s.dr(_s.sot_file_gb['GC'], 0x1c402...0x1c555),
    ],
  }
  
  # Offset ranges of character super move descriptions
  _s.character_super_move_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0xed40...0xf6d1),
      _s.dr(_s.sot_file_es['DC'], 0xec71...0xf617),
      _s.dr(_s.sot_file_fr['DC'], 0xece4...0xf696),
      _s.dr(_s.sot_file_gb['DC'], 0xeaa4...0xf451),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0xeeb1...0xf842),
      _s.dr(_s.sot_file_es['DC'], 0xec98...0xf63e),
      _s.dr(_s.sot_file_fr['DC'], 0xed74...0xf726),
      _s.dr(_s.sot_file_gb['DC'], 0xeab1...0xf45e),
    ],
    'DC-JP-6107810'    => _s.dr(
      _s.exec_file['DC'], 0x2ae8c0...0x2aeeac, exclusions: [0x31]
    ),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3336a8...0x334094),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x337cb0...0x33869c),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x332ab8...0x333110, exclusions: [0x31]
    ),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x332120...0x332ad8),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x11d53...0x126e4),
      _s.dr(_s.sot_file_es['GC'], 0x11a56...0x12410),
      _s.dr(_s.sot_file_fr['GC'], 0x11a9a...0x1244e),
      _s.dr(_s.sot_file_gb['GC'], 0x116a9...0x12056),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c68d4...0x2c72c0),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c73e0...0x2c7d9c),
  }

#------------------------------------------------------------------------------
# Crew member data
#------------------------------------------------------------------------------

  # Range of crew member IDs
  _s.crew_member_id_range = 0x0...0x16
  
  # Offset ranges of crew member data
  _s.crew_member_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x360668...0x360878),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x362708...0x362918),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3457c4...0x345adc),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x349dcc...0x34a0e4),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33dc64...0x33df7c),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x343714...0x343a2c),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f8a4c...0x2f8c5c),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d5aa4...0x2d5dbc),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d5e64...0x2d617c),
  }
  
  # Offset ranges of crew member names
  _s.crew_member_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1ba76...0x1bb0c),
      _s.dr(_s.sot_file_es['DC'], 0x1ba43...0x1bad9),
      _s.dr(_s.sot_file_fr['DC'], 0x1bd1a...0x1bdb0),
      _s.dr(_s.sot_file_gb['DC'], 0x1b51f...0x1b5b5),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1bc84...0x1bd1a),
      _s.dr(_s.sot_file_es['DC'], 0x1ba79...0x1bb0f),
      _s.dr(_s.sot_file_fr['DC'], 0x1bdad...0x1be43),
      _s.dr(_s.sot_file_gb['DC'], 0x1b527...0x1b5bd),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1ed75...0x1ee0b),
      _s.dr(_s.sot_file_es['GC'], 0x1eb78...0x1ec0e),
      _s.dr(_s.sot_file_fr['GC'], 0x1ed91...0x1ee27),
      _s.dr(_s.sot_file_gb['GC'], 0x1e3dd...0x1e473),
    ],
  }
  
  # Offset ranges of crew member descriptions
  _s.crew_member_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x18e5d...0x1958c),
      _s.dr(_s.sot_file_es['DC'], 0x18c0e...0x1937a),
      _s.dr(_s.sot_file_fr['DC'], 0x18ebf...0x1964b),
      _s.dr(_s.sot_file_gb['DC'], 0x18955...0x19052),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1906c...0x1979b),
      _s.dr(_s.sot_file_es['DC'], 0x18c3b...0x193a9),
      _s.dr(_s.sot_file_fr['DC'], 0x18f4f...0x196db),
      _s.dr(_s.sot_file_gb['DC'], 0x18964...0x19061),
    ],
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33d9e0...0x33e1f0),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x341fe8...0x3427f8),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x3363c4...0x336690,
      exclusions: [0x9, 0xf]
     ),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33ba34...0x33c140),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1c085...0x1c7ab),
      _s.dr(_s.sot_file_es['GC'], 0x1bc6f...0x1c3da),
      _s.dr(_s.sot_file_fr['GC'], 0x1be6e...0x1c5fa),
      _s.dr(_s.sot_file_gb['GC'], 0x1b766...0x1be63),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d0dcc...0x2d15dc),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d0ef4...0x2d1600),
  }

#------------------------------------------------------------------------------
# Enemy encounter data
#------------------------------------------------------------------------------

  # Maximum number of enemies in enemy encounter data
  _s.enemy_encounter_num_enemies = {
    'DC'               => 84,
    'DC-JP-6107110 06' => 50,
    'DC-JP-6107810'    => 50,
    'GC'               => 84,
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
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x362b6c...0x362ba7),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x364c0c...0x364c47),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3f673c...0x3f6777),
    'DC-JP-6107110 06' => _s.dr(_s.exec_file['DC'], 0x3c5a0b...0x3c5a14),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x3c5187...0x3c5190),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x3faeec...0x3faf27),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x3ef074...0x3ef0af),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x3f4eb8...0x3f4ef3),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2e03a0...0x2e03db),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2e1200...0x2e123b),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2e16e0...0x2e171b),
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

#------------------------------------------------------------------------------
# Enemy magic data
#------------------------------------------------------------------------------

  # Range of enemy magic IDs
  _s.enemy_magic_id_range = 0x0...0x24
  
  # Offset ranges of enemy magic data
  _s.enemy_magic_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x36fa64...0x36fd34),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x371af8...0x371dc8),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x358bd8...0x3590e8),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x35d1d8...0x35d6e8),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x350fe4...0x3514f4),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x356c30...0x357140),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d9398...0x2d9668),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2a9ee8...0x2aa3f8),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2aa440...0x2aa950),
  }
  
  # Offset ranges of enemy magic names
  _s.enemy_magic_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x12b6...0x13c4),
      _s.dr(_s.sot_file_es['DC'], 0x12a9...0x13b7),
      _s.dr(_s.sot_file_fr['DC'], 0x12ac...0x13ba),
      _s.dr(_s.sot_file_gb['DC'], 0x12a6...0x13b4),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x12b6...0x13c4),
      _s.dr(_s.sot_file_es['DC'], 0x12a9...0x13b7),
      _s.dr(_s.sot_file_fr['DC'], 0x12ac...0x13ba),
      _s.dr(_s.sot_file_gb['DC'], 0x12a6...0x13b4),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x13d6...0x14e4),
      _s.dr(_s.sot_file_es['GC'], 0x13c9...0x14d7),
      _s.dr(_s.sot_file_fr['GC'], 0x13cb...0x14d9),
      _s.dr(_s.sot_file_gb['GC'], 0x13c6...0x14d4),
    ],
  }

#------------------------------------------------------------------------------
# Enemy ship data
#------------------------------------------------------------------------------

  # Range of enemy ship IDs
  _s.enemy_ship_id_range = 0x0...0x2d
  
  # Offset ranges of enemy ship data
  _s.enemy_ship_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35e7f0...0x35fa38),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x360890...0x361ad8),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35eb5c...0x35fc3c),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3430dc...0x3445f4),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x3476e4...0x348bfc),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33b57c...0x33ca94),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x34102c...0x342544),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f6d14...0x2f7f5c),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d3574...0x2d4a8c),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d3934...0x2d4e4c),
  }
  
  # Offset ranges of enemy ship names
  _s.enemy_ship_name_files     = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1b335...0x1b50a),
      _s.dr(_s.sot_file_es['DC'], 0x1b27e...0x1b453),
      _s.dr(_s.sot_file_fr['DC'], 0x1b581...0x1b756),
      _s.dr(_s.sot_file_gb['DC'], 0x1adc0...0x1af95),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1b54a...0x1b71f),
      _s.dr(_s.sot_file_es['DC'], 0x1b2b4...0x1b489),
      _s.dr(_s.sot_file_fr['DC'], 0x1b612...0x1b7e7),
      _s.dr(_s.sot_file_gb['DC'], 0x1adcf...0x1afa4),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1e635...0x1e809),
      _s.dr(_s.sot_file_es['GC'], 0x1e3a6...0x1e57b),
      _s.dr(_s.sot_file_fr['GC'], 0x1e5f7...0x1e7cc),
      _s.dr(_s.sot_file_gb['GC'], 0x1dc7e...0x1de53),
    ],
  }
  
  # Offset ranges of enemy ship armament names
  _s.enemy_ship_arm_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1bb0c...0x1c0e5),
      _s.dr(_s.sot_file_es['DC'], 0x1bad9...0x1c0b5),
      _s.dr(_s.sot_file_fr['DC'], 0x1bdb0...0x1c382),
      _s.dr(_s.sot_file_gb['DC'], 0x1b5b5...0x1bb4f),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1bd1a...0x1c2f3),
      _s.dr(_s.sot_file_es['DC'], 0x1bb0f...0x1c0eb),
      _s.dr(_s.sot_file_fr['DC'], 0x1be43...0x1c415),
      _s.dr(_s.sot_file_gb['DC'], 0x1b5bd...0x1bb57),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1ee0b...0x1f3e5),
      _s.dr(_s.sot_file_es['GC'], 0x1ec0e...0x1f1da),
      _s.dr(_s.sot_file_fr['GC'], 0x1ee27...0x1f3f9),
      _s.dr(_s.sot_file_gb['GC'], 0x1e473...0x1ea0d),
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
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x36fd34...0x371274),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x371dc8...0x373308),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3590e8...0x35b728),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x35d6e8...0x35fd28),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x3514f4...0x353b34),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x357140...0x359780),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d9668...0x2dae8c),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2aa3f8...0x2acf6c),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2aa950...0x2ad4c4),
  }
  
  # Offset ranges of enemy super move names
  _s.enemy_super_move_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x13c4...0x1dc3),
      _s.dr(_s.sot_file_es['DC'], 0x13b7...0x1e6c),
      _s.dr(_s.sot_file_fr['DC'], 0x13ba...0x1e25),
      _s.dr(_s.sot_file_gb['DC'], 0x13b4...0x1d37),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x13c4...0x1dc3),
      _s.dr(_s.sot_file_es['DC'], 0x13b7...0x1e6c),
      _s.dr(_s.sot_file_fr['DC'], 0x13ba...0x1e25),
      _s.dr(_s.sot_file_gb['DC'], 0x13b4...0x1d37),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x14e4...0x2079),
      _s.dr(_s.sot_file_es['GC'], 0x14d7...0x215d),
      _s.dr(_s.sot_file_fr['GC'], 0x14d9...0x211a),
      _s.dr(_s.sot_file_gb['GC'], 0x14d4...0x1ff8),
    ],
  }

#------------------------------------------------------------------------------
# EXP curve data
#------------------------------------------------------------------------------

  # Range of EXP curve IDs
  _s.exp_curve_id_range = 0x0...0x6
  
  # Offset ranges of EXP curve data
  _s.exp_curve_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.level_file['DC'], 0x0...0x948),
    'DC-EU-8320062 50' => _s.dr(_s.level_file['DC'], 0x0...0x948),
    'DC-JP-6107810'    => _s.dr(_s.level_file['DC'], 0x0...0x948),
    'DC-JP-HDR-0076'   => _s.dr(_s.level_file['DC'], 0x0...0x948),
    'DC-JP-HDR-0119'   => _s.dr(_s.level_file['DC'], 0x0...0x948),
    'DC-US-IGN9'       => _s.dr(_s.level_file['DC'], 0x0...0x948),
    'DC-US-MK-51052'   => _s.dr(_s.level_file['DC'], 0x0...0x948),
    'GC-EU-GEA'        => _s.dr(_s.level_file['GC'], 0x0...0x948),
    'GC-JP-GEA'        => _s.dr(_s.level_file['GC'], 0x0...0x948),
    'GC-US-GEA'        => _s.dr(_s.level_file['GC'], 0x0...0x948),
  }

#------------------------------------------------------------------------------
# Magic EXP curve data
#------------------------------------------------------------------------------

  # Range of magic EXP curve IDs
  _s.magic_exp_curve_id_range = 0x0...0x6
  
  # Offset ranges of magic EXP curve data
  _s.magic_exp_curve_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.level_file['DC'], 0x948...0xaf8),
    'DC-EU-8320062 50' => _s.dr(_s.level_file['DC'], 0x948...0xaf8),
    'DC-JP-6107810'    => _s.dr(_s.level_file['DC'], 0x948...0xaf8),
    'DC-JP-HDR-0076'   => _s.dr(_s.level_file['DC'], 0x948...0xaf8),
    'DC-JP-HDR-0119'   => _s.dr(_s.level_file['DC'], 0x948...0xaf8),
    'DC-US-IGN9'       => _s.dr(_s.level_file['DC'], 0x948...0xaf8),
    'DC-US-MK-51052'   => _s.dr(_s.level_file['DC'], 0x948...0xaf8),
    'GC-EU-GEA'        => _s.dr(_s.level_file['GC'], 0x948...0xaf8),
    'GC-JP-GEA'        => _s.dr(_s.level_file['GC'], 0x948...0xaf8),
    'GC-US-GEA'        => _s.dr(_s.level_file['GC'], 0x948...0xaf8),
  }

#------------------------------------------------------------------------------
# Playable ship data
#------------------------------------------------------------------------------

  # Range of playable ship IDs
  _s.playable_ship_id_range = {
    'DC'               => 0x0...0x5,
    'DC-JP-6107110 06' => 0x0...0x6,
    'DC-JP-6107810'    => 0x0...0x6,
    'GC'               => 0x0...0x5,
  }

  
  # Offset ranges of playable ship data
  _s.playable_ship_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35e64c...0x35e7f0),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x3606ec...0x360890),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35ea0c...0x35eb5c),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x342ee8...0x3430dc),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x3474f0...0x3476e4),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33b388...0x33b57c),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x340e38...0x34102c),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f6b70...0x2f6d14),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d3380...0x2d3574),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d3740...0x2d3934),
  }
  
  # Offset ranges of playable ship names
  _s.playable_ship_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1b2ff...0x1b335),
      _s.dr(_s.sot_file_es['DC'], 0x1b248...0x1b27e),
      _s.dr(_s.sot_file_fr['DC'], 0x1b54b...0x1b581),
      _s.dr(_s.sot_file_gb['DC'], 0x1ad8a...0x1adc0),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1b514...0x1b54a),
      _s.dr(_s.sot_file_es['DC'], 0x1b27e...0x1b2b4),
      _s.dr(_s.sot_file_fr['DC'], 0x1b5dc...0x1b612),
      _s.dr(_s.sot_file_gb['DC'], 0x1ad99...0x1adcf),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1e5ff...0x1e635),
      _s.dr(_s.sot_file_es['GC'], 0x1e370...0x1e3a6),
      _s.dr(_s.sot_file_fr['GC'], 0x1e5c1...0x1e5f7),
      _s.dr(_s.sot_file_gb['GC'], 0x1dc48...0x1dc7e),
    ],
  }

#------------------------------------------------------------------------------
# Ship accessory data
#------------------------------------------------------------------------------

  # Range of ship accessory IDs
  _s.ship_accessory_id_range = 0x1b8...0x1e0
  
  # Offset ranges of ship accessory data
  _s.ship_accessory_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35fe98...0x360398),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x361f38...0x362438),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x344c34...0x345314),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x34923c...0x34991c),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33d0d4...0x33d7b4),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x342b84...0x343264),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f831c...0x2f877c),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d502c...0x2d566c),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d53ec...0x2d5a2c),
  }
  
  # Offset ranges of ship accessory names
  _s.ship_accessory_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1b715...0x1b916),
      _s.dr(_s.sot_file_es['DC'], 0x1b661...0x1b89c),
      _s.dr(_s.sot_file_fr['DC'], 0x1b95b...0x1bb8d),
      _s.dr(_s.sot_file_gb['DC'], 0x1b1a8...0x1b3bf),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1b923...0x1bb24),
      _s.dr(_s.sot_file_es['DC'], 0x1b697...0x1b8d2),
      _s.dr(_s.sot_file_fr['DC'], 0x1b9ec...0x1bc1e),
      _s.dr(_s.sot_file_gb['DC'], 0x1b1b0...0x1b3c7),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1ea14...0x1ec15),
      _s.dr(_s.sot_file_es['GC'], 0x1e789...0x1e9cd),
      _s.dr(_s.sot_file_fr['GC'], 0x1e9d1...0x1ec03),
      _s.dr(_s.sot_file_gb['GC'], 0x1e066...0x1e27d),
    ],
  }
  
  # Offset ranges of ship accessory descriptions
  _s.ship_accessory_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x16c49...0x1798f),
      _s.dr(_s.sot_file_es['DC'], 0x16aec...0x177d1),
      _s.dr(_s.sot_file_fr['DC'], 0x16cb4...0x179e9),
      _s.dr(_s.sot_file_gb['DC'], 0x16897...0x1757b),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x16e58...0x17b9e),
      _s.dr(_s.sot_file_es['DC'], 0x16b19...0x177fe),
      _s.dr(_s.sot_file_fr['DC'], 0x16d44...0x17a79),
      _s.dr(_s.sot_file_gb['DC'], 0x168a6...0x1758a),
    ],
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33bb44...0x33c86c),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x34014c...0x340e74),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x334cdc...0x3355a8),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x339a38...0x33a730),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x19e71...0x1abb8),
      _s.dr(_s.sot_file_es['GC'], 0x19b0f...0x1a7f2),
      _s.dr(_s.sot_file_fr['GC'], 0x19c5d...0x1a998),
      _s.dr(_s.sot_file_gb['GC'], 0x196a8...0x1a38c),
    ],
    'GC-JP-GEA'       => _s.dr(_s.exec_file['GC'], 0x2cef30...0x2cfc58),
    'GC-US-GEA'       => _s.dr(_s.exec_file['GC'], 0x2ceef8...0x2cfbf0),
  }

#------------------------------------------------------------------------------
# Ship cannon data
#------------------------------------------------------------------------------

  # Range of ship cannon IDs
  _s.ship_cannon_id_range = 0x190...0x1b8
  
  # Offset ranges of ship cannon data
  _s.ship_cannon_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35fa38...0x35fe98),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x361ad8...0x361f38),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3445f4...0x344c34),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x348bfc...0x34923c),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33ca94...0x33d0d4),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x342544...0x342b84),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f7f5c...0x2f831c),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d4a8c...0x2d502c),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d4e4c...0x2d53ec),
  }
  
  # Offset ranges of ship cannon names
  _s.ship_cannon_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1b50a...0x1b715),
      _s.dr(_s.sot_file_es['DC'], 0x1b453...0x1b661),
      _s.dr(_s.sot_file_fr['DC'], 0x1b756...0x1b95b),
      _s.dr(_s.sot_file_gb['DC'], 0x1af95...0x1b1a8),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1b71f...0x1b923),
      _s.dr(_s.sot_file_es['DC'], 0x1b489...0x1b697),
      _s.dr(_s.sot_file_fr['DC'], 0x1b7e7...0x1b9ec),
      _s.dr(_s.sot_file_gb['DC'], 0x1afa4...0x1b1b0),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1e809...0x1ea14),
      _s.dr(_s.sot_file_es['GC'], 0x1e57b...0x1e789),
      _s.dr(_s.sot_file_fr['GC'], 0x1e7cc...0x1e9d1),
      _s.dr(_s.sot_file_gb['GC'], 0x1de53...0x1e066),
    ],
  }
  
  # Offset ranges of ship cannon descriptions
  _s.ship_cannon_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x15f61...0x16c49),
      _s.dr(_s.sot_file_es['DC'], 0x15da3...0x16aec),
      _s.dr(_s.sot_file_fr['DC'], 0x15f44...0x16cb4),
      _s.dr(_s.sot_file_gb['DC'], 0x15bce...0x16897),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x16170...0x16e58),
      _s.dr(_s.sot_file_es['DC'], 0x15dce...0x16b19),
      _s.dr(_s.sot_file_fr['DC'], 0x15fd4...0x16d44),
      _s.dr(_s.sot_file_gb['DC'], 0x15bdd...0x168a6),
    ],
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33aec8...0x33bb44),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x33f4d0...0x34014c),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x334340...0x334cdc),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x338d64...0x339a38),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1918c...0x19e71),
      _s.dr(_s.sot_file_es['GC'], 0x18dd2...0x19b0f),
      _s.dr(_s.sot_file_fr['GC'], 0x18ef6...0x19c5d),
      _s.dr(_s.sot_file_gb['GC'], 0x189df...0x196a8),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2ce2b4...0x2cef30),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2ce220...0x2ceef8),
  }

#------------------------------------------------------------------------------
# Ship item data
#------------------------------------------------------------------------------

  # Range of ship item IDs
  _s.ship_item_id_range = 0x1e0...0x1fe
  
  # Offset ranges of ship item data
  _s.ship_item_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x360398...0x360668),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x362438...0x362708),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x345314...0x3457c4),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x34991c...0x349dcc),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33d7b4...0x33dc64),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x343264...0x343714),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f877c...0x2f8a4c),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d566c...0x2d5aa4),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2d5a2c...0x2d5e64),
  }
  
  # Offset ranges of ship item names
  _s.ship_item_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1b916...0x1ba76),
      _s.dr(_s.sot_file_es['DC'], 0x1b89c...0x1ba43),
      _s.dr(_s.sot_file_fr['DC'], 0x1bb8d...0x1bd1a),
      _s.dr(_s.sot_file_gb['DC'], 0x1b3bf...0x1b51f),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1bb24...0x1bc84),
      _s.dr(_s.sot_file_es['DC'], 0x1b8d2...0x1ba79),
      _s.dr(_s.sot_file_fr['DC'], 0x1bc1e...0x1bdad),
      _s.dr(_s.sot_file_gb['DC'], 0x1b3c7...0x1b527),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1ec15...0x1ed75),
      _s.dr(_s.sot_file_es['GC'], 0x1e9cd...0x1eb78),
      _s.dr(_s.sot_file_fr['GC'], 0x1ec03...0x1ed91),
      _s.dr(_s.sot_file_gb['GC'], 0x1e27d...0x1e3dd),
    ],
  }
  
  # Offset ranges of ship item descriptions
  _s.ship_item_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1798f...0x183d9),
      _s.dr(_s.sot_file_es['DC'], 0x177d1...0x18219),
      _s.dr(_s.sot_file_fr['DC'], 0x179e9...0x1843a),
      _s.dr(_s.sot_file_gb['DC'], 0x1757b...0x17f3a),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x17b9e...0x185e8),
      _s.dr(_s.sot_file_es['DC'], 0x177fe...0x18246),
      _s.dr(_s.sot_file_fr['DC'], 0x17a79...0x184ca),
      _s.dr(_s.sot_file_gb['DC'], 0x1758a...0x17f49),
    ],
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33c86c...0x33d1a0),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x340e74...0x3417a8),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x3355a8...0x335c10),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33a730...0x33b104),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1abb8...0x1b603),
      _s.dr(_s.sot_file_es['GC'], 0x1a7f2...0x1b23a),
      _s.dr(_s.sot_file_fr['GC'], 0x1a998...0x1b3e9),
      _s.dr(_s.sot_file_gb['GC'], 0x1a38c...0x1ad4b),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2cfc58...0x2d058c),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2cfbf0...0x2d05c4),
  }

#------------------------------------------------------------------------------
# Shop data
#------------------------------------------------------------------------------

  # Range of shop IDs
  _s.shop_id_range = {
    'DC'         => 0x0...0x2b,
    'DC-US-IGN9' => 0x0...0x3 ,
    'GC'         => 0x0...0x2b,
  }

  # Offset ranges of shop data
  _s.shop_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x36a85c...0x36b9d4),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x36c8f0...0x36da68),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3ffec0...0x401038),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x404670...0x4057e8),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x3f8808...0x3f8940),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x3fe558...0x3ff6d0),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2e7dd4...0x2e8f4c),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2e8d08...0x2e9e80),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2e90a0...0x2ea218),
  }
  
  # Offset ranges of shop descriptions
  _s.shop_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0xdc6e...0xdef1),
      _s.dr(_s.sot_file_es['DC'], 0xdb92...0xde38),
      _s.dr(_s.sot_file_fr['DC'], 0xdbe3...0xde88),
      _s.dr(_s.sot_file_gb['DC'], 0xd990...0xdc3b),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0xddc2...0xe045),
      _s.dr(_s.sot_file_es['DC'], 0xdbaf...0xde55),
      _s.dr(_s.sot_file_fr['DC'], 0xdc61...0xdf06),
      _s.dr(_s.sot_file_gb['DC'], 0xd99d...0xdc48),
    ],
    'DC-JP-HDR-0076'   => _s.dr(
      _s.exec_file['DC'], 0x34e0f0...0x34e2dc, msg_table: true
    ),
    'DC-JP-HDR-0119'   => _s.dr(
      _s.exec_file['DC'], 0x3526f8...0x3528e4, msg_table: true
    ),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x34679c...0x3467d4, msg_table: true
     ),
    'DC-US-MK-51052'   => _s.dr(
      _s.exec_file['DC'], 0x34c034...0x34c210, msg_table: true
    ),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x10c7c...0x10f00),
      _s.dr(_s.sot_file_es['GC'], 0x1095d...0x10c03),
      _s.dr(_s.sot_file_fr['GC'], 0x10993...0x10c38),
      _s.dr(_s.sot_file_gb['GC'], 0x10580...0x1082b),
    ],
    'GC-JP-GEA'        => _s.dr(
      _s.exec_file['GC'], 0x2b6158...0x2b6344, msg_table: true
    ),
    'GC-US-GEA'      => _s.dr(
      _s.exec_file['GC'], 0x2b6554...0x2b6730, msg_table: true
    ),
  }

#------------------------------------------------------------------------------
# Special item data
#------------------------------------------------------------------------------

  # Range of special item IDs
  _s.special_item_id_range = 0x140...0x190
  
  # Offset ranges of special item data
  _s.special_item_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35e18c...0x35e54c),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x36022c...0x3605ec),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35dc28...0x35e308),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x342104...0x3427e4),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x34670c...0x346dec),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33a5a4...0x33ac84),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x340054...0x340734),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f4aa8...0x2f4e68),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c4c6c...0x2c534c),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c5774...0x2c5e54),
  }
  
  # Offset ranges of special item names
  _s.special_item_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1ac8f...0x1b060),
      _s.dr(_s.sot_file_es['DC'], 0x1abe8...0x1afab),
      _s.dr(_s.sot_file_fr['DC'], 0x1af13...0x1b2e1),
      _s.dr(_s.sot_file_gb['DC'], 0x1a741...0x1ab16),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1aea0...0x1b271),
      _s.dr(_s.sot_file_es['DC'], 0x1ac18...0x1afde),
      _s.dr(_s.sot_file_fr['DC'], 0x1afa5...0x1b372),
      _s.dr(_s.sot_file_gb['DC'], 0x1a752...0x1ab27),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1dede...0x1e2b1),
      _s.dr(_s.sot_file_es['GC'], 0x1dc62...0x1e028),
      _s.dr(_s.sot_file_fr['GC'], 0x1ded3...0x1e2a2),
      _s.dr(_s.sot_file_gb['GC'], 0x1d556...0x1d929),
    ],
  }
  
  # Offset ranges of special item descriptions
  _s.special_item_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x151e2...0x15f61),
      _s.dr(_s.sot_file_es['DC'], 0x14fd2...0x15da3),
      _s.dr(_s.sot_file_fr['DC'], 0x1513a...0x15f44),
      _s.dr(_s.sot_file_gb['DC'], 0x14d74...0x15bce),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x153d2...0x16170),
      _s.dr(_s.sot_file_es['DC'], 0x14ffa...0x15dce),
      _s.dr(_s.sot_file_fr['DC'], 0x151ca...0x15fd4),
      _s.dr(_s.sot_file_gb['DC'], 0x14d83...0x15bdd),
    ],
    'DC-JP-6107810'    => _s.dr(
      _s.exec_file['DC'], 0x2afff8...0x2b0314,
      exclusions: [0x14a, 0x14b, 0x151, 0x154]
    ),
    'DC-JP-HDR-0076'   => _s.dr(
      _s.exec_file['DC'], 0x33a3c4...0x33aec8,
      exclusions: [0x152, 0x15b, 0x161, 0x162]
    ),
    'DC-JP-HDR-0119'   => _s.dr(
      _s.exec_file['DC'], 0x33e9cc...0x33f4d0,
      exclusions: [0x152, 0x15b, 0x161, 0x162]
    ),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x334034...0x334340,
      exclusions: [0x14a, 0x14b, 0x151, 0x154]
     ),
    'DC-US-MK-51052'   => _s.dr(
      _s.exec_file['DC'], 0x3381a4...0x338d64,
      exclusions: [0x152, 0x15b, 0x161, 0x162]
    ),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x18262...0x1918c),
      _s.dr(_s.sot_file_es['GC'], 0x17e6f...0x18dd2),
      _s.dr(_s.sot_file_fr['GC'], 0x17f59...0x18ef6),
      _s.dr(_s.sot_file_gb['GC'], 0x179f9...0x189df),
    ],
    'GC-JP-GEA'        => _s.dr(
      _s.exec_file['GC'], 0x2cd644...0x2ce2b4,
      exclusions: [0x152, 0x15b, 0x161, 0x162]
    ),
    'GC-US-GEA'        => _s.dr(
      _s.exec_file['GC'], 0x2cd4ec...0x2ce220,
      exclusions: [0x152, 0x15b, 0x161, 0x162]
    ),
  }

#------------------------------------------------------------------------------
# Spirit curve data
#------------------------------------------------------------------------------

  # Range of spirit curve IDs
  _s.spirit_curve_id_range = 0x0...0x6
  
  # Offset ranges of spirit curve data
  _s.spirit_curve_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x333f6c...0x334410),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x335fd8...0x33647c),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35e528...0x35e9cc),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x342a04...0x342ea8),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x34700c...0x3474b0),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x33aea4...0x33b348),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x340954...0x340df8),
    'GC-EU'            => _s.dr(_s.exec_file['GC'], 0x2c4aa0...0x2c4f44),
    'GC-JP'            => _s.dr(_s.exec_file['GC'], 0x2c567c...0x2c5b20),
    'GC-US'            => _s.dr(_s.exec_file['GC'], 0x2c6184...0x2c6628),
  }

#------------------------------------------------------------------------------
# Usable item data
#------------------------------------------------------------------------------

  # Range of usable item IDs
  _s.usable_item_id_range = 0xf0...0x140
  
  # Offset ranges of usable item data
  _s.usable_item_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35da0c...0x35e18c),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x35faac...0x36022c),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35d0e8...0x35dc28),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x3415c4...0x342104),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x345bcc...0x34670c),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x339a64...0x33a5a4),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33f514...0x340054),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f4328...0x2f4aa8),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c412c...0x2c4c6c),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c4c34...0x2c5774),
  }
  
  # Offset ranges of usable item names
  _s.usable_item_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x1a8d2...0x1ac8f),
      _s.dr(_s.sot_file_es['DC'], 0x1a7ce...0x1abe8),
      _s.dr(_s.sot_file_fr['DC'], 0x1aae6...0x1af13),
      _s.dr(_s.sot_file_gb['DC'], 0x1a384...0x1a741),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x1aae1...0x1aea0),
      _s.dr(_s.sot_file_es['DC'], 0x1a7fc...0x1ac18),
      _s.dr(_s.sot_file_fr['DC'], 0x1ab76...0x1afa5),
      _s.dr(_s.sot_file_gb['DC'], 0x1a393...0x1a752),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1db1c...0x1dede),
      _s.dr(_s.sot_file_es['GC'], 0x1d83d...0x1dc62),
      _s.dr(_s.sot_file_fr['GC'], 0x1daa2...0x1ded3),
      _s.dr(_s.sot_file_gb['GC'], 0x1d194...0x1d556),
    ],
  }
  
  # Offset ranges of usable item descriptions
  _s.usable_item_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x138e9...0x151e2),
      _s.dr(_s.sot_file_es['DC'], 0x13690...0x14fd2),
      _s.dr(_s.sot_file_fr['DC'], 0x13817...0x1513a),
      _s.dr(_s.sot_file_gb['DC'], 0x134b8...0x14d74),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x13ad7...0x153d2),
      _s.dr(_s.sot_file_es['DC'], 0x136b6...0x14ffa),
      _s.dr(_s.sot_file_fr['DC'], 0x138a5...0x151ca),
      _s.dr(_s.sot_file_gb['DC'], 0x134c5...0x14d83),
    ],
    'DC-JP-6107810'    => _s.dr(
      _s.exec_file['DC'], 0x2af74c...0x2afff8,
      exclusions: [0x100, 0x101, (0x10c..0x11a).to_a].flatten!
    ),
    'DC-JP-HDR-0076'   => _s.dr(
      _s.exec_file['DC'], 0x3387d4...0x33a3c4,
      exclusions: (0x12e..0x130).to_a
    ),
    'DC-JP-HDR-0119'   => _s.dr(
      _s.exec_file['DC'], 0x33cddc...0x33e9cc,
      exclusions: (0x12e..0x130).to_a
    ),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x3338a4...0x334034,
      exclusions: [0x100, 0x101, (0x10c..0x11a).to_a].flatten!
     ),
    'DC-US-MK-51052'   => _s.dr(
      _s.exec_file['DC'], 0x33693c...0x3381a4,
      exclusions: (0x12d..0x130).to_a
    ),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x16979...0x18262),
      _s.dr(_s.sot_file_es['GC'], 0x1652e...0x17e6f),
      _s.dr(_s.sot_file_fr['GC'], 0x16635...0x17f59),
      _s.dr(_s.sot_file_gb['GC'], 0x1613d...0x179f9),
    ],
    'GC-JP-GEA'        => _s.dr(
        _s.exec_file['GC'], 0x2cba54...0x2cd644,
        exclusions: (0x12e..0x130).to_a
    ),
    'GC-US-GEA'        => _s.dr(
        _s.exec_file['GC'], 0x2cbc88...0x2cd4ec,
        exclusions: (0x12d..0x130).to_a
    ),
  }

#------------------------------------------------------------------------------
# Weapon data
#------------------------------------------------------------------------------

  # Range of weapon IDs
  _s.weapon_id_range = 0x0...0x50
  
  # Offset ranges of weapon data
  _s.weapon_data_files = {
    'DC-EU-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x35c24c...0x35c88c),
    'DC-EU-8320062 50' => _s.dr(_s.exec_file['DC'], 0x35e2ec...0x35e92c),
    'DC-JP-6107810'    => _s.dr(_s.exec_file['DC'], 0x35ac44...0x35b644),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x33f120...0x33fb20),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x343728...0x344128),
    'DC-US-IGN9'       => _s.dr(_s.exec_file['DC'], 0x3375c0...0x337fc0),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x33d070...0x33da70),
    'GC-EU-GEA'        => _s.dr(_s.exec_file['GC'], 0x2f2b68...0x2f31a8),
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c1c88...0x2c2688),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c2790...0x2c3190),
  }
  
  # Offset ranges of weapon names
  _s.weapon_name_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0x19c74...0x1a06a),
      _s.dr(_s.sot_file_es['DC'], 0x19a98...0x19ed7),
      _s.dr(_s.sot_file_fr['DC'], 0x19dd8...0x1a1d5),
      _s.dr(_s.sot_file_gb['DC'], 0x19744...0x19b11),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0x19e83...0x1a279),
      _s.dr(_s.sot_file_es['DC'], 0x19ac8...0x19f07),
      _s.dr(_s.sot_file_fr['DC'], 0x19e68...0x1a265),
      _s.dr(_s.sot_file_gb['DC'], 0x19753...0x19b20),
    ],
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x1ce93...0x1d289),
      _s.dr(_s.sot_file_es['GC'], 0x1cb04...0x1cf43),
      _s.dr(_s.sot_file_fr['GC'], 0x1cd83...0x1d18e),
      _s.dr(_s.sot_file_gb['GC'], 0x1c555...0x1c921),
    ],
  }
  
  # Offset ranges of weapon descriptions
  _s.weapon_dscr_files = {
    'DC-EU-MK-51052'   => [
      _s.dr(_s.sot_file_de['DC'], 0xf6d1...0x10fec),
      _s.dr(_s.sot_file_es['DC'], 0xf617...0x10f83),
      _s.dr(_s.sot_file_fr['DC'], 0xf696...0x10f79),
      _s.dr(_s.sot_file_gb['DC'], 0xf451...0x10da4),
    ],
    'DC-EU-8320062 50' => [
      _s.dr(_s.sot_file_de['DC'], 0xf842...0x111d9),
      _s.dr(_s.sot_file_es['DC'], 0xf63e...0x10faa),
      _s.dr(_s.sot_file_fr['DC'], 0xf726...0x11008),
      _s.dr(_s.sot_file_gb['DC'], 0xf45e...0x10db1),
    ],
    'DC-JP-6107810'    => _s.dr(
      _s.exec_file['DC'], 0x2aeeac...0x2af194,
      exclusions: [
        0x3, 0x4, (0x6..0xf).to_a, 0x12, 0x13, (0x15..0x1f).to_a, 
        (0x22..0x2f).to_a, (0x31..0x39).to_a, (0x3b..0x3f).to_a, 
        (0x41..0x46).to_a
      ].flatten!
    ),
    'DC-JP-HDR-0076'   => _s.dr(_s.exec_file['DC'], 0x334094...0x335b4c),
    'DC-JP-HDR-0119'   => _s.dr(_s.exec_file['DC'], 0x33869c...0x33a154),
    'DC-US-IGN9'       => _s.dr(
      _s.exec_file['DC'], 0x333110...0x33337c,
      exclusions: [
        0x3, 0x4, (0x6..0xf).to_a, 0x12, 0x13, (0x15..0x1f).to_a, 
        (0x22..0x2f).to_a, (0x31..0x39).to_a, (0x3b..0x3f).to_a, 
        (0x41..0x46).to_a
      ].flatten!
    ),
    'DC-US-MK-51052'   => _s.dr(_s.exec_file['DC'], 0x332ad8...0x3343f8),
    'GC-EU-GEA'        => [
      _s.dr(_s.sot_file_de['GC'], 0x126e4...0x14060),
      _s.dr(_s.sot_file_es['GC'], 0x12410...0x13dc4),
      _s.dr(_s.sot_file_fr['GC'], 0x1244e...0x13da3),
      _s.dr(_s.sot_file_gb['GC'], 0x12056...0x139f6),
    ],
    'GC-JP-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c72c0...0x2c8ddc),
    'GC-US-GEA'        => _s.dr(_s.exec_file['GC'], 0x2c7d9c...0x2c9714),
  }

end # class SYS

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
