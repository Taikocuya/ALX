#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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
# Game paths
#------------------------------------------------------------------------------

  # Path to 'share' directory
  _s.share_dir      = _s.expand_path('share')
  # Path to 'thirdparty' directory
  _s.thirdparty_dir = _s.expand_path('thirdparty')

  # Path to 'bak' directory relative to game root
  _s.bak_dir  = 'bak'
  # Path to 'csv' directory relative to game root
  _s.csv_dir  = 'csv'
  # Path to 'root' directory relative to game root
  _s.root_dir = 'root'
  
  # Path to BNR file relative to game root
  _s.bnr_file = "#{_s.root_dir}/opening.bnr"
  # Path to HDR file relative to game root
  _s.hdr_file = "#{_s.root_dir}/&&systemdata/ISO.hdr"

  # Path to DOL file relative to game root
  _s.dol_file    = "#{_s.root_dir}/&&systemdata/Start.dol"
  # Path to LMT file relative to game root
  _s.lmt_file    = "#{_s.root_dir}/battle/first.lmt"
  # Path to German SOT file relative to game root (PAL-E only)
  _s.sot_file_de = "#{_s.root_dir}/german.sot"
  # Path to Spanish SOT file relative to game root (PAL-E only)
  _s.sot_file_es = "#{_s.root_dir}/spanish.sot"
  # Path to French SOT file relative to game root (PAL-E only)
  _s.sot_file_fr = "#{_s.root_dir}/french.sot"
  # Path to English SOT file relative to game root (PAL-E only)
  _s.sot_file_gb = "#{_s.root_dir}/english.sot"

  # Path to DAT files of boss enemies relative to game root
  _s.eb_dat_file = "#{_s.root_dir}/battle/ebinit%s.dat"
  # Path to DAT files of standard enemies relative to game root
  _s.ec_dat_file = "#{_s.root_dir}/battle/ecinit%s.dat"
  # Path to ENP files with +%s+ as wildcard relative to game root
  _s.enp_file    = "#{_s.root_dir}/field/%s.enp"
  # Path to EVP file relative to game root
  _s.evp_file    = "#{_s.root_dir}/battle/epevent.evp"
  # Path to TEC files with +%s+ as wildcard relative to game root
  _s.tec_file    = "#{_s.root_dir}/field/%s.tec"

#------------------------------------------------------------------------------
# CSV paths
#------------------------------------------------------------------------------

  # Path to CSV file of accessories relative to game root
  _s.accessory_csv_file            = "#{_s.csv_dir}/accessories.csv"
  # Path to CSV file of armors relative to game root
  _s.armor_csv_file                = "#{_s.csv_dir}/armors.csv"
  # Path to CSV file of characters relative to game root
  _s.character_csv_file            = "#{_s.csv_dir}/characters.csv"
  # Path to CSV file of character magics relative to game root
  _s.character_magic_csv_file      = "#{_s.csv_dir}/charactermagics.csv"
  # Path to CSV file of character skills relative to game root
  _s.character_super_move_csv_file = "#{_s.csv_dir}/charactersupermoves.csv"
  # Path to CSV file of crew members relative to game root
  _s.crew_member_csv_file          = "#{_s.csv_dir}/crewmembers.csv"
  # Path to CSV file of enemy database relative to game root
  _s.enemy_csv_file                = "#{_s.csv_dir}/enemies.csv"
  # Path to CSV file of enemy events relative to game root
  _s.enemy_event_csv_file          = "#{_s.csv_dir}/enemyevents.csv"
  # Path to CSV file of enemy encounters relative to game root
  _s.enemy_encounter_csv_file      = "#{_s.csv_dir}/enemyencounters.csv"
  # Path to CSV file of enemy magics relative to game root
  _s.enemy_magic_csv_file          = "#{_s.csv_dir}/enemymagics.csv"
  # Path to CSV file of enemy ships relative to game root
  _s.enemy_ship_csv_file           = "#{_s.csv_dir}/enemyships.csv"
  # Path to CSV file of enemy ship tasks relative to game root
  _s.enemy_ship_task_csv_file      = "#{_s.csv_dir}/enemyshiptasks.csv"
  # Path to CSV file of enemy skills relative to game root
  _s.enemy_super_move_csv_file     = "#{_s.csv_dir}/enemysupermoves.csv"
  # Path to CSV file of EXP curves relative to game root
  _s.exp_curve_csv_file            = "#{_s.csv_dir}/expcurves.csv"
  # Path to CSV file of magic EXP curves relative to game root
  _s.magic_exp_curve_csv_file      = "#{_s.csv_dir}/magicexpcurves.csv"
  # Path to CSV file of playable ships relative to game root
  _s.playable_ship_csv_file        = "#{_s.csv_dir}/playableships.csv"
  # Path to CSV file of ship accessories relative to game root
  _s.ship_accessory_csv_file       = "#{_s.csv_dir}/shipaccessories.csv"
  # Path to CSV file of ship cannons relative to game root
  _s.ship_cannon_csv_file          = "#{_s.csv_dir}/shipcannons.csv"
  # Path to CSV file of ship items relative to game root
  _s.ship_item_csv_file            = "#{_s.csv_dir}/shipitems.csv"
  # Path to CSV file of shops relative to game root
  _s.shop_csv_file                 = "#{_s.csv_dir}/shops.csv"
  # Path to CSV file of special items relative to game root
  _s.special_item_csv_file         = "#{_s.csv_dir}/specialitems.csv"
  # Path to CSV file of spirit curves relative to game root
  _s.spirit_curve_csv_file         = "#{_s.csv_dir}/spiritcurves.csv"
  # Path to CSV file of usable items relative to game root
  _s.usable_item_csv_file          = "#{_s.csv_dir}/usableitems.csv"
  # Path to CSV file of weapons relative to game root
  _s.weapon_csv_file               = "#{_s.csv_dir}/weapons.csv"

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
# BNR data
#------------------------------------------------------------------------------

  # Regular expression to check validity of game title.
  _s.game_title_exp = /^(Skies of Arcadia Legends|ｴﾀｰﾅﾙｱﾙｶﾃﾞｨｱ ﾚｼﾞｪﾝﾄﾞ)$/
  # Regular expression to check validity of developer.
  _s.developer_exp  = /^(SEGA|セガ)$/

