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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x338c40...0x3398c0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36c7ac...0x36d42c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33e5f4...0x33f274),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33e6f0...0x33f370),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f3a68...0x2f4328),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c3308...0x2c3f88),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c3e10...0x2c4a90),
  }
  
  # Offset ranges of accessory names
  _s.accessory_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1a675...0x1aae1),
      rd(CFG.sot_file_es['DC'], 0x1a35f...0x1a7fc),
      rd(CFG.sot_file_fr['DC'], 0x1a6ad...0x1ab76),
      rd(CFG.sot_file_gb['DC'], 0x19f12...0x1a393),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x19f98...0x1a419),
      rd(CFG.sot_file_es['DC'], 0x1a441...0x1a8d9),
      rd(CFG.sot_file_fr['DC'], 0x1a86b...0x1ad34),
      rd(CFG.sot_file_gb['DC'], 0x19f68...0x1a3e9),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x19f98...0x1a419),
      rd(CFG.sot_file_es['DC'], 0x1a441...0x1a8d9),
      rd(CFG.sot_file_fr['DC'], 0x1a86b...0x1ad34),
      rd(CFG.sot_file_gb['DC'], 0x19f98...0x1a419),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1a466...0x1a8d2),
      rd(CFG.sot_file_es['DC'], 0x1a32f...0x1a7ce),
      rd(CFG.sot_file_fr['DC'], 0x1a61d...0x1aae6),
      rd(CFG.sot_file_gb['DC'], 0x19f03...0x1a384),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1d6aa...0x1db1c),
      rd(CFG.sot_file_es['GC'], 0x1d39e...0x1d83d),
      rd(CFG.sot_file_fr['GC'], 0x1d5d7...0x1daa2),
      rd(CFG.sot_file_gb['GC'], 0x1cd13...0x1d194),
    ],
  }
  
  # Offset ranges of accessory descriptions
  _s.accessory_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x12543...0x13ad7),
      rd(CFG.sot_file_es['DC'], 0x121e9...0x136b6),
      rd(CFG.sot_file_fr['DC'], 0x1227f...0x138a5),
      rd(CFG.sot_file_gb['DC'], 0x1200c...0x134c5),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x12061...0x1351a),
      rd(CFG.sot_file_es['DC'], 0x12134...0x1364f),
      rd(CFG.sot_file_fr['DC'], 0x122e9...0x13969),
      rd(CFG.sot_file_gb['DC'], 0x12031...0x134ea),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x12061...0x1351a),
      rd(CFG.sot_file_es['DC'], 0x12134...0x1364f),
      rd(CFG.sot_file_fr['DC'], 0x122e9...0x13969),
      rd(CFG.sot_file_gb['DC'], 0x12061...0x1351a),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x12352...0x138e9),
      rd(CFG.sot_file_es['DC'], 0x121c3...0x13690),
      rd(CFG.sot_file_fr['DC'], 0x121f0...0x13817),
      rd(CFG.sot_file_gb['DC'], 0x11fff...0x134b8),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2afae4...0x2afe30, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2af400...0x2af74c, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x3370f0...0x3387d4
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x33b6f8...0x33cddc
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2ead78...0x2eb0ec, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x33356c...0x3338a4, excl: [
        0xa1, 0xa3..0xa7, 0xa9..0xaf, 0xb1..0xb5, 0xb8..0xbf, 0xc1..0xc8, 
        0xcb, 0xce, 0xd0, 0xd2, 0xd3
      ]
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x364228...0x3653bc
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x3353f0...0x336850
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x335548...0x33693c
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x153d7...0x16979),
      rd(CFG.sot_file_es['GC'], 0x1502e...0x1652e),
      rd(CFG.sot_file_fr['GC'], 0x15017...0x16635),
      rd(CFG.sot_file_gb['GC'], 0x14c6f...0x1613d),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2ca370...0x2cba54
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x337fc0...0x338c40),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36bb2c...0x36c7ac),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33d974...0x33e5f4),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33da70...0x33e6f0),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f31a8...0x2f3a68),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c2688...0x2c3308),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c3190...0x2c3e10),
  }
  
  # Offset ranges of armor names
  _s.armor_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1a279...0x1a675),
      rd(CFG.sot_file_es['DC'], 0x19f07...0x1a35f),
      rd(CFG.sot_file_fr['DC'], 0x1a265...0x1a6ad),
      rd(CFG.sot_file_gb['DC'], 0x19b20...0x19f12),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x19ba6...0x19f98),
      rd(CFG.sot_file_es['DC'], 0x19fe3...0x1a441),
      rd(CFG.sot_file_fr['DC'], 0x1a423...0x1a86b),
      rd(CFG.sot_file_gb['DC'], 0x19b76...0x19f68),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x19ba6...0x19f98),
      rd(CFG.sot_file_es['DC'], 0x19fe3...0x1a441),
      rd(CFG.sot_file_fr['DC'], 0x1a423...0x1a86b),
      rd(CFG.sot_file_gb['DC'], 0x19ba6...0x19f98),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1a06a...0x1a466),
      rd(CFG.sot_file_es['DC'], 0x19ed7...0x1a32f),
      rd(CFG.sot_file_fr['DC'], 0x1a1d5...0x1a61d),
      rd(CFG.sot_file_gb['DC'], 0x19b11...0x19f03),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1d289...0x1d6aa),
      rd(CFG.sot_file_es['GC'], 0x1cf43...0x1d39e),
      rd(CFG.sot_file_fr['GC'], 0x1d18e...0x1d5d7),
      rd(CFG.sot_file_gb['GC'], 0x1c921...0x1cd13),
    ],
  }
  
  # Offset ranges of armor descriptions
  _s.armor_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x111d9...0x12543),
      rd(CFG.sot_file_es['DC'], 0x10faa...0x121e9),
      rd(CFG.sot_file_fr['DC'], 0x11008...0x1227f),
      rd(CFG.sot_file_gb['DC'], 0x10db1...0x1200c),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x10e06...0x12061),
      rd(CFG.sot_file_es['DC'], 0x10e97...0x12134),
      rd(CFG.sot_file_fr['DC'], 0x11002...0x122e9),
      rd(CFG.sot_file_gb['DC'], 0x10dd6...0x12031),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x10e06...0x12061),
      rd(CFG.sot_file_es['DC'], 0x10e97...0x12134),
      rd(CFG.sot_file_fr['DC'], 0x11002...0x122e9),
      rd(CFG.sot_file_gb['DC'], 0x10e06...0x12061),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x10fec...0x12352),
      rd(CFG.sot_file_es['DC'], 0x10f83...0x121c3),
      rd(CFG.sot_file_fr['DC'], 0x10f79...0x121f0),
      rd(CFG.sot_file_gb['DC'], 0x10da4...0x11fff),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2af878...0x2afae4, excl: [0x59, 0x5b..0x70]
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2af194...0x2af400, excl: [0x59, 0x5b..0x70]
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x335b4c...0x3370f0
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x33a154...0x33b6f8
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2eab28...0x2ead78, excl: [0x59, 0x5b..0x70]
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x33337c...0x33356c, excl: [0x59, 0x5b..0x70]
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x363334...0x364228
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x3342a0...0x3353f0
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x3343f8...0x335548
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x14060...0x153d7),
      rd(CFG.sot_file_es['GC'], 0x13dc4...0x1502e),
      rd(CFG.sot_file_fr['GC'], 0x13da3...0x15017),
      rd(CFG.sot_file_gb['GC'], 0x139f6...0x14c6f),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2c8ddc...0x2ca370
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-JP-HDR-0076'          => rd(CFG.exec_file['DC'], 0x33e1F0...0x33e580),
    'DC-JP-HDR-0119'          => rd(CFG.exec_file['DC'], 0x3427f8...0x342b88),
    'DC-US-HDR-0000'          => rd(CFG.exec_file['DC'], 0x2edd14...0x2ee0a4),
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x336690...0x336a20),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36a1fc...0x36a58c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33c044...0x33c3d4),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33c140...0x33c4d0),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2c2ff0...0x2c3380),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c0d58...0x2c10e8),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c1860...0x2c1bf0),
  }

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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x336a20...0x3370e0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36a58c...0x36ac4c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33c3d4...0x33ca94),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33c4d0...0x33cb90),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f22b0...0x2f27c0),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c10e8...0x2c17a8),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c1bf0...0x2c22b0),
  }
  
  # Offset ranges of character magic names
  _s.character_magic_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x19c2a...0x19d38),
      rd(CFG.sot_file_es['DC'], 0x19854...0x19963),
      rd(CFG.sot_file_fr['DC'], 0x19bde...0x19cec),
      rd(CFG.sot_file_gb['DC'], 0x194f2...0x19600),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x19578...0x19686),
      rd(CFG.sot_file_es['DC'], 0x1992a...0x19a38),
      rd(CFG.sot_file_fr['DC'], 0x19d9c...0x19eaa),
      rd(CFG.sot_file_gb['DC'], 0x19548...0x19656),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x19578...0x19686),
      rd(CFG.sot_file_es['DC'], 0x1992a...0x19a38),
      rd(CFG.sot_file_fr['DC'], 0x19d9c...0x19eaa),
      rd(CFG.sot_file_gb['DC'], 0x19578...0x19686),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x19a1b...0x19b29),
      rd(CFG.sot_file_es['DC'], 0x19825...0x19933),
      rd(CFG.sot_file_fr['DC'], 0x19b4e...0x19c5c),
      rd(CFG.sot_file_gb['DC'], 0x194e3...0x195f1),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1cc3a...0x1cd48),
      rd(CFG.sot_file_es['GC'], 0x1c88d...0x1c99b),
      rd(CFG.sot_file_fr['GC'], 0x1cafd...0x1cc0b),
      rd(CFG.sot_file_gb['GC'], 0x1c2f4...0x1c402),
    ],
  }
  
  # Offset ranges of character magic descriptions
  _s.character_magic_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0xe17f...0xeeb1),
      rd(CFG.sot_file_es['DC'], 0xdf7f...0xec98),
      rd(CFG.sot_file_fr['DC'], 0xe016...0xed74),
      rd(CFG.sot_file_gb['DC'], 0xdd50...0xeab1),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0xdda5...0xeb06),
      rd(CFG.sot_file_es['DC'], 0xde1e...0xeb37),
      rd(CFG.sot_file_fr['DC'], 0xdfe9...0xed47),
      rd(CFG.sot_file_gb['DC'], 0xdd75...0xead6),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0xdda5...0xeb06),
      rd(CFG.sot_file_es['DC'], 0xde1e...0xeb37),
      rd(CFG.sot_file_fr['DC'], 0xdfe9...0xed47),
      rd(CFG.sot_file_gb['DC'], 0xdda5...0xeb06),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0xe00e...0xed40),
      rd(CFG.sot_file_es['DC'], 0xdf58...0xec71),
      rd(CFG.sot_file_fr['DC'], 0xdf86...0xece4),
      rd(CFG.sot_file_gb['DC'], 0xdd43...0xeaa4),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2ae5e4...0x2aefa4
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2adf00...0x2ae8c0
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x332934...0x3336a8
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x336f3c...0x337cb0
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2e9848...0x2ea25c
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x3320b4...0x332ab8
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x36076c...0x361424
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x3312b8...0x332028
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x3313b4...0x332120
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x11025...0x11d53),
      rd(CFG.sot_file_es['GC'], 0x10d2f...0x11a56),
      rd(CFG.sot_file_fr['GC'], 0x10d3c...0x11a9a),
      rd(CFG.sot_file_gb['GC'], 0x1093f...0x116a9),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2c5b60...0x2c68d4
    ),
    'GC-US-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2c6668...0x2c73e0
    ),
  }
  
  # Offset ranges of character magic ship descriptions
  _s.character_magic_ship_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x185e8...0x1906c),
      rd(CFG.sot_file_es['DC'], 0x18246...0x18c3b),
      rd(CFG.sot_file_fr['DC'], 0x184ca...0x18f52),
      rd(CFG.sot_file_gb['DC'], 0x17f49...0x18964),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x17f97...0x189b2),
      rd(CFG.sot_file_es['DC'], 0x182ea...0x18d16),
      rd(CFG.sot_file_fr['DC'], 0x18685...0x19147),
      rd(CFG.sot_file_gb['DC'], 0x17f67...0x18982),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x17f97...0x189b2),
      rd(CFG.sot_file_es['DC'], 0x182ea...0x18d16),
      rd(CFG.sot_file_fr['DC'], 0x18685...0x19147),
      rd(CFG.sot_file_gb['DC'], 0x17f97...0x189b2),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x183d9...0x18e5d),
      rd(CFG.sot_file_es['DC'], 0x18219...0x18c0e),
      rd(CFG.sot_file_fr['DC'], 0x1843a...0x18ebf),
      rd(CFG.sot_file_gb['DC'], 0x17f3a...0x18955),
    ],
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x33d1a0...0x33d9e0, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x3417a8...0x341fe8, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2ed4ec...0x2edca0, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x335c10...0x3363c4, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x3692e4...0x369bcc, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x33aff0...0x33b920, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x33b104...0x33ba34, excl: [0x8, 0xa..0xc, 0xe..0x13]
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1b603...0x1c085),
      rd(CFG.sot_file_es['GC'], 0x1b23a...0x1bc6f),
      rd(CFG.sot_file_fr['GC'], 0x1b3e9...0x1be6e),
      rd(CFG.sot_file_gb['GC'], 0x1ad4b...0x1b766),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2d058c...0x2d0dcc, excl: [0xa..0xc, 0xe..0x13     ]
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3370e0...0x3375c0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36ac4c...0x36b12c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33ca94...0x33cf74),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33cb90...0x33d070),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f27c0...0x2f2b68),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c17a8...0x2c1c88),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c22b0...0x2c2790),
  }
  
  # Offset ranges of character super move names
  _s.character_super_move_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x19d38...0x19e83),
      rd(CFG.sot_file_es['DC'], 0x19963...0x19ac8),
      rd(CFG.sot_file_fr['DC'], 0x19cec...0x19e68),
      rd(CFG.sot_file_gb['DC'], 0x19600...0x19753),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x19686...0x197d9),
      rd(CFG.sot_file_es['DC'], 0x19a38...0x19b9d),
      rd(CFG.sot_file_fr['DC'], 0x19eaa...0x1a026),
      rd(CFG.sot_file_gb['DC'], 0x19656...0x197a9),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x19686...0x197d9),
      rd(CFG.sot_file_es['DC'], 0x19a38...0x19b9d),
      rd(CFG.sot_file_fr['DC'], 0x19eaa...0x1a026),
      rd(CFG.sot_file_gb['DC'], 0x19686...0x197d9),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x19b29...0x19c74),
      rd(CFG.sot_file_es['DC'], 0x19933...0x19a98),
      rd(CFG.sot_file_fr['DC'], 0x19c5c...0x19dd8),
      rd(CFG.sot_file_gb['DC'], 0x195f1...0x19744),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1cd48...0x1ce93),
      rd(CFG.sot_file_es['GC'], 0x1c99b...0x1cb04),
      rd(CFG.sot_file_fr['GC'], 0x1cc0b...0x1cd83),
      rd(CFG.sot_file_gb['GC'], 0x1c402...0x1c555),
    ],
  }
  
  # Offset ranges of character super move descriptions
  _s.character_super_move_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0xeeb1...0xf842),
      rd(CFG.sot_file_es['DC'], 0xec98...0xf63e),
      rd(CFG.sot_file_fr['DC'], 0xed74...0xf726),
      rd(CFG.sot_file_gb['DC'], 0xeab1...0xf45e),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0xeb06...0xf4b3),
      rd(CFG.sot_file_es['DC'], 0xeb37...0xf4e4),
      rd(CFG.sot_file_fr['DC'], 0xed47...0xf6fd),
      rd(CFG.sot_file_gb['DC'], 0xead6...0xf483),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0xeb06...0xf4b3),
      rd(CFG.sot_file_es['DC'], 0xeb37...0xf4e4),
      rd(CFG.sot_file_fr['DC'], 0xed47...0xf6fd),
      rd(CFG.sot_file_gb['DC'], 0xeb06...0xf4b3),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0xed40...0xf6d1),
      rd(CFG.sot_file_es['DC'], 0xec71...0xf617),
      rd(CFG.sot_file_fr['DC'], 0xece4...0xf696),
      rd(CFG.sot_file_gb['DC'], 0xeaa4...0xf451),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2aefa4...0x2af590, excl: [0x31]
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2ae8c0...0x2aeeac, excl: [0x31]
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x3336a8...0x334094
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x337cb0...0x33869c
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2ea25c...0x2ea848
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x332ab8...0x333110, excl: [0x31]
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x361424...0x361d60
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x332028...0x3329d4
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x332120...0x332ad8
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x11d53...0x126e4),
      rd(CFG.sot_file_es['GC'], 0x11a56...0x12410),
      rd(CFG.sot_file_fr['GC'], 0x11a9a...0x1244e),
      rd(CFG.sot_file_gb['GC'], 0x116a9...0x12056),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2c68d4...0x2c72c0
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33dc64...0x33df7c),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x3717d0...0x371ae8),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x343618...0x343930),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x343714...0x343a2c),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f8a4c...0x2f8c5c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d5aa4...0x2d5dbc),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d5e64...0x2d617c),
  }
  
  # Offset ranges of crew member names
  _s.crew_member_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1bc84...0x1bd1a),
      rd(CFG.sot_file_es['DC'], 0x1ba79...0x1bb0f),
      rd(CFG.sot_file_fr['DC'], 0x1bdad...0x1be43),
      rd(CFG.sot_file_gb['DC'], 0x1b527...0x1b5bd),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b5c2...0x1b658),
      rd(CFG.sot_file_es['DC'], 0x1bace...0x1bb64),
      rd(CFG.sot_file_fr['DC'], 0x1bf81...0x1c017),
      rd(CFG.sot_file_gb['DC'], 0x1b592...0x1b628),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b5c2...0x1b658),
      rd(CFG.sot_file_es['DC'], 0x1bace...0x1bb64),
      rd(CFG.sot_file_fr['DC'], 0x1bf81...0x1c017),
      rd(CFG.sot_file_gb['DC'], 0x1b5c2...0x1b658),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1ba76...0x1bb0c),
      rd(CFG.sot_file_es['DC'], 0x1ba43...0x1bad9),
      rd(CFG.sot_file_fr['DC'], 0x1bd1a...0x1bdb0),
      rd(CFG.sot_file_gb['DC'], 0x1b51f...0x1b5b5),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1ed75...0x1ee0b),
      rd(CFG.sot_file_es['GC'], 0x1eb78...0x1ec0e),
      rd(CFG.sot_file_fr['GC'], 0x1ed91...0x1ee27),
      rd(CFG.sot_file_gb['GC'], 0x1e3dd...0x1e473),
    ],
  }

  # Offset ranges of crew member descriptions
  _s.crew_member_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1906c...0x1979b),
      rd(CFG.sot_file_es['DC'], 0x18c3b...0x193a9),
      rd(CFG.sot_file_fr['DC'], 0x18f4f...0x196db),
      rd(CFG.sot_file_gb['DC'], 0x18964...0x19061),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x189b2...0x190af),
      rd(CFG.sot_file_es['DC'], 0x18d16...0x19487),
      rd(CFG.sot_file_fr['DC'], 0x19147...0x198d3),
      rd(CFG.sot_file_gb['DC'], 0x18982...0x1907f),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x189b2...0x190af),
      rd(CFG.sot_file_es['DC'], 0x18d16...0x19487),
      rd(CFG.sot_file_fr['DC'], 0x19147...0x198d3),
      rd(CFG.sot_file_gb['DC'], 0x189b2...0x190af),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x18e5d...0x1958c),
      rd(CFG.sot_file_es['DC'], 0x18c0e...0x1937a),
      rd(CFG.sot_file_fr['DC'], 0x18ebf...0x1964b),
      rd(CFG.sot_file_gb['DC'], 0x18955...0x19052),
    ],
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x33d9e0...0x33e1f0
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x341fe8...0x3427f8
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2edca0...0x2edd14, excl: [
        0x01, 0x03, 0x05, 0x07, 0x09, 0x0b, 0x0d, 0x0f, 0x11, 0x13, 0x15
      ]
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x3363c4...0x336690, excl: [0x9, 0xf]
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x369bcc...0x36a1fc
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x33b920...0x33c044
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x33ba34...0x33c140
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1c085...0x1c7ab),
      rd(CFG.sot_file_es['GC'], 0x1bc6f...0x1c3da),
      rd(CFG.sot_file_fr['GC'], 0x1be6e...0x1c5fa),
      rd(CFG.sot_file_gb['GC'], 0x1b766...0x1be63),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2d0dcc...0x2d15dc
    ),
    'GC-US-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2d0ef4...0x2d1600
    ),
  }

