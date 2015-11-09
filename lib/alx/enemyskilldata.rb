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

require_relative('enemyskill.rb')
require_relative('entrytransform.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy skills from binary and/or CSV files.
class EnemySkillData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x159

  # Offset ranges of data entries
  BIN_FILES_DATA = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2aa440...0x2ad4c4),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2a9ee8...0x2acf6c),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2d9398...0x2dae8c),
  }

  # Offset ranges of name entries
  BIN_FILES_NAMES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_FILE_DE, 0x13d6...0x2079),
      DataRange.new(EntryTransform::SOT_FILE_ES, 0x13c9...0x215d),
      DataRange.new(EntryTransform::SOT_FILE_FR, 0x13cb...0x211a),
      DataRange.new(EntryTransform::SOT_FILE_GB, 0x13c6...0x1ff8),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'enemyskills.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemySkillData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(EnemySkill, _root)
    self.id_range        = ID_RANGE
    self.bin_files_data  = BIN_FILES_DATA
    self.bin_files_names = BIN_FILES_NAMES
    self.csv_file        = CSV_FILE
  end

end # class EnemySkillData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