#------------------------------------------------------------------------------
# HDR data
#------------------------------------------------------------------------------

  # Game ID
  _s.game_id    = 'GEA'
  # Region IDs
  _s.region_ids = {
    'E' => 'NTSC-U',
    'J' => 'NTSC-J',
    'P' => 'PAL-E' ,
  }
  # ISO 3166-1 alpha-2 IDs
  _s.country_ids = {
    'E' => 'US',
    'J' => 'JP',
    'P' => 'EU',
  }
  # Maker ID
  _s.maker_id   = '8P'
  
#------------------------------------------------------------------------------
# Accessory data
#------------------------------------------------------------------------------

  # Range of accessory IDs
  _s.accessory_id_range   = 0xa0...0xf0
  # Offset ranges of accessory data
  _s.accessory_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c3e10...0x2c4a90),
    'J' => DataRange.new(_s.dol_file, 0x2c3308...0x2c3f88),
    'P' => DataRange.new(_s.dol_file, 0x2f3a68...0x2f4328),
  }
  # Offset ranges of accessory names
  _s.accessory_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1d6aa...0x1db1c),
      DataRange.new(_s.sot_file_es, 0x1d39e...0x1d83d),
      DataRange.new(_s.sot_file_fr, 0x1d5d7...0x1daa2),
      DataRange.new(_s.sot_file_gb, 0x1cd13...0x1d194),
    ],
  }
  # Offset ranges of accessory descriptions
  _s.accessory_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2ca880...0x2cbc88),
    'J' => DataRange.new(_s.dol_file, 0x2ca370...0x2cba54),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x153d7...0x16979),
      DataRange.new(_s.sot_file_es, 0x1502e...0x1652e),
      DataRange.new(_s.sot_file_fr, 0x15017...0x16635),
      DataRange.new(_s.sot_file_gb, 0x14c6f...0x1613d),
    ],
  }

