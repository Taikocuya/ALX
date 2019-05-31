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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy instruction.
class EnemyInstruction < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyShipTask.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @files       = []
    @enemies     = []
    @magics      = {}
    @super_moves = {}

    members << StrDmy.new(VOC.filter           , ''      )
    members << IntDmy.new(VOC.instr_enemy_id   , -1      )
    members << StrDmy.new(VOC.enemy_name_jp[-1], ''      )
    members << StrDmy.new(VOC.enemy_name_us[-1], ''      )
    members << StrDmy.new(VOC.enemy_name_eu[-1], ''      )
    members << IntVar.new(VOC.instr_type_id    , -1, 's>')
    members << StrDmy.new(VOC.instr_type_name  , ''      )
    members << IntVar.new(VOC.instr_id         , -1, 's>')
    members << StrDmy.new(VOC.instr_name       , ''      )
    members << IntVar.new(VOC.instr_param_id   , -1, 's>')
    members << StrDmy.new(VOC.instr_param_name , ''      )
  end

  # Compares two entries based on +FltVar+, +IntVar+ and +StrVar+ members. 
  # Returns +true+ if all member values are equal, or +false+ otherwise.
  # @param _entry [Entry] Entry
  # @return [Boolean] +true+ if all member values are equal, otherwise +false+.
  def ==(_entry)
    (enemy_id == _entry.enemy_id) && super
  end
  
  # Reads one entry from a CSV  file.
  # @param _csv [CSV] CSV object
  def read_from_csv(_csv)
    super
    @files = find_member(VOC.filter).value.split(';')
  end
  
  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_to_csv(_csv)
    find_member(VOC.filter).value = @files.join(';')

    _id = find_member(VOC.instr_enemy_id).value
    _entry = @enemies.find { |_enemy| _enemy.id == _id }
    if _entry
      _name_jp = _entry.find_member(VOC.name_str['JP']).value
      _name_us = VOC.enemies_us[_id]
      _name_eu = VOC.enemies_eu[_id]
    else
      _name_jp = '???'
      _name_us = '???'
      _name_eu = '???'
    end
    find_member(VOC.enemy_name_jp[-1]).value = _name_jp
    find_member(VOC.enemy_name_us[-1]).value = _name_us
    find_member(VOC.enemy_name_eu[-1]).value = _name_eu

    _type_id    = find_member(VOC.instr_type_id ).value
    _instr_id   = find_member(VOC.instr_id      ).value
    _param_id   = find_member(VOC.instr_param_id).value
    _type_name  = VOC.instr_types[_type_id]
    _instr_name = _instr_id != -1 ? '???' : 'None'
    _param_name = _param_id != -1 ? '???' : 'None'
    
    case _type_id
    # Strategy
    when 0
      # TODO!
    # Action
    when 1
      # Action type
      _entry = nil
      if _instr_id >= 550
        _instr_name = VOC.basic_actions[_instr_id]
      elsif _instr_id >= 500
        _entry = @magics[_instr_id - 500]
      elsif _instr_id >= 0
        _entry = @super_moves[_instr_id]
      end
      if _entry
        if is_jp? || is_us?
          _instr_name = _entry.find_member(VOC.name_str[country_id]).value
        elsif is_eu?
          _instr_name = _entry.find_member(VOC.name_str['GB']   ).value
        end
      end
    
      # Action target
      _param_name = VOC.action_targets[_param_id]
    end

    find_member(VOC.instr_type_name ).value = _type_name
    find_member(VOC.instr_name      ).value = _instr_name
    find_member(VOC.instr_param_name).value = _param_name

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :files
  attr_accessor :enemies
  attr_accessor :magics
  attr_accessor :super_moves

  def enemy_id
    _member = find_member(VOC.instr_enemy_id)
    if _member
      _member.value
    else
      -1
    end
  end
  
  def enemy_id=(_enemy_id)
    _member = find_member(VOC.instr_enemy_id)
    if _member
      _member.value = _enemy_id
    else
      _enemy_id
    end
  end
  
  def type_id
    _member = find_member(VOC.instr_type_id)
    if _member
      _member.value
    else
      -1
    end
  end
  
  def type_id=(_type_id)
    _member = find_member(VOC.instr_type_id)
    if _member
      _member.value = _type_id
    else
      _type_id
    end
  end

  def order
    _order = 0xff
    
    @files.each do |_filename|
      case File.extname(_filename)
      when '.enp', '*'
        _order = [_order, 0].min
      when '.evp'
        _order = [_order, 1].min
      when '.dat'
        _order = [_order, 2].min
      end
    end
    
    _order
  end

end	# class EnemyInstruction

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
