#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

require_relative('charactermagic.rb')
require_relative('enemydata.rb')

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
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(CharacterMagic, _depend)
    self.id_range   = dscrptr(:character_magic_id_range)
    self.data_file  = dscrptr(:character_magic_data_files)
    self.dscr_file  = dscrptr(:character_magic_dscr_files)
    self.csv_file   = join(CFG.character_magic_csv_file)
    self.tpl_file   = File.join(CFG.build_dir, CFG.character_magic_tpl_file)
    @ship_dscr_file = dscrptr(:character_magic_ship_dscr_files)
  end

  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    unless super
      return false
    end

    each_descriptor(@ship_dscr_file) do |_d|
      load_bin_ship_dscr(glob(_d.name))
    end
  end

  # Writes all entries to binary files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_bin
    unless super
      return false
    end

    each_descriptor(@ship_dscr_file) do |_d|
      save_bin_ship_dscr(glob(_d.name))
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :ship_dscr_file

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super
    cache.add_descriptor(:bin, @ship_dscr_file)
  end

  # Reads all ship description entries from a binary file.
  # @param _filename [String] File name
  def load_bin_ship_dscr(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_dscr, _filename))

    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _last_id    = @id_range.begin
      _descriptor = find_descriptor(@ship_dscr_file, _filename)
      _msgt       = _descriptor.msgt
      
      _descriptor.each do |_range|
        _f.pos = _range.begin
        _split = (!_msgt || _range.end != _descriptor.end)
        
        (_last_id...@id_range.end).each do |_id|
          if _split && ( _f.eof? || !_descriptor.include?(_f.pos))
            _last_id = _id
            break
          end
          unless id_valid?(_id, @id_range, _descriptor)
            next
          end

          _entry = @data[_id]
          _msgid = _entry.sot_pos
          _pos   = _entry.fetch(VOC.ship_dscr_pos(cid))
          _size  = _entry.fetch(VOC.ship_dscr_size(cid))
          _dscr  = _entry.fetch(VOC.ship_dscr_str(cid))

          if _msgt
            _msg = @msg_table[_msgid]
            if _msg
              _pos.int  = _msg.pos
              _size.int = _msg.size
              _dscr.str = _msg.value
              next
            end
          end

          _pos.int = _f.pos
          if jp? || us?
            _dscr.str = _f.read_str(blocks: 0x4)
          else
            _dscr.str = _f.read_str(blocks: 0x1, enc: 'Windows-1252')
          end
          _size.int = _f.pos - _pos.int

          if _msgt
            _msg                = Message.new
            _msg.pos            = _pos.int
            _msg.size           = _size.int
            _msg.value          = _dscr.str
            @msg_table[_msgid] = _msg
          end
        end
      end
    end
  end

  # Writes all ship description entries to a binary file.
  # @param _filename [String] File name
  def save_bin_ship_dscr(_filename)
    if @data.empty?
      return
    end

    LOG.info(sprintf(VOC.save, VOC.open_dscr, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@ship_dscr_file, _filename)
      @data.each do |_id, _entry|
        unless id_valid?(_id, @id_range, _descriptor)
          next
        end

        _pos  = _entry[VOC.ship_dscr_pos(cid)]
        _size = _entry[VOC.ship_dscr_size(cid)]
        _dscr = _entry[VOC.ship_dscr_str(cid)]

        _f.pos = _pos
        if !_descriptor.include?(_f.pos, _size)
          next
        end

        if jp? || us?
          _f.write_str(_dscr, length: _size, blocks: 0x4)
        else
          _f.write_str(_dscr, length: _size, blocks: 0x1, enc: 'Windows-1252')
        end
      end
    end
  end

end # class CharacterMagicData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
