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
require_relative('shipcannon.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle ship cannons from binary and/or CSV files.
class ShipCannonData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x190...0x1b8

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2d4e4c...0x2d53ec),
    'J' => DataRange.new(DOL_FILE, 0x2d4a8c...0x2d502c),
    'P' => DataRange.new(DOL_FILE, 0x2f7f5c...0x2f831c),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1e809...0x1ea14),
      DataRange.new(SOT_FILE_ES, 0x1e57b...0x1e789),
      DataRange.new(SOT_FILE_FR, 0x1e7cc...0x1e9d1),
      DataRange.new(SOT_FILE_GB, 0x1de53...0x1e066),
    ],
  }

  # Offset ranges of description entries
  DSCR_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2ce220...0x2ceef8),
    'J' => DataRange.new(DOL_FILE, 0x2ce2b4...0x2cef30),
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1918c...0x19e71),
      DataRange.new(SOT_FILE_ES, 0x18dd2...0x19b0f),
      DataRange.new(SOT_FILE_FR, 0x18ef6...0x19c5d),
      DataRange.new(SOT_FILE_GB, 0x189df...0x196a8),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'csv/shipcannons.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipCannonData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(ShipCannon, _root)
    self.id_range   = ID_RANGE
    self.data_files = DATA_FILES
    self.name_files = NAME_FILES
    self.dscr_files = DSCR_FILES
    self.csv_file   = CSV_FILE
  end

end # class ShipCannonData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
