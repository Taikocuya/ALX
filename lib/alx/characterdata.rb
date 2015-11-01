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

require_relative('armordata.rb')
require_relative('accessorydata.rb')
require_relative('entrytransform.rb')
require_relative('dolentrydata.rb')
require_relative('character.rb')
require_relative('weapondata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle characters from binary and/or CSV files.
class CharacterData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x6

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2c1860...0x2c1bf0),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2c0d58...0x2c10e8),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2c2ff0...0x2c3380),
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Character, _root)
    self.id_range    = ID_RANGE
    self.data_ranges = DATA_RANGES
    @weapon_data     = WeaponData.new(_root)
    @armor_data      = ArmorData.new(_root)
    @accessory_data  = AccessoryData.new(_root)
  end

  # Creates an entry.
  # @param _id [String] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry                = super
    _entry.weapon_data    = @weapon_data.data
    _entry.armor_data     = @armor_data.data
    _entry.accessory_data = @accessory_data.data
    _entry
  end
  
  # Reads all entries from binary files.
  def load_from_bins
    @weapon_data.load_from_bins
    @armor_data.load_from_bins
    @accessory_data.load_from_bins
    super
  end

end # class CharacterData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
