#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2022 Marcel Renner
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

require_relative('armordata.rb')
require_relative('accessorydata.rb')
require_relative('character.rb')
require_relative('weapondata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle characters from binary and/or CSV files.
class CharacterData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(Character, _depend)
    self.id_range  = sys(:character_id_range)
    self.data_file = sys(:character_data_files)
    self.csv_file  = join(SYS.character_csv_file)
    self.tpl_file  = File.join(SYS.build_dir, SYS.character_tpl_file)
    @boost_file    = sys(:character_boost_files)
    
    if depend
      @weapon_data    = WeaponData.new
      @armor_data     = ArmorData.new
      @accessory_data = AccessoryData.new
    end
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry             = super
    _entry.weapons     = @weapon_data&.data
    _entry.armors      = @armor_data&.data
    _entry.accessories = @accessory_data&.data
    _entry
  end
  
  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    @weapon_data&.load_bin
    @armor_data&.load_bin
    @accessory_data&.load_bin

    unless super
      return false
    end

    each_descriptor(@boost_file) do |_d|
      load_bin_boosts(glob(_d.name))
    end
  end

  # Writes all entries to binary files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_bin
    unless super
      return false
    end

    each_descriptor(@boost_file) do |_d|
      save_bin_boosts(glob(_d.name))
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :boost_file

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super
    cache.add_descriptor(:bin, @boost_file)
  end

  # Reads all character boost entries from a binary file.
  # @param _filename [String] File name
  def load_bin_boosts(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_boosts, _filename))

    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _last_id    = id_range.begin
      _descriptor = find_descriptor(@boost_file, _filename)
      
      _descriptor.each do |_range|
        _f.pos = _range.begin

        (_last_id...id_range.end).each do |_id|
          if _f.eof? || !_descriptor.include?(_f.pos)
            _last_id = _id
            break
          end
          unless id_valid?(_id, id_range, _descriptor)
            next
          end

          _entry                = data[_id]
          _entry[VOC.exp_boost] = _f.read_int(:u32)
        end
      end
    end
  end
  
  # Writes all character boost entries to a binary file.
  # @param _filename [String] File name
  def save_bin_boosts(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_boosts, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _real_id    = id_range.begin
      _descriptor = find_descriptor(@boost_file, _filename)
      data.each do |_id, _entry|
        unless id_valid?(_id, id_range, _descriptor)
          next
        end
        
        _f.pos = _descriptor.convert((_real_id - id_range.begin) * 0x4)
        if !_descriptor.include?(_f.pos)
          next
        end

        _boost = _entry[VOC.exp_boost]
        _f.write_int(_boost, :u32)
        
        _real_id += 1
      end
    end
  end
  
end # class CharacterData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
