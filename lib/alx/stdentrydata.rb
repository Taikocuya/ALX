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

require_relative('binaryfile.rb')
require_relative('entrydata.rb')
require_relative('message.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle standard entries from binary and/or CSV files.
class StdEntryData < EntryData
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a StdEntryData.
  # @param _class  [Entry]   Entry object
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_class, _depend = true)
    super
    @id_range  = ALX.rng(0x0..)
    @data_file = nil
    @name_file = nil
    @dscr_file = nil
    @msg_table = {}
    @csv_file  = ''
    @tpl_file  = ''
    @data      = Hash.new do |_h, _k|
      _h[_k] = create_entry(_k)
    end
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry    = super()
    _entry.id = _id
    _entry
  end

  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    unless @data.empty?
      return false
    end

    load_cache
    if cache.valid?
      return false
    end
    
    each_descriptor(@data_file) do |_d|
      load_bin_data(glob(_d.name))
    end
    each_descriptor(@name_file) do |_d|
      load_bin_names(glob(_d.name))
    end
    each_descriptor(@dscr_file) do |_d|
      load_bin_dscr(glob(_d.name))
    end
    
    true
  end

  # Writes all entries to binary files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_bin
    if @data.empty?
      return false
    end
    if cache.valid?
      return false
    end

    each_descriptor(@data_file) do |_d|
      save_bin_data(glob(_d.name))
    end
    each_descriptor(@name_file) do |_d|
      save_bin_name(glob(_d.name))
    end
    each_descriptor(@dscr_file) do |_d|
      save_bin_dscr(glob(_d.name))
    end
    save_cache
    
    true
  end

  # Reads all entries from CSV files (CSV files first, TPL files last).
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_csv
    load_cache
    if cache.valid?
      return false
    end
    
    load_csv_data(@csv_file)
    load_csv_data(@tpl_file, true)
    
    true
  end

  # Writes all entries to CSV files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_csv
    if @data.empty?
      return false
    end
    if cache.valid?
      return false
    end
    
    save_csv_data(@csv_file)
    save_cache
    
    true
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :id_range
  attr_accessor :data_file
  attr_accessor :name_file
  attr_accessor :dscr_file
  attr_accessor :msg_table
  attr_accessor :csv_file
  attr_accessor :tpl_file
  attr_accessor :data

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super
    cache.add_descriptor(:bin, @data_file)
    cache.add_descriptor(:bin, @name_file)
    cache.add_descriptor(:bin, @dscr_file)
    cache.add_descriptor(:csv, @csv_file )
    cache.add_descriptor(:csv, @tpl_file )
  end

  # Initializes the cache storage.
  def init_cache_storage
    super
    cache.add_storage(:@data, @data)
  end

  # Reads all data entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_data, _filename))

    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _size       = create_entry.size
      _last_id    = @id_range.begin
      _descriptor = find_descriptor(@data_file, _filename)
      _descriptor.each do |_range|
        _f.pos = _range.begin
        
        (_last_id...@id_range.end).each do |_id|
          if _f.eof? || !_descriptor.include?(_f.pos, _size)
            _last_id = _id
            break
          end
          unless id_valid?(_id, @id_range, _descriptor)
            next
          end

          _entry = @data[_id]
          _entry.read_bin(_f)
        end
      end
    end
  end
    
  # Reads all name entries from a binary file.
  # @param _filename [String] File name
  def load_bin_names(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_name, _filename))

    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _last_id    = @id_range.begin
      _descriptor = find_descriptor(@name_file, _filename)
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
          _msgid = _entry.msg_id

          if jp? || us?
            _lang = country_id
          else
            _lang = find_lang(_filename)
          end
          _pos  = _entry.fetch(VOC.name_pos(_lang))
          _size = _entry.fetch(VOC.name_size(_lang))
          _name = _entry.fetch(VOC.name_str(_lang))
      
          if _msgt
            _msg = @msg_table[_msgid]
            if _msg
              _pos.int  = _msg.pos
              _size.int = _msg.size
              _name.str = _msg.value
              next
            end
          end

          _pos.int  = _f.pos
          _name.str = _f.read_str(blocks: 0x1, enc: 'Windows-1252')
          _size.int = _f.pos - _pos.int

          if _msgt
            _msg               = Message.new
            _msg.pos           = _pos.int
            _msg.size          = _size.int
            _msg.value         = _name.str
            @msg_table[_msgid] = _msg
          end
        end
      end
    end
  end
  
  # Reads all description entries from a binary file.
  # @param _filename [String] File name
  def load_bin_dscr(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_dscr, _filename))

    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _last_id    = @id_range.begin
      _descriptor = find_descriptor(@dscr_file, _filename)
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
          _msgid = _entry.msg_id

          if jp? || us?
            _lang = country_id
          elsif eu?
            _lang = find_lang(_filename)
          end
          _pos  = _entry.fetch(VOC.dscr_pos(_lang))
          _size = _entry.fetch(VOC.dscr_size(_lang))
          _dscr = _entry.fetch(VOC.dscr_str(_lang))
          
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
            _msg               = Message.new
            _msg.pos           = _pos.int
            _msg.size          = _size.int
            _msg.value         = _dscr.str
            @msg_table[_msgid] = _msg
          end
        end
      end
    end
  end

  # Writes all data entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_data, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _size       = create_entry.size
      _descriptor = find_descriptor(@data_file, _filename)
      @data.each do |_id, _entry|
        _f.pos = _descriptor.convert((_id - @id_range.begin) * _size)
        if !_descriptor.include?(_f.pos, _size)    || 
           !id_valid?(_id, @id_range, _descriptor)
          next
        end

        _entry.write_bin(_f)
      end
    end
  end
    
  # Writes all name entries to a binary file.
  # @param _filename [String] File name
  def save_bin_name(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_name, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@name_file, _filename)
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
          _pos  = _entry[VOC.name_pos(_lang)]
          _size = _entry[VOC.name_size(_lang)]
          _name = _entry[VOC.name_str(_lang)]
        else
          _pos  = -1
          _size = 0
        end
        
        _f.pos = _pos
        if !_descriptor.include?(_f.pos, _size)
          next
        end

        _f.write_str(_name, length: _size, blocks: 0x1, enc: 'Windows-1252')
      end
    end
  end
  
  # Writes all description entries to a binary file.
  # @param _filename [String] File name
  def save_bin_dscr(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_dscr, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@dscr_file, _filename)
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
          _pos  = _entry[VOC.dscr_pos(_lang)]
          _size = _entry[VOC.dscr_size(_lang)]
          _dscr = _entry[VOC.dscr_str(_lang)]
        else
          _pos  = -1
          _size = 0
        end
        
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

  # Reads all data entries from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skips missing file and ignore missing 
  #                            properties.
  def load_csv_data(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
  
    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        _row   = _f.shift
        _entry = create_entry
        _entry.read_csv(_row, _force)
        _exist = @data.has_key?(_entry.id) 

        if _force && _exist
          _entry = @data[_entry.id]
          _entry.read_csv(_row, _force)
        else
          @data[_entry.id] = _entry
        end
      end
    end
  end

  # Writes all data entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_data(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    _header = create_entry.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @data.each do |_id, _entry|
        _entry.write_csv(_f)
      end
    end
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Finds the PAL-E language for the given file name.
  # @param _filename [String] File name
  # @return [String] PAL-E language
  def find_lang(_filename)
    return de if _filename.include?(glob(:sot_file_de))
    return es if _filename.include?(glob(:sot_file_es))
    return fr if _filename.include?(glob(:sot_file_fr))
    return gb if _filename.include?(glob(:sot_file_gb))
    nil
  end
  
end # class StdEntryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
