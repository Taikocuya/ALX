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
require_relative('shipaccessory.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle ship accessories from binary and/or CSV files.
class ShipAccessoryData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x1b8...0x1e0

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2d53ec...0x2d5a2c),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2d502c...0x2d566c),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f831c...0x2f877c),
  }

  # Offset ranges of name entries
  NAME_RANGES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1ea14...0x1ec15),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1e789...0x1e9cd),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1e9d1...0x1ec03),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1e066...0x1e27d),
    ],
  }

  # Offset ranges of description entries
  DSCR_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2ceef8...0x2cfbf0),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2cef30...0x2cfc58),
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x19e71...0x1abb8),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x19b0f...0x1a7f2),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x19c5d...0x1a998),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x196a8...0x1a38c),
    ],
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipAccessoryData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(ShipAccessory, _root)
    self.id_range    = ID_RANGE
    self.data_ranges = DATA_RANGES
    self.name_ranges = NAME_RANGES
    self.dscr_ranges = DSCR_RANGES
  end

end # class ShipAccessoryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
