#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle the base configuration.
CFG.configure do |_c|

#------------------------------------------------------------------------------
# ALX
#------------------------------------------------------------------------------

  # Required version of Ruby
  _c.ruby_version   = '2.7.0'
  # Maximum number of worker processes
  _c.worker_max     = Etc.nprocessors
  # Timeout per worker process in seconds 
  _c.worker_timeout = 0

  # Path to 'build' directory
  _c.build_dir  = expand('build')
  # Path to 'doc' directory
  _c.doc_dir    = expand('doc')
  # Path to 'log' directory
  _c.log_dir    = expand('log')
  # Path to 'temp' directory
  _c.temp_dir   = expand('temp')
  # Path to 'tool' directory
  _c.tool_dir   = expand('tool')
  # Path to 'vendor' directory
  _c.vendor_dir = expand('vendor')

  # Path to GCRebuilder executable file
  _c.gcm_builder_exe = join(_c.vendor_dir, 'gcrebuilder/gcr.exe')
  # Path to GDIBuilder executable file
  _c.gdi_builder_exe = join(_c.vendor_dir, 'gdibuilder/buildgdi.exe')
  # Path to Ruby executable file
  _c.ruby_exe        = join(_c.vendor_dir, 'ruby/ruby.exe')

#------------------------------------------------------------------------------
# Logging
#------------------------------------------------------------------------------

  # Enables or disables logging.
  _c.log       = true
  # Number of log files per command
  _c.log_keep  = 3
  # Severity level for log messages
  _c.log_level = 'info'
  
#------------------------------------------------------------------------------
# Cache
#------------------------------------------------------------------------------

  # Enables or disables caching.
  _c.cache             = true
  # Compression level of cache
  _c.cache_compression = 1

