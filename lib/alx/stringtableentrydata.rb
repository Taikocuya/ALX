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

require_relative('entrydata.rb')
require_relative('sotfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle string table entries from binary and/or CSV files.
class StringTableEntryData < EntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an StringTableEntryData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(StringTableEntry, _depend)
    @csv_file = join(CFG.string_table_entry_csv_file)
    @data     = {}
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

    sot_files.each do |_p|
      load_bin_data(_p)
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

    _dirname = File.dirname(join(:sot_file))
    _first_table = @data.first[1]
    _first_entry = _first_table[0]
    _first_entry.header.each do |_filename|
       if _filename == VOC.id || _filename == VOC.name_str(nil)
         next
       end
       
       save_bin_data(File.join(_dirname, _filename))
    end
    save_cache

    true
  end

  # Reads all entries from CSV files.
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

  attr_accessor :csv_file
  attr_accessor :data

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super

    sot_files.each do |_p|
      cache.add_descriptor(:bin, _p)
    end

    cache.add_descriptor(:csv, @csv_file)
  end

  # Initializes the cache storage.
  def init_cache_storage
    super
    cache.add_storage(:@data, @data)
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    _file      = SotFile.new
    _file.data = @data
    _file.load(_filename)
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file      = SotFile.new
    _file.data = @data
    _file.save(_filename)
  end

  # Reads all data entries from a CSV file.
  # @param _filename [String] File name
  def load_csv_data(_filename)
    unless @data.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        _entry = create_entry
        _entry.read_csv(_f)
        _table = @data[_entry.table_name] ||= []
        _table << _entry
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
      @data.each_value do |_table|
        _table.each do |_entry|
          _entry.write_csv(_f)
        end
      end
    end
  end

end # class StringTableEntryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
