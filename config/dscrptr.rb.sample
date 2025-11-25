#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

# Class to handle data descriptors.
DSCRPTR.configure do |_s|

#------------------------------------------------------------------------------
# Accessory Data
#------------------------------------------------------------------------------

  # Range of accessory IDs
  _s.accessory_id_range = rng(0xa0...0xf0)

  # Offset ranges of accessory data
  _s.accessory_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x35f1ec...0x35faac),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b6890...0x3b7150),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35d14c...0x35da0c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35cb44...0x35d968),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35c2c4...0x35d0e8),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3407a0...0x341420),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x344da8...0x345a28),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f02c4...0x2f0f44),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36e43c...0x36f0bc),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36e47c...0x36f0fc),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x338c40...0x3398c0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36c7ac...0x36d42c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33e5f4...0x33f274),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33e6f0...0x33f370),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f3a68...0x2f4328),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c3308...0x2c3f88),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c3e10...0x2c4a90),
  }

  # Offset ranges of accessory descriptions
  _s.accessory_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2afae4...0x2afe30, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2af400...0x2af74c, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x3370f0...0x3387d4
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x33b6f8...0x33cddc
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2ead78...0x2eb0ec, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x364d8c...0x366470
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x364dcc...0x3664b0
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x33356c...0x3338a4, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x364228...0x3653bc
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x3353f0...0x336850
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x335548...0x33693c
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2ca370...0x2cba54
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2ca880...0x2cbc88
    ),
  }

#------------------------------------------------------------------------------
# Armor Data
#------------------------------------------------------------------------------

  # Range of armor IDs
  _s.armor_id_range = rng(0x50...0xa0)
  
  # Offset ranges of armor data
  _s.armor_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x35e92c...0x35f1ec),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b5fd0...0x3b6890),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35c88c...0x35d14c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35bec4...0x35cb44),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35b644...0x35c2c4),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x33fb20...0x3407a0),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x344128...0x344da8),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2ef644...0x2f02c4),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36d7bc...0x36e43c),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36d7fc...0x36e47c),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x337fc0...0x338c40),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36bb2c...0x36c7ac),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33d974...0x33e5f4),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33da70...0x33e6f0),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f31a8...0x2f3a68),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c2688...0x2c3308),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c3190...0x2c3e10),
  }

  # Offset ranges of armor descriptions
  _s.armor_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2af878...0x2afae4, excl: [0x59, 0x5b..0x70]
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2af194...0x2af400, excl: [0x59, 0x5b..0x70]
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x335b4c...0x3370f0
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x33a154...0x33b6f8
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2eab28...0x2ead78, excl: [0x59, 0x5b..0x70]
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x3637e8...0x364d8c
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x363828...0x364dcc
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x33337c...0x33356c, excl: [0x59, 0x5b..0x70]
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x363334...0x364228
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x3342a0...0x3353f0
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x3343f8...0x335548
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c8ddc...0x2ca370
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c9714...0x2ca880
    ),
  }

#------------------------------------------------------------------------------
# Character Data
#------------------------------------------------------------------------------

  # Range of character IDs
  _s.character_id_range = 0x0...0x6
  
  # Offset ranges of character data
  _s.character_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x335aa4...0x335e68),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x361bbc...0x361f4c),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x333a38...0x333dc8),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35a594...0x35a924),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x359d14...0x35a0a4),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x33e1f0...0x33e580),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x3427f8...0x342b88),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2edd14...0x2ee0a4),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36be8c...0x36c21c),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36becc...0x36c25c),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x336690...0x336a20),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36a1fc...0x36a58c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33c044...0x33c3d4),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33c140...0x33c4d0),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2c2ff0...0x2c3380),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c0d58...0x2c10e8),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c1860...0x2c1bf0),
  }

#------------------------------------------------------------------------------
# Character Animation Data
#------------------------------------------------------------------------------

  # Enables or disables creation of new character animation files. When 
  # enabled, missing files will be created automatically. When disabled, only 
  # existing files will be modified; missing files will not be created.
  _s.character_animation_allow_new_files = false