#------------------------------------------------------------------------------
# Game Paths
#------------------------------------------------------------------------------

  # Glob pattern for filtering game directories relative to +CFG.build_dir+.
  # This can be useful, for example, to quickly restrict to specific 
  # directories.
  _c.gameroot_dir = '**'

  # Path to 'backup' directory relative to the game directory.
  _c.backup_dir = 'backup'
  # Path to 'cache' directory relative to the game directory.
  _c.cache_dir  = 'cache'
  # Path to 'data' directory relative to the game directory.
  _c.data_dir   = 'data'
  # Path to 'image' directory relative to the game directory.
  _c.image_dir  = 'image'
  # Path to 'meta' directory relative to the game directory.
  _c.meta_dir   = 'meta'
  # Path to 'root' directory relative to the game directory.
  _c.root_dir   = 'root'

  # Path to BNR file relative to +CFG.root_dir+.
  _c.bnr_file = join(_c.root_dir, 'opening.bnr')
  # Path to HDR file relative to +CFG.root_dir+.
  _c.hdr_file = join(_c.root_dir, '&&systemdata/ISO.hdr')
  # Path to IP.BIN file relative to +CFG.root_dir+.
  _c.ip_file  = join(_c.meta_dir, 'IP.BIN')
  
  # Path to executable file relative to +CFG.root_dir+.
  _c.exec_file = {
    'DC' => join(_c.root_dir, '{ARES,ETERNAL,1ST_READ}.BIN'),
    'GC' => join(_c.root_dir, '&&systemdata/Start.dol'     ),
  }
  
  # Path to level data file relative to +CFG.root_dir+.
  _c.level_file = {
    'DC' => join(_c.root_dir, 'BATTLE/LEVELUP.DAT'),
    'GC' => join(_c.root_dir, 'battle/first.lmt'  ),
  }
  # Path to German SOT file relative to +CFG.root_dir+ (PAL-E only).
  _c.sot_file_de = {
    'DC' => join(_c.root_dir, 'GERMAN.SOT'),
    'GC' => join(_c.root_dir, 'german.sot'),
  }
  # Path to Spanish SOT file relative to +CFG.root_dir+ (PAL-E only).
  _c.sot_file_es = {
    'DC' => join(_c.root_dir, 'SPANISH.SOT'),
    'GC' => join(_c.root_dir, 'spanish.sot'),
  }
  # Path to French SOT file relative to +CFG.root_dir+ (PAL-E only).
  _c.sot_file_fr = {
    'DC' => join(_c.root_dir, 'FRENCH.SOT'),
    'GC' => join(_c.root_dir, 'french.sot'),
  }
  # Path to English SOT file relative to +CFG.root_dir+ (PAL-E only).
  _c.sot_file_gb = {
    'DC' => join(_c.root_dir, 'ENGLISH.SOT'),
    'GC' => join(_c.root_dir, 'english.sot'),
  }
  # Path to boss data files relative to +CFG.root_dir+. A single asterisk 
  # must be used.
  _c.eb_file = {
    'DC' => glob(_c.root_dir, 'BATTLE/EBINIT*.DAT'),
    'GC' => glob(_c.root_dir, 'battle/ebinit*.dat'),
  }
  # Path to enemy data files relative to +CFG.root_dir+. A single asterisk
  # must be used.
  _c.ec_file = {
    'DC' => glob(_c.root_dir, 'BATTLE/ECINIT*.DAT'),
    'GC' => glob(_c.root_dir, 'battle/ecinit*.dat'),
  }
  # Path to enemy encounter files relative to +CFG.root_dir+. A single 
  # asterisk must be used.
  _c.enp_file = {
    'DC' => glob(_c.root_dir, 'FIELD/*_EP.BIN'),
    'GC' => glob(_c.root_dir, 'field/*_ep.enp'),
  }
  # Path to enemy event file relative to +CFG.root_dir+.
  _c.evp_file = {
    'DC' => join(_c.root_dir, 'BATTLE/EPEVENT.BIN'),
    'GC' => join(_c.root_dir, 'battle/epevent.evp'),
  }
  # Path to script files relative to +CFG.root_dir+. A single asterisk must 
  # be used.
  _c.sct_file = {
    'DC' => glob(_c.root_dir, 'FIELD/*.SCT'),
    'GC' => glob(_c.root_dir, 'field/*.sct'),
  }
  # Path to enemy ship task files relative to +CFG.root_dir+. A single 
  # asterisk must be used.
  _c.tec_file = {
    'DC' => glob(_c.root_dir, 'FIELD/R*.BIN'),
    'GC' => glob(_c.root_dir, 'field/r*.tec'),
  }

