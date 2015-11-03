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
class PlayableShipData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x6

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2d3740...0x2d3934),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2d3380...0x2d3574),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f6b70...0x2f6d14),
  }

  # Offset ranges of name entries
  NAME_RANGES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1e5ff...0x1e635),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1e370...0x1e3a6),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1e5c1...0x1e5f7),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1dc48...0x1dc7e),
    ],
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a PlayableShipData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(PlayableShip, _root)
    self.id_range        = ID_RANGE
    self.data_ranges     = DATA_RANGES
    self.name_ranges     = NAME_RANGES
    @ship_cannon_data    = ShipCannonData.new(_root)
    @ship_accessory_data = ShipAccessoryData.new(_root)
  end

  # Creates an entry.
  # @param _id [String] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry                     = super
    _entry.ship_cannon_data    = @ship_cannon_data.data
    _entry.ship_accessory_data = @ship_accessory_data.data
    _entry
  end
  
  # Reads all entries from binary files.
  def load_from_bins
    @ship_cannon_data.load_from_bins
    @ship_accessory_data.load_from_bins
    super
  end

end # class PlayableShipData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