#------------------------------------------------------------------------------
# Character Magic Data
#------------------------------------------------------------------------------

  # Range of character magic IDs
  _s.character_magic_id_range = 0x0...0x24
  
  # Offset ranges of character magic data
  _s.character_magic_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x35da34...0x35df44),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b50d8...0x3b55e8),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35b994...0x35bea4),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35a924...0x35afe4),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35a0a4...0x35a764),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x33e580...0x33ec40),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x342b88...0x343248),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2ee0a4...0x2ee764),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36c21c...0x36c8dc),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36c25c...0x36c91c),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x336a20...0x3370e0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36a58c...0x36ac4c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33c3d4...0x33ca94),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33c4d0...0x33cb90),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f22b0...0x2f27c0),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c10e8...0x2c17a8),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c1bf0...0x2c22b0),
  }

  # Offset ranges of character magic descriptions
  _s.character_magic_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2ae5e4...0x2aefa4
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2adf00...0x2ae8c0
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x332934...0x3336a8
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x336f3c...0x337cb0
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2e9848...0x2ea25c
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x3605d0...0x361344
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x360610...0x361384
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x3320b4...0x332ab8
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x36076c...0x361424
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x3312b8...0x332028
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x3313b4...0x332120
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c5b60...0x2c68d4
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c6668...0x2c73e0
    ),
  }
  
  # Offset ranges of character magic ship descriptions
  _s.character_magic_ship_dscr_files = {
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x33d1a0...0x33d9e0, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x3417a8...0x341fe8, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2ed4ec...0x2edca0, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x36ae3c...0x36b67c, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x36ae7c...0x36b6bc, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x335c10...0x3363c4, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x3692e4...0x369bcc, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x33aff0...0x33b920, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x33b104...0x33ba34, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2d058c...0x2d0dcc, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2d05c4...0x2d0ef4, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
  }

#------------------------------------------------------------------------------
# Character Super Move Data
#------------------------------------------------------------------------------

  # Range of character super move IDs
  _s.character_super_move_id_range = 0x24...0x3e
  
  # Offset ranges of character super move data
  _s.character_super_move_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x35df44...0x35e2ec),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b55e8...0x3b5990),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35bea4...0x35c24c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35afe4...0x35b4c4),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35a764...0x35ac44),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x33ec40...0x33f120),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x343248...0x343728),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2ee764...0x2eec44),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36c8dc...0x36cdbc),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36c91c...0x36cdfc),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3370e0...0x3375c0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36ac4c...0x36b12c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33ca94...0x33cf74),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33cb90...0x33d070),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f27c0...0x2f2b68),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c17a8...0x2c1c88),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c22b0...0x2c2790),
  }

  # Offset ranges of character super move descriptions
  _s.character_super_move_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2aefa4...0x2af590, excl: [0x31]
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2ae8c0...0x2aeeac, excl: [0x31]
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x3336a8...0x334094
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x337cb0...0x33869c
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2ea25c...0x2ea848
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x361344...0x361d30
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x361384...0x361d70
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x332ab8...0x333110, excl: [0x31]
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x361424...0x361d60
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x332028...0x3329d4
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x332120...0x332ad8
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c68d4...0x2c72c0
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c73e0...0x2c7d9c
    ),
  }

#------------------------------------------------------------------------------
# Crew Member Data
#------------------------------------------------------------------------------

  # Range of crew member IDs
  _s.crew_member_id_range = 0x0...0x16
  
  # Offset ranges of crew member data
  _s.crew_member_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x362708...0x362918),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b9dac...0x3b9fbc),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x360668...0x360878),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x36186c...0x361b2c),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x360fec...0x3612ac),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3457c4...0x345adc),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x349dcc...0x34a0e4),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f5180...0x2f5440),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x373460...0x373778),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x3734a0...0x3737b8),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33dc64...0x33df7c),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x3717d0...0x371ae8),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x343618...0x343930),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x343714...0x343a2c),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f8a4c...0x2f8c5c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d5aa4...0x2d5dbc),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d5e64...0x2d617c),
  }

  # Offset ranges of crew member descriptions
  _s.crew_member_dscr_files = {
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x33d9e0...0x33e1f0
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x341fe8...0x3427f8
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2edca0...0x2edd14, excl: [
        0x01, 0x03, 0x05, 0x07, 0x09, 0x0b, 0x0d, 0x0f, 0x11, 0x13, 0x15
      ]
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x36b67c...0x36be8c
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x36b6bc...0x36becc
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x3363c4...0x336690, excl: [0x9, 0xf]
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x369bcc...0x36a1fc
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x33b920...0x33c044
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x33ba34...0x33c140
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2d0dcc...0x2d15dc
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2d0ef4...0x2d1600
    ),
  }