#------------------------------------------------------------------------------
# CSV Paths
#------------------------------------------------------------------------------

  # Path to CSV file of accessories relative to +CFG.data_dir+.
  _c.accessory_csv_file            = "#{_c.data_dir}/accessory.csv"
  # Path to CSV file of armors relative to +CFG.data_dir+.
  _c.armor_csv_file                = "#{_c.data_dir}/armor.csv"
  # Path to CSV file of characters relative to +CFG.data_dir+.
  _c.character_csv_file            = "#{_c.data_dir}/character.csv"
  # Path to CSV file of character magics relative to +CFG.data_dir+.
  _c.character_magic_csv_file      = "#{_c.data_dir}/charactermagic.csv"
  # Path to CSV file of character super moves relative to +CFG.data_dir+.
  _c.character_super_move_csv_file = "#{_c.data_dir}/charactersupermove.csv"
  # Path to CSV file of crew members relative to +CFG.data_dir+.
  _c.crew_member_csv_file          = "#{_c.data_dir}/crewmember.csv"
  # Path to CSV file of defined strings relative to +CFG.data_dir+.
  _c.defined_string_csv_file       = "#{_c.data_dir}/definedstring.csv"
  # Path to CSV file of enemy database relative to +CFG.data_dir+.
  _c.enemy_csv_file                = "#{_c.data_dir}/enemy.csv"
  # Path to CSV file of enemy events relative to +CFG.data_dir+.
  _c.enemy_event_csv_file          = "#{_c.data_dir}/enemyevent.csv"
  # Path to CSV file of enemy encounters relative to +CFG.data_dir+.
  _c.enemy_encounter_csv_file      = "#{_c.data_dir}/enemyencounter.csv"
  # Path to CSV file of enemy magics relative to +CFG.data_dir+.
  _c.enemy_magic_csv_file          = "#{_c.data_dir}/enemymagic.csv"
  # Path to CSV file of enemy ships relative to +CFG.data_dir+.
  _c.enemy_ship_csv_file           = "#{_c.data_dir}/enemyship.csv"
  # Path to CSV file of enemy ship tasks relative to +CFG.data_dir+.
  _c.enemy_ship_task_csv_file      = "#{_c.data_dir}/enemyshiptask.csv"
  # Path to CSV file of enemy super moves relative to +CFG.data_dir+.
  _c.enemy_super_move_csv_file     = "#{_c.data_dir}/enemysupermove.csv"
  # Path to CSV file of enemy tasks relative to +CFG.data_dir+.
  _c.enemy_task_csv_file           = "#{_c.data_dir}/enemytask.csv"
  # Path to CSV file of EXP boost relative to +CFG.data_dir+.
  _c.exp_boost_csv_file            = "#{_c.data_dir}/expboost.csv"
  # Path to CSV file of EXP curves relative to +CFG.data_dir+.
  _c.exp_curve_csv_file            = "#{_c.data_dir}/expcurve.csv"
  # Path to CSV file of magic EXP curves relative to +CFG.data_dir+.
  _c.magic_exp_curve_csv_file      = "#{_c.data_dir}/magicexpcurve.csv"
  # Path to CSV file of playable ships relative to +CFG.data_dir+.
  _c.playable_ship_csv_file        = "#{_c.data_dir}/playableship.csv"
  # Path to CSV file of script tasks relative to +CFG.data_dir+. A single 
  # asterisk must be used.
  _c.script_task_csv_file          = "#{_c.data_dir}/scripttask/*.csv"
  # Path to CSV file of script versions relative to +CFG.data_dir+.
  _c.script_version_csv_file       = "#{_c.data_dir}/scriptversion.csv"
  # Path to CSV file of ship accessories relative to +CFG.data_dir+.
  _c.ship_accessory_csv_file       = "#{_c.data_dir}/shipaccessory.csv"
  # Path to CSV file of ship cannons relative to +CFG.data_dir+.
  _c.ship_cannon_csv_file          = "#{_c.data_dir}/shipcannon.csv"
  # Path to CSV file of ship items relative to +CFG.data_dir+.
  _c.ship_item_csv_file            = "#{_c.data_dir}/shipitem.csv"
  # Path to CSV file of shops relative to +CFG.data_dir+.
  _c.shop_csv_file                 = "#{_c.data_dir}/shop.csv"
  # Path to CSV file of special items relative to +CFG.data_dir+.
  _c.special_item_csv_file         = "#{_c.data_dir}/specialitem.csv"
  # Path to CSV file of spirit curves relative to +CFG.data_dir+.
  _c.spirit_curve_csv_file         = "#{_c.data_dir}/spiritcurve.csv"
  # Path to CSV file of swashbuckler ratings relative to +CFG.data_dir+.
  _c.swashbuckler_csv_file         = "#{_c.data_dir}/swashbuckler.csv"
  # Path to CSV file of treasure chests relative to +CFG.data_dir+.
  _c.treasure_chest_csv_file       = "#{_c.data_dir}/treasurechest.csv"
  # Path to CSV file of usable items relative to +CFG.data_dir+.
  _c.usable_item_csv_file          = "#{_c.data_dir}/usableitem.csv"
  # Path to CSV file of weapons relative to +CFG.data_dir+.
  _c.weapon_csv_file               = "#{_c.data_dir}/weapon.csv"
  # Path to CSV file of weapon effects relative to +CFG.data_dir+.
  _c.weapon_effect_csv_file        = "#{_c.data_dir}/weaponeffect.csv"

