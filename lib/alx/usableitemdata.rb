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
require_relative('usableitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle usable items from binary and/or CSV files.
class UsableItemData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0xf0...0x140

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2c4c34...0x2c5774),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2c412c...0x2c4c6c),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f4328...0x2f4aa8),
  }

  # Offset ranges of name entries
  NAME_RANGES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1db1c...0x1dede),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1d83d...0x1dc62),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1daa2...0x1ded3),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1d194...0x1d556),
    ],
  }

  # Offset ranges of description entries
  DSCR_RANGES = {
    'E' => DataRange.new(
      EntryTransform::DOL_FILE, 0x2cbc88...0x2cd4ec, (0x12d..0x130).to_a
    ),
    'J' => DataRange.new(
      EntryTransform::DOL_FILE, 0x2cba54...0x2cd644, (0x12e..0x130).to_a
    ),
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x16979...0x18262),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1652e...0x17e6f),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x16635...0x17f59),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1613d...0x179f9),
    ],
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an UsableItemData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(UsableItem, _root)
    self.id_range    = ID_RANGE
    self.data_ranges = DATA_RANGES
    self.name_ranges = NAME_RANGES
    self.dscr_ranges = DSCR_RANGES
  end

end # class UsableItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