#------------------------------------------------------------------------------
# Enemy Data
#------------------------------------------------------------------------------

  # Enables or disables the summary of enemy filters. If you enable the 
  # summary of enemy filters, the longest filter of the same enemy line 
  # will be summarized with an asterisk.
  _s.enemy_summarize_filter = true

#------------------------------------------------------------------------------
# Enemy Encounter Data
#------------------------------------------------------------------------------

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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x350fe4...0x3514f4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x385db0...0x3862c0),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x356bc4...0x3570d4),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x356c30...0x357140),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2d9398...0x2d9668),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2a9ee8...0x2aa3f8),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2aa440...0x2aa950),
  }
  
  # Offset ranges of enemy magic names
  _s.enemy_magic_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x12b6...0x13c4),
      rd(CFG.sot_file_es['DC'], 0x12a9...0x13b7),
      rd(CFG.sot_file_fr['DC'], 0x12ac...0x13ba),
      rd(CFG.sot_file_gb['DC'], 0x12a6...0x13b4),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1276...0x1384),
      rd(CFG.sot_file_es['DC'], 0x1279...0x1387),
      rd(CFG.sot_file_fr['DC'], 0x127c...0x138a),
      rd(CFG.sot_file_gb['DC'], 0x1246...0x1354),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1276...0x1384),
      rd(CFG.sot_file_es['DC'], 0x1279...0x1387),
      rd(CFG.sot_file_fr['DC'], 0x127c...0x138a),
      rd(CFG.sot_file_gb['DC'], 0x1276...0x1384),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x12b6...0x13c4),
      rd(CFG.sot_file_es['DC'], 0x12a9...0x13b7),
      rd(CFG.sot_file_fr['DC'], 0x12ac...0x13ba),
      rd(CFG.sot_file_gb['DC'], 0x12a6...0x13b4),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x13d6...0x14e4),
      rd(CFG.sot_file_es['GC'], 0x13c9...0x14d7),
      rd(CFG.sot_file_fr['GC'], 0x13cb...0x14d9),
      rd(CFG.sot_file_gb['GC'], 0x13c6...0x14d4),
    ],
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33b57c...0x33ca94),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36f0e8...0x370600),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x340f30...0x342448),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x34102c...0x342544),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f6d14...0x2f7f5c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d3574...0x2d4a8c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d3934...0x2d4e4c),
  }
  
  # Offset ranges of enemy ship names
  _s.enemy_ship_name_files     = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1b54a...0x1b71f),
      rd(CFG.sot_file_es['DC'], 0x1b2b4...0x1b489),
      rd(CFG.sot_file_fr['DC'], 0x1b612...0x1b7e7),
      rd(CFG.sot_file_gb['DC'], 0x1adcf...0x1afa4),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1ae6a...0x1b03f),
      rd(CFG.sot_file_es['DC'], 0x1b373...0x1b548),
      rd(CFG.sot_file_fr['DC'], 0x1b7ed...0x1b9c2),
      rd(CFG.sot_file_gb['DC'], 0x1ae3a...0x1b00f),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1ae6a...0x1b03f),
      rd(CFG.sot_file_es['DC'], 0x1b373...0x1b548),
      rd(CFG.sot_file_fr['DC'], 0x1b7ed...0x1b9c2),
      rd(CFG.sot_file_gb['DC'], 0x1ae6a...0x1b03f),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1b335...0x1b50a),
      rd(CFG.sot_file_es['DC'], 0x1b27e...0x1b453),
      rd(CFG.sot_file_fr['DC'], 0x1b581...0x1b756),
      rd(CFG.sot_file_gb['DC'], 0x1adc0...0x1af95),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1e635...0x1e809),
      rd(CFG.sot_file_es['GC'], 0x1e3a6...0x1e57b),
      rd(CFG.sot_file_fr['GC'], 0x1e5f7...0x1e7cc),
      rd(CFG.sot_file_gb['GC'], 0x1dc7e...0x1de53),
    ],
  }
  
  # Offset ranges of enemy ship armament names
  _s.enemy_ship_arm_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1bd1a...0x1c2f3),
      rd(CFG.sot_file_es['DC'], 0x1bb0f...0x1c0eb),
      rd(CFG.sot_file_fr['DC'], 0x1be43...0x1c415),
      rd(CFG.sot_file_gb['DC'], 0x1b5bd...0x1bb57),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b658...0x1bbf2),
      rd(CFG.sot_file_es['DC'], 0x1bb64...0x1c0fe),
      rd(CFG.sot_file_fr['DC'], 0x1c017...0x1c5ce),
      rd(CFG.sot_file_gb['DC'], 0x1b628...0x1bbc2),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b658...0x1bbf2),
      rd(CFG.sot_file_es['DC'], 0x1bb64...0x1c0fe),
      rd(CFG.sot_file_fr['DC'], 0x1c017...0x1c5ce),
      rd(CFG.sot_file_gb['DC'], 0x1b658...0x1bbf2),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1bb0c...0x1c0e5),
      rd(CFG.sot_file_es['DC'], 0x1bad9...0x1c0b5),
      rd(CFG.sot_file_fr['DC'], 0x1bdb0...0x1c382),
      rd(CFG.sot_file_gb['DC'], 0x1b5b5...0x1bb4f),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1ee0b...0x1f3e5),
      rd(CFG.sot_file_es['GC'], 0x1ec0e...0x1f1da),
      rd(CFG.sot_file_fr['GC'], 0x1ee27...0x1f3f9),
      rd(CFG.sot_file_gb['GC'], 0x1e473...0x1ea0d),
    ],
  }

