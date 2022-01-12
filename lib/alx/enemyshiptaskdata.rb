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

require_relative('charactermagicdata.rb')
require_relative('enemyshipdata.rb')
require_relative('enemyshiptask.rb')
require_relative('tecfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy ship tasks from binary and/or CSV files.
class EnemyShipTaskData < EntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyShipTaskData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(EnemyShipTask, _depend)
    @tec_file = sys(:tec_file)
    @csv_file = join(SYS.enemy_ship_task_csv_file)
    @tpl_file = File.join(SYS.build_dir, SYS.enemy_ship_task_tpl_file)
    
    if depend
      @character_magic_data = CharacterMagicData.new
      @enemy_ship_data      = EnemyShipData.new
    end
    
    @data = []
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry             = super()
    _entry.id          = _id
    _entry.magics      = @character_magic_data&.data
    _entry.enemy_ships = @enemy_ship_data&.data
    _entry
  end

  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    unless @data.empty?
      return false
    end

    @character_magic_data&.load_bin
    @enemy_ship_data&.load_bin
    
    load_cache
    if cache.valid?
      return false
    end
    
    glob(@tec_file) do |_p|
      if File.file?(_p)
        load_bin_data(_p)
      end
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
    
    _files = []
    @data.each do |_entry|
      _filename = _entry.file
      unless _files.include?(_filename)
        _files << _filename
      end
    end
    _files.sort!

    _dirname = File.dirname(@tec_file)
    _files.each do |_filename|
      save_bin_data(glob(_dirname, _filename))
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

    load_csv_data(@tpl_file, true)
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

  attr_accessor :tec_file
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

    glob(@tec_file) do |_p|
      if File.file?(_p)
        cache.add_descriptor(:bin, _p)
      end
    end

    cache.add_descriptor(:csv, @csv_file)
    cache.add_descriptor(:csv, @tpl_file)
  end

  # Initializes the cache storage.
  def init_cache_storage
    super
    cache.add_storage(:@data, @data)
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    _file             = TecFile.new
    _file.magics      = @character_magic_data&.data
    _file.enemy_ships = @enemy_ship_data&.data
    _file.load(_filename)
    @data.concat(_file.tasks)
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file       = TecFile.new
    _file.tasks = @data
    _file.save(_filename)
  end

  # Reads all data entries from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_data(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @data.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      _cache = cache.data
      while !_f.eof?
        _entry = create_entry
        _entry.read_csv(_f)

        unless _cache.include?(_entry)
          _entry.modified = true
        end
        
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

end # class EnemyShipTaskData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
