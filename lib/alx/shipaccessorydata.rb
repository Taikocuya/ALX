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
require_relative('shipaccessory.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle ship accessories from binary and/or CSV files.
class ShipAccessoryData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x1b8...0x1e0

  # Offset ranges of data entries
  BIN_FILES_DATA = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2d53ec...0x2d5a2c),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2d502c...0x2d566c),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f831c...0x2f877c),
  }

  # Offset ranges of name entries
  BIN_FILES_NAMES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_FILE_DE, 0x1ea14...0x1ec15),
      DataRange.new(EntryTransform::SOT_FILE_ES, 0x1e789...0x1e9cd),
      DataRange.new(EntryTransform::SOT_FILE_FR, 0x1e9d1...0x1ec03),
      DataRange.new(EntryTransform::SOT_FILE_GB, 0x1e066...0x1e27d),
    ],
  }

  # Offset ranges of description entries
  BIN_FILES_DSCR = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2ceef8...0x2cfbf0),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2cef30...0x2cfc58),
    'P' => [
      DataRange.new(EntryTransform::SOT_FILE_DE, 0x19e71...0x1abb8),
      DataRange.new(EntryTransform::SOT_FILE_ES, 0x19b0f...0x1a7f2),
      DataRange.new(EntryTransform::SOT_FILE_FR, 0x19c5d...0x1a998),
      DataRange.new(EntryTransform::SOT_FILE_GB, 0x196a8...0x1a38c),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'shipaccessories.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipAccessoryData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(ShipAccessory, _root)
    self.id_range        = ID_RANGE
    self.bin_files_data  = BIN_FILES_DATA
    self.bin_files_names = BIN_FILES_NAMES
    self.bin_files_dscr  = BIN_FILES_DSCR
    self.csv_file        = CSV_FILE
  end

end # class ShipAccessoryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
