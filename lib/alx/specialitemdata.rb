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
require_relative('specialitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle special items from binary and/or CSV files.
class SpecialItemData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x140...0x190

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2c5774...0x2c5e54),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2c4c6c...0x2c534c),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f4aa8...0x2f4e68),
  }

  # Offset ranges of name entries
  NAME_RANGES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1dede...0x1e2b1),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1dc62...0x1e028),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1ded3...0x1e2a2),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1d556...0x1d929),
    ],
  }

  # Offset ranges of description entries
  DSCR_RANGES = {
    'E' => DataRange.new(
      EntryTransform::DOL_FILE, 0x2cd4ec...0x2ce220,
      [0x152, 0x15b, 0x161, 0x162]
    ),
    'J' => DataRange.new(
      EntryTransform::DOL_FILE, 0x2cd644...0x2ce2b4,
      [0x152, 0x15b, 0x161, 0x162]
    ),
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x18262...0x1918c),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x17e6f...0x18dd2),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x17f59...0x18ef6),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x179f9...0x189df),
    ],
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a SpecialItemData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(SpecialItem, _root)
    self.id_range    = ID_RANGE
    self.data_ranges = DATA_RANGES
    self.name_ranges = NAME_RANGES
    self.dscr_ranges = DSCR_RANGES
  end

end # class SpecialItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