#------------------------------------------------------------------------------
# Enemy Data
#------------------------------------------------------------------------------

  # Enables or disables creation of new enemy data files. When enabled, 
  # missing files will be created automatically. When disabled, only existing 
  # files will be modified; missing files will not be created.
  _s.enemy_allow_new_files = false

  # Enables or disables summarization of enemy filters. When enabled, multiple 
  # identical enemy filter lines are collapsed, and the longest one is marked 
  # with an asterisk (*).
  _s.enemy_summarize_filter = true

#------------------------------------------------------------------------------
# Enemy Animation Data
#------------------------------------------------------------------------------

  # Enables or disables creation of new enemy animation files. When enabled, 
  # missing files will be created automatically. When disabled, only existing 
  # files will be modified; missing files will not be created.
  _s.enemy_animation_allow_new_files = false

#------------------------------------------------------------------------------
# Enemy Encounter Data
#------------------------------------------------------------------------------

  # Enables or disables creation of new enemy encounter files. When enabled, 
  # missing files will be created automatically. When disabled, only existing 
  # files will be modified; missing files will not be created.
  _s.enemy_encounter_allow_new_files = false

  # Maximum number of enemies in enemy encounter data
  _s.enemy_encounter_num_enemies = {
    '*'                => 84,
    'DC-JP-6107110 06' => 50,
    'DC-JP-6107810'    => 50,
    'DC-US-HDR-0000'   => 56,
  }
  
  # Maximum number of encounters in enemy encounter data
  _s.enemy_encounter_num_encounters = 32

#------------------------------------------------------------------------------
# Enemy Event Data
#------------------------------------------------------------------------------

  # Maximum number of enemies in enemy event data
  _s.enemy_event_num_enemies = {
    'DC'               =>  84,
    'DC-JP-6107110 06' =>  50,
    'DC-JP-6107810'    =>  50,
    'DC-US-HDR-0000'   =>  56,
    'GC'               => 200,
  }
  
  # Maximum number of events in enemy event data
  _s.enemy_event_num_events = {
    'DC'               =>  80,
    'DC-JP-6107110 06' =>  11,
    'DC-JP-6107810'    =>  11,
    'DC-US-HDR-0000'   =>  10,
    'GC'               => 250,
  }

  # Range of enemy event BGM IDs
  _s.enemy_event_bgm_id_range = 0x0...0x59
  
  # Offset ranges of enemy event BGMs
  _s.enemy_event_bgm_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x364c0c...0x364c47),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3bc2b0...0x3bc2eb),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x362b6c...0x362ba7),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3f673c...0x3f6777),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x3c5a0b...0x3c5a14),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x3c5187...0x3c5190),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x3faeec...0x3faf27),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x4517f0...0x45182b),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x451830...0x45186b),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3ef074...0x3ef0af),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x3f4eb8...0x3f4ef3),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2e03a0...0x2e03db),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2e1200...0x2e123b),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2e16e0...0x2e171b),
  }

#------------------------------------------------------------------------------
# Enemy Magic Data
#------------------------------------------------------------------------------

  # Range of enemy magic IDs
  _s.enemy_magic_id_range = 0x0...0x24
  
  # Offset ranges of enemy magic data
  _s.enemy_magic_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x371af8...0x371dc8),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3c9218...0x3c94e8),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x36fa64...0x36fd34),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x3b83a8...0x3b88b8),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x3b7b28...0x3b8038),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x358bd8...0x3590e8),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x35d1d8...0x35d6e8),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x303540...0x303a50),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x3877f8...0x387d08),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x387838...0x387d48),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x350fe4...0x3514f4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x385db0...0x3862c0),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x356bc4...0x3570d4),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x356c30...0x357140),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2d9398...0x2d9668),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2a9ee8...0x2aa3f8),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2aa440...0x2aa950),
  }

