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
  FOCUS_TASKS.store(-1, 'Preparing Attack')
  FOCUS_TASKS.store( 0, 'Focus'           )
  FOCUS_TASKS.store( 1, 'Taking Aim'      )
  FOCUS_TASKS.store( 2, 'Preparing Attack')
  FOCUS_TASKS.store(34, 'Preparing Attack')
  
  
  # Guard task IDs
  GUARD_TASKS = Hash.new('???')
  GUARD_TASKS.store(-1, 'Evasive Action')
  GUARD_TASKS.store( 0, 'Evasive Action')
  
  # Nothing task IDs
  NOTHING_TASKS = Hash.new('???')
  NOTHING_TASKS.store(-1, 'Flee'            )
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
    @file   = ''
    @magics = {}
    
    members << StrDmy.new(CsvHdr::FILTER           , ''      )
    members << IntVar.new(CsvHdr::UNKNOWN[-1]      ,  0, 's>')
    # members << IntVar.new(CsvHdr::TASK_COND_ID     ,  0, 's>')
    # members << StrDmy.new(CsvHdr::TASK_COND_NAME   , ''      )
    members << IntVar.new(CsvHdr::TASK_RATING      ,  0, 's>')
    members << IntVar.new(CsvHdr::TASK_A_TYPE_ID   ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_A_TYPE_NAME , ''      )
    members << IntVar.new(CsvHdr::TASK_A_ARM_ID    ,  0, 's>')
    members << IntVar.new(CsvHdr::TASK_A_PARAM_ID  ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_A_PARAM_NAME, ''      )
    members << IntVar.new(CsvHdr::TASK_A_RANGE     ,  0, 's>')
    members << IntVar.new(CsvHdr::TASK_B_TYPE_ID   ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_B_TYPE_NAME , ''      )
    members << IntVar.new(CsvHdr::TASK_B_ARM_ID    ,  0, 's>')
    members << IntVar.new(CsvHdr::TASK_B_PARAM_ID  ,  0, 's>')
    members << StrDmy.new(CsvHdr::TASK_B_PARAM_NAME, ''      )
    members << IntVar.new(CsvHdr::TASK_B_RANGE     ,  0, 's>')
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
    find_member(CsvHdr::FILTER).value = @file

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
  attr_accessor :magics

end	# class EnemyShipTask

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
