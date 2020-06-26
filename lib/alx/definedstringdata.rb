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

require_relative('entrydata.rb')
require_relative('definedstring.rb')
require_relative('definedstringdetector.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle defined strings from binary and/or CSV files.
class DefinedStringData < EntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a DefinedStringData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(DefinedString, _root)
    @data_file = sys(:defined_string_data_files)
    @csv_file  = SYS.defined_string_csv_file
    @data      = []
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry    = super()
    _entry.id = _id
    _entry
  end
  
  # Reads all snaphots (instance variables) from SHT files.
  def load_sht
    super
    load_sht_data(:data)
  end
  
  # Writes all snaphots (instance variables) to SHT files.
  def save_sht
    super
    save_sht_data(:data, @data)
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    _detect = DefinedStringDetector.new(root)
    if SYS.defined_string_cache
      _detect.load_cache
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.check_mtime(_filename)
    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@data_file, _filename)
      _descriptor.each do |_range|
        _f.pos        = _range.begin
        _detect.range = _range
        
        (@data.size..).each do |_id|
          if _f.eof? || !_descriptor.include?(_f.pos)
            break
          end

          LOG.info(sprintf(VOC.search, _id, _f.pos))

          _detect.clear
          while !_f.eof? && _descriptor.include?(_f.pos)
            if _detect.detect(_f)
              break
            end
          end
          unless _detect.valid?
            next
          end

          _entry = create_entry(_id)
          _entry[VOC.string_pos     ] = _detect.pos
          _entry[VOC.string_size    ] = _detect.size + 1
          _entry[VOC.string_encoding] = _detect.encoding
          _entry[VOC.string_value   ] = _detect.string
          _entry[VOC.string_data    ] = _detect.dump
          
          if SYS.defined_string_append_filter
            _entry[VOC.string_filter] = _detect.substitute
          end
          
          @data << _entry
        end
      end
    end

    LOG.info(sprintf(VOC.close, _filename))

    if SYS.defined_string_cache
      _detect.save_cache
    end
  end

  # Reads all entries from binary files.
  def load_bin
    unless @data.empty?
      return
    end

    each_descriptor(@data_file) do |_d|
      load_bin_data(glob(_d.name))
    end
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    if @data.empty?
      return
    end
    unless meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@data_file, _filename)
      @data.each_with_index do |_entry, _id|
        _pos      = _entry[VOC.string_pos     ]
        _size     = _entry[VOC.string_size    ]
        _encoding = _entry[VOC.string_encoding]
        _str      = _entry[VOC.string_value   ]
        
        _f.pos = _pos
        unless _descriptor.include?(_f.pos, _size)
          next
        end
        if !_entry.expired || _encoding == 'ASCII-8BIT'
          LOG.info(sprintf(VOC.dup, _id, _pos))
          next
        end
        
        LOG.info(sprintf(VOC.write, _id, _pos))
        _f.write_str(_str, _size, 0x1, _encoding)
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all entries to binary files.
  def save_bin
    if @data.empty?
      return
    end

    each_descriptor(@data_file) do |_d|
      save_bin_data(glob(_d.name))
    end
  end

  # Reads all data entries from a CSV file.
  # @param _filename [String]  File name
  def load_csv_data(_filename)
    unless @data.empty?
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.check_mtime(_filename)
    CSV.open(_filename, headers: true) do |_f|
      _snapshot = snaps[:data].dup

      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _entry = create_entry
        _entry.read_csv(_f)

        if _snapshot
          _result = false
          _snapshot.reject! do |_sht|
            if _result
              break
            end
            _result = _entry.check_expiration(_sht)
          end
        else
          _entry.expired = true
        end
        
        @data << _entry
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all entries from CSV files (TPL files first, CSV files last).
  def load_csv
    load_csv_data(File.join(root.dirname, @csv_file))
  end

  # Writes all data entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_data(_filename)
    if @data.empty?
      return
    end
    if File.exist?(_filename) && !meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))
  
    _header = create_entry.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @data.each do |_entry|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _entry.write_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all entries to CSV files.
  def save_csv
    save_csv_data(glob(@csv_file))
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :data_file
  attr_accessor :csv_file
  attr_accessor :data

end # class DefinedStringData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