#------------------------------------------------------------------------------
# Enemy Ship Data
#------------------------------------------------------------------------------

  # Range of enemy ship IDs
  _s.enemy_ship_id_range = 0x0...0x2d
  
  # Offset ranges of enemy ship data
  _s.enemy_ship_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x360890...0x361ad8),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b7f34...0x3b917c),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35e7f0...0x35fa38),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35f3dc...0x3604bc),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35eb5c...0x35fc3c),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3430dc...0x3445f4),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x3476e4...0x348bfc),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f2c00...0x2f3fb0),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x370d78...0x372290),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x370db8...0x3722d0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33b57c...0x33ca94),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36f0e8...0x370600),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x340f30...0x342448),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x34102c...0x342544),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f6d14...0x2f7f5c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d3574...0x2d4a8c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d3934...0x2d4e4c),
  }

#------------------------------------------------------------------------------
# Enemy Ship Task Data
#------------------------------------------------------------------------------

  # Enables or disables creation of new enemy ship task files. When enabled, 
  # missing files will be created automatically. When disabled, only existing 
  # files will be modified; missing files will not be created.
  _s.enemy_ship_task_allow_new_files = false

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
# Enemy Super Move Data
#------------------------------------------------------------------------------

  # Range of enemy super move IDs
  _s.enemy_super_move_id_range = {
    'DC' => 0x0...0x110,
    'GC' => 0x0...0x135,
  }
  
  # Offset ranges of enemy super move data
  _s.enemy_super_move_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x371dc8...0x373308),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3c94e8...0x3caa28),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x36fd34...0x371274),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x3b88b8...0x3baef8),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x3b8038...0x3ba678),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3590e8...0x35b728),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x35d6e8...0x35fd28),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x303a50...0x306090),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x387d08...0x38a348),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x387d48...0x38a388),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3514f4...0x353b34),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x3862c0...0x388900),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x3570d4...0x359714),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x357140...0x359780),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2d9668...0x2dae8c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2aa3f8...0x2acf6c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2aa950...0x2ad4c4),
  }

#------------------------------------------------------------------------------
# Enemy Task Data
#------------------------------------------------------------------------------

  # Enables or disables summarization of enemy task filters. When enabled, 
  # multiple identical enemy task filter lines are collapsed, and the longest 
  # one is marked with an asterisk (*).
  _s.enemy_task_filter_summary = true

  # Base multiplier applied to all enemy task IDs. This allows reserving 
  # unused ID ranges for future branches or actions without reorganizing 
  # existing IDs.
  _s.enemy_task_id_base = 1

  # Defines the maximum number of enemy tasks allowed per game version. The 
  # asterisk (*) value is used as the default for unspecified versions.
  _s.enemy_task_max_count = {
    '*'                => 64,
    'DC-JP-6107110 06' => 32,
    'DC-JP-6107810'    => 32,
    'DC-US-HDR-0000'   => 32,
  }

#------------------------------------------------------------------------------
# EXP Boost Data
#------------------------------------------------------------------------------

  # Range of EXP boost IDs
  _s.exp_boost_id_range = 0x3...0x6

  # Offset ranges of EXP boost data
  _s.exp_boost_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x335920...0x335974),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x361a54...0x361aa8),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x3338b4...0x333908),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3328d8...0x33292c),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x336ee0...0x336f34),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x360574...0x3605c8),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x3605b4...0x360608),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x332058...0x3320ac),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x360710...0x360764),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33125c...0x3312b0),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x331358...0x3313ac),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2cffd0...0x2d0024),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d1614...0x2d1668),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d1638...0x2d168c),
  }

#------------------------------------------------------------------------------
# EXP Curve Data
#------------------------------------------------------------------------------

  # Range of EXP curve IDs
  _s.exp_curve_id_range = 0x0...0x6
  
  # Offset ranges of EXP curve data
  _s.exp_curve_data_files = {
    'DC' => rd(CFG.level_file['DC'], 0x0...0x948),
    'GC' => rd(CFG.level_file['GC'], 0x0...0x948),
  }

#------------------------------------------------------------------------------
# Magic EXP Curve Data
#------------------------------------------------------------------------------

  # Range of magic EXP curve IDs
  _s.magic_exp_curve_id_range = 0x0...0x6
  
  # Offset ranges of magic EXP curve data
  _s.magic_exp_curve_data_files = {
    'DC' => rd(CFG.level_file['DC'], 0x948...0xaf8),
    'GC' => rd(CFG.level_file['GC'], 0x948...0xaf8),
  }

