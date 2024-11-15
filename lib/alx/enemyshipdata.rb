#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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

  # Constructs an EnemyShipData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(EnemyShip, _depend)
    self.id_range  = dscrptr(:enemy_ship_id_range)
    self.data_file = dscrptr(:enemy_ship_data_files)
    self.name_file = dscrptr(:enemy_ship_name_files)
    self.csv_file  = join(CFG.enemy_ship_csv_file)
    self.tpl_file  = File.join(CFG.build_dir, CFG.enemy_ship_tpl_file)
    @arm_name_file = dscrptr(:enemy_ship_arm_name_files)
        
    if depend
      @accessory_data      = AccessoryData.new
      @armor_data          = ArmorData.new
      @ship_accessory_data = ShipAccessoryData.new
      @ship_cannon_data    = ShipCannonData.new
      @ship_item_data      = ShipItemData.new
      @special_item_data   = SpecialItemData.new
      @usable_item_data    = UsableItemData.new
      @weapon_data         = WeaponData.new
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
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
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

    unless super
      return false
    end

    each_descriptor(@arm_name_file) do |_d|
      load_arm_name_from_bin(glob(_d.name))
    end
  end
  
  # Writes all entries to binary files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_bin
    unless super
      return false
    end
  
    each_descriptor(@arm_name_file) do |_d|
      save_bin_arm_name(glob(_d.name))
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :arm_name_file

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super
    cache.add_descriptor(:bin, @arm_name_file)
  end

  # Reads all armament name entries from a binary file.
  # @param _filename [String] File name
  def load_arm_name_from_bin(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_name, _filename))

    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _last_id    = @id_range.begin
      _descriptor = find_descriptor(@arm_name_file, _filename)

      _descriptor.each do |_range|
        _f.pos = _range.begin
        
        (_last_id...@id_range.end).each do |_id|
          if  _f.eof? || !_descriptor.include?(_f.pos)
            _last_id = _id
            break
          end
          unless id_valid?(_id, @id_range, _descriptor)
            next
          end

          _entry = @data[_id]

          (1..4).each do |_i|
            _lang = find_lang(_filename)
            _pos  = _entry.fetch(VOC.arm_name_pos(_i, _lang) )
            _size = _entry.fetch(VOC.arm_name_size(_i, _lang))
            _name = _entry.fetch(VOC.arm_name_str(_i, _lang) )

            _pos.int  = _f.pos
            _name.str = _f.read_str(blocks: 0x1, enc: 'Windows-1252')
            _size.int = _f.pos - _pos.int
          end
        end
      end
    end
  end

  # Writes all armament name entries to a binary file.
  # @param _filename [String] File name
  def save_bin_arm_name(_filename)
    if @data.empty?
      return
    end

    LOG.info(sprintf(VOC.save, VOC.open_name, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@arm_name_file, _filename)
      @data.each do |_id, _entry|
        unless id_valid?(_id, @id_range, _descriptor)
          next
        end
        
        (1..4).each do |_i|
          _lang = find_lang(_filename)
          if _lang
            _pos  = _entry[VOC.arm_name_pos(_i, _lang) ]
            _size = _entry[VOC.arm_name_size(_i, _lang)]
            _name = _entry[VOC.arm_name_str(_i, _lang) ]
          else
            _pos  = -1
            _size = 0
          end

          _f.pos = _pos
          if !_descriptor.include?(_f.pos, _size - 1)
            next
          end

          _f.write_str(_name, length: _size, blocks: 0x1, enc: 'Windows-1252')
        end
      end
    end
  end

end # class EnemyShipData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
