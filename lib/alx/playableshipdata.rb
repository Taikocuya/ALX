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

require_relative('playableship.rb')
require_relative('entrytransform.rb')
require_relative('shipaccessorydata.rb')
require_relative('shipcannondata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle playable ships from binary and/or CSV files.
class PlayableShipData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x6

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2d3740...0x2d3934),
    'J' => DataRange.new(DOL_FILE, 0x2d3380...0x2d3574),
    'P' => DataRange.new(DOL_FILE, 0x2f6b70...0x2f6d14),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1e5ff...0x1e635),
      DataRange.new(SOT_FILE_ES, 0x1e370...0x1e3a6),
      DataRange.new(SOT_FILE_FR, 0x1e5c1...0x1e5f7),
      DataRange.new(SOT_FILE_GB, 0x1dc48...0x1dc7e),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'csv/playableships.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a PlayableShipData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(PlayableShip, _root)
    self.id_range        = ID_RANGE
    self.data_files      = DATA_FILES
    self.name_files      = NAME_FILES
    self.csv_file        = CSV_FILE
    @ship_cannon_data    = ShipCannonData.new(_root)
    @ship_accessory_data = ShipAccessoryData.new(_root)
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry                  = super
    _entry.ship_cannons     = @ship_cannon_data.data
    _entry.ship_accessories = @ship_accessory_data.data
    _entry
  end
  
  # Reads all entries from binary files.
  def load_all_from_bin
    @ship_cannon_data.load_all_from_bin
    @ship_accessory_data.load_all_from_bin
    super
  end

end # class PlayableShipData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
