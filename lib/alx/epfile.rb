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
  # @param _region [String] Region ID
  def initialize(_region)
    @region       = _region
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
    _enemy        = Enemy.new(region)
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
    _instr              = EnemyInstruction.new(region)
    _instr.id           = _id
    _instr.files       << File.basename(_filename)
    _instr.enemies      = @enemies
    _instr.magics       = @magics
    _instr.super_moves  = @super_moves
    _instr
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :region
  attr_accessor :enemies
  attr_accessor :instructions
  attr_accessor :items
  attr_accessor :magics
  attr_accessor :super_moves

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns an enemy by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Enemy] Enemy
  def find_enemy(_id, _filename)
    _enemies = @enemies.select { |_enemy| _enemy.id == _id }
      
    _enemies.each do |_enemy|
      if _enemy.files.include?(File.basename(_filename))
        return _enemy
      end
    end

    _enemies.each do |_enemy|
      if _enemy.files.include?('*')
        return _enemy
      end
    end
    
    nil
  end

  # Loads an enemy and its instructions from a binary I/O stream.
  # @param _f        [IO]      Binary I/O stream.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Entry] Enemy object
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
    
    _instructions = @instructions.find_all do |_instr|
      _instr.enemy_id == _id && _instr.files.include?(File.basename(_filename))
    end
    if _instructions.empty?
      _instructions = @instructions.find_all do |_instr|
        _instr.enemy_id == _id && _instr.files.include?('*')
      end
    end
    
    _size = _instructions.size
    if _size == 0
      raise(IOError, "instructions for enemy ##{_id} not found")
    end
    if _size > INSTR_SIZE
      raise(IOError, "instruction quota of #{INSTR_SIZE} exceeded")
    end

    _empty = EnemyInstruction.new(@region)
    _last  = nil
    (0...INSTR_SIZE).each do |_i|
      _instr = _instructions[_i]
      if !_instr
        _instr = _empty
      else
        if _last && _instr.id != _last.id + 1
          _str = 'instruction ID invalid (given %s, expected %s)'
          raise(IOError, sprintf(_str, _instr.id, _last.id + 1))
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