#------------------------------------------------------------------------------
# Armor data
#------------------------------------------------------------------------------

  # Range of armor IDs
  _s.armor_id_range   = 0x50...0xa0
  # Offset ranges of armor data
  _s.armor_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c3190...0x2c3e10),
    'J' => DataRange.new(_s.dol_file, 0x2c2688...0x2c3308),
    'P' => DataRange.new(_s.dol_file, 0x2f31a8...0x2f3a68),
  }
  # Offset ranges of armor names
  _s.armor_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1d289...0x1d6aa),
      DataRange.new(_s.sot_file_es, 0x1cf43...0x1d39e),
      DataRange.new(_s.sot_file_fr, 0x1d18e...0x1d5d7),
      DataRange.new(_s.sot_file_gb, 0x1c921...0x1cd13),
    ],
  }
  # Offset ranges of armor descriptions
  _s.armor_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c9714...0x2ca880),
    'J' => DataRange.new(_s.dol_file, 0x2c8ddc...0x2ca370),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x14060...0x153d7),
      DataRange.new(_s.sot_file_es, 0x13dc4...0x1502e),
      DataRange.new(_s.sot_file_fr, 0x13da3...0x15017),
      DataRange.new(_s.sot_file_gb, 0x139f6...0x14c6f),
    ],
  }

#------------------------------------------------------------------------------
# Character magic data
#------------------------------------------------------------------------------

  # Range of character magic IDs
  _s.character_magic_id_range        = 0x0...0x24
  # Offset ranges of character magic data
  _s.character_magic_data_files      = {
    'E' => DataRange.new(_s.dol_file, 0x2c1bf0...0x2c22b0),
    'J' => DataRange.new(_s.dol_file, 0x2c10e8...0x2c17a8),
    'P' => DataRange.new(_s.dol_file, 0x2f22b0...0x2f27c0),
  }
  # Offset ranges of character magic names
  _s.character_magic_name_files      = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1cc3a...0x1cd48),
      DataRange.new(_s.sot_file_es, 0x1c88d...0x1c99b),
      DataRange.new(_s.sot_file_fr, 0x1cafd...0x1cc0b),
      DataRange.new(_s.sot_file_gb, 0x1c2f4...0x1c40),
    ],
  }
  # Offset ranges of character magic descriptions
  _s.character_magic_dscr_files      = {
    'E' => DataRange.new(_s.dol_file, 0x2c6668...0x2c73e0),
    'J' => DataRange.new(_s.dol_file, 0x2c5b60...0x2c68d4),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x11025...0x11d53),
      DataRange.new(_s.sot_file_es, 0x10d2f...0x11a56),
      DataRange.new(_s.sot_file_fr, 0x10d3c...0x11a9a),
      DataRange.new(_s.sot_file_gb, 0x1093f...0x116a9),
    ],
  }
  # Offset ranges of character magic ship descriptions
  _s.character_magic_ship_dscr_files = {
    'E' => DataRange.new(
      _s.dol_file, 0x2d05c4...0x2d0ef4,
      :exclusions => [0x8, 0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'J' => DataRange.new(
      _s.dol_file, 0x2d058c...0x2d0dcc,
      :exclusions => [0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1b603...0x1c085),
      DataRange.new(_s.sot_file_es, 0x1b23a...0x1bc6f),
      DataRange.new(_s.sot_file_fr, 0x1b3e9...0x1be6e),
      DataRange.new(_s.sot_file_gb, 0x1ad4b...0x1b766),
    ],
  }

#------------------------------------------------------------------------------
# Character data
#------------------------------------------------------------------------------

  # Range of character IDs
  _s.character_id_range   = 0x0...0x6
  # Offset ranges of character data
  _s.character_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c1860...0x2c1bf0),
    'J' => DataRange.new(_s.dol_file, 0x2c0d58...0x2c10e8),
    'P' => DataRange.new(_s.dol_file, 0x2c2ff0...0x2c3380),
  }

#------------------------------------------------------------------------------
# Character super move data
#------------------------------------------------------------------------------

  # Range of character super move IDs
  _s.character_super_move_id_range   = 0x24...0x3e
  # Offset ranges of character super move data
  _s.character_super_move_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c22b0...0x2c2790),
    'J' => DataRange.new(_s.dol_file, 0x2c17a8...0x2c1c88),
    'P' => DataRange.new(_s.dol_file, 0x2f27c0...0x2f2b68),
  }
  # Offset ranges of character super move names
  _s.character_super_move_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1cd48...0x1ce93),
      DataRange.new(_s.sot_file_es, 0x1c99b...0x1cb04),
      DataRange.new(_s.sot_file_fr, 0x1cc0b...0x1cd83),
      DataRange.new(_s.sot_file_gb, 0x1c402...0x1c555),
    ],
  }
  # Offset ranges of character super move descriptions
  _s.character_super_move_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c73e0...0x2c7d9c),
    'J' => DataRange.new(_s.dol_file, 0x2c68d4...0x2c72c0),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x11d53...0x126e4),
      DataRange.new(_s.sot_file_es, 0x11a56...0x12410),
      DataRange.new(_s.sot_file_fr, 0x11a9a...0x1244e),
      DataRange.new(_s.sot_file_gb, 0x116a9...0x12056),
    ],
  }

