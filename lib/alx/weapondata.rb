#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('entrytransform.rb')
require_relative('dolentrydata.rb')
require_relative('weapon.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle weapons from binary and/or CSV files.
class WeaponData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x50

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2c2790...0x2c3190),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2c1c88...0x2c2688),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f2b68...0x2f31a8),
  }

  # Offset ranges of name entries
  NAME_RANGES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1ce93...0x1d289),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1cb04...0x1cf43),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1cd83...0x1d18e),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1c555...0x1c921),
    ],
  }

  # Offset ranges of description entries
  DSCR_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2c7d9c...0x2c9714),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2c72c0...0x2c8ddc),
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x126e4...0x14060),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x12410...0x13dc4),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1244e...0x13da3),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x12056...0x139f6),
    ],
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a WeaponData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Weapon, _root)
    self.id_range    = ID_RANGE
    self.data_ranges = DATA_RANGES
    self.name_ranges = NAME_RANGES
    self.dscr_ranges = DSCR_RANGES
  end

end # class WeaponData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
