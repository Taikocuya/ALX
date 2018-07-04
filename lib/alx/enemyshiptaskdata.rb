#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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

require('fileutils')
require_relative('charactermagicdata.rb')
require_relative('enemyshiptask.rb')
require_relative('entrytransform.rb')
require_relative('tecfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy ship tasks from binary and/or CSV files.
class EnemyShipTaskData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Path to TEC files with +%s+ as wildcard
  TEC_FILE = 'root/field/%s.tec'
  # Path to CSV file
  CSV_FILE = 'csv/enemyshiptasks.csv'
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemyShipTaskData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(EnemyShipTask, _root)
    @tec_file             = sprintf(TEC_FILE, '*')
    @csv_file             = CSV_FILE
    @character_magic_data = CharacterMagicData.new(_root)
    @data                 = []
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry        = super()
    _entry.id     = _id
    _entry.magics = @character_magic_data.data
    _entry
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_entries_from_bin(_filename)
    _file        = TecFile.new(region)
    _file.magics = @character_magic_data.data
    _file.load(_filename)
    @data.concat(_file.tasks)
  end

  # Reads all entries from binary files.
  def load_all_from_bin
    @character_magic_data.load_all_from_bin
    
    Dir.glob(File.join(root.path, @tec_file)).each do |_p|
      if File.file?(_p)
        load_entries_from_bin(_p)
      end
    end
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_entries_to_bin(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file       = TecFile.new(region)
    _file.tasks = @data
    _file.save(_filename)
  end

  # Writes all entries to binary files.
  def save_all_to_bin
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
      save_entries_to_bin(File.join(root.path, _dirname, _filename))
    end
  end

  # Reads all data entries from a a CSV file.
  # @param _filename [String] File name
  def load_entries_from_csv(_filename)
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_READ, STR_OPEN_DATA))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        puts(sprintf(STR_READ, [0, _f.lineno - 1].max, _f.pos))
        _entry = create_entry
        _entry.read_from_csv(_f)
        @data << _entry
      end
    end

    puts(sprintf(STR_CLOSE, _filename))
  end

  # Reads all entries from CSV files.
  def load_all_from_csv
    load_entries_from_csv(File.join(root.path, @csv_file))
  end

  # Writes all data entries to a CSV file.
  # @param _filename [String] File name
  def save_entries_to_csv(_filename)
    if @data.empty?
      return
    end
    
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_WRITE, STR_OPEN_DATA))

    _header = create_entry.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @data.each do |_entry|
        puts(sprintf(STR_WRITE, [0, _f.lineno - 1].max, _f.pos))
        _entry.write_to_csv(_f)
      end
    end
    
    puts(sprintf(STR_CLOSE, _filename))
  end

  # Writes all entries to CSV files.
  def save_all_to_csv
    save_entries_to_csv(File.join(root.path, @csv_file))
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :tec_file
  attr_accessor :csv_file
  attr_accessor :data

end # class EnemyShipTaskData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