#------------------------------------------------------------------------------
# Crew member data
#------------------------------------------------------------------------------

  # Range of crew member IDs
  _s.crew_member_id_range   = 0x0...0x16
  # Offset ranges of crew member data
  _s.crew_member_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2d5e64...0x2d617c),
    'J' => DataRange.new(_s.dol_file, 0x2d5aa4...0x2d5dbc),
    'P' => DataRange.new(_s.dol_file, 0x2f8a4c...0x2f8c5c),
  }
  # Offset ranges of crew member names
  _s.crew_member_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1ed75...0x1ee0b),
      DataRange.new(_s.sot_file_es, 0x1eb78...0x1ec0e),
      DataRange.new(_s.sot_file_fr, 0x1ed91...0x1ee27),
      DataRange.new(_s.sot_file_gb, 0x1e3dd...0x1e473),
    ],
  }
  # Offset ranges of crew member descriptions
  _s.crew_member_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2d0ef4...0x2d1600),
    'J' => DataRange.new(_s.dol_file, 0x2d0dcc...0x2d15dc),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1c085...0x1c7ab),
      DataRange.new(_s.sot_file_es, 0x1bc6f...0x1c3da),
      DataRange.new(_s.sot_file_fr, 0x1be6e...0x1c5fa),
      DataRange.new(_s.sot_file_gb, 0x1b766...0x1be63),
    ],
  }

#------------------------------------------------------------------------------
# Enemy event BGM data
#------------------------------------------------------------------------------

  # Range of enemy event BGM IDs
  _s.enemy_event_bgm_id_range = 0x0...0x59
  # Offset ranges of enemy event BGMs
  _s.enemy_event_bgm_files = {
    'E' => DataRange.new(_s.dol_file, 0x2e16e0...0x2e171b),
    'J' => DataRange.new(_s.dol_file, 0x2e1200...0x2e123b),
    'P' => DataRange.new(_s.dol_file, 0x2e03a0...0x2e03db),
  }

#------------------------------------------------------------------------------
# Enemy magic data
#------------------------------------------------------------------------------

  # Range of enemy magic IDs
  _s.enemy_magic_id_range   = 0x0...0x24
  # Offset ranges of enemy magic data
  _s.enemy_magic_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2aa440...0x2aa950),
    'J' => DataRange.new(_s.dol_file, 0x2a9ee8...0x2aa3f8),
    'P' => DataRange.new(_s.dol_file, 0x2d9398...0x2d9668),
  }
  # Offset ranges of enemy magic names
  _s.enemy_magic_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x13d6...0x14e4),
      DataRange.new(_s.sot_file_es, 0x13c9...0x14d7),
      DataRange.new(_s.sot_file_fr, 0x13cb...0x14d9),
      DataRange.new(_s.sot_file_gb, 0x13c6...0x14d4),
    ],
  }

#------------------------------------------------------------------------------
# Enemy ship data
#------------------------------------------------------------------------------

  # Range of enemy ship IDs
  _s.enemy_ship_id_range       = 0x0...0x2d
  # Offset ranges of enemy ship data
  _s.enemy_ship_data_files     = {
    'E' => DataRange.new(_s.dol_file, 0x2d3934...0x2d4e4c),
    'J' => DataRange.new(_s.dol_file, 0x2d3574...0x2d4a8c),
    'P' => DataRange.new(_s.dol_file, 0x2f6d14...0x2f7f5c),
  }
  # Offset ranges of enemy ship names
  _s.enemy_ship_name_files     = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1e635...0x1e809),
      DataRange.new(_s.sot_file_es, 0x1e3a6...0x1e57b),
      DataRange.new(_s.sot_file_fr, 0x1e5f7...0x1e7cc),
      DataRange.new(_s.sot_file_gb, 0x1dc7e...0x1de53),
    ],
  }
  # Offset ranges of enemy ship armament names
  _s.enemy_ship_arm_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1ee0b...0x1f3e5),
      DataRange.new(_s.sot_file_es, 0x1ec0e...0x1f1da),
      DataRange.new(_s.sot_file_fr, 0x1ee27...0x1f3f9),
      DataRange.new(_s.sot_file_gb, 0x1e473...0x1ea0d),
    ],
  }

