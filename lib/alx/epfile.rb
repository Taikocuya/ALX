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
  # EOF mark
  EOF_MARK   = -0x1

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EpFile.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    @root         = _root
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

  # @see GameRoot#etc
  def etc(*_args)
    @root.etc(*_args)
  end

  # @see GameRoot#sys
  def sys(*_args)
    @root.sys(*_args)
  end

  # @see GameRoot#voc
  def voc(*_args)
    @root.voc(*_args)
  end

  # @see GameRoot#join
  def join(*_args)
    @root.join(*_args)
  end

  # @see GameRoot#glob
  def glob(*_args, &_block)
    @root.glob(*_args, &_block)
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :root
  attr_accessor :enemies
  attr_accessor :instructions
  attr_accessor :items
  attr_accessor :magics
  attr_accessor :super_moves

  def country_id
    @root.country_id
  end
  
  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def dc?
    @root.dc?
  end

  # Returns +true+ if the platform is a Gamecube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Gamecube, otherwise +false+.
  def gc?
    @root.gc?
  end

  # Returns +true+ if the country is 'EU', otherwise +false+.
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def eu?
    @root.eu?
  end

  # Returns +true+ if the country is 'JP', otherwise +false+.
  # @return [Boolean] +true+ if country is 'JP', otherwise +false+.
  def jp?
    @root.jp?
  end

  # Returns +true+ if the country is 'US', otherwise +false+.
  # @return [Boolean] +true+ if country is 'US', otherwise +false+.
  def us?
    @root.us?
  end

  # Returns +:big+ or +:little+ depending on the platform endianness.
  # @return [Symbol] +:big+ or +:little+ depending on endianness.
  def endianness
    @root.endianness
  end

  # Returns +true+ if the endianness is big-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is big-endian, otherwise +false+.
  def big_endian?
    @root.big_endian?
  end

  # Returns +true+ if the endianness is little-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is little-endian, otherwise +false+.
  def little_endian?
    @root.little_endian?
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
    _enemies = @enemies.find_all { |_enemy| _enemy.id == _id }
    
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?(File.basename(_filename))
    end
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?('*')
    end
    
    _enemy
  end

  # Returns an enemy instructions by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Array] Enemy instructions
  def find_instructions(_id, _filename)
    _instructions = @instructions.find_all do |_instr|
      _instr.enemy_id == _id && _instr.files.include?(File.basename(_filename))
    end
    if _instructions.empty?
      _instructions = @instructions.find_all do |_instr|
        _instr.enemy_id == _id && _instr.files.include?('*')
      end
    end
    
    _instructions
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
    
    if _f.read_int(:int16) != EOF_MARK
      raise(EOFError, 'EOF mark not found')
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

    _empty = create_instruction
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

    _f.write_int(EOF_MARK, :int16)
  end
  
end # class EpFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
