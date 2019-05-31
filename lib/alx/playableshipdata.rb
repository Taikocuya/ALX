#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a PlayableShipData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(PlayableShip, _root)
    self.id_range        = sys(:playable_ship_id_range)
    self.data_file       = sys(:playable_ship_data_files)
    self.name_file       = sys(:playable_ship_name_files)
    self.csv_file        = sys(:playable_ship_csv_file)
    self.tpl_file        = sys(:playable_ship_tpl_file)
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
