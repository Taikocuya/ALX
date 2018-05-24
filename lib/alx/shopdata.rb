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

require_relative('armordata.rb')
require_relative('accessorydata.rb')
require_relative('entrytransform.rb')
require_relative('shipaccessorydata.rb')
require_relative('shipcannondata.rb')
require_relative('shipitemdata.rb')
require_relative('shop.rb')
require_relative('specialitemdata.rb')
require_relative('usableitemdata.rb')
require_relative('weapondata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle shops from binary and/or CSV files.
class ShopData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x2b

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2e90a0...0x2ea218),
    'J' => DataRange.new(DOL_FILE, 0x2e8d08...0x2e9e80),
    'P' => DataRange.new(DOL_FILE, 0x2e7dd4...0x2e8f4c),
  }

  # Offset ranges of description entries
  DSCR_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2b6554...0x2b6730, :use_msg_table => true),
    'J' => DataRange.new(DOL_FILE, 0x2b6158...0x2b6344, :use_msg_table => true),
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x10c7c...0x10f00),
      DataRange.new(SOT_FILE_ES, 0x1095d...0x10c03),
      DataRange.new(SOT_FILE_FR, 0x10993...0x10c38),
      DataRange.new(SOT_FILE_GB, 0x10580...0x1082b),
    ],
  }
  
  # Path to CSV file
  CSV_FILE = 'csv/shops.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShopData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Shop, _root)
    self.id_range   = ID_RANGE
    self.data_files = DATA_FILES
    self.dscr_files = DSCR_FILES
    self.csv_file   = CSV_FILE
    
    @accessory_data      = AccessoryData.new(_root)
    @armor_data          = ArmorData.new(_root)
    @ship_cannon_data    = ShipCannonData.new(_root)
    @ship_accessory_data = ShipAccessoryData.new(_root)
    @ship_item_data      = ShipItemData.new(_root)
    @special_item_data   = SpecialItemData.new(_root)
    @usable_item_data    = UsableItemData.new(_root)
    @weapon_data         = WeaponData.new(_root)
    @items               = {}
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
  def load_all_from_bin
    @accessory_data.load_all_from_bin
    @armor_data.load_all_from_bin
    @ship_cannon_data.load_all_from_bin
    @ship_accessory_data.load_all_from_bin
    @ship_item_data.load_all_from_bin
    @special_item_data.load_all_from_bin
    @usable_item_data.load_all_from_bin
    @weapon_data.load_all_from_bin
    
    @items.merge!(@accessory_data.data)
    @items.merge!(@armor_data.data)
    @items.merge!(@ship_cannon_data.data)
    @items.merge!(@ship_accessory_data.data)
    @items.merge!(@ship_item_data.data)
    @items.merge!(@special_item_data.data)
    @items.merge!(@usable_item_data.data)
    @items.merge!(@weapon_data.data)
    
    super
  end

end # class ShopData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
