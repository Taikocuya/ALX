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

require_relative('enemysupermove.rb')
require_relative('entrytransform.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy skills from binary and/or CSV files.
class EnemySuperMoveData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x135

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2aa950...0x2ad4c4),
    'J' => DataRange.new(DOL_FILE, 0x2aa3f8...0x2acf6c),
    'P' => DataRange.new(DOL_FILE, 0x2d9668...0x2dae8c),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x14e4...0x2079),
      DataRange.new(SOT_FILE_ES, 0x14d7...0x215d),
      DataRange.new(SOT_FILE_FR, 0x14d9...0x211a),
      DataRange.new(SOT_FILE_GB, 0x14d4...0x1ff8),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'csv/enemysupermoves.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemySuperMoveData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(EnemySuperMove, _root)
    self.id_range   = ID_RANGE
    self.data_files = DATA_FILES
    self.name_files = NAME_FILES
    self.csv_file   = CSV_FILE
  end

end # class EnemySuperMoveData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