#------------------------------------------------------------------------------
# Enemy ship task data
#------------------------------------------------------------------------------

  _s.enemy_ship_map              = Hash.new('???')
  _s.enemy_ship_map['r500a.tec'] = 23
  _s.enemy_ship_map['r501a.tec'] =  2
  _s.enemy_ship_map['r503a.tec'] = 21
  _s.enemy_ship_map['r506a.tec'] = 24
  _s.enemy_ship_map['r507a.tec'] = 11
  _s.enemy_ship_map['r509a.tec'] = 12
  _s.enemy_ship_map['r510a.tec'] =  4
  _s.enemy_ship_map['r513a.tec'] = 35
  _s.enemy_ship_map['r514a.tec'] = 13
  _s.enemy_ship_map['r515a.tec'] = 25
  _s.enemy_ship_map['r518a.tec'] =  4
  _s.enemy_ship_map['r519a.tec'] = 38
  _s.enemy_ship_map['r520a.tec'] =  9
  _s.enemy_ship_map['r521a.tec'] = 10
  _s.enemy_ship_map['r522a.tec'] = 16
  _s.enemy_ship_map['r523a.tec'] = 32
  _s.enemy_ship_map['r524a.tec'] = 29
  _s.enemy_ship_map['r525a.tec'] = 44
  _s.enemy_ship_map['r527a.tec'] = 36
  _s.enemy_ship_map['r530a.tec'] = 17
  _s.enemy_ship_map['r531a.tec'] = 26
  _s.enemy_ship_map['r532a.tec'] = 37
  _s.enemy_ship_map['r535a.tec'] = 27
  _s.enemy_ship_map['r537a.tec'] = 30
  _s.enemy_ship_map['r538a.tec'] = 31
  _s.enemy_ship_map['r540a.tec'] = 14
  _s.enemy_ship_map['r541a.tec'] = 14
  _s.enemy_ship_map['r542a.tec'] =  4
  _s.enemy_ship_map['r543a.tec'] =  5
  _s.enemy_ship_map['r544a.tec'] =  8
  _s.enemy_ship_map['r545a.tec'] = 18
  _s.enemy_ship_map['r547a.tec'] = 28
  _s.enemy_ship_map['r550a.tec'] = 21
  _s.enemy_ship_map['r551a.tec'] = 21
  _s.enemy_ship_map['r552a.tec'] = 21
  _s.enemy_ship_map['r553a.tec'] =  1
  _s.enemy_ship_map['r554a.tec'] =  0
  _s.enemy_ship_map['r555a.tec'] =  1
  _s.enemy_ship_map['r556a.tec'] =  3
  _s.enemy_ship_map['r557a.tec'] =  4
  _s.enemy_ship_map['r558a.tec'] =  4
  _s.enemy_ship_map['r559a.tec'] = 22
  _s.enemy_ship_map['r560a.tec'] =  1
  _s.enemy_ship_map['r562a.tec'] =  4
  _s.enemy_ship_map['r563a.tec'] =  5
  _s.enemy_ship_map['r564a.tec'] =  1
  _s.enemy_ship_map['r565a.tec'] = 22
  _s.enemy_ship_map['r566a.tec'] =  7
  _s.enemy_ship_map['r567a.tec'] =  6
  _s.enemy_ship_map['r568a.tec'] = 22
  _s.enemy_ship_map['r569a.tec'] =  5
  _s.enemy_ship_map['r572a.tec'] = 22
  _s.enemy_ship_map['r573a.tec'] = 43
  _s.enemy_ship_map['r574a.tec'] =  6
  _s.enemy_ship_map['r575a.tec'] =  7
  _s.enemy_ship_map['r576a.tec'] = 35
  _s.enemy_ship_map['r577a.tec'] = 32
  _s.enemy_ship_map['r578a.tec'] = 36
  _s.enemy_ship_map['r579a.tec'] = 37
  _s.enemy_ship_map['r580a.tec'] = 40
  _s.enemy_ship_map['r581a.tec'] = 41
  _s.enemy_ship_map['r582a.tec'] = 40
  _s.enemy_ship_map['r583a.tec'] = 40

