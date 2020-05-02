#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2020 Marcel Renner
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

require_relative('charactermagic.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle character magics from binary and/or CSV files.
class CharacterMagicData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterMagicData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(CharacterMagic, _root)
    self.id_range   = sys(:character_magic_id_range)
    self.data_file  = sys(:character_magic_data_files)
    self.name_file  = sys(:character_magic_name_files)
    self.dscr_file  = sys(:character_magic_dscr_files)
    self.csv_file   = SYS.character_magic_csv_file
    self.tpl_file   = SYS.character_magic_tpl_file
    @ship_dscr_file = sys(:character_magic_ship_dscr_files)
  end

  # Reads all ship description entries from a binary file.
  # @param _filename [String] File name
  def load_ship_dscr_from_bin(_filename)
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_dscr))

    meta.check_mtime(_filename)
    BinaryFile.open(_filename, 'rb', endianness: root.endianness) do |_f|
      _range = determine_range(@ship_dscr_file, _filename)
      _f.pos = _range.begin
      
      id_range.each do |_id|
        unless id_valid?(_id, id_range, _range)
          next
        end

        _entry  = @data[_id]
        _msg_id = _entry.msg_id

        if jp? || us?
          _pos  = _entry.find_member(VOC.ship_dscr_pos[country_id] )
          _size = _entry.find_member(VOC.ship_dscr_size[country_id])
          _str  = _entry.find_member(VOC.ship_dscr_str[country_id] )
        elsif eu?
          _lang = determine_lang(_filename)
          _pos  = _entry.find_member(VOC.ship_dscr_pos[_lang] )
          _size = _entry.find_member(VOC.ship_dscr_size[_lang])
          _str  = _entry.find_member(VOC.ship_dscr_str[_lang] )
        end

        if _range.msg_table
          _msg = @msg_table[_msg_id]
          if _msg
            _pos.value  = _msg.pos
            _size.value = _msg.size
            _str.value  = _msg.value
            next
          end
        end

        unless pos_valid?(_f.pos, 1, _range)
          next
        end
        
        LOG.info(sprintf(VOC.read, _id - id_range.begin, _f.pos))
        _pos.value  = _f.pos
        if jp? || us?
          _str.value  = _f.read_str(0xff, 0x4)
        else
          _str.value  = _f.read_str(0xff, 0x1, 'Windows-1252')
        end
        _size.value = _f.pos - _pos.value

        if _range.msg_table
          _msg                = Message.new
          _msg.pos            = _pos.value
          _msg.size           = _size.value
          _msg.value          = _str.value
          @msg_table[_msg_id] = _msg
        end
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all entries from binary files.
  def load_all_from_bin
    super
  
    _ranges = @ship_dscr_file
    if _ranges
      unless _ranges.is_a?(Array)
        _ranges = [_ranges]
      end
      _ranges.each do |_range|
        load_ship_dscr_from_bin(glob(_range.name))
      end
    end
  end

  # Writes all ship description entries to a binary file.
  # @param _filename [String] File name
  def save_ship_dscr_to_bin(_filename)
    if @data.empty?
      return
    end
    unless meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_dscr))
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_dscr))
  
    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: root.endianness) do |_f|
      _range    = determine_range(@ship_dscr_file, _filename) 

      @data.each do |_id, _entry|
        unless id_valid?(_id, id_range, _range)
          next
        end

        if jp? || us?
          _pos  = _entry.find_member(VOC.ship_dscr_pos[country_id] ).value
          _size = _entry.find_member(VOC.ship_dscr_size[country_id]).value
          _str  = _entry.find_member(VOC.ship_dscr_str[country_id] ).value
        elsif eu?
          _lang = determine_lang(_filename)
          if _lang
            _pos  = _entry.find_member(VOC.ship_dscr_pos[_lang] ).value
            _size = _entry.find_member(VOC.ship_dscr_size[_lang]).value
            _str  = _entry.find_member(VOC.ship_dscr_str[_lang] ).value
          else
            _pos  = 0
            _size = 0
          end
        end
        
        _f.pos = _pos
        unless pos_valid?(_f.pos, _size, _range)
          next
        end
        unless _entry.expired
          LOG.info(sprintf(VOC.dup, _id - @id_range.begin, _pos))
          next
        end
        
        LOG.info(sprintf(VOC.write, _id, _pos))
        if jp? || us?
          _f.write_str(_str, _size, 0x4)
        else
          _f.write_str(_str, _size, 0x1, 'Windows-1252')
        end
      end
    end
  
    LOG.info(sprintf(VOC.close, _filename))
  end
    
  # Writes all entries to binary files.
  def save_all_to_bin
    super
  
    _ranges = @ship_dscr_file
    if _ranges
      unless _ranges.is_a?(Array)
        _ranges = [_ranges]
      end
      _ranges.each do |_range|
        save_ship_dscr_to_bin(glob(_range.name))
      end
    end
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :ship_dscr_file

end # class CharacterMagicData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
