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

require_relative('accessorydata.rb')
require_relative('armordata.rb')
require_relative('enemyship.rb')
require_relative('shipaccessorydata.rb')
require_relative('shipcannondata.rb')
require_relative('shipitemdata.rb')
require_relative('specialitemdata.rb')
require_relative('usableitemdata.rb')
require_relative('weapondata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy ships from binary and/or CSV files.
class EnemyShipData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemyShipData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(EnemyShip, _root)
    self.id_range        = SYS.enemy_ship_id_range
    self.data_files      = SYS.enemy_ship_data_files
    self.name_files      = SYS.enemy_ship_name_files
    self.csv_file        = SYS.enemy_ship_csv_file
    self.tpl_file        = SYS.enemy_ship_tpl_file
    @arm_name_files      = SYS.enemy_ship_arm_name_files
    
    @accessory_data      = AccessoryData.new(_root)
    @armor_data          = ArmorData.new(_root)
    @ship_accessory_data = ShipAccessoryData.new(_root)
    @ship_cannon_data    = ShipCannonData.new(_root)
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

  # Reads all armament name entries from a binary file.
  # @param _filename [String] File name
  def load_arm_name_from_bin(_filename)
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_name))

    BinaryFile.open(_filename, 'rb') do |_f|
      _range = determine_range(@arm_name_files[region], _filename)
      _f.pos = _range.begin
      
      @id_range.each do |_id|
        if _f.eof? || _f.pos < _range.begin || _f.pos >= _range.end
          break 
        end
        if _range.exclusions.include?(_id)
          next
        end

        _entry = @data[_id]

        (0...4).each do |_i|
          case determine_lang(_filename)
          when 'DE'
            _pos  = _entry.find_member(VOC.arm_name_de_pos[_i] )
            _size = _entry.find_member(VOC.arm_name_de_size[_i])
            _str  = _entry.find_member(VOC.arm_name_de_str[_i] )
          when 'ES'
            _pos  = _entry.find_member(VOC.arm_name_es_pos[_i] )
            _size = _entry.find_member(VOC.arm_name_es_size[_i])
            _str  = _entry.find_member(VOC.arm_name_es_str[_i] )
          when 'FR'
            _pos  = _entry.find_member(VOC.arm_name_fr_pos[_i] )
            _size = _entry.find_member(VOC.arm_name_fr_size[_i])
            _str  = _entry.find_member(VOC.arm_name_fr_str[_i] )
          when 'GB'
            _pos  = _entry.find_member(VOC.arm_name_gb_pos[_i] )
            _size = _entry.find_member(VOC.arm_name_gb_size[_i])
            _str  = _entry.find_member(VOC.arm_name_gb_str[_i] )
          end
          
          puts(sprintf(VOC.read, _id, _f.pos))
          _pos.value  = _f.pos
          if region != 'P'
            _str.value  = _f.read_str(0xff, 0x4)
          else
            _str.value  = _f.read_str(0xff, 0x1, 'ISO8859-1')
          end
          _size.value = _f.pos - _pos.value
        end
      end
    end

    puts(sprintf(VOC.close, _filename))
  end

  # Reads all entries from binary files.
  def load_all_from_bin
    @accessory_data.load_all_from_bin
    @armor_data.load_all_from_bin
    @ship_accessory_data.load_all_from_bin
    @ship_cannon_data.load_all_from_bin
    @ship_item_data.load_all_from_bin
    @special_item_data.load_all_from_bin
    @usable_item_data.load_all_from_bin
    @weapon_data.load_all_from_bin
    
    @items.merge!(@accessory_data.data)
    @items.merge!(@armor_data.data)
    @items.merge!(@ship_accessory_data.data)
    @items.merge!(@ship_cannon_data.data)
    @items.merge!(@ship_item_data.data)
    @items.merge!(@special_item_data.data)
    @items.merge!(@usable_item_data.data)
    @items.merge!(@weapon_data.data)
    
    super
  
    _ranges = @arm_name_files[region]
    if _ranges
      unless _ranges.is_a?(Array)
        _ranges = [_ranges]
      end
      _ranges.each do |_range|
        load_arm_name_from_bin(File.join(root.path, _range.name))
      end
    end
  end
  
  # Writes all armament name entries to a binary file.
  # @param _filename [String] File name
  def save_arm_name_to_bin(_filename)
    if @data.empty?
      return
    end
    
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_name))
  
    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b') do |_f|
      _range = determine_range(@arm_name_files[region], _filename) 
  
      @data.each do |_id, _entry|
        if _id < @id_range.begin && _id >= @id_range.end
          next
        end
        if _range.exclusions.include?(_id)
          next
        end

        (0...4).each do |_i|
          case determine_lang(_filename)
          when 'DE'
            _pos  = _entry.find_member(VOC.arm_name_de_pos[_i] ).value
            _size = _entry.find_member(VOC.arm_name_de_size[_i]).value
            _str  = _entry.find_member(VOC.arm_name_de_str[_i] ).value
          when 'ES'
            _pos  = _entry.find_member(VOC.arm_name_es_pos[_i] ).value
            _size = _entry.find_member(VOC.arm_name_es_size[_i]).value
            _str  = _entry.find_member(VOC.arm_name_es_str[_i] ).value
          when 'FR'
            _pos  = _entry.find_member(VOC.arm_name_fr_pos[_i] ).value
            _size = _entry.find_member(VOC.arm_name_fr_size[_i]).value
            _str  = _entry.find_member(VOC.arm_name_fr_str[_i] ).value
          when 'GB'
            _pos  = _entry.find_member(VOC.arm_name_gb_pos[_i] ).value
            _size = _entry.find_member(VOC.arm_name_gb_size[_i]).value
            _str  = _entry.find_member(VOC.arm_name_gb_str[_i] ).value
          else
            _pos  = 0
            _size = 0
          end
          if _pos <= 0 || _size <= 0
            next
          end
          
          _f.pos = _pos
          if _f.eof? || _f.pos < _range.begin || _f.pos + _size > _range.end
            next
          end
          
          puts(sprintf(VOC.write, _id, _pos))
          if region != 'P'
            _f.write_str(_str, _size, 0x4)
          else
            _f.write_str(_str, _size, 0x1, 'ISO8859-1')
          end
        end
      end
    end
  
    puts(sprintf(VOC.close, _filename))
  end
    
  # Writes all entries to binary files.
  def save_all_to_bin
    super
  
    _ranges = @arm_name_files[region]
    if _ranges
      unless _ranges.is_a?(Array)
        _ranges = [_ranges]
      end
      _ranges.each do |_range|
        save_arm_name_to_bin(File.join(root.path, _range.name))
      end
    end
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :arm_name_files

end # class EnemyShipData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