#------------------------------------------------------------------------------
# Enemy super move data
#------------------------------------------------------------------------------

  # Range of enemy super move IDs
  _s.enemy_super_move_id_range   = 0x0...0x135
  # Offset ranges of enemy super move data
  _s.enemy_super_move_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2aa950...0x2ad4c4),
    'J' => DataRange.new(_s.dol_file, 0x2aa3f8...0x2acf6c),
    'P' => DataRange.new(_s.dol_file, 0x2d9668...0x2dae8c),
  }
  # Offset ranges of enemy super move names
  _s.enemy_super_move_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x14e4...0x2079),
      DataRange.new(_s.sot_file_es, 0x14d7...0x215d),
      DataRange.new(_s.sot_file_fr, 0x14d9...0x211a),
      DataRange.new(_s.sot_file_gb, 0x14d4...0x1ff8),
    ],
  }

#------------------------------------------------------------------------------
# EXP curve data
#------------------------------------------------------------------------------

  # Range of EXP curve IDs
  _s.exp_curve_id_range   = 0x0...0x6
  # Offset ranges of EXP curve data
  _s.exp_curve_data_files = {
    'E' => DataRange.new(_s.lmt_file, 0x000...0x948),
    'J' => DataRange.new(_s.lmt_file, 0x000...0x948),
    'P' => DataRange.new(_s.lmt_file, 0x000...0x948),
  }

#------------------------------------------------------------------------------
# Magic EXP curve data
#------------------------------------------------------------------------------

  # Range of magic EXP curve IDs
  _s.magic_exp_curve_id_range   = 0x0...0x6
  # Offset ranges of magic EXP curve data
  _s.magic_exp_curve_data_files = {
    'E' => DataRange.new(_s.lmt_file, 0x948...0xaf8),
    'J' => DataRange.new(_s.lmt_file, 0x948...0xaf8),
    'P' => DataRange.new(_s.lmt_file, 0x948...0xaf8),
  }

#------------------------------------------------------------------------------
# Playable ship data
#------------------------------------------------------------------------------

  # Range of playable ship IDs
  _s.playable_ship_id_range   = 0x0...0x5
  # Offset ranges of playable ship data
  _s.playable_ship_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2d3740...0x2d3934),
    'J' => DataRange.new(_s.dol_file, 0x2d3380...0x2d3574),
    'P' => DataRange.new(_s.dol_file, 0x2f6b70...0x2f6d14),
  }
  # Offset ranges of playable ship names
  _s.playable_ship_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1e5ff...0x1e635),
      DataRange.new(_s.sot_file_es, 0x1e370...0x1e3a6),
      DataRange.new(_s.sot_file_fr, 0x1e5c1...0x1e5f7),
      DataRange.new(_s.sot_file_gb, 0x1dc48...0x1dc7e),
    ],
  }

#------------------------------------------------------------------------------
# Ship accessory data
#------------------------------------------------------------------------------

  # Range of ship accessory IDs
  _s.ship_accessory_id_range   = 0x1b8...0x1e0
  # Offset ranges of ship accessory data
  _s.ship_accessory_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2d53ec...0x2d5a2c),
    'J' => DataRange.new(_s.dol_file, 0x2d502c...0x2d566c),
    'P' => DataRange.new(_s.dol_file, 0x2f831c...0x2f877c),
  }
  # Offset ranges of ship accessory names
  _s.ship_accessory_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1ea14...0x1ec15),
      DataRange.new(_s.sot_file_es, 0x1e789...0x1e9cd),
      DataRange.new(_s.sot_file_fr, 0x1e9d1...0x1ec03),
      DataRange.new(_s.sot_file_gb, 0x1e066...0x1e27d),
    ],
  }
  # Offset ranges of ship accessory descriptions
  _s.ship_accessory_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2ceef8...0x2cfbf0),
    'J' => DataRange.new(_s.dol_file, 0x2cef30...0x2cfc58),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x19e71...0x1abb8),
      DataRange.new(_s.sot_file_es, 0x19b0f...0x1a7f2),
      DataRange.new(_s.sot_file_fr, 0x19c5d...0x1a998),
      DataRange.new(_s.sot_file_gb, 0x196a8...0x1a38c),
    ],
  }

