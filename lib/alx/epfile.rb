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

require_relative('enemy.rb')
require_relative('enemytask.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write EP files.
class EpFile

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # EOF mark
  EOF_MARK = -0x1

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EpFile.
  def initialize
    @enemies     = []
    @tasks       = []
    @items       = {}
    @magics      = {}
    @super_moves = {}
  end
  
  # Creates an enemy.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Entry] Enemy object
  def create_enemy(_id = -1, _filename = '*')
    _enemy        = Enemy.new
    _enemy.id     = _id
    _enemy.files << File.basename(_filename)
    _enemy.items  = @items
    _enemy
  end
  
  # Creates an enemy task.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Entry] EnemyTask object
  def create_task(_id = -1, _filename = '*')
    _task              = EnemyTask.new
    _task.id           = _id
    _task.files       << File.basename(_filename)
    _task.enemies      = @enemies
    _task.magics       = @magics
    _task.super_moves  = @super_moves
    _task
  end

  # @see Root#etc
  def etc(...)
    Root.etc(...)
  end

  # @see Root#cfg
  def cfg(...)
    Root.cfg(...)
  end

  # @see Root#dscrptr
  def dscrptr(...)
    Root.dscrptr(...)
  end

  # @see Root#strdetr
  def strdetr(...)
    Root.strdetr(...)
  end

  # @see Root#voc
  def voc(...)
    Root.voc(...)
  end

  # @see Root#join
  def join(...)
    Root.join(...)
  end

  # @see Root#glob
  def glob(...)
    Root.glob(...)
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :enemies
  attr_accessor :tasks
  attr_accessor :items
  attr_accessor :magics
  attr_accessor :super_moves

  def product_id
    Root.product_id
  end
  
  def country_id
    Root.country_id
  end

  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def dc?
    Root.dc?
  end

  # Returns +true+ if the platform is a GameCube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a GameCube, otherwise +false+.
  def gc?
    Root.gc?
  end

  # Returns +true+ if the country is 'EU', otherwise +false+.
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def eu?
    Root.eu?
  end

  # Returns +true+ if the country is 'JP', otherwise +false+.
  # @return [Boolean] +true+ if country is 'JP', otherwise +false+.
  def jp?
    Root.jp?
  end

  # Returns +true+ if the country is 'US', otherwise +false+.
  # @return [Boolean] +true+ if country is 'US', otherwise +false+.
  def us?
    Root.us?
  end

  # Returns +:big+ or +:little+ depending on the platform endianness.
  # @return [Symbol] +:big+ or +:little+ depending on endianness.
  def endianness
    Root.endianness
  end

  # Returns +true+ if the endianness is big-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is big-endian, otherwise +false+.
  def big_endian?
    Root.big_endian?
  end

  # Returns +true+ if the endianness is little-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is little-endian, otherwise +false+.
  def little_endian?
    Root.little_endian?
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns an enemy by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Enemy] Enemy object
  def find_enemy(_id, _filename)
    _basename = File.basename(_filename)
    _enemies  = @enemies.find_all { |_enemy| _enemy.id == _id }
    
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?(_basename)
    end
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?('*')
    end
    
    _enemy
  end

  # Returns enemy tasks by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Array] Enemy tasks
  def find_tasks(_id, _filename)
    _basename = File.basename(_filename)
    _tasks    = @tasks.find_all do |_task|
      _task.enemy_id == _id && _task.files.include?(_basename)
    end
    if _tasks.empty?
      _tasks = @tasks.find_all do |_task|
        _task.enemy_id == _id && _task.files.include?('*')
      end
    end
    _tasks.sort! do |_a, _b|
      _a.id <=> _b.id
    end
    
    _tasks
  end
  
  # Loads an enemy and its tasks from a binary I/O stream.
  # @param _f        [IO]      Binary I/O stream
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  def load_enemy(_f, _id, _filename)
    _max_tasks = dscrptr(:enemy_task_max_count)

    _enemy = create_enemy(_id, _filename)
    _enemy.read_bin(_f)
    @enemies << _enemy

    _empty = true
    (1.._max_tasks).each do |_i|
      _task          = create_task(_i, _filename)
      _task.enemy_id = _id
      _task.read_bin(_f)
      if _task.type_id != -1 || (_empty && _i == _max_tasks)
        @tasks << _task
        _empty = false
      end
    end

    if _f.read_int(:i16) != EOF_MARK
      raise(EOFError, 'EOF mark not found')
    end
  end

  # Saves an enemy and its tasks to a binary I/O stream.
  # @param _f        [IO]     Binary I/O stream
  # @param _enemy    [Enemy]  Enemy object
  # @param _filename [String] File name
  def save_enemy(_f, _enemy, _filename)
    _max_tasks = dscrptr(:enemy_task_max_count)
    
    _id = _enemy.id
    _enemy.write_bin(_f)
    
    _tasks = find_tasks(_id, _filename)
    _size  = _tasks.size
    if _size == 0
      raise(IOError, "tasks for enemy ##{_id} not found")
    end
    if _size > _max_tasks
      raise(IOError, "task quota of #{_max_tasks} exceeded")
    end

    _map = {}
    _tasks.each do |_task|
      if _map.has_key?(_task.id)
        _msg = 'enemy task ID not unique (given %s)'
        raise(IOError, sprintf(_msg, _task.id))
      end
      
      _map[_task.id] = _map.size + 1
    end

    _tasks.each do |_orig|
      _task          = create_task(_orig.id)
      _task.id       = _map[_orig.id]
      _task.files    = _orig.files.dup
      _task.enemy_id = _orig.enemy_id
      _task.type_id  = _orig.type_id
      _task.task_id  = _orig.task_id
      _task.param_id = _orig.param_id
      
      if _task.type_id == 0
        if _task.param_id < 1 || !_map.has_key?(_task.param_id)
          _msg = 'enemy task param ID invalid (given %s)'
          raise(IOError, sprintf(_msg, _task.param_id))
        end
        _task.param_id = _map[_task.param_id]
      end

      _task.write_bin(_f)
    end
    
    _empty = create_task
    (_size..._max_tasks).each do
      _empty.write_bin(_f)
    end

    _f.write_int(EOF_MARK, :i16)
  end
  
end # class EpFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
