#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
# 
# This file is part of ALX.
# 
# ALX is free software: you can redistribute it and/or modify it under the 
# terms of the GNU General Public License as published by the Free Software 
# Foundation, either version 3 of the License, or (at your CHARAion) any later 
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

require_relative('accessory.rb')
require_relative('entrytransform.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle accessories from binary and/or CSV files.
class AccessoryData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0xa0...0xf0

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2c3e10...0x2c4a90),
    'J' => DataRange.new(DOL_FILE, 0x2c3308...0x2c3f88),
    'P' => DataRange.new(DOL_FILE, 0x2f3a68...0x2f4328),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1d6aa...0x1db1c),
      DataRange.new(SOT_FILE_ES, 0x1d39e...0x1d83d),
      DataRange.new(SOT_FILE_FR, 0x1d5d7...0x1daa2),
      DataRange.new(SOT_FILE_GB, 0x1cd13...0x1d194),
    ],
  }

  # Offset ranges of description entries
  DSCR_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2ca880...0x2cbc88),
    'J' => DataRange.new(DOL_FILE, 0x2ca370...0x2cba54),
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x153d7...0x16979),
      DataRange.new(SOT_FILE_ES, 0x1502e...0x1652e),
      DataRange.new(SOT_FILE_FR, 0x15017...0x16635),
      DataRange.new(SOT_FILE_GB, 0x14c6f...0x1613d),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'csv/accessories.csv'
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an AccessoryData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Accessory, _root)
    self.id_range   = ID_RANGE
    self.data_files = DATA_FILES
    self.name_files = NAME_FILES
    self.dscr_files = DSCR_FILES
    self.csv_file   = CSV_FILE
  end

end # class AccessoryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
