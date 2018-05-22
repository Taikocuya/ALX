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

require_relative('entry.rb')
require_relative('translatable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an encounter.
class Encounter < Entry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Translatable)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Enemy.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @enemies = {}
    @file    = ''

    members << StrDmy.new(CsvHdr::FILTER             , ''      )
    members << IntVar.new(CsvHdr::UNKNOWN[0]         ,  0, 'C' )
    members << IntVar.new(CsvHdr::MEGIC_EXP          ,  0, 'C' )

    (1..8).each do |_i|
      members << IntVar.new(CsvHdr::ENEMY_ID[_i]     ,  0, 'C' )
      members << StrDmy.new(CsvHdr::ENEMY_NAME_JP[_i], ''      )
      members << StrDmy.new(CsvHdr::ENEMY_NAME_US[_i], ''      )
      members << StrDmy.new(CsvHdr::ENEMY_NAME_EU[_i], ''      )
    end
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
    
    (1..8).each do |_i|
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

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :enemies
  attr_accessor :file

end	# class Encounter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
