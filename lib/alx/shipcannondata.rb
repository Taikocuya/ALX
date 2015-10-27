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
require_relative('shipcannon.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle ship cannons from binary and/or CSV files.
class ShipCannonData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x190...0x1b8

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2d4e4c...0x2d53ec),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2d4a8c...0x2d502c),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f7f5c...0x2f831c),
  }

  # Offset ranges of name entries
  NAME_RANGES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1e809...0x1ea14),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1e57b...0x1e789),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1e7cc...0x1e9d1),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1de53...0x1e066),
    ],
  }

  # Offset ranges of description entries
  DSCR_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2ce220...0x2ceef8),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2ce2b4...0x2cef30),
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1918c...0x19e71),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x18dd2...0x19b0f),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x18ef6...0x19c5d),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x189df...0x196a8),
    ],
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipCannonData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(ShipCannon, _root)
    self.id_range    = ID_RANGE
    self.data_ranges = DATA_RANGES
    self.name_ranges = NAME_RANGES
    self.dscr_ranges = DSCR_RANGES
  end

end # class ShipCannonData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
