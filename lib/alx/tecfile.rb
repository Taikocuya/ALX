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

require_relative('aklzfile.rb')
require_relative('enemyshiptask.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write TEC files.
class TecFile
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # EOF marker
  EOF_MARKER = -0x2

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a TecFile.
  # @param _region [String] Region ID
  def initialize(_region)
    @region      = _region
    @tasks       = []
    @enemy_ships = {}
    @magics      = {}
  end

  # Creates a task.
  # @param _id       [Integer] Task ID
  # @param _filename [String]  File name
  # @return [Entry] EnemyShipTask object
  def create_task(_id = -1, _filename = '*')
    _task             = EnemyShipTask.new(@region)
    _task.id          = _id
    _task.file        = File.basename(_filename)
    _task.enemy_ships = @enemy_ships
    _task.magics      = @magics
    _task
  end

  # Reads a TEC file.
  # @param _filename [String] File name
  def load(_filename)
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    AklzFile.open(_filename, 'rb') do |_f|
      _size = (_f.size - 0x4) / create_task.size
      (0..._size).each do |_id|
        puts(sprintf(VOC.read, _id, _f.pos))
        _task = create_task(_id, _filename)
        _task.read_from_bin(_f)
        @tasks << _task
      end

      if _f.pos > _f.size - 0x4
        _str = 'file size invalid (given %s, expected %s)'
        raise(IOError, sprintf(_str, _f.pos + 0x4, _f.size))
      end
      
      _eofCheck1 = _f.read_int('s>')
      _eofCheck2 = _f.read_int('s>')
      
      if _eofCheck1 != EOF_MARKER or _eofCheck2 != EOF_MARKER
        raise(EOFError, 'EOF marker not found')
      end
    end
    
    puts(sprintf(VOC.close, _filename))
  end

  # Writes a TEC file.
  # @param _filename [String] File name
  def save(_filename)
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    AklzFile.open(_filename, 'wb') do |_f|
      _tasks = @tasks.select do |_task|
        _task.file == File.basename(_filename)
      end

      (0..._tasks.size).each do |_id|
        puts(sprintf(VOC.write, _id, _f.pos))
        _task = _tasks[_id]
        _task.write_to_bin(_f)
      end
      
      _f.write_int(EOF_MARKER, 's>')
      _f.write_int(EOF_MARKER, 's>')
    end

    puts(sprintf(VOC.close, _filename))
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :region
  attr_accessor :tasks
  attr_accessor :enemy_ships
  attr_accessor :magics

end # class TecFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
