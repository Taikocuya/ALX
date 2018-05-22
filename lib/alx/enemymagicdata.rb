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

require_relative('enemymagic.rb')
require_relative('entrytransform.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy magics from binary and/or CSV files.
class EnemyMagicData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x24

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2aa440...0x2aa950),
    'J' => DataRange.new(DOL_FILE, 0x2a9ee8...0x2aa3f8),
    'P' => DataRange.new(DOL_FILE, 0x2d9398...0x2d9668),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x13d6...0x14e4),
      DataRange.new(SOT_FILE_ES, 0x13c9...0x14d7),
      DataRange.new(SOT_FILE_FR, 0x13cb...0x14d9),
      DataRange.new(SOT_FILE_GB, 0x13c6...0x14d4),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'csv/enemymagics.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemyMagicData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(EnemyMagic, _root)
    self.id_range   = ID_RANGE
    self.data_files = DATA_FILES
    self.name_files = NAME_FILES
    self.csv_file   = CSV_FILE
  end

end # class EnemyMagicData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