#------------------------------------------------------------------------------
# TPL Paths
#------------------------------------------------------------------------------

  # Path to TPL file of accessories relative to +CFG.build_dir+.
  _c.accessory_tpl_file            = 'accessory.tpl.csv'
  # Path to TPL file of armors relative to +CFG.build_dir+.
  _c.armor_tpl_file                = 'armor.tpl.csv'
  # Path to TPL file of characters relative to +CFG.build_dir+.
  _c.character_tpl_file            = 'character.tpl.csv'
  # Path to TPL file of character magics relative to +CFG.build_dir+.
  _c.character_magic_tpl_file      = 'charactermagic.tpl.csv'
  # Path to TPL file of character skills relative to +CFG.build_dir+.
  _c.character_super_move_tpl_file = 'charactersupermove.tpl.csv'
  # Path to TPL file of crew members relative to +CFG.build_dir+.
  _c.crew_member_tpl_file          = 'crewmember.tpl.csv'
  # Path to TPL file of enemy database relative to +CFG.build_dir+.
  _c.enemy_tpl_file                = 'enemy.tpl.csv'
  # Path to TPL file of enemy events relative to +CFG.build_dir+.
  _c.enemy_event_tpl_file          = 'enemyevent.tpl.csv'
  # Path to TPL file of enemy encounters relative to +CFG.build_dir+.
  _c.enemy_encounter_tpl_file      = 'enemyencounter.tpl.csv'
  # Path to TPL file of enemy magics relative to +CFG.build_dir+.
  _c.enemy_magic_tpl_file          = 'enemymagic.tpl.csv'
  # Path to TPL file of enemy ships relative to +CFG.build_dir+.
  _c.enemy_ship_tpl_file           = 'enemyship.tpl.csv'
  # Path to TPL file of enemy ship tasks relative to +CFG.build_dir+.
  _c.enemy_ship_task_tpl_file      = 'enemyshiptask.tpl.csv'
  # Path to TPL file of enemy skills relative to +CFG.build_dir+.
  _c.enemy_super_move_tpl_file     = 'enemysupermove.tpl.csv'
  # Path to TPL file of enemy tasks relative to +CFG.build_dir+.
  _c.enemy_task_tpl_file           = 'enemytask.tpl.csv'
  # Path to TPL file of EXP boost relative to +CFG.build_dir+.
  _c.exp_boost_tpl_file            = 'expboost.tpl.csv'
  # Path to TPL file of EXP curves relative to +CFG.build_dir+.
  _c.exp_curve_tpl_file            = 'expcurve.tpl.csv'
  # Path to TPL file of magic EXP curves relative to +CFG.build_dir+.
  _c.magic_exp_curve_tpl_file      = 'magicexpcurve.tpl.csv'
  # Path to TPL file of playable ships relative to +CFG.build_dir+.
  _c.playable_ship_tpl_file        = 'playableship.tpl.csv'
  # Path to TPL file of ship accessories relative to +CFG.build_dir+.
  _c.ship_accessory_tpl_file       = 'shipaccessory.tpl.csv'
  # Path to TPL file of ship cannons relative to +CFG.build_dir+.
  _c.ship_cannon_tpl_file          = 'shipcannon.tpl.csv'
  # Path to TPL file of ship items relative to +CFG.build_dir+.
  _c.ship_item_tpl_file            = 'shipitem.tpl.csv'
  # Path to TPL file of shops relative to +CFG.build_dir+.
  _c.shop_tpl_file                 = 'shop.tpl.csv'
  # Path to TPL file of special items relative to +CFG.build_dir+.
  _c.special_item_tpl_file         = 'specialitem.tpl.csv'
  # Path to TPL file of spirit curves relative to +CFG.build_dir+.
  _c.spirit_curve_tpl_file         = 'spiritcurve.tpl.csv'
  # Path to TPL file of swashbuckler ratings relative to +CFG.build_dir+.
  _c.swashbuckler_tpl_file         = 'swashbuckler.tpl.csv'
  # Path to TPL file of treasure chests relative to +CFG.build_dir+.
  _c.treasure_chest_tpl_file       = 'treasurechest.tpl.csv'
  # Path to TPL file of usable items relative to +CFG.build_dir+.
  _c.usable_item_tpl_file          = 'usableitem.tpl.csv'
  # Path to TPL file of weapons relative to +CFG.build_dir+.
  _c.weapon_tpl_file               = 'weapon.tpl.csv'
  # Path to TPL file of weapon effects relative to +CFG.build_dir+.
  _c.weapon_effect_tpl_file        = 'weaponeffect.tpl.csv'

