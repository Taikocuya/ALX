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

require_relative('characterdata.rb')
require_relative('entrytransform.rb')
require_relative('expcurve.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle EXP curves from binary and/or CSV files.
class ExpCurveData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x6

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(LMT_FILE, 0x000...0x948),
    'J' => DataRange.new(LMT_FILE, 0x000...0x948),
    'P' => DataRange.new(LMT_FILE, 0x000...0x948),
  }

  # Path to CSV file
  CSV_FILE = 'csv/expcurves.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ExpCurveData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(ExpCurve, _root)
    self.id_range       = ID_RANGE
    self.data_files = DATA_FILES
    self.csv_file       = CSV_FILE
    @character_data     = CharacterData.new(_root)
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry            = super
    _entry.characters = @character_data.data
    _entry
  end
  
  # Reads all entries from binary files.
  def load_all_from_bin
    @character_data.load_all_from_bin
    super
  end

end # class ExpCurveData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