#------------------------------------------------------------------------------
# Ship cannon data
#------------------------------------------------------------------------------

  # Range of ship cannon IDs
  _s.ship_cannon_id_range   = 0x190...0x1b8
  # Offset ranges of ship cannon data
  _s.ship_cannon_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2d4e4c...0x2d53ec),
    'J' => DataRange.new(_s.dol_file, 0x2d4a8c...0x2d502c),
    'P' => DataRange.new(_s.dol_file, 0x2f7f5c...0x2f831c),
  }
  # Offset ranges of ship cannon names
  _s.ship_cannon_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1e809...0x1ea14),
      DataRange.new(_s.sot_file_es, 0x1e57b...0x1e789),
      DataRange.new(_s.sot_file_fr, 0x1e7cc...0x1e9d1),
      DataRange.new(_s.sot_file_gb, 0x1de53...0x1e066),
    ],
  }
  # Offset ranges of ship cannon descriptions
  _s.ship_cannon_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2ce220...0x2ceef8),
    'J' => DataRange.new(_s.dol_file, 0x2ce2b4...0x2cef30),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1918c...0x19e71),
      DataRange.new(_s.sot_file_es, 0x18dd2...0x19b0f),
      DataRange.new(_s.sot_file_fr, 0x18ef6...0x19c5d),
      DataRange.new(_s.sot_file_gb, 0x189df...0x196a8),
    ],
  }

#------------------------------------------------------------------------------
# Ship item data
#------------------------------------------------------------------------------

  # Range of ship item IDs
  _s.ship_item_id_range   = 0x1e0...0x1fe
  # Offset ranges of ship item data
  _s.ship_item_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2d5a2c...0x2d5e64),
    'J' => DataRange.new(_s.dol_file, 0x2d566c...0x2d5aa4),
    'P' => DataRange.new(_s.dol_file, 0x2f877c...0x2f8a4c),
  }
  # Offset ranges of ship item names
  _s.ship_item_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1ec15...0x1ed75),
      DataRange.new(_s.sot_file_es, 0x1e9cd...0x1eb78),
      DataRange.new(_s.sot_file_fr, 0x1ec03...0x1ed91),
      DataRange.new(_s.sot_file_gb, 0x1e27d...0x1e3dd),
    ],
  }
  # Offset ranges of ship item descriptions
  _s.ship_item_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2cfbf0...0x2d05c4),
    'J' => DataRange.new(_s.dol_file, 0x2cfc58...0x2d058c),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1abb8...0x1b603),
      DataRange.new(_s.sot_file_es, 0x1a7f2...0x1b23a),
      DataRange.new(_s.sot_file_fr, 0x1a998...0x1b3e9),
      DataRange.new(_s.sot_file_gb, 0x1a38c...0x1ad4b),
    ],
  }

#------------------------------------------------------------------------------
# Shop data
#------------------------------------------------------------------------------

  # Range of shop IDs
  _s.shop_id_range   = 0x0...0x2b
  # Offset ranges of shop data
  _s.shop_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2e90a0...0x2ea218),
    'J' => DataRange.new(_s.dol_file, 0x2e8d08...0x2e9e80),
    'P' => DataRange.new(_s.dol_file, 0x2e7dd4...0x2e8f4c),
  }
  # Offset ranges of shop descriptions
  _s.shop_dscr_files = {
    'E' => DataRange.new(
      _s.dol_file, 0x2b6554...0x2b6730,
      :use_msg_table => true
    ),
    'J' => DataRange.new(
      _s.dol_file, 0x2b6158...0x2b6344,
      :use_msg_table => true
    ),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x10c7c...0x10f00),
      DataRange.new(_s.sot_file_es, 0x1095d...0x10c03),
      DataRange.new(_s.sot_file_fr, 0x10993...0x10c38),
      DataRange.new(_s.sot_file_gb, 0x10580...0x1082b),
    ],
  }

#------------------------------------------------------------------------------
# Special item data
#------------------------------------------------------------------------------

  # Range of special item IDs
  _s.special_item_id_range   = 0x140...0x190
  # Offset ranges of special item data
  _s.special_item_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c5774...0x2c5e54),
    'J' => DataRange.new(_s.dol_file, 0x2c4c6c...0x2c534c),
    'P' => DataRange.new(_s.dol_file, 0x2f4aa8...0x2f4e68),
  }
  # Offset ranges of special item names
  _s.special_item_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1dede...0x1e2b1),
      DataRange.new(_s.sot_file_es, 0x1dc62...0x1e028),
      DataRange.new(_s.sot_file_fr, 0x1ded3...0x1e2a2),
      DataRange.new(_s.sot_file_gb, 0x1d556...0x1d929),
    ],
  }
  # Offset ranges of special item descriptions
  _s.special_item_dscr_files = {
    'E' => DataRange.new(
      _s.dol_file, 0x2cd4ec...0x2ce220,
      :exclusions => [0x152, 0x15b, 0x161, 0x162]
    ),
    'J' => DataRange.new(
      _s.dol_file, 0x2cd644...0x2ce2b4,
      :exclusions => [0x152, 0x15b, 0x161, 0x162]
    ),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x18262...0x1918c),
      DataRange.new(_s.sot_file_es, 0x17e6f...0x18dd2),
      DataRange.new(_s.sot_file_fr, 0x17f59...0x18ef6),
      DataRange.new(_s.sot_file_gb, 0x179f9...0x189df),
    ],
  }

