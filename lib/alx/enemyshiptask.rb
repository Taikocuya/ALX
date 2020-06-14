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
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @file        = ''
    @enemy_ships = {}
    @magics      = {}

    members << StrDmy.new(VOC.filter               , ''        )
    members << StrDmy.new(VOC.enemy_ship_id        , ''        )
    members << StrDmy.new(VOC.enemy_ship_name      , ''        )
    members << IntVar.new(VOC.task_cond_id         ,  0, :int16)
    members << StrDmy.new(VOC.task_cond_name       , '???'     )
    members << IntVar.new(VOC.task_rating          ,  0, :int16)
    
    (1..2).each do |_i|
      members << IntVar.new(VOC.task_type_id[_i]   ,  0, :int16)
      members << StrDmy.new(VOC.task_type_name[_i] , ''        )
      members << IntVar.new(VOC.task_arm_id[_i]    ,  0, :int16)
      if eu?
        members << StrDmy.new(VOC.task_arm_name[_i], ''        )
      end
      members << IntVar.new(VOC.task_param_id[_i]  ,  0, :int16)
      members << StrDmy.new(VOC.task_param_name[_i], ''        )
      members << IntVar.new(VOC.task_range[_i]     ,  0, :int16)
    end
  end

  # Checks the entry with a snapshot. Assigns +true+ to #expired if the entry 
  # differs from the snapshot, otherwise nothing happens. Returns +true+ if 
  # the entry matches the snapshot, otherwise +false+.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if entry matches the snapshot, otherwise +false+.
  def check_expiration(_entry)
    _found   = true
    _found &&= _entry.is_a?(EnemyShipTask)
    _found &&= (id    == _entry.id  )
    _found &&= (@file == _entry.file)

    if _found
      super
    end
    
    _found
  end

  # Reads one entry from a CSV  file.
  # @param _csv [CSV] CSV object
  def read_csv(_csv)
    super
    @file = find_member(VOC.filter).value
  end
  
  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_csv(_csv)
    _match = SYS.enemy_ship_tasks.find do |_, _array|
      _array.any? do |_task_id|
        @file.include?(_task_id.to_s)
      end
    end
    if _match
      _enemy_id   = _match[0]
      _enemy_ship = @enemy_ships[_enemy_id]
    else
      _enemy_id   = '???'
      _enemy_ship = nil
    end
    
    find_member(VOC.filter).value        = @file
    find_member(VOC.enemy_ship_id).value = _enemy_id
    
    _name = '???'
    if _enemy_ship
      if jp? || us?
        _name = _enemy_ship.find_member(VOC.name_str[country_id]).value
      elsif eu?
        _name = _enemy_ship.find_member(VOC.name_str['GB']   ).value
      end
    end
    find_member(VOC.enemy_ship_name).value = _name

    (1..2).each do |_i|
      if eu?
        _name = '???'
        if _enemy_ship
          _id = find_member(VOC.task_arm_id[_i]).value
          if _id > -1
            _name = _enemy_ship.find_member(VOC.arm_name_gb_str[_id + 1]).value
          else
            _name = 'None'
          end
        end
        find_member(VOC.task_arm_name[_i]).value = _name
      end
    
      _id = find_member(VOC.task_type_id[_i]).value
      find_member(VOC.task_type_name[_i]).value = VOC.task_types[_id]
    
      _type_id    = find_member(VOC.task_type_id[_i] ).value
      _param_id   = find_member(VOC.task_param_id[_i]).value
      _type_name  = VOC.task_types[_type_id]
      _param_name = _param_id != -1 ? '???' : 'None'
      case _type_id
      when 0
        _param_name = 'None'
      when 1
        _entry = @magics[_param_id]
        if _entry
          if jp? || us?
            _param_name = _entry.find_member(VOC.name_str[country_id]).value
          elsif eu?
            _param_name = _entry.find_member(VOC.name_str['GB']   ).value
          end
        end
      when 2
        _param_name = VOC.focus_tasks[_param_id]
      when 3
        _param_name = VOC.guard_tasks[_param_id]
      when 4
        _param_name = VOC.nothing_tasks[_param_id]
      end
      find_member(VOC.task_type_name[_i] ).value = _type_name
      find_member(VOC.task_param_name[_i]).value = _param_name
    end
    
    super
  end

  # Provides marshalling support for use by the Marshal library.
  # @param _hash [Hash] Hash object
  def marshal_load(_hash)
    _hash.each do |_key, _value|
      instance_variable_set(_key, _value)
    end
    @enemy_ships = {}
    @magics      = {}
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash         = super
    _hash[:@file] = @file
    _hash
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :file
  attr_accessor :enemy_ships
  attr_accessor :magics

end	# class EnemyShipTask

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