#------------------------------------------------------------------------------
# Playable Ship Data
#------------------------------------------------------------------------------

  # Range of playable ship IDs
  _s.playable_ship_id_range = {
    '*'                => 0x0...0x5,
    'DC-JP-6107110 06' => 0x0...0x6,
    'DC-JP-6107810'    => 0x0...0x6,
  }

  # Offset ranges of playable ship data
  _s.playable_ship_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x3606ec...0x360890),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b7d90...0x3b7f34),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35e64c...0x35e7f0),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35f28c...0x35f3dc),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35ea0c...0x35eb5c),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x342ee8...0x3430dc),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x3474f0...0x3476e4),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f2a0c...0x2f2c00),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x370b84...0x370d78),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x370bc4...0x370db8),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33b388...0x33b57c),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36eef4...0x36f0e8),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x340d3c...0x340f30),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x340e38...0x34102c),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f6b70...0x2f6d14),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d3380...0x2d3574),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d3740...0x2d3934),
  }

#------------------------------------------------------------------------------
# Script Task Data
#------------------------------------------------------------------------------

  # Enables or disables text-only mode for script task data. When enabled, 
  # only plain text (without metadata) is exported. Useful for comparing game 
  # script data between builds using a diff tool.
  _s.script_task_text_only = false

#------------------------------------------------------------------------------
# Ship Accessory Data
#------------------------------------------------------------------------------

  # Range of ship accessory IDs
  _s.ship_accessory_id_range = 0x1b8...0x1e0
  
  # Offset ranges of ship accessory data
  _s.ship_accessory_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x361f38...0x362438),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b95dc...0x3b9adc),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35fe98...0x360398),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x360cdc...0x3613bc),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x36045c...0x360b3c),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x344c34...0x345314),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x34923c...0x34991c),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f45f0...0x2f4cd0),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x3728d0...0x372fb0),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x372910...0x372ff0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33d0d4...0x33d7b4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x370c40...0x371320),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x342a88...0x343168),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x342b84...0x343264),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f831c...0x2f877c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d502c...0x2d566c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d53ec...0x2d5a2c),
  }

  # Offset ranges of ship accessory descriptions
  _s.ship_accessory_dscr_files = {
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x33bb44...0x33c86c
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x34014c...0x340e74
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2ec5b8...0x2ece84
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x3697e0...0x36a508
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x369820...0x36a548
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x334cdc...0x3355a8
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x367eb0...0x368a08
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x33990c...0x33a61c
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x339a38...0x33a730
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2cef30...0x2cfc58
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2ceef8...0x2cfbf0
    ),
  }

#------------------------------------------------------------------------------
# Ship Cannon Data
#------------------------------------------------------------------------------

  # Range of ship cannon IDs
  _s.ship_cannon_id_range = 0x190...0x1b8
  
  # Offset ranges of ship cannon data
  _s.ship_cannon_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x361ad8...0x361f38),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b917c...0x3b95dc),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35fa38...0x35fe98),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x3604bc...0x360cdc),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35fc3c...0x36045c),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3445f4...0x344c34),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x348bfc...0x34923c),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f3fb0...0x2f45f0),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x372290...0x3728d0),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x3722d0...0x372910),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33ca94...0x33d0d4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x370600...0x370c40),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x342448...0x342a88),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x342544...0x342b84),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f7f5c...0x2f831c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d4a8c...0x2d502c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d4e4c...0x2d53ec),
  }

  # Offset ranges of ship cannon descriptions
  _s.ship_cannon_dscr_files = {
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x33aec8...0x33bb44
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x33f4d0...0x34014c
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2ebc1c...0x2ec5b8
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x368b64...0x3697e0
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x368ba4...0x369820
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x334340...0x334cdc
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x367388...0x367eb0
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x338c38...0x33990c
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x338d64...0x339a38
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2ce2b4...0x2cef30
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2ce220...0x2ceef8
    ),
  }