#------------------------------------------------------------------------------
# Game Root Directory
#------------------------------------------------------------------------------

  # Platform files
  _c.platform_files        = {
    'DC' => [_c.exec_file['DC'], _c.ip_file              ],
    'GC' => [_c.exec_file['GC'], _c.bnr_file, _c.hdr_file],
  }
  # Platform endianness
  _c.platform_endianness   = {
    'DC' => :le,
    'GC' => :be,
  }
  # Platform compressions
  _c.platform_compressions = {
    'DC' => 'ALX::BinaryFile',
    'GC' => 'ALX::AklzFile'  ,
  }

  # Product IDs
  _c.product_ids   = {
    'DC' => Regexp.union(
      /^(6107110 06|6107810|8320062 50)$/,
      /^(HDR-0000|HDR-0076|HDR-0119|IGN9|MK-51052)$/
    ),
    'GC' => Regexp.union(
      /^GEA$/
    ),
  }
  # Product Names
  _c.product_names = {
    'DC' => Regexp.union(
      /^(DREAMON 20|DREAMCAST EXPRESS VOL6)$/           ,
      /^ETERNAL ARCADIA( KEY VERSION| KUZOKUBAN)?$/     ,
      /^OFFICIAL SEGA DREAMCAST MAGAZINE DECEMBER 2000$/,
      /^SKIES OF ARCADIA( DISC\s?(1|2))?$/,
      /^THIS IS A SAMPLE DISK FOR USE IN THE OFFICE ONLY/
    ),
    'GC' => Regexp.union(
      /^(Skies of|Eternal) Arcadia Legends$/,
      /^ｴﾀｰﾅﾙｱﾙｶﾃﾞｨｱ ﾚｼﾞｪﾝﾄﾞ$/
    ),
  }
    
  # Region IDs
  _c.region_ids = {
    'DC-E'   => 'PAL-E' ,
    'DC-J'   => 'NTSC-J',
    'DC-JU'  => 'NTSC-U',
    'DC-JUE' => 'NTSC-U',
    'DC-U'   => 'NTSC-U',
    'DC-UE'  => 'PAL-E' ,
    'GC-E'   => 'NTSC-U',
    'GC-J'   => 'NTSC-J',
    'GC-P'   => 'PAL-E' ,
  }

  # Country IDs
  _c.country_ids = {
    'DC-E'   => 'EU',
    'DC-J'   => 'JP',
    'DC-JU'  => 'US',
    'DC-JUE' => 'US',
    'DC-U'   => 'US',
    'DC-UE'  => 'EU',
    'GC-E'   => 'US',
    'GC-J'   => 'JP',
    'GC-P'   => 'EU',
  }

  # Maker IDs
  _c.maker_ids   = {
    'DC' => /^SEGA ENTERPRISES$/,
    'GC' => /^8P$/              ,
  }
  # Maker Names
  _c.maker_names = {
    'DC' => /^SEGA ENTERPRISES$/,
    'GC' => /^(SEGA|セガ)$/      ,
  }

  # Language names
  _c.language_names = {
    'DE' => 'German' ,
    'ES' => 'Spanish',
    'FR' => 'French' ,
    'GB' => 'English',
  }

end # class CFG

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
