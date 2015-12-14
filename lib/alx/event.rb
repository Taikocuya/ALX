#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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
require_relative('translatable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an event.
class Event < Entry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Translatable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Defeat condition IDs
  DEFEATS = Hash.new('???')
  DEFEATS.store(0, 'Must not lose')
  DEFEATS.store(1, 'May try again')
  DEFEATS.store(2, 'May lose')
  
  # Escape condition IDs
  ESCAPES = Hash.new('???')
  ESCAPES.store(0, 'Can escape'   )
  ESCAPES.store(1, 'Cannot escape')
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Enemy.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @enemies = {}

    members << IntVar.new(CsvHdr::MEGIC_EXP           ,  0, 'C' )
    
    (1..4).each do |_i|
      members << IntVar.new(CsvHdr::CHARACTER_ID[_i]  ,  0, 'C' )
      members << StrDmy.new(CsvHdr::CHARACTER_NAME[_i], ''      )
      members << IntVar.new(CsvHdr::CHARACTER_X[_i]   ,  0, 'C' )
      members << IntVar.new(CsvHdr::CHARACTER_Y[_i]   ,  0, 'C' )
    end
    
    (1..7).each do |_i|
      members << IntVar.new(CsvHdr::ENEMY_ID[_i]      ,  0, 'C' )
      members << StrDmy.new(CsvHdr::ENEMY_NAME_JP[_i] , ''      )
      members << StrDmy.new(CsvHdr::ENEMY_NAME_US[_i] , ''      )
      members << StrDmy.new(CsvHdr::ENEMY_NAME_EU[_i] , ''      )
      members << IntVar.new(CsvHdr::ENEMY_X[_i]       ,  0, 'C' )
      members << IntVar.new(CsvHdr::ENEMY_Y[_i]       ,  0, 'C' )
    end

    members << IntVar.new(CsvHdr::UNKNOWN[0]          ,  0, 'C' )
    members << IntVar.new(CsvHdr::DEFEAT_COND_ID      ,  0, 'C' )
    members << StrDmy.new(CsvHdr::DEFEAT_COND_NAME    , ''      )
    members << IntVar.new(CsvHdr::ESCAPE_COND_ID      ,  0, 'C' )
    members << StrDmy.new(CsvHdr::ESCAPE_COND_NAME    , ''      )
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    (1..4).each do |_i|
      _id = find_member(CsvHdr::CHARACTER_ID[_i]).value
      if _id != 255
        _name = CHARACTERS[_id]
      else
        _name = 'None'
      end
      find_member(CsvHdr::CHARACTER_NAME[_i]).value = _name
    end
    
    (1..7).each do |_i|
      _id = find_member(CsvHdr::ENEMY_ID[_i]).value
      if _id != 255
        _entry = @enemies.find { |_enemy| _enemy.id == _id }
        if _entry
          _name_jp = _entry.find_member(CsvHdr::NAME_JP_STR).value
          _name_us = ENEMY_US_LIST[_id]
          _name_eu = ENEMY_EU_LIST[_id]
        else
          _name_jp = '???'
          _name_us = '???'
          _name_eu = '???'
        end
      else
        _name_jp = 'None'
        _name_us = 'None'
        _name_eu = 'None'
      end
      find_member(CsvHdr::ENEMY_NAME_JP[_i]).value = _name_jp
      find_member(CsvHdr::ENEMY_NAME_US[_i]).value = _name_us
      find_member(CsvHdr::ENEMY_NAME_EU[_i]).value = _name_eu
    end

    _id = find_member(CsvHdr::DEFEAT_COND_ID).value
    find_member(CsvHdr::DEFEAT_COND_NAME).value = DEFEATS[_id]

    _id = find_member(CsvHdr::ESCAPE_COND_ID).value
    find_member(CsvHdr::ESCAPE_COND_NAME).value = ESCAPES[_id]

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :enemies

end	# class Event

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