#------------------------------------------------------------------------------
# Ship Item Data
#------------------------------------------------------------------------------

  # Range of ship item IDs
  _s.ship_item_id_range = 0x1e0...0x1fe
  
  # Offset ranges of ship item data
  _s.ship_item_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x362438...0x362708),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b9adc...0x3b9dac),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x360398...0x360668),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x3613bc...0x36186c),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x360b3c...0x360fec),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x345314...0x3457c4),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x34991c...0x349dcc),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f4cd0...0x2f5180),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x372fb0...0x373460),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x372ff0...0x3734a0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33d7b4...0x33dc64),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x371320...0x3717d0),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x343168...0x343618),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x343264...0x343714),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f877c...0x2f8a4c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d566c...0x2d5aa4),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d5a2c...0x2d5e64),
  }

  # Offset ranges of ship item descriptions
  _s.ship_item_dscr_files = {
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x33c86c...0x33d1a0
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x340e74...0x3417a8
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2ece84...0x2edca0
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x36a508...0x36ae3c
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x36a548...0x36ae7c
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x3355a8...0x335c10
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x368a08...0x3692e4
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x33a61c...0x33aff0
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x33a730...0x33b104
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2cfc58...0x2d058c
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2cfbf0...0x2d05c4
    ),
  }

#------------------------------------------------------------------------------
# Shop Data
#------------------------------------------------------------------------------

  # Range of shop IDs
  _s.shop_id_range = {
    '*'                => 0x0...0x2b,
    'DC-JP-6107810'    => 0x0...0x3 ,
    'DC-JP-6107110 06' => 0x0...0x3 ,
    'DC-US-HDR-0000'   => 0x0...0x3 ,
    'DC-US-IGN9'       => 0x0...0x3 ,
  }

  # Offset ranges of shop data
  _s.shop_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x36c8f0...0x36da68),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3c4010...0x3c5188),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x36a85c...0x36b9d4),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x3b1828...0x3b1960),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x3b0fa8...0x3b10e0),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3ffec0...0x401038),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x404670...0x4057e8),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x409df8...0x409f30),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x45aff8...0x45c170),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x45b038...0x45c1b0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3f8808...0x3f8940),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x4594f8...0x45a670),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x3fe50c...0x3ff684),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x3fe558...0x3ff6d0),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2e7dd4...0x2e8f4c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2e8d08...0x2e9e80),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2e90a0...0x2ea218),
  }
  
  # Offset ranges of shop descriptions
  _s.shop_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2b571c...0x2b5750, sot: true
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2b4e6c...0x2b4ea0, sot: true
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x34e0f0...0x34e2dc, sot: true
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x3526f8...0x3528e4, sot: true
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2fc450...0x2fc488, sot: true
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x37cb3c...0x37cd28, sot: true
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x37cb7c...0x37cd68, sot: true
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x34679c...0x3467d4, sot: true
     ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x37aeb8...0x37b098, sot: true
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x34befc...0x34c0dc, sot: true
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x34c034...0x34c210, sot: true
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2b6158...0x2b6344, sot: true
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2b6554...0x2b6730, sot: true
    ),
  }

#------------------------------------------------------------------------------
# Special Item Data
#------------------------------------------------------------------------------

  # Range of special item IDs
  _s.special_item_id_range = 0x140...0x190
  
  # Offset ranges of special item data
  _s.special_item_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x36022c...0x3605ec),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b78d0...0x3b7c90),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35e18c...0x35e54c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35e4a8...0x35eb88),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35dc28...0x35e308),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x342104...0x3427e4),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x34670c...0x346dec),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f1c28...0x2f2308),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36fda0...0x370480),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36fde0...0x3704c0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33a5a4...0x33ac84),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36e110...0x36e7f0),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33ff58...0x340638),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x340054...0x340734),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f4aa8...0x2f4e68),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c4c6c...0x2c534c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c5774...0x2c5e54),
  }

  # Offset ranges of special item descriptions
  _s.special_item_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2b06dc...0x2b09f8, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2afff8...0x2b0314, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x33a3c4...0x33aec8, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x33e9cc...0x33f4d0, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2eb8bc...0x2ebc1c, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x368060...0x368b64, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x3680a0...0x368ba4, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x334034...0x334340, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x3668e8...0x367388, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x338078...0x338c38, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x3381a4...0x338d64, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2cd644...0x2ce2b4, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2cd4ec...0x2ce220, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
  }

