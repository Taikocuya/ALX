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
    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _last_id    = @id_range.begin
      _descriptor = find_descriptor(@ship_dscr_file, _filename)
      _msgtbl     = _descriptor.msgtbl
      
      _descriptor.each do |_range|
        _f.pos = _range.begin
        _split = (!_msgtbl || _range.end != _descriptor.end)
        
        (_last_id...@id_range.end).each do |_id|
          if _split && ( _f.eof? || !_descriptor.include?(_f.pos))
            _last_id = _id
            break
          end
          unless id_valid?(_id, @id_range, _descriptor)
            next
          end

          _entry = @data[_id]
          _msgid = _entry.msg_id

          if jp? || us?
            _lang = country_id
          elsif eu?
            _lang = find_lang(_filename)
          end
          _pos  = _entry.fetch(VOC.ship_dscr_pos[_lang])
          _size = _entry.fetch(VOC.ship_dscr_size[_lang])
          _dscr = _entry.fetch(VOC.ship_dscr_str[_lang])

          if _msgtbl
            _msg = @msg_table[_msgid]
            if _msg
              _pos.int  = _msg.pos
              _size.int = _msg.size
              _dscr.str = _msg.value
              next
            end
          end

          LOG.info(sprintf(VOC.read, _id - @id_range.begin, _f.pos))
          
          _pos.int = _f.pos
          if jp? || us?
            _dscr.str = _f.read_str(0xff, 0x4)
          else
            _dscr.str = _f.read_str(0xff, 0x1, 'Windows-1252')
          end
          _size.int = _f.pos - _pos.int

          if _msgtbl
            _msg                = Message.new
            _msg.pos            = _pos.int
            _msg.size           = _size.int
            _msg.value          = _dscr.str
            @msg_table[_msgid] = _msg
          end
        end
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all entries from binary files.
  def load_bin
    super

    each_descriptor(@ship_dscr_file) do |_d|
      load_ship_dscr_from_bin(glob(_d.name))
    end
  end

  # Writes all ship description entries to a binary file.
  # @param _filename [String] File name
  def save_bin_ship_dscr(_filename)
    if @data.empty?
      return
    end
    unless meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_dscr))
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_dscr))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@ship_dscr_file, _filename)
      @data.each do |_id, _entry|
        unless id_valid?(_id, @id_range, _descriptor)
          next
        end

        if jp? || us?
          _lang = country_id
        else
          _lang = find_lang(_filename)
        end
        if _lang
          _pos  = _entry[VOC.ship_dscr_pos[_lang]]
          _size = _entry[VOC.ship_dscr_size[_lang]]
          _dscr = _entry[VOC.ship_dscr_str[_lang]]
        else
          _pos  = -1
          _size = 0
        end
        
        _f.pos = _pos
        if !_descriptor.include?(_f.pos, _size) || !_entry.expired
          next
        end
        
        LOG.info(sprintf(VOC.write, _id - @id_range.begin, _pos))
        
        if jp? || us?
          _f.write_str(_dscr, _size, 0x4)
        else
          _f.write_str(_dscr, _size, 0x1, 'Windows-1252')
        end
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end
    
  # Writes all entries to binary files.
  def save_bin
    super

    each_descriptor(@ship_dscr_file) do |_d|
      save_bin_ship_dscr(glob(_d.name))
    end
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :ship_dscr_file

end # class CharacterMagicData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
