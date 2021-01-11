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

  # EOF mark
  EOF_MARK = -0x2

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a TecFile.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    @root        = _root
    @tasks       = []
    @enemy_ships = {}
    @magics      = {}
  end

  # Creates a task.
  # @param _id       [Integer] Task ID
  # @param _filename [String]  File name
  # @return [Entry] EnemyShipTask object
  def create_task(_id = -1, _filename = '*')
    _task             = EnemyShipTask.new(@root)
    _task.id          = _id
    _task.file        = File.basename(_filename)
    _task.enemy_ships = @enemy_ships
    _task.magics      = @magics
    _task
  end

  # Reads a TEC file.
  # @param _filename [String] File name
  def load(_filename)
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    CompressedFile.open(@root, _filename, 'rb') do |_f|
      _size = (_f.size - 0x4) / create_task.size
      (0..._size).each do |_id|
        LOG.info(sprintf(VOC.read, _id, _f.pos))
        _task = create_task(_id, _filename)
        _task.read_bin(_f)
        @tasks << _task
      end

      if _f.pos > _f.size - 0x4
        _msg = 'file size invalid (given %#x, expected %#x)'
        raise(IOError, sprintf(_msg, _f.pos + 0x4, _f.size))
      end
      
      _eof_check1 = _f.read_int(:i16)
      _eof_check2 = _f.read_int(:i16)
      
      if _eof_check1 != EOF_MARK or _eof_check2 != EOF_MARK
        raise(EOFError, 'EOF mark not found')
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes a TEC file.
  # @param _filename [String] File name
  def save(_filename)
    _basename = File.basename(_filename)
    _expired  = false
    _tasks    = @tasks.find_all do |_task|
      _result = (_task.file == _basename)
      if _result
        _expired ||= _task.expired
      end
      _result
    end
    if _tasks.empty?
      return
    end
    unless _expired
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    CompressedFile.open(@root, _filename, 'wb') do |_f|
      _last = nil
      (0..._tasks.size).each do |_id|
        LOG.info(sprintf(VOC.write, _id, _f.pos))
        _task = _tasks[_id]
        if _last && _task.id != _last.id + 1
          _msg = 'task ID invalid (given %s, expected %s)'
          raise(IOError, sprintf(_msg, _task.id, _last.id + 1))
        end
        _task.write_bin(_f)
        _last = _task
      end
      
      _f.write_int(EOF_MARK, :i16)
      _f.write_int(EOF_MARK, :i16)
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :root
  attr_accessor :tasks
  attr_accessor :enemy_ships
  attr_accessor :magics

end # class TecFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
