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
  def initialize
    super(DefinedString)
    @data_file = sys(:defined_string_data_files)
    @csv_file  = join(SYS.defined_string_csv_file)
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

  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    unless @data.empty?
      return false
    end

    load_cache
    if cache.valid? && !SYS.defined_string_use_dictionary
      return false
    end

    each_descriptor(@data_file) do |_d|
      load_bin_data(glob(_d.name))
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
    save_cache
    
    true
  end

  # Reads all entries from CSV files (TPL files first, CSV files last).
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_csv
    load_cache
    if cache.valid?
      return false
    end
    
    load_csv_data(@csv_file)
    
    true
  end

  # Writes all entries to CSV files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_csv
    if @data.empty?
      return false
    end
    if cache.valid? && !SYS.defined_string_use_dictionary
      return false
    end
    
    save_csv_data(@csv_file)
    save_cache
    
    true
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :data_file
  attr_accessor :csv_file
  attr_accessor :data

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super
    
    cache.add_descriptor(:bin, @data_file)
    cache.add_descriptor(:csv, @csv_file )
  end

  # Initializes the cache storage.
  def init_cache_storage
    super
    cache.add_storage(:@data, @data)
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    _descriptor = find_descriptor(@data_file, _filename)
    _detect     = DefinedStringDetector.new
    if SYS.defined_string_use_dictionary
      _detect.load_dictionary(_descriptor)
    end
    
    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _descriptor.each do |_range|
        _f.pos        = _range.begin
        _detect.range = _range
        
        (@data.size..).each do |_id|
          if _f.eof? || !_descriptor.include?(_f.pos)
            break
          end

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
            _entry[VOC.string_filter] = _detect.substitution
          end
          
          @data << _entry
        end
      end
    end

    if SYS.defined_string_use_dictionary
      _detect.save_dictionary
    end
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@data_file, _filename)
      @data.each_with_index do |_entry, _id|
        _pos      = _entry[VOC.string_pos     ]
        _size     = _entry[VOC.string_size    ]
        _encoding = _entry[VOC.string_encoding]
        _str      = _entry[VOC.string_value   ]
        
        _f.pos = _pos
        if !_descriptor.include?(_f.pos, _size)
          next
        end
        
        _f.write_str(
          _str, length: _size, blocks: 0x1, enc: _encoding, tr: false
        )
      end
    end
  end

  # Reads all data entries from a CSV file.
  # @param _filename [String]  File name
  def load_csv_data(_filename)
    unless @data.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        _entry = create_entry
        _entry.read_csv(_f)
        @data << _entry
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
      @data.each do |_entry|
        _entry.write_csv(_f)
      end
    end
  end

end # class DefinedStringData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