#------------------------------------------------------------------------------
# Enemy Ship Task Data
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3514f4...0x353b34),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x3862c0...0x388900),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x3570d4...0x359714),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x357140...0x359780),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2d9668...0x2dae8c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2aa3f8...0x2acf6c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2aa950...0x2ad4c4),
  }
  
  # Offset ranges of enemy super move names
  _s.enemy_super_move_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x13c4...0x1dc3),
      rd(CFG.sot_file_es['DC'], 0x13b7...0x1e6c),
      rd(CFG.sot_file_fr['DC'], 0x13ba...0x1e25),
      rd(CFG.sot_file_gb['DC'], 0x13b4...0x1d37),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1384...0x1d07),
      rd(CFG.sot_file_es['DC'], 0x1387...0x1e3e),
      rd(CFG.sot_file_fr['DC'], 0x138a...0x1df6),
      rd(CFG.sot_file_gb['DC'], 0x1354...0x1cd7),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1384...0x1d07),
      rd(CFG.sot_file_es['DC'], 0x1387...0x1e3e),
      rd(CFG.sot_file_fr['DC'], 0x138a...0x1df6),
      rd(CFG.sot_file_gb['DC'], 0x1384...0x1d07),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x13c4...0x1dc3),
      rd(CFG.sot_file_es['DC'], 0x13b7...0x1e6c),
      rd(CFG.sot_file_fr['DC'], 0x13ba...0x1e25),
      rd(CFG.sot_file_gb['DC'], 0x13b4...0x1d37),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x14e4...0x2079),
      rd(CFG.sot_file_es['GC'], 0x14d7...0x215d),
      rd(CFG.sot_file_fr['GC'], 0x14d9...0x211a),
      rd(CFG.sot_file_gb['GC'], 0x14d4...0x1ff8),
    ],
  }

