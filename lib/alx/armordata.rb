#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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

require_relative('armor.rb')
require_relative('entrytransform.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle armors from binary and/or CSV files.
class ArmorData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x50...0xa0

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2c3190...0x2c3e10),
    'J' => DataRange.new(DOL_FILE, 0x2c2688...0x2c3308),
    'P' => DataRange.new(DOL_FILE, 0x2f31a8...0x2f3a68),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1d289...0x1d6aa),
      DataRange.new(SOT_FILE_ES, 0x1cf43...0x1d39e),
      DataRange.new(SOT_FILE_FR, 0x1d18e...0x1d5d7),
      DataRange.new(SOT_FILE_GB, 0x1c921...0x1cd13),
    ],
  }

  # Offset ranges of description entries
  DSCR_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2c9714...0x2ca880),
    'J' => DataRange.new(DOL_FILE, 0x2c8ddc...0x2ca370),
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x14060...0x153d7),
      DataRange.new(SOT_FILE_ES, 0x13dc4...0x1502e),
      DataRange.new(SOT_FILE_FR, 0x13da3...0x15017),
      DataRange.new(SOT_FILE_GB, 0x139f6...0x14c6f),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'csv/armors.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ArmorData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Armor, _root)
    self.id_range   = ID_RANGE
    self.data_files = DATA_FILES
    self.name_files = NAME_FILES
    self.dscr_files = DSCR_FILES
    self.csv_file   = CSV_FILE
  end

end # class ArmorData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