#------------------------------------------------------------------------------
# Spirit Curve Data
#------------------------------------------------------------------------------

  # Range of spirit curve IDs
  _s.spirit_curve_id_range = 0x0...0x6
  
  # Offset ranges of spirit curve data
  _s.spirit_curve_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x335fd8...0x33647c),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3620f0...0x362594),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x333f6c...0x334410),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35eda8...0x35f24c),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35e528...0x35e9cc),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x342a04...0x342ea8),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x34700c...0x3474b0),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f2528...0x2f29cc),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x3706a0...0x370b44),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x3706e0...0x370b84),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33aea4...0x33b348),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36ea10...0x36eeb4),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x340858...0x340cfc),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x340954...0x340df8),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2c4aa0...0x2c4f44),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c567c...0x2c5b20),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c6184...0x2c6628),
  }

#------------------------------------------------------------------------------
# Swashbuckler Data
#------------------------------------------------------------------------------

  # Range of swashbuckler IDs
  _s.swashbuckler_id_range = {
    'DC' => 0x0...0x10,
    'GC' => 0x0...0x18,
  }

  # Offset ranges of swashbuckler data
  _s.swashbuckler_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x3605ec...0x3606ec),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b7c90...0x3b7d90),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35e54c...0x35e64c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35eb88...0x35eda8),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35e308...0x35e528),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3427e4...0x342a04),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x346dec...0x34700c),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f2308...0x2f2528),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x370480...0x3706a0),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x3704c0...0x3706e0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33ac84...0x33aea4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36e7f0...0x36ea10),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x340638...0x340858),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x340734...0x340954),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f4e68...0x2f4fe8),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c534c...0x2c567c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c5e54...0x2c6184),
  }

#------------------------------------------------------------------------------
# Treasure Chest Data
#------------------------------------------------------------------------------

  # Range of treasure chest IDs
  _s.treasure_chest_id_range = {
    '*'                => 0x0...0x77,
    'DC-JP-6107110 06' => 0x0...0x6,
    'DC-JP-6107810'    => 0x0...0x6,
    'DC-JP-HDR-0000'   => 0x0...0x6,
  }

  # Offset ranges of treasure chest data
  _s.treasure_chest_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x334928...0x334ce0),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x35f370...0x35f728),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x3328bc...0x332c74),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x34c7f8...0x34c810),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x34bf78...0x34bf90),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3308dc...0x330c94),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x334ee4...0x33529c),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2e8238...0x2e8268),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x35d0d8...0x35d490),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x35d118...0x35d4d0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x330148...0x330500),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x35d1a0...0x35d558),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x32f298...0x32f650),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x32f3b0...0x32f768),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2d1610...0x2d19c8),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d26d0...0x2d2a88),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d29e8...0x2d2da0),
  }

#------------------------------------------------------------------------------
# Usable Item Data
#------------------------------------------------------------------------------

  # Range of usable item IDs
  _s.usable_item_id_range = 0xf0...0x140
  
  # Offset ranges of usable item data
  _s.usable_item_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x35faac...0x36022c),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b7150...0x3b78d0),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35da0c...0x35e18c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35d968...0x35e4a8),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35d0e8...0x35dc28),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x3415c4...0x342104),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x345bcc...0x34670c),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f10e8...0x2f1c28),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36f260...0x36fda0),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36f2a0...0x36fde0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x339a64...0x33a5a4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36d5d0...0x36e110),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33f418...0x33ff58),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33f514...0x340054),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f4328...0x2f4aa8),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c412c...0x2c4c6c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c4c34...0x2c5774),
  }

  # Offset ranges of usable item descriptions
  _s.usable_item_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2afe30...0x2b06dc, excl: [
        0x100, 0x101, 0x10c..0x11a
      ]
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2af74c...0x2afff8, excl: [
        0x100, 0x101, 0x10c..0x11a
      ]
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x3387d4...0x33a3c4, excl: [
        0x12e..0x130
      ]
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x33cddc...0x33e9cc, excl: [
        0x12e..0x130
      ]
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2eb0ec...0x2eb8bc, excl: [
        0x100..0x101, 0x10c..0x11a
      ]
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x366470...0x368060, excl: [
        0x12e..0x130
      ]
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x3664b0...0x3680a0, excl: [
        0x12e..0x130
      ]
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x3338a4...0x334034, excl: [
        0x100..0x101, 0x10c..0x11a
      ]
     ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x3653bc...0x3668e8, excl: [
        0x0f2, 0x10c, 0x12d..0x130
      ]
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x336850...0x338078, excl: [
        0x12d..0x130
      ]
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x33693c...0x3381a4, excl: [
        0x12d..0x130
      ]
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2cba54...0x2cd644, excl: [
        0x12e..0x130
      ]
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2cbc88...0x2cd4ec, excl: [
        0x12d..0x130
      ]
    ),
  }