#------------------------------------------------------------------------------
# Enemy Task Data
#------------------------------------------------------------------------------

  # Enables or disables the summary of enemy task filters. If you enable the 
  # summary of enemy task filters, the longest filter of the same enemy task 
  # line will be summarized with an asterisk.
  _s.enemy_task_summarize_filter = true

  # Multiplies this base to each enemy task ID. This can be useful, for 
  # example, to have unused task IDs available and to insert additional 
  # branches or actions without much effort.
  _s.enemy_task_id_base = 1
  
  # Maximum number of tasks in enemy task data
  _s.enemy_task_num_tasks = {
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33b388...0x33b57c),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36eef4...0x36f0e8),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x340d3c...0x340f30),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x340e38...0x34102c),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f6b70...0x2f6d14),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d3380...0x2d3574),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d3740...0x2d3934),
  }
  
  # Offset ranges of playable ship names
  _s.playable_ship_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1b514...0x1b54a),
      rd(CFG.sot_file_es['DC'], 0x1b27e...0x1b2b4),
      rd(CFG.sot_file_fr['DC'], 0x1b5dc...0x1b612),
      rd(CFG.sot_file_gb['DC'], 0x1ad99...0x1adcf),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1ae34...0x1ae6a),
      rd(CFG.sot_file_es['DC'], 0x1b33d...0x1b373),
      rd(CFG.sot_file_fr['DC'], 0x1b7b7...0x1b7ed),
      rd(CFG.sot_file_gb['DC'], 0x1ae04...0x1ae3a),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1ae34...0x1ae6a),
      rd(CFG.sot_file_es['DC'], 0x1b33d...0x1b373),
      rd(CFG.sot_file_fr['DC'], 0x1b7b7...0x1b7ed),
      rd(CFG.sot_file_gb['DC'], 0x1ae34...0x1ae6a),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1b2ff...0x1b335),
      rd(CFG.sot_file_es['DC'], 0x1b248...0x1b27e),
      rd(CFG.sot_file_fr['DC'], 0x1b54b...0x1b581),
      rd(CFG.sot_file_gb['DC'], 0x1ad8a...0x1adc0),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1e5ff...0x1e635),
      rd(CFG.sot_file_es['GC'], 0x1e370...0x1e3a6),
      rd(CFG.sot_file_fr['GC'], 0x1e5c1...0x1e5f7),
      rd(CFG.sot_file_gb['GC'], 0x1dc48...0x1dc7e),
    ],
  }

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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33d0d4...0x33d7b4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x370c40...0x371320),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x342a88...0x343168),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x342b84...0x343264),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f831c...0x2f877c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d502c...0x2d566c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d53ec...0x2d5a2c),
  }
  
  # Offset ranges of ship accessory names
  _s.ship_accessory_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1b923...0x1bb24),
      rd(CFG.sot_file_es['DC'], 0x1b697...0x1b8d2),
      rd(CFG.sot_file_fr['DC'], 0x1b9ec...0x1bc1e),
      rd(CFG.sot_file_gb['DC'], 0x1b1b0...0x1b3c7),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b24b...0x1b462),
      rd(CFG.sot_file_es['DC'], 0x1b757...0x1b96e),
      rd(CFG.sot_file_fr['DC'], 0x1bbc0...0x1bdf2),
      rd(CFG.sot_file_gb['DC'], 0x1b21b...0x1b432),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b24b...0x1b462),
      rd(CFG.sot_file_es['DC'], 0x1b757...0x1b96e),
      rd(CFG.sot_file_fr['DC'], 0x1bbc0...0x1bdf2),
      rd(CFG.sot_file_gb['DC'], 0x1b24b...0x1b462),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1b715...0x1b916),
      rd(CFG.sot_file_es['DC'], 0x1b661...0x1b89c),
      rd(CFG.sot_file_fr['DC'], 0x1b95b...0x1bb8d),
      rd(CFG.sot_file_gb['DC'], 0x1b1a8...0x1b3bf),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1ea14...0x1ec15),
      rd(CFG.sot_file_es['GC'], 0x1e789...0x1e9cd),
      rd(CFG.sot_file_fr['GC'], 0x1e9d1...0x1ec03),
      rd(CFG.sot_file_gb['GC'], 0x1e066...0x1e27d),
    ],
  }
  
  # Offset ranges of ship accessory descriptions
  _s.ship_accessory_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x16e58...0x17b9e),
      rd(CFG.sot_file_es['DC'], 0x16b19...0x177fe),
      rd(CFG.sot_file_fr['DC'], 0x16d44...0x17a79),
      rd(CFG.sot_file_gb['DC'], 0x168a6...0x1758a),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x168f4...0x175d8),
      rd(CFG.sot_file_es['DC'], 0x16baa...0x178a4),
      rd(CFG.sot_file_fr['DC'], 0x16eff...0x17c34),
      rd(CFG.sot_file_gb['DC'], 0x168c4...0x175a8),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x168f4...0x175d8),
      rd(CFG.sot_file_es['DC'], 0x16baa...0x178a4),
      rd(CFG.sot_file_fr['DC'], 0x16eff...0x17c34),
      rd(CFG.sot_file_gb['DC'], 0x168f4...0x175d8),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x16c49...0x1798f),
      rd(CFG.sot_file_es['DC'], 0x16aec...0x177d1),
      rd(CFG.sot_file_fr['DC'], 0x16cb4...0x179e9),
      rd(CFG.sot_file_gb['DC'], 0x16897...0x1757b),
    ],
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x33bb44...0x33c86c
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x34014c...0x340e74
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2ec5b8...0x2ece84
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x334cdc...0x3355a8
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x367eb0...0x368a08
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x33990c...0x33a61c
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x339a38...0x33a730
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x19e71...0x1abb8),
      rd(CFG.sot_file_es['GC'], 0x19b0f...0x1a7f2),
      rd(CFG.sot_file_fr['GC'], 0x19c5d...0x1a998),
      rd(CFG.sot_file_gb['GC'], 0x196a8...0x1a38c),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2cef30...0x2cfc58
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33ca94...0x33d0d4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x370600...0x370c40),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x342448...0x342a88),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x342544...0x342b84),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f7f5c...0x2f831c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d4a8c...0x2d502c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d4e4c...0x2d53ec),
  }
  
  # Offset ranges of ship cannon names
  _s.ship_cannon_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1b71f...0x1b923),
      rd(CFG.sot_file_es['DC'], 0x1b489...0x1b697),
      rd(CFG.sot_file_fr['DC'], 0x1b7e7...0x1b9ec),
      rd(CFG.sot_file_gb['DC'], 0x1afa4...0x1b1b0),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b03f...0x1b24b),
      rd(CFG.sot_file_es['DC'], 0x1b548...0x1b757),
      rd(CFG.sot_file_fr['DC'], 0x1b9c2...0x1bbc0),
      rd(CFG.sot_file_gb['DC'], 0x1b00f...0x1b21b),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b03f...0x1b24b),
      rd(CFG.sot_file_es['DC'], 0x1b548...0x1b757),
      rd(CFG.sot_file_fr['DC'], 0x1b9c2...0x1bbc0),
      rd(CFG.sot_file_gb['DC'], 0x1b03f...0x1b24b),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1b50a...0x1b715),
      rd(CFG.sot_file_es['DC'], 0x1b453...0x1b661),
      rd(CFG.sot_file_fr['DC'], 0x1b756...0x1b95b),
      rd(CFG.sot_file_gb['DC'], 0x1af95...0x1b1a8),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1e809...0x1ea14),
      rd(CFG.sot_file_es['GC'], 0x1e57b...0x1e789),
      rd(CFG.sot_file_fr['GC'], 0x1e7cc...0x1e9d1),
      rd(CFG.sot_file_gb['GC'], 0x1de53...0x1e066),
    ],
  }
  
  # Offset ranges of ship cannon descriptions
  _s.ship_cannon_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x16170...0x16e58),
      rd(CFG.sot_file_es['DC'], 0x15dce...0x16b19),
      rd(CFG.sot_file_fr['DC'], 0x15fd4...0x16d44),
      rd(CFG.sot_file_gb['DC'], 0x15bdd...0x168a6),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x15c2b...0x168f4),
      rd(CFG.sot_file_es['DC'], 0x15e5e...0x16baa),
      rd(CFG.sot_file_fr['DC'], 0x1619f...0x16eff),
      rd(CFG.sot_file_gb['DC'], 0x15bfb...0x168c4),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x15c2b...0x168f4),
      rd(CFG.sot_file_es['DC'], 0x15e5e...0x16baa),
      rd(CFG.sot_file_fr['DC'], 0x1619f...0x16eff),
      rd(CFG.sot_file_gb['DC'], 0x15c2b...0x168f4),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x15f61...0x16c49),
      rd(CFG.sot_file_es['DC'], 0x15da3...0x16aec),
      rd(CFG.sot_file_fr['DC'], 0x15f44...0x16cb4),
      rd(CFG.sot_file_gb['DC'], 0x15bce...0x16897),
    ],
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x33aec8...0x33bb44
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x33f4d0...0x34014c
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2ebc1c...0x2ec5b8
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x334340...0x334cdc
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x367388...0x367eb0
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x338c38...0x33990c
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x338d64...0x339a38
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1918c...0x19e71),
      rd(CFG.sot_file_es['GC'], 0x18dd2...0x19b0f),
      rd(CFG.sot_file_fr['GC'], 0x18ef6...0x19c5d),
      rd(CFG.sot_file_gb['GC'], 0x189df...0x196a8),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2ce2b4...0x2cef30
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33d7b4...0x33dc64),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x371320...0x3717d0),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x343168...0x343618),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x343264...0x343714),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f877c...0x2f8a4c),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2d566c...0x2d5aa4),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2d5a2c...0x2d5e64),
  }
  
  # Offset ranges of ship item names
  _s.ship_item_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1bb24...0x1bc84),
      rd(CFG.sot_file_es['DC'], 0x1b8d2...0x1ba79),
      rd(CFG.sot_file_fr['DC'], 0x1bc1e...0x1bdad),
      rd(CFG.sot_file_gb['DC'], 0x1b3c7...0x1b527),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b462...0x1b5c2),
      rd(CFG.sot_file_es['DC'], 0x1b96e...0x1bace),
      rd(CFG.sot_file_fr['DC'], 0x1bdf2...0x1bf81),
      rd(CFG.sot_file_gb['DC'], 0x1b432...0x1b592),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1b462...0x1b5c2),
      rd(CFG.sot_file_es['DC'], 0x1b96e...0x1bace),
      rd(CFG.sot_file_fr['DC'], 0x1bdf2...0x1bf81),
      rd(CFG.sot_file_gb['DC'], 0x1b462...0x1b5c2),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1b916...0x1ba76),
      rd(CFG.sot_file_es['DC'], 0x1b89c...0x1ba43),
      rd(CFG.sot_file_fr['DC'], 0x1bb8d...0x1bd1a),
      rd(CFG.sot_file_gb['DC'], 0x1b3bf...0x1b51f),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1ec15...0x1ed75),
      rd(CFG.sot_file_es['GC'], 0x1e9cd...0x1eb78),
      rd(CFG.sot_file_fr['GC'], 0x1ec03...0x1ed91),
      rd(CFG.sot_file_gb['GC'], 0x1e27d...0x1e3dd),
    ],
  }
  
  # Offset ranges of ship item descriptions
  _s.ship_item_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x17b9e...0x185e8),
      rd(CFG.sot_file_es['DC'], 0x177fe...0x18246),
      rd(CFG.sot_file_fr['DC'], 0x17a79...0x184ca),
      rd(CFG.sot_file_gb['DC'], 0x1758a...0x17f49),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x175d8...0x17f97),
      rd(CFG.sot_file_es['DC'], 0x178a4...0x182ea),
      rd(CFG.sot_file_fr['DC'], 0x17c34...0x18685),
      rd(CFG.sot_file_gb['DC'], 0x175a8...0x17f67),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x175d8...0x17f97),
      rd(CFG.sot_file_es['DC'], 0x178a4...0x182ea),
      rd(CFG.sot_file_fr['DC'], 0x17c34...0x18685),
      rd(CFG.sot_file_gb['DC'], 0x175d8...0x17f97),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1798f...0x183d9),
      rd(CFG.sot_file_es['DC'], 0x177d1...0x18219),
      rd(CFG.sot_file_fr['DC'], 0x179e9...0x1843a),
      rd(CFG.sot_file_gb['DC'], 0x1757b...0x17f3a),
    ],
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x33c86c...0x33d1a0
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x340e74...0x3417a8
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2ece84...0x2edca0
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x3355a8...0x335c10
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x368a08...0x3692e4
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x33a61c...0x33aff0
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x33a730...0x33b104
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1abb8...0x1b603),
      rd(CFG.sot_file_es['GC'], 0x1a7f2...0x1b23a),
      rd(CFG.sot_file_fr['GC'], 0x1a998...0x1b3e9),
      rd(CFG.sot_file_gb['GC'], 0x1a38c...0x1ad4b),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2cfc58...0x2d058c
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0xddc2...0xe045),
      rd(CFG.sot_file_es['DC'], 0xdbaf...0xde55),
      rd(CFG.sot_file_fr['DC'], 0xdc61...0xdf06),
      rd(CFG.sot_file_gb['DC'], 0xd99d...0xdc48),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0xd9f2...0xdc9d),
      rd(CFG.sot_file_es['DC'], 0xda6b...0xdd16),
      rd(CFG.sot_file_fr['DC'], 0xdc36...0xdee1),
      rd(CFG.sot_file_gb['DC'], 0xd9c2...0xdc6d),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0xd9f2...0xdc9d),
      rd(CFG.sot_file_es['DC'], 0xda6b...0xdd16),
      rd(CFG.sot_file_fr['DC'], 0xdc36...0xdee1),
      rd(CFG.sot_file_gb['DC'], 0xd9f2...0xdc9d),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0xdc6e...0xdef1),
      rd(CFG.sot_file_es['DC'], 0xdb92...0xde38),
      rd(CFG.sot_file_fr['DC'], 0xdbe3...0xde88),
      rd(CFG.sot_file_gb['DC'], 0xd990...0xdc3b),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2b571c...0x2b5750, msgt: true
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2b4e6c...0x2b4ea0, msgt: true
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x34e0f0...0x34e2dc, msgt: true
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x3526f8...0x3528e4, msgt: true
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2fc450...0x2fc488, msgt: true
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x34679c...0x3467d4, msgt: true
     ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x37aeb8...0x37b098, msgt: true
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x34befc...0x34c0dc, msgt: true
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x34c034...0x34c210, msgt: true
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x10c7c...0x10f00),
      rd(CFG.sot_file_es['GC'], 0x1095d...0x10c03),
      rd(CFG.sot_file_fr['GC'], 0x10993...0x10c38),
      rd(CFG.sot_file_gb['GC'], 0x10580...0x1082b),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2b6158...0x2b6344, msgt: true
    ),
    'GC-US-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2b6554...0x2b6730, msgt: true
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33a5a4...0x33ac84),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36e110...0x36e7f0),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33ff58...0x340638),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x340054...0x340734),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f4aa8...0x2f4e68),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c4c6c...0x2c534c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c5774...0x2c5e54),
  }
  
  # Offset ranges of special item names
  _s.special_item_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1aea0...0x1b271),
      rd(CFG.sot_file_es['DC'], 0x1ac18...0x1afde),
      rd(CFG.sot_file_fr['DC'], 0x1afa5...0x1b372),
      rd(CFG.sot_file_gb['DC'], 0x1a752...0x1ab27),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1a7d8...0x1abad),
      rd(CFG.sot_file_es['DC'], 0x1acf8...0x1b0be),
      rd(CFG.sot_file_fr['DC'], 0x1b163...0x1b530),
      rd(CFG.sot_file_gb['DC'], 0x1a7a8...0x1ab7d),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1a7d8...0x1abad),
      rd(CFG.sot_file_es['DC'], 0x1acf8...0x1b0be),
      rd(CFG.sot_file_fr['DC'], 0x1b163...0x1b530),
      rd(CFG.sot_file_gb['DC'], 0x1a7d8...0x1abad),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1ac8f...0x1b060),
      rd(CFG.sot_file_es['DC'], 0x1abe8...0x1afab),
      rd(CFG.sot_file_fr['DC'], 0x1af13...0x1b2e1),
      rd(CFG.sot_file_gb['DC'], 0x1a741...0x1ab16),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1dede...0x1e2b1),
      rd(CFG.sot_file_es['GC'], 0x1dc62...0x1e028),
      rd(CFG.sot_file_fr['GC'], 0x1ded3...0x1e2a2),
      rd(CFG.sot_file_gb['GC'], 0x1d556...0x1d929),
    ],
  }
  
  # Offset ranges of special item descriptions
  _s.special_item_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x153d2...0x16170),
      rd(CFG.sot_file_es['DC'], 0x14ffa...0x15dce),
      rd(CFG.sot_file_fr['DC'], 0x151ca...0x15fd4),
      rd(CFG.sot_file_gb['DC'], 0x14d83...0x15bdd),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x14dd0...0x15c2b),
      rd(CFG.sot_file_es['DC'], 0x14faa...0x15e5e),
      rd(CFG.sot_file_fr['DC'], 0x152b2...0x1619f),
      rd(CFG.sot_file_gb['DC'], 0x14da0...0x15bfb),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x14dd0...0x15c2b),
      rd(CFG.sot_file_es['DC'], 0x14faa...0x15e5e),
      rd(CFG.sot_file_fr['DC'], 0x152b2...0x1619f),
      rd(CFG.sot_file_gb['DC'], 0x14dd0...0x15c2b),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x151e2...0x15f61),
      rd(CFG.sot_file_es['DC'], 0x14fd2...0x15da3),
      rd(CFG.sot_file_fr['DC'], 0x1513a...0x15f44),
      rd(CFG.sot_file_gb['DC'], 0x14d74...0x15bce),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2b06dc...0x2b09f8, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2afff8...0x2b0314, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x33a3c4...0x33aec8, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x33e9cc...0x33f4d0, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2eb8bc...0x2ebc1c, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x334034...0x334340, excl: [
        0x14a, 0x14b, 0x151, 0x154
      ]
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x3668e8...0x367388, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x338078...0x338c38, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x3381a4...0x338d64, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x18262...0x1918c),
      rd(CFG.sot_file_es['GC'], 0x17e6f...0x18dd2),
      rd(CFG.sot_file_fr['GC'], 0x17f59...0x18ef6),
      rd(CFG.sot_file_gb['GC'], 0x179f9...0x189df),
    ],
    'GC-JP-GEA'                        => rd(
      CFG.exec_file['GC'], 0x2cd644...0x2ce2b4, excl: [
        0x152, 0x15b, 0x161..0x162
      ]
    ),
    'GC-US-GEA'                        => rd(
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x33ac84...0x33aea4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36e7f0...0x36ea10),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x340638...0x340858),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x340734...0x340954),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f4e68...0x2f4fe8),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c534c...0x2c567c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c5e54...0x2c6184),
  }
  
  # Offset ranges of swashbuckler names
  _s.swashbuckler_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1b271...0x1b3a5),
      rd(CFG.sot_file_es['DC'], 0x1afde...0x1b0fd),
      rd(CFG.sot_file_fr['DC'], 0x1b372...0x1b481),
      rd(CFG.sot_file_gb['DC'], 0x1ab27...0x1ac42),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1abad...0x1acc8),
      rd(CFG.sot_file_es['DC'], 0x1b0be...0x1b1d9),
      rd(CFG.sot_file_fr['DC'], 0x1b530...0x1b64b),
      rd(CFG.sot_file_gb['DC'], 0x1ab7d...0x1ac98),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1abad...0x1acc8),
      rd(CFG.sot_file_es['DC'], 0x1b0be...0x1b1d9),
      rd(CFG.sot_file_fr['DC'], 0x1b530...0x1b64b),
      rd(CFG.sot_file_gb['DC'], 0x1abad...0x1acc8),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1b060...0x1b194),
      rd(CFG.sot_file_es['DC'], 0x1afab...0x1b0ca),
      rd(CFG.sot_file_fr['DC'], 0x1b2e1...0x1b3f0),
      rd(CFG.sot_file_gb['DC'], 0x1ab16...0x1ac31),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1e2b1...0x1e49d),
      rd(CFG.sot_file_es['GC'], 0x1e028...0x1e1f2),
      rd(CFG.sot_file_fr['GC'], 0x1e2a2...0x1e466),
      rd(CFG.sot_file_gb['GC'], 0x1d929...0x1daef),
    ],
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x339a64...0x33a5a4),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36d5d0...0x36e110),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33f418...0x33ff58),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33f514...0x340054),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f4328...0x2f4aa8),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c412c...0x2c4c6c),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c4c34...0x2c5774),
  }
  
  # Offset ranges of usable item names
  _s.usable_item_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x1aae1...0x1aea0),
      rd(CFG.sot_file_es['DC'], 0x1a7fc...0x1ac18),
      rd(CFG.sot_file_fr['DC'], 0x1ab76...0x1afa5),
      rd(CFG.sot_file_gb['DC'], 0x1a393...0x1a752),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1a419...0x1a7d8),
      rd(CFG.sot_file_es['DC'], 0x1a8d9...0x1acf8),
      rd(CFG.sot_file_fr['DC'], 0x1ad34...0x1b163),
      rd(CFG.sot_file_gb['DC'], 0x1a3e9...0x1a7a8),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1a419...0x1a7d8),
      rd(CFG.sot_file_es['DC'], 0x1a8d9...0x1acf8),
      rd(CFG.sot_file_fr['DC'], 0x1ad34...0x1b163),
      rd(CFG.sot_file_gb['DC'], 0x1a419...0x1a7d8),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x1a8d2...0x1ac8f),
      rd(CFG.sot_file_es['DC'], 0x1a7ce...0x1abe8),
      rd(CFG.sot_file_fr['DC'], 0x1aae6...0x1af13),
      rd(CFG.sot_file_gb['DC'], 0x1a384...0x1a741),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1db1c...0x1dede),
      rd(CFG.sot_file_es['GC'], 0x1d83d...0x1dc62),
      rd(CFG.sot_file_fr['GC'], 0x1daa2...0x1ded3),
      rd(CFG.sot_file_gb['GC'], 0x1d194...0x1d556),
    ],
  }
  
  # Offset ranges of usable item descriptions
  _s.usable_item_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x13ad7...0x153d2),
      rd(CFG.sot_file_es['DC'], 0x136b6...0x14ffa),
      rd(CFG.sot_file_fr['DC'], 0x138a5...0x151ca),
      rd(CFG.sot_file_gb['DC'], 0x134c5...0x14d83),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x1351a...0x14dd0),
      rd(CFG.sot_file_es['DC'], 0x1364f...0x14faa),
      rd(CFG.sot_file_fr['DC'], 0x13969...0x152b2),
      rd(CFG.sot_file_gb['DC'], 0x134ea...0x14da0),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x1351a...0x14dd0),
      rd(CFG.sot_file_es['DC'], 0x1364f...0x14faa),
      rd(CFG.sot_file_fr['DC'], 0x13969...0x152b2),
      rd(CFG.sot_file_gb['DC'], 0x1351a...0x14dd0),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x138e9...0x151e2),
      rd(CFG.sot_file_es['DC'], 0x13690...0x14fd2),
      rd(CFG.sot_file_fr['DC'], 0x13817...0x1513a),
      rd(CFG.sot_file_gb['DC'], 0x134b8...0x14d74),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2afe30...0x2b06dc, excl: [
        0x100, 0x101, 0x10c..0x11a
      ]
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2af74c...0x2afff8, excl: [
        0x100, 0x101, 0x10c..0x11a
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x3387d4...0x33a3c4, excl: [
        0x12e..0x130
      ]
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x33cddc...0x33e9cc, excl: [
        0x12e..0x130
      ]
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2eb0ec...0x2eb8bc, excl: [
        0x100..0x101, 0x10c..0x11a
      ]
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x3338a4...0x334034, excl: [
        0x100..0x101, 0x10c..0x11a
      ]
     ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x3653bc...0x3668e8, excl: [
        0x0f2, 0x10c, 0x12d..0x130
      ]
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x336850...0x338078, excl: [
        0x12d..0x130
      ]
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x33693c...0x3381a4, excl: [
        0x12d..0x130
      ]
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x16979...0x18262),
      rd(CFG.sot_file_es['GC'], 0x1652e...0x17e6f),
      rd(CFG.sot_file_fr['GC'], 0x16635...0x17f59),
      rd(CFG.sot_file_gb['GC'], 0x1613d...0x179f9),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2cba54...0x2cd644, excl: [
        0x12e..0x130
      ]
    ),
    'GC-US-GEA'                         => rd(
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
    'DC-US-IGN9'              => rd(CFG.exec_file['DC'], 0x3375c0...0x337fc0),
    'DC-US-MK-51052-20000905' => rd(CFG.exec_file['DC'], 0x36b12c...0x36bb2c),
    'DC-US-MK-51052-20000914' => rd(CFG.exec_file['DC'], 0x33cf74...0x33d974),
    'DC-US-MK-51052-20001010' => rd(CFG.exec_file['DC'], 0x33d070...0x33da70),
    'GC-EU-GEA'               => rd(CFG.exec_file['GC'], 0x2f2b68...0x2f31a8),
    'GC-JP-GEA'               => rd(CFG.exec_file['GC'], 0x2c1c88...0x2c2688),
    'GC-US-GEA'               => rd(CFG.exec_file['GC'], 0x2c2790...0x2c3190),
  }
  
  # Offset ranges of weapon names
  _s.weapon_name_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0x19e83...0x1a279),
      rd(CFG.sot_file_es['DC'], 0x19ac8...0x19f07),
      rd(CFG.sot_file_fr['DC'], 0x19e68...0x1a265),
      rd(CFG.sot_file_gb['DC'], 0x19753...0x19b20),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0x197d9...0x19ba6),
      rd(CFG.sot_file_es['DC'], 0x19b9d...0x19fe3),
      rd(CFG.sot_file_fr['DC'], 0x1a026...0x1a423),
      rd(CFG.sot_file_gb['DC'], 0x197a9...0x19b76),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0x197d9...0x19ba6),
      rd(CFG.sot_file_es['DC'], 0x19b9d...0x19fe3),
      rd(CFG.sot_file_fr['DC'], 0x1a026...0x1a423),
      rd(CFG.sot_file_gb['DC'], 0x197d9...0x19ba6),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0x19c74...0x1a06a),
      rd(CFG.sot_file_es['DC'], 0x19a98...0x19ed7),
      rd(CFG.sot_file_fr['DC'], 0x19dd8...0x1a1d5),
      rd(CFG.sot_file_gb['DC'], 0x19744...0x19b11),
    ],
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x1ce93...0x1d289),
      rd(CFG.sot_file_es['GC'], 0x1cb04...0x1cf43),
      rd(CFG.sot_file_fr['GC'], 0x1cd83...0x1d18e),
      rd(CFG.sot_file_gb['GC'], 0x1c555...0x1c921),
    ],
  }
  
  # Offset ranges of weapon descriptions
  _s.weapon_dscr_files = {
    'DC-EU-8320062 50'                  => [
      rd(CFG.sot_file_de['DC'], 0xf842...0x111d9),
      rd(CFG.sot_file_es['DC'], 0xf63e...0x10faa),
      rd(CFG.sot_file_fr['DC'], 0xf726...0x11008),
      rd(CFG.sot_file_gb['DC'], 0xf45e...0x10db1),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM1/2' => [
      rd(CFG.sot_file_de['DC'], 0xf4b3...0x10e06),
      rd(CFG.sot_file_es['DC'], 0xf4e4...0x10e97),
      rd(CFG.sot_file_fr['DC'], 0xf6fd...0x11002),
      rd(CFG.sot_file_gb['DC'], 0xf483...0x10dd6),
    ],
    'DC-EU-MK-51052-20001115-GD-ROM2/2' => [
      rd(CFG.sot_file_de['DC'], 0xf4b3...0x10e06),
      rd(CFG.sot_file_es['DC'], 0xf4e4...0x10e97),
      rd(CFG.sot_file_fr['DC'], 0xf6fd...0x11002),
      rd(CFG.sot_file_gb['DC'], 0xf4b3...0x10e06),
    ],
    'DC-EU-MK-51052-20010306'           => [
      rd(CFG.sot_file_de['DC'], 0xf6d1...0x10fec),
      rd(CFG.sot_file_es['DC'], 0xf617...0x10f83),
      rd(CFG.sot_file_fr['DC'], 0xf696...0x10f79),
      rd(CFG.sot_file_gb['DC'], 0xf451...0x10da4),
    ],
    'DC-JP-6107110 06'                  => rd(
      CFG.exec_file['DC'], 0x2af590...0x2af878, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-JP-6107810'                     => rd(
      CFG.exec_file['DC'], 0x2aeeac...0x2af194, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-JP-HDR-0076'                    => rd(
      CFG.exec_file['DC'], 0x334094...0x335b4c
    ),
    'DC-JP-HDR-0119'                    => rd(
      CFG.exec_file['DC'], 0x33869c...0x33a154
    ),
    'DC-US-HDR-0000'                    => rd(
      CFG.exec_file['DC'], 0x2ea848...0x2eab28, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-US-IGN9'                        => rd(
      CFG.exec_file['DC'], 0x333110...0x33337c, excl: [
        0x03..0x04, 0x06..0x0f, 0x12..0x13, 0x15..0x1f, 0x22..0x2f, 0x31..0x39, 
        0x3b..0x3f, 0x41..0x46
      ]
    ),
    'DC-US-MK-51052-20000905'           => rd(
      CFG.exec_file['DC'], 0x361d60...0x363334
    ),
    'DC-US-MK-51052-20000914'           => rd(
      CFG.exec_file['DC'], 0x3329d4...0x3342a0
    ),
    'DC-US-MK-51052-20001010'           => rd(
      CFG.exec_file['DC'], 0x332ad8...0x3343f8
    ),
    'GC-EU-GEA'                         => [
      rd(CFG.sot_file_de['GC'], 0x126e4...0x14060),
      rd(CFG.sot_file_es['GC'], 0x12410...0x13dc4),
      rd(CFG.sot_file_fr['GC'], 0x1244e...0x13da3),
      rd(CFG.sot_file_gb['GC'], 0x12056...0x139f6),
    ],
    'GC-JP-GEA'                         => rd(
      CFG.exec_file['GC'], 0x2c72c0...0x2c8ddc
    ),
    'GC-US-GEA'                         => rd(
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
