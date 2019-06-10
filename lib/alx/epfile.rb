#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
require_relative('enemy.rb')
require_relative('enemyinstruction.rb')

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

  # Size of instruction table
  INSTR_SIZE = 0x40
  # EOF marker
  EOF_MARKER = -0x1

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EpFile.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    @root         = _root
    @snapshots    = {}
    @enemy_cache  = {}
    @instr_cache  = {}
    @enemies      = []
    @instructions = []
    @items        = {}
    @magics       = {}
    @super_moves  = {}
  end
  
  # Creates an enemy.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Entry] Enemy object
  def create_enemy(_id = -1, _filename = '*')
    _enemy        = Enemy.new(@root)
    _enemy.id     = _id
    _enemy.files << File.basename(_filename)
    _enemy.items  = @items
    _enemy
  end
  
  # Creates an enemy instruction.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Entry] EnemyInstruction object
  def create_instruction(_id = -1, _filename = '*')
    _instr              = EnemyInstruction.new(@root)
    _instr.id           = _id
    _instr.files       << File.basename(_filename)
    _instr.enemies      = @enemies
    _instr.magics       = @magics
    _instr.super_moves  = @super_moves
    _instr
  end

  # Returns the value of a SYS attribute. If the value is a Hash, the 
  # instance variables are considered during key selection.
  # @param _sym [Symbol] SYS attribute symbol
  # @return [Object] SYS attribute object
  def sys(_sym)
    @root.sys(_sym)
  end
    
  # Returns a new path formed by joining the strings using '/' relative to 
  # #dir. SYS symbols are resolved as well. If they contain a Hash, the game 
  # root attributes are considered during key selection.
  # 
  # @param _args [String,Symbol] Paths or SYS symbols
  # @return [String] Path
  # @see ::File::join
  def join(*_args)
    @root.join(*_args)
  end
  
  # Expands glob pattern and returns a path of the first matching file or 
  # directory relative to #dir. SYS symbols are resolved as well. If they 
  # contain a Hash, the game root attributes are considered during key 
  # selection.
  # 
  # If a block is given, calls the block once for each matching file or 
  # directory, passing the path as a parameter to the block. 
  # 
  # @param _args [String,Symbol] Glob patterns or SYS attributes
  # @return [String] First matching path
  # @see ::Dir::glob
  def glob(*_args, &_block)
    @root.glob(*_args, &_block)
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :root
  attr_accessor :snapshots
  attr_accessor :enemies
  attr_accessor :instructions
  attr_accessor :items
  attr_accessor :magics
  attr_accessor :super_moves

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns +true+ if the enemy object and instructions match the snapshot, 
  # otherwise +false+.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Boolean] +true+ if enemy object and instructions match the 
  #                   snapshot, otherwise +false+.
  def match_enemy_snapshot(_id, _filename)
    # Enemies
    _result   = false
    _snapshot = snapshots[:enemies]
    if _snapshot
      _enemy = find_enemy(_id, _filename)
      if _enemy
        _result = (_enemy.checksum == _snapshot[_enemy.key])
      end
    end
    unless _result
      return false
    end

    # Instructions
    _result   = false
    _snapshot = snapshots[:instructions]
    if _snapshot
      _instructions = find_instructions(_id, _filename)
      if _instructions
        _base = _instructions.first
        _dump = ''
        _instructions.each do |_task|
          _dump << _task.dump
        end
        _result = (Digest::MD5.hexdigest(_dump) == _snapshot[_base.key])
      end
    end

    _result
  end

  # Returns an enemy by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Enemy] Enemy
  def find_enemy(_id, _filename)
    _key   = sprintf('%d-%s', _id, _filename)
    _enemy = @enemy_cache[_key]
    if _enemy
      return _enemy
    end
    
    _enemies = @enemies.select { |_enemy| _enemy.id == _id }
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?(File.basename(_filename))
    end
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?('*')
    end
    
    @enemy_cache[_key] = _enemy
  end

  # Returns an enemy instructions by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Array] Enemy instructions
  def find_instructions(_id, _filename)
    _key   = sprintf('%d-%s', _id, _filename)
    _instr = @instr_cache[_key]
    if _instr
      return _instr
    end

    _instructions = @instructions.find_all do |_instr|
      _instr.enemy_id == _id && _instr.files.include?(File.basename(_filename))
    end
    if _instructions.empty?
      _instructions = @instructions.find_all do |_instr|
        _instr.enemy_id == _id && _instr.files.include?('*')
      end
    end
    
    @instr_cache[_key] = _instructions
  end
  
  # Loads an enemy and its instructions from a binary I/O stream.
  # @param _f        [IO]      Binary I/O stream.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  def load_enemy(_f, _id, _filename)
    _enemy = create_enemy(_id, _filename)
    _enemy.read_from_bin(_f)
    @enemies << _enemy
    
    (1..INSTR_SIZE).each do |_i|
      _instr          = create_instruction(_i, _filename)
      _instr.enemy_id = _id
      _instr.read_from_bin(_f)
      if _instr.type_id != -1
        @instructions << _instr
      end
    end
    
    if _f.read_int('s>') != EOF_MARKER
      raise(EOFError, 'EOF marker not found')
    end
  end

  # Saves an enemy and its instructions to a binary I/O stream.
  # @param _f        [IO]     Binary I/O stream.
  # @param _enemy    [Enemy]  Enemy object
  # @param _filename [String] File name
  def save_enemy(_f, _enemy, _filename)
    _id = _enemy.id
    _enemy.write_to_bin(_f)
    
    _instructions = find_instructions(_id, _filename)
    _size         = _instructions.size
    if _size == 0
      raise(IOError, "instructions for enemy ##{_id} not found")
    end
    if _size > INSTR_SIZE
      raise(IOError, "instruction quota of #{INSTR_SIZE} exceeded")
    end

    _empty = EnemyInstruction.new(@country_id)
    _last  = nil
    (0...INSTR_SIZE).each do |_i|
      _instr = _instructions[_i]
      unless _instr
        _instr = _empty
      else
        if _last && _instr.id != _last.id + 1
          _msg = 'instruction ID invalid (given %s, expected %s)'
          raise(IOError, sprintf(_msg, _instr.id, _last.id + 1))
        end
      end
      _instr.write_to_bin(_f)
      _last = _instr
    end

    _f.write_int(EOF_MARKER, 's>')
  end
  
end # class EpFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
