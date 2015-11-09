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

require_relative('accessorydata.rb')
require_relative('armordata.rb')
require_relative('enemyship.rb')
require_relative('entrytransform.rb')
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
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x2d

  # Offset ranges of data entries
  BIN_FILES_DATA = {
    'E' => DataRange.new(DOL_FILE, 0x2d3934...0x2d4e4c),
    'J' => DataRange.new(DOL_FILE, 0x2d3574...0x2d4a8c),
    'P' => DataRange.new(DOL_FILE, 0x2f6d14...0x2f7f5c),
  }

  # Offset ranges of name entries
  BIN_FILES_NAMES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1e635...0x1e809),
      DataRange.new(SOT_FILE_ES, 0x1e3a6...0x1e57b),
      DataRange.new(SOT_FILE_FR, 0x1e5f7...0x1e7cc),
      DataRange.new(SOT_FILE_GB, 0x1dc7e...0x1de53),
    ],
  }

  # Offset ranges of armament name entries
  ARM_BIN_FILES_NAMES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1ee0b...0x1f3e5),
      DataRange.new(SOT_FILE_ES, 0x1ec0e...0x1f1da),
      DataRange.new(SOT_FILE_FR, 0x1ee27...0x1f3f9),
      DataRange.new(SOT_FILE_GB, 0x1e473...0x1ea0d),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'enemyships.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemyShipData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(EnemyShip, _root)
    self.id_range        = ID_RANGE
    self.bin_files_data  = BIN_FILES_DATA
    self.bin_files_names = BIN_FILES_NAMES
    self.csv_file        = CSV_FILE
    @arm_bin_files_names = ARM_BIN_FILES_NAMES
    @accessory_data      = AccessoryData.new(_root)
    @armor_data          = ArmorData.new(_root)
    @ship_cannon_data    = ShipCannonData.new(_root)
    @ship_accessory_data = ShipAccessoryData.new(_root)
    @ship_item_data      = ShipItemData.new(_root)
    @special_item_data   = SpecialItemData.new(_root)
    @usable_item_data    = UsableItemData.new(_root)
    @weapon_data         = WeaponData.new(_root)
  end

  # Creates an entry.
  # @param _id [String] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry                = super
    _entry.item_data      = @accessory_data.data
    _entry.item_data.merge!(@armor_data.data)
    _entry.item_data.merge!(@ship_cannon_data.data)
    _entry.item_data.merge!(@ship_accessory_data.data)
    _entry.item_data.merge!(@ship_item_data.data)
    _entry.item_data.merge!(@special_item_data.data)
    _entry.item_data.merge!(@usable_item_data.data)
    _entry.item_data.merge!(@weapon_data.data)
    _entry
  end

  # Reads all armament name entries from a binary file.
  # @param _filename [String] File name
  def load_arm_name_from_bin(_filename)
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_READ, STR_OPEN_NAME))

    BinaryFile.open(_filename, 'rb') do |_f|
      _range = determine_range(@arm_bin_files_names[region], _filename)
      _f.pos = _range.begin
      
      @id_range.each do |_id|
        if _f.eof? || _f.pos < _range.begin || _f.pos >= _range.end
          break 
        end
        if _range.exclusion.include?(_id)
          next
        end

        _entry = @data[_id]

        (1..4).each do |_i|
          case determine_lang(_filename)
          when 'DE'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_DE_POS[_i] )
            _size = _entry.find_member(CsvHdr::ARM_NAME_DE_SIZE[_i])
            _str  = _entry.find_member(CsvHdr::ARM_NAME_DE_STR[_i] )
          when 'ES'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_ES_POS[_i] )
            _size = _entry.find_member(CsvHdr::ARM_NAME_ES_SIZE[_i])
            _str  = _entry.find_member(CsvHdr::ARM_NAME_ES_STR[_i] )
          when 'FR'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_FR_POS[_i] )
            _size = _entry.find_member(CsvHdr::ARM_NAME_FR_SIZE[_i])
            _str  = _entry.find_member(CsvHdr::ARM_NAME_FR_STR[_i] )
          when 'GB'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_GB_POS[_i] )
            _size = _entry.find_member(CsvHdr::ARM_NAME_GB_SIZE[_i])
            _str  = _entry.find_member(CsvHdr::ARM_NAME_GB_STR[_i] )
          end
          
          puts(sprintf(STR_READ, _id, _f.pos))
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

    puts(sprintf(STR_CLOSE, _filename))
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
    
    super
  
    _ranges = @arm_bin_files_names[region]
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
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_WRITE, STR_OPEN_NAME))
  
    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b') do |_f|
      _range = determine_range(@arm_bin_files_names[region], _filename) 
  
      @data.each do |_id, _entry|
        if _id < @id_range.begin && _id >= @id_range.end
          next
        end
        if _range.exclusion.include?(_id)
          next
        end

        (1..4).each do |_i|
          case determine_lang(_filename)
          when 'DE'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_DE_POS[_i] ).value
            _size = _entry.find_member(CsvHdr::ARM_NAME_DE_SIZE[_i]).value
            _str  = _entry.find_member(CsvHdr::ARM_NAME_DE_STR[_i] ).value
          when 'ES'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_ES_POS[_i] ).value
            _size = _entry.find_member(CsvHdr::ARM_NAME_ES_SIZE[_i]).value
            _str  = _entry.find_member(CsvHdr::ARM_NAME_ES_STR[_i] ).value
          when 'FR'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_FR_POS[_i] ).value
            _size = _entry.find_member(CsvHdr::ARM_NAME_FR_SIZE[_i]).value
            _str  = _entry.find_member(CsvHdr::ARM_NAME_FR_STR[_i] ).value
          when 'GB'
            _pos  = _entry.find_member(CsvHdr::ARM_NAME_GB_POS[_i] ).value
            _size = _entry.find_member(CsvHdr::ARM_NAME_GB_SIZE[_i]).value
            _str  = _entry.find_member(CsvHdr::ARM_NAME_GB_STR[_i] ).value
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
          
          puts(sprintf(STR_WRITE, _id, _pos))
          if region != 'P'
            _f.write_str(_str, _size, 0x4)
          else
            _f.write_str(_str, _size, 0x1, 'ISO8859-1')
          end
        end
      end
    end
  
    puts(sprintf(STR_CLOSE, _filename))
  end
    
  # Writes all entries to binary files.
  def save_all_to_bin
    super
  
    _ranges = @arm_bin_files_names[region]
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

  attr_accessor :arm_bin_files_names

end # class EnemyShipData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