#------------------------------------------------------------------------------
# Spirit curve data
#------------------------------------------------------------------------------

  # Range of spirit curve IDs
  _s.spirit_curve_id_range   = 0x0...0x6
  # Offset ranges of spirit curve data
  _s.spirit_curve_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c6184...0x2c6628),
    'J' => DataRange.new(_s.dol_file, 0x2c567c...0x2c5b20),
    'P' => DataRange.new(_s.dol_file, 0x2c4aa0...0x2c4f44),
  }

#------------------------------------------------------------------------------
# Usable item data
#------------------------------------------------------------------------------

  # Range of usable item IDs
  _s.usable_item_id_range   = 0xf0...0x140
  # Offset ranges of usable item data
  _s.usable_item_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c4c34...0x2c5774),
    'J' => DataRange.new(_s.dol_file, 0x2c412c...0x2c4c6c),
    'P' => DataRange.new(_s.dol_file, 0x2f4328...0x2f4aa8),
  }
  # Offset ranges of usable item names
  _s.usable_item_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1db1c...0x1dede),
      DataRange.new(_s.sot_file_es, 0x1d83d...0x1dc62),
      DataRange.new(_s.sot_file_fr, 0x1daa2...0x1ded3),
      DataRange.new(_s.sot_file_gb, 0x1d194...0x1d556),
    ],
  }
  # Offset ranges of usable item descriptions
  _s.usable_item_dscr_files = {
    'E' => DataRange.new(
      _s.dol_file, 0x2cbc88...0x2cd4ec,
      :exclusions => (0x12d..0x130).to_a
    ),
    'J' => DataRange.new(
      _s.dol_file, 0x2cba54...0x2cd644,
      :exclusions => (0x12e..0x130).to_a
    ),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x16979...0x18262),
      DataRange.new(_s.sot_file_es, 0x1652e...0x17e6f),
      DataRange.new(_s.sot_file_fr, 0x16635...0x17f59),
      DataRange.new(_s.sot_file_gb, 0x1613d...0x179f9),
    ],
  }

#------------------------------------------------------------------------------
# Weapon data
#------------------------------------------------------------------------------

  # Range of weapon IDs
  _s.weapon_id_range   = 0x0...0x50
  # Offset ranges of weapon data
  _s.weapon_data_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c2790...0x2c3190),
    'J' => DataRange.new(_s.dol_file, 0x2c1c88...0x2c2688),
    'P' => DataRange.new(_s.dol_file, 0x2f2b68...0x2f31a8),
  }
  # Offset ranges of weapon names
  _s.weapon_name_files = {
    'P' => [
      DataRange.new(_s.sot_file_de, 0x1ce93...0x1d289),
      DataRange.new(_s.sot_file_es, 0x1cb04...0x1cf43),
      DataRange.new(_s.sot_file_fr, 0x1cd83...0x1d18e),
      DataRange.new(_s.sot_file_gb, 0x1c555...0x1c921),
    ],
  }
  # Offset ranges of weapon descriptions
  _s.weapon_dscr_files = {
    'E' => DataRange.new(_s.dol_file, 0x2c7d9c...0x2c9714),
    'J' => DataRange.new(_s.dol_file, 0x2c72c0...0x2c8ddc),
    'P' => [
      DataRange.new(_s.sot_file_de, 0x126e4...0x14060),
      DataRange.new(_s.sot_file_es, 0x12410...0x13dc4),
      DataRange.new(_s.sot_file_fr, 0x1244e...0x13da3),
      DataRange.new(_s.sot_file_gb, 0x12056...0x139f6),
    ],
  }

end # class SYS

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
