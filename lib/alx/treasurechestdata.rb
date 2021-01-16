#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2021 Marcel Renner
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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('accessorydata.rb')
require_relative('armordata.rb')
require_relative('shipaccessorydata.rb')
require_relative('shipcannondata.rb')
require_relative('shipitemdata.rb')
require_relative('specialitemdata.rb')
require_relative('stdentrydata.rb')
require_relative('treasurechest.rb')
require_relative('usableitemdata.rb')
require_relative('weapondata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle treasure chests from binary and/or CSV files.
class TreasureChestData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a TreasureChestData.
  # @param _root   [GameRoot] Game root
  # @param _depend [Boolean]  Resolve dependencies
  def initialize(_root, _depend = true)
    super(TreasureChest, _root, _depend)
    self.id_range  = sys(:treasure_chest_id_range)
    self.data_file = sys(:treasure_chest_data_files)
    self.csv_file  = SYS.treasure_chest_csv_file
    self.tpl_file  = SYS.treasure_chest_tpl_file
        
    if depend
      @accessory_data      = AccessoryData.new(_root)
      @armor_data          = ArmorData.new(_root)
      @ship_accessory_data = ShipAccessoryData.new(_root)
      @ship_cannon_data    = ShipCannonData.new(_root)
      @ship_item_data      = ShipItemData.new(_root)
      @special_item_data   = SpecialItemData.new(_root)
      @usable_item_data    = UsableItemData.new(_root)
      @weapon_data         = WeaponData.new(_root)
    end
    
    @items = {}
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry       = super
    _entry.items = @items
    _entry
  end
  
  # Reads all entries from binary files.
  def load_bin
    @accessory_data&.load_bin
    @armor_data&.load_bin
    @ship_accessory_data&.load_bin
    @ship_cannon_data&.load_bin
    @ship_item_data&.load_bin
    @special_item_data&.load_bin
    @usable_item_data&.load_bin
    @weapon_data&.load_bin
    
    if depend
      @items.merge!(@accessory_data.data)
      @items.merge!(@armor_data.data)
      @items.merge!(@ship_accessory_data.data)
      @items.merge!(@ship_cannon_data.data)
      @items.merge!(@ship_item_data.data)
      @items.merge!(@special_item_data.data)
      @items.merge!(@usable_item_data.data)
      @items.merge!(@weapon_data.data)
    end
    
    super
  end

end # class TreasureChestData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