#------------------------------------------------------------------------------
# Weapon Data
#------------------------------------------------------------------------------

  # Range of weapon IDs
  _s.weapon_id_range = 0x0...0x50
  
  # Offset ranges of weapon data
  _s.weapon_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x35e2ec...0x35e92c),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x3b5990...0x3b5fd0),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x35c24c...0x35c88c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35b4c4...0x35bec4),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35ac44...0x35b644),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x33f120...0x33fb20),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x343728...0x344128),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2eec44...0x2ef644),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36cdbc...0x36d7bc),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36cdfc...0x36d7fc),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3375c0...0x337fc0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36b12c...0x36bb2c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33cf74...0x33d974),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33d070...0x33da70),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f2b68...0x2f31a8),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c1c88...0x2c2688),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c2790...0x2c3190),
  }

  # Offset ranges of weapon descriptions
  _s.weapon_dscr_files = {
    'DC-JP-6107110 06'        => rd(
      CFG.exec_file['DC'], 0x2af590...0x2af878, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-JP-6107810'           => rd(
      CFG.exec_file['DC'], 0x2aeeac...0x2af194, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-JP-HDR-0076'          => rd(
      CFG.exec_file['DC'], 0x334094...0x335b4c
    ),
    'DC-JP-HDR-0119'          => rd(
      CFG.exec_file['DC'], 0x33869c...0x33a154
    ),
    'DC-US-HDR-0000'          => rd(
      CFG.exec_file['DC'], 0x2ea848...0x2eab28, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-US-HDR-0076-20000824' => rd(
      CFG.exec_file['DC'], 0x361d30...0x3637e8
    ),
    'DC-US-HDR-0076-20000825' => rd(
      CFG.exec_file['DC'], 0x361d70...0x363828
    ),
    'DC-US-IGN9'              => rd(
      CFG.exec_file['DC'], 0x333110...0x33337c, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-US-MK-51052-20000905' => rd(
      CFG.exec_file['DC'], 0x361d60...0x363334
    ),
    'DC-US-MK-51052-20000914' => rd(
      CFG.exec_file['DC'], 0x3329d4...0x3342a0
    ),
    'DC-US-MK-51052-20001010' => rd(
      CFG.exec_file['DC'], 0x332ad8...0x3343f8
    ),
    'GC-JP-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c72c0...0x2c8ddc
    ),
    'GC-US-GEA'               => rd(
      CFG.exec_file['GC'], 0x2c7d9c...0x2c9714
    ),
  }


#------------------------------------------------------------------------------
# Weapon Effect Data
#------------------------------------------------------------------------------

  # Range of weapon effect IDs
  _s.weapon_effect_id_range = 0x0...0x15
  
  # Offset ranges of weapon effect data
  _s.weapon_effect_data_files = {
    'DC-EU-8320062 50'        => rd(CFG.exec_file['DC'], 0x335e34...0x335fd8),
    'DC-EU-MK-51052-20001115' => rd(CFG.exec_file['DC'], 0x361f4c...0x3620f0),
    'DC-EU-MK-51052-20010306' => rd(CFG.exec_file['DC'], 0x333dc8...0x333f6c),
    'DC-JP-6107110 06'        => rd(CFG.exec_file['DC'], 0x35d7c4...0x35d968),
    'DC-JP-6107810'           => rd(CFG.exec_file['DC'], 0x35cf44...0x35d0e8),
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x341420...0x3415c4),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x345a28...0x345bcc),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2f0f44...0x2f10e8),
    'DC-US-HDR-0076-20000824' => rd(CFG.exec_file['DC'], 0x36f0bc...0x36f260),
    'DC-US-HDR-0076-20000825' => rd(CFG.exec_file['DC'], 0x36f0fc...0x36f2a0),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3398c0...0x339a64),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36d42c...0x36d5d0),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33f274...0x33f418),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33f370...0x33f514),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2c40a8...0x2c424c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c3f88...0x2c412c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c4a90...0x2c4c34),
  }

end # class DSCRPTR

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
