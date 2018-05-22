#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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

require_relative('charactersupermove.rb')
require_relative('entrytransform.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle character skills from binary and/or CSV files.
class CharacterSuperMoveData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x24...0x3e

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2c22b0...0x2c2790),
    'J' => DataRange.new(DOL_FILE, 0x2c17a8...0x2c1c88),
    'P' => DataRange.new(DOL_FILE, 0x2f27c0...0x2f2b68),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1cd48...0x1ce93),
      DataRange.new(SOT_FILE_ES, 0x1c99b...0x1cb04),
      DataRange.new(SOT_FILE_FR, 0x1cc0b...0x1cd83),
      DataRange.new(SOT_FILE_GB, 0x1c402...0x1c555),
    ],
  }

  # Offset ranges of description entries
  DSCR_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2c73e0...0x2c7d9c),
    'J' => DataRange.new(DOL_FILE, 0x2c68d4...0x2c72c0),
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x11d53...0x126e4),
      DataRange.new(SOT_FILE_ES, 0x11a56...0x12410),
      DataRange.new(SOT_FILE_FR, 0x11a9a...0x1244e),
      DataRange.new(SOT_FILE_GB, 0x116a9...0x12056),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'csv/charactersupermoves.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterSuperMoveData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(CharacterSuperMove, _root)
    self.id_range    = ID_RANGE
    self.data_files  = DATA_FILES
    self.name_files  = NAME_FILES
    self.dscr_files  = DSCR_FILES
    self.csv_file    = CSV_FILE
  end

end # class CharacterSuperMoveData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
