#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2023 Marcel Renner
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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy ship task.
class EnemyShipTask < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyShipTask.
  def initialize
    super
    init_attrs
    init_props
    init_procs
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :enemy_id
  attr_reader   :enemy_ships
  attr_reader   :magics

  def enemy_ships=(_enemy_ships)
    @enemy_ships = _enemy_ships || {}
    
    fetch(VOC.filter)&.call_proc
    if eu?
      (1..2).each do |_i|
        fetch(VOC.task_arm_id(_i))&.call_proc
      end
    end
  end
  
  def magics=(_magics)
    @magics = _magics || {}
    
    (1..2).each do |_i|
      fetch(VOC.task_param_id(_i))&.call_proc
    end
  end
  
  def file
    self[VOC.filter]
  end

  def file=(_file)
    self[VOC.filter] = _file
  end
  
#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @enemy_id    ||= -1
    @enemy_ships ||= {}
    @magics      ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    self[VOC.filter         ] = StrProp.new( nil,    '', ext: true)
    self[VOC.enemy_ship_id  ] = StrProp.new( nil,    '', dmy: true)
    self[VOC.enemy_ship_name] = StrProp.new( nil,    '', dmy: true)
    self[VOC.turn_id        ] = IntProp.new(:u32,     0, dmy: true)
    self[VOC.phase_id       ] = IntProp.new(:u32,     0, dmy: true)
    self[VOC.cond_id        ] = IntProp.new(:i16,     0           )
    self[VOC.cond_name      ] = StrProp.new( nil, '???', dmy: true)
    self[VOC.cond_param_id  ] = IntProp.new(:i16,     0           )
    self[VOC.cond_param_name] = StrProp.new( nil, '???', dmy: true)
    
    (1..2).each do |_i|
      self[VOC.task_type_id(_i)  ] = IntProp.new(:i16,  0           )
      self[VOC.task_type_name(_i)] = StrProp.new( nil, '', dmy: true)
      self[VOC.task_arm_id(_i)   ] = IntProp.new(:i16,  0           )
      
      if eu?
        self[VOC.task_arm_name(_i)] = StrProp.new(nil, '', dmy: true)
      end
      
      self[VOC.task_param_id(_i)  ] = IntProp.new(:i16,  0           )
      self[VOC.task_param_name(_i)] = StrProp.new( nil, '', dmy: true)
      self[VOC.task_duration(_i)  ] = IntProp.new(:i16,  0           )
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.id).proc = Proc.new do |_id|
      self[VOC.turn_id ] = _id / 4
      self[VOC.phase_id] = _id % 4
    end

    fetch(VOC.filter).proc = Proc.new do |_filter|
      _match = SYS.enemy_ship_tasks.find do |_, _array|
        _array.any? do |_task_id|
          _filter.include?(_task_id.to_s)
        end
      end
      
      @enemy_id = _match ? _match[0] : -1
      self[VOC.enemy_ship_id] = @enemy_id
      
      _name       = '???'
      _enemy_ship = (@enemy_id != -1) ? @enemy_ships[@enemy_id] : nil
      if _enemy_ship
        if jp? || us?
          _name = _enemy_ship[VOC.name_str(cid)]
        elsif eu?
          _name = _enemy_ship[VOC.name_str('GB')]
        end
      end
      self[VOC.enemy_ship_name] = _name
    end

    fetch(VOC.cond_id).proc = Proc.new do |_id|
      self[VOC.cond_name] = VOC.conditions(_id)
      
      fetch(VOC.cond_param_id)&.call_proc
    end
    
    fetch(VOC.cond_param_id).proc = Proc.new do |_id|
      case self[VOC.cond_id]
      when 0, 1
        self[VOC.cond_param_name] = '%'
      when 2
        self[VOC.cond_param_name] = VOC.sp(nil)
      when 3
        self[VOC.cond_param_name] = '%'
      when 4, 5
        self[VOC.cond_param_name] = VOC.ship_task_types[_id]
      else
        self[VOC.cond_param_name] = VOC.conditions[-1]
      end
    end
    
    (1..2).each do |_i|
      if eu?
        fetch(VOC.task_arm_id(_i)).proc = Proc.new do |_id|
          _name       = '???'
          _enemy_ship = (@enemy_id != -1) ? @enemy_ships[@enemy_id] : nil
          if _enemy_ship
            _type_id = self[VOC.task_type_id(_i)]
            _id      = self[VOC.task_arm_id(_i)]
            if _type_id == 0 && _id > -1
              _name = _enemy_ship[VOC.arm_name_str(_id + 1, gb)]
            else
              _name = 'None'
            end
          end
          self[VOC.task_arm_name(_i)] = _name
        end
      end

      fetch(VOC.task_type_id(_i)).proc = Proc.new do
        fetch(VOC.task_param_id(_i))&.call_proc
        fetch(VOC.task_arm_id(_i))&.call_proc
      end
      
      fetch(VOC.task_param_id(_i)).proc = Proc.new do |_param_id|
        _type_id    = self[VOC.task_type_id(_i)]
        _type_name  = VOC.ship_task_types(_type_id)
        _param_name = (_param_id != -1) ? '???' : 'None'
        
        case _type_id
        when 0
          _param_name = 'None'
        when 1
          _entry = @magics[_param_id]
          if _entry
            if jp? || us?
              _param_name = _entry[VOC.name_str(cid)]
            elsif eu?
              _param_name = _entry[VOC.name_str('GB')]
            end
          end
        when 2
          _param_name = VOC.focus_ship_tasks(_param_id)
        when 3
          _param_name = VOC.guard_ship_tasks(_param_id)
        when 4
          _param_name = VOC.nothing_ship_tasks(_param_id)
        end
        
        self[VOC.task_type_name(_i) ] = _type_name
        self[VOC.task_param_name(_i)] = _param_name
      end
    end
  end

end	# class EnemyShipTask

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
