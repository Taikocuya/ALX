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

require_relative('effectable.rb')
require_relative('entry.rb')
require_relative('translatable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy ship task.
class EnemyShipTask < Entry

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # IDs of ship enemies
  ENEMY_SHIP_LIST = Hash.new('???')
  ENEMY_SHIP_LIST.store('r500a.tec', 23)
  ENEMY_SHIP_LIST.store('r501a.tec',  2)
  ENEMY_SHIP_LIST.store('r503a.tec', 21)
  ENEMY_SHIP_LIST.store('r506a.tec', 24)
  ENEMY_SHIP_LIST.store('r507a.tec', 11)
  ENEMY_SHIP_LIST.store('r509a.tec', 12)
  ENEMY_SHIP_LIST.store('r510a.tec',  4)
  ENEMY_SHIP_LIST.store('r513a.tec', 35)
  ENEMY_SHIP_LIST.store('r514a.tec', 13)
  ENEMY_SHIP_LIST.store('r515a.tec', 25)
  ENEMY_SHIP_LIST.store('r518a.tec',  4)
  ENEMY_SHIP_LIST.store('r519a.tec', 38)
  ENEMY_SHIP_LIST.store('r520a.tec',  9)
  ENEMY_SHIP_LIST.store('r521a.tec', 10)
  ENEMY_SHIP_LIST.store('r522a.tec', 16)
  ENEMY_SHIP_LIST.store('r523a.tec', 32)
  ENEMY_SHIP_LIST.store('r524a.tec', 29)
  ENEMY_SHIP_LIST.store('r525a.tec', 44)
  ENEMY_SHIP_LIST.store('r527a.tec', 36)
  ENEMY_SHIP_LIST.store('r530a.tec', 17)
  ENEMY_SHIP_LIST.store('r531a.tec', 26)
  ENEMY_SHIP_LIST.store('r532a.tec', 37)
  ENEMY_SHIP_LIST.store('r535a.tec', 27)
  ENEMY_SHIP_LIST.store('r537a.tec', 30)
  ENEMY_SHIP_LIST.store('r538a.tec', 31)
  ENEMY_SHIP_LIST.store('r540a.tec', 14)
  ENEMY_SHIP_LIST.store('r541a.tec', 14)
  ENEMY_SHIP_LIST.store('r542a.tec',  4)
  ENEMY_SHIP_LIST.store('r543a.tec',  5)
  ENEMY_SHIP_LIST.store('r544a.tec',  8)
  ENEMY_SHIP_LIST.store('r545a.tec', 18)
  ENEMY_SHIP_LIST.store('r547a.tec', 28)
  ENEMY_SHIP_LIST.store('r550a.tec', 21)
  ENEMY_SHIP_LIST.store('r551a.tec', 21)
  ENEMY_SHIP_LIST.store('r552a.tec', 21)
  ENEMY_SHIP_LIST.store('r553a.tec',  1)
  ENEMY_SHIP_LIST.store('r554a.tec',  0)
  ENEMY_SHIP_LIST.store('r555a.tec',  1)
  ENEMY_SHIP_LIST.store('r556a.tec',  3)
  ENEMY_SHIP_LIST.store('r557a.tec',  4)
  ENEMY_SHIP_LIST.store('r558a.tec',  4)
  ENEMY_SHIP_LIST.store('r559a.tec', 22)
  ENEMY_SHIP_LIST.store('r560a.tec',  1)
  ENEMY_SHIP_LIST.store('r562a.tec',  4)
  ENEMY_SHIP_LIST.store('r563a.tec',  5)
  ENEMY_SHIP_LIST.store('r564a.tec',  1)
  ENEMY_SHIP_LIST.store('r565a.tec', 22)
  ENEMY_SHIP_LIST.store('r566a.tec',  7)
  ENEMY_SHIP_LIST.store('r567a.tec',  6)
  ENEMY_SHIP_LIST.store('r568a.tec', 22)
  ENEMY_SHIP_LIST.store('r569a.tec',  5)
  ENEMY_SHIP_LIST.store('r572a.tec', 22)
  ENEMY_SHIP_LIST.store('r573a.tec', 43)
  ENEMY_SHIP_LIST.store('r574a.tec',  6)
  ENEMY_SHIP_LIST.store('r575a.tec',  7)
  ENEMY_SHIP_LIST.store('r576a.tec', 35)
  ENEMY_SHIP_LIST.store('r577a.tec', 32)
  ENEMY_SHIP_LIST.store('r578a.tec', 36)
  ENEMY_SHIP_LIST.store('r579a.tec', 37)
  ENEMY_SHIP_LIST.store('r580a.tec', 40)
  ENEMY_SHIP_LIST.store('r581a.tec', 41)
  ENEMY_SHIP_LIST.store('r582a.tec', 40)
  ENEMY_SHIP_LIST.store('r583a.tec', 40)
  
  # Task type IDs
  TASK_TYPES = Hash.new('???')
  TASK_TYPES.store(-1, 'None'   )
  TASK_TYPES.store( 0, 'Attack' )
  TASK_TYPES.store( 1, 'Magic'  )
  TASK_TYPES.store( 2, 'Focus'  )
  TASK_TYPES.store( 3, 'Guard'  )
  TASK_TYPES.store( 4, 'Nothing')

  # Focus task IDs
  FOCUS_TASKS = Hash.new('???')
  FOCUS_TASKS.store(-1, 'None'            )
  FOCUS_TASKS.store( 0, 'Focus'           )
  FOCUS_TASKS.store( 1, 'Taking Aim'      )
  FOCUS_TASKS.store( 2, 'Preparing Attack')
  FOCUS_TASKS.store(34, 'Preparing Attack')
  
  
  # Guard task IDs
  GUARD_TASKS = Hash.new('???')
  GUARD_TASKS.store(-1, 'None'          )
  GUARD_TASKS.store( 0, 'Evasive Action')
  
  # Nothing task IDs
  NOTHING_TASKS = Hash.new('???')
  NOTHING_TASKS.store(-1, 'None'            )
  NOTHING_TASKS.store( 0, 'Awaiting Orders' )
  NOTHING_TASKS.store( 1, 'Target Lost'     )
  NOTHING_TASKS.store( 2, 'Assessing Damage')
  NOTHING_TASKS.store( 3, 'Hull Ram'        )
  NOTHING_TASKS.store( 4, 'Red Ray'         )
  NOTHING_TASKS.store( 5, 'Fist of Grendel' )
  NOTHING_TASKS.store( 6, 'Boulder Throw'   )
  NOTHING_TASKS.store( 7, 'Stomp'           )
  NOTHING_TASKS.store( 8, 'Flee'            )

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyShipTask.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @file        = ''
    @enemy_ships = {}
    @magics      = {}

    members << StrDmy.new(CsvHdr::FILTER             , ''      )
    members << StrDmy.new(CsvHdr::ENEMY_SHIP_ID      , ''      )
    members << StrDmy.new(CsvHdr::ENEMY_SHIP_NAME    , ''      )
    members << IntVar.new(CsvHdr::UNKNOWN[-1]        ,  0, 's>')
    # members << IntVar.new(CsvHdr::TASK_COND_ID       ,  0, 's>')
    # members << StrDmy.new(CsvHdr::TASK_COND_NAME     , ''      )
    members << IntVar.new(CsvHdr::TASK_RATING        ,  0, 's>')
    members << IntVar.new(CsvHdr::TASK_A_TYPE_ID     ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_A_TYPE_NAME   , ''      )
    members << IntVar.new(CsvHdr::TASK_A_ARM_ID      ,  0, 's>')
    if region == 'P'
      members << StrDmy.new(CsvHdr::TASK_A_ARM_NAME  , ''      )
    end
    members << IntVar.new(CsvHdr::TASK_A_PARAM_ID    ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_A_PARAM_NAME  , ''      )
    members << IntVar.new(CsvHdr::TASK_A_RANGE       ,  0, 's>')
    members << IntVar.new(CsvHdr::TASK_B_TYPE_ID     ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_B_TYPE_NAME   , ''      )
    members << IntVar.new(CsvHdr::TASK_B_ARM_ID      ,  0, 's>')
    if region == 'P'
      members << StrDmy.new(CsvHdr::TASK_B_ARM_NAME  , ''      )
    end
    members << IntVar.new(CsvHdr::TASK_B_PARAM_ID    ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_B_PARAM_NAME  , ''      )
    members << IntVar.new(CsvHdr::TASK_B_RANGE       ,  0, 's>')
  end

  # Reads one entry from a CSV  file.
  # @param _f [CSV] CSV object
  def read_from_csv(_f)
    super
    @file = find_member(CsvHdr::FILTER).value
  end
  
  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _enemy_id   = ENEMY_SHIP_LIST[@file]
    _enemy_ship = @enemy_ships[_enemy_id]
    
    find_member(CsvHdr::FILTER).value        = @file
    find_member(CsvHdr::ENEMY_SHIP_ID).value = _enemy_id
    
    _name = '???'
    if _enemy_ship
      case region
      when 'E'
        _name = _enemy_ship.find_member(CsvHdr::NAME_US_STR).value
      when 'J'
        _name = _enemy_ship.find_member(CsvHdr::NAME_JP_STR).value
      when 'P'
        _name = _enemy_ship.find_member(CsvHdr::NAME_GB_STR).value
      end
    end
    find_member(CsvHdr::ENEMY_SHIP_NAME).value = _name

    if region == 'P'
      _name = '???'
      if _enemy_ship
        _id = find_member(CsvHdr::TASK_A_ARM_ID).value
        if _id > -1
          _name = _enemy_ship.find_member(CsvHdr::ARM_NAME_GB_STR[_id]).value
        else
          _name = 'None'
        end
      end
      find_member(CsvHdr::TASK_A_ARM_NAME).value = _name
      
      _name = '???'
      if _enemy_ship
        _id = find_member(CsvHdr::TASK_B_ARM_ID).value
        if _id > -1
          _name = _enemy_ship.find_member(CsvHdr::ARM_NAME_GB_STR[_id]).value
        else
          _name = 'None'
        end
      end
      find_member(CsvHdr::TASK_B_ARM_NAME).value = _name
    end

    _id = find_member(CsvHdr::TASK_A_TYPE_ID).value
    find_member(CsvHdr::TASK_A_TYPE_NAME).value = TASK_TYPES[_id]
    
    _id = find_member(CsvHdr::TASK_B_TYPE_ID).value
    find_member(CsvHdr::TASK_B_TYPE_NAME).value = TASK_TYPES[_id]

    _type_id    = find_member(CsvHdr::TASK_A_TYPE_ID ).value
    _param_id   = find_member(CsvHdr::TASK_A_PARAM_ID).value
    _type_name  = TASK_TYPES[_type_id]
    _param_name = _param_id != -1 ? '???' : 'None'
    case _type_id
    when 0
      _param_name = 'None'
    when 1
      _entry = @magics[_param_id]
      if _entry
        case region
        when 'E'
          _param_name = _entry.find_member(CsvHdr::NAME_US_STR).value
        when 'J'
          _param_name = _entry.find_member(CsvHdr::NAME_JP_STR).value
        when 'P'
          _param_name = _entry.find_member(CsvHdr::NAME_GB_STR).value
        end
      end
    when 2
      _param_name = FOCUS_TASKS[_param_id]
    when 3
      _param_name = GUARD_TASKS[_param_id]
    when 4
      _param_name = NOTHING_TASKS[_param_id]
    end
    find_member(CsvHdr::TASK_A_TYPE_NAME ).value = _type_name
    find_member(CsvHdr::TASK_A_PARAM_NAME).value = _param_name
    
    _type_id    = find_member(CsvHdr::TASK_B_TYPE_ID ).value
    _param_id   = find_member(CsvHdr::TASK_B_PARAM_ID).value
    _type_name  = TASK_TYPES[_type_id]
    _param_name = _param_id != -1 ? '???' : 'None'
    case _type_id
    when -1
      _param_name = 'None'
    when 0
      _param_name = 'None'
    when 1
      _entry = @magics[_param_id]
      if _entry
        case region
        when 'E'
          _param_name = _entry.find_member(CsvHdr::NAME_US_STR).value
        when 'J'
          _param_name = _entry.find_member(CsvHdr::NAME_JP_STR).value
        when 'P'
          _param_name = _entry.find_member(CsvHdr::NAME_GB_STR).value
        end
      end
    when 2
      _param_name = FOCUS_TASKS[_param_id]
    when 3
      _param_name = GUARD_TASKS[_param_id]
    when 4
      _param_name = NOTHING_TASKS[_param_id]
    end
    find_member(CsvHdr::TASK_B_TYPE_NAME ).value = _type_name
    find_member(CsvHdr::TASK_B_PARAM_NAME).value = _param_name
    
    super
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
