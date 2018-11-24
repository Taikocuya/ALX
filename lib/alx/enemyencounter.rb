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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy encounter.
class EnemyEncounter < Entry

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

    members << StrDmy.new(VOC.filter             , ''      )
    members << IntVar.new(VOC.party_vigor        ,  0, 'C' )
    members << IntVar.new(VOC.magic_exp          ,  0, 'C' )

    (0...8).each do |_i|
      members << IntVar.new(VOC.enemy_id[_i]     ,  0, 'C' )
      members << StrDmy.new(VOC.enemy_name_jp[_i], ''      )
      members << StrDmy.new(VOC.enemy_name_us[_i], ''      )
      members << StrDmy.new(VOC.enemy_name_eu[_i], ''      )
    end
  end

  # Reads one entry from a CSV  file.
  # @param _csv [CSV] CSV object
  def read_from_csv(_csv)
    super
    @file = find_member(VOC.filter).value
  end
  
  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_to_csv(_csv)
    find_member(VOC.filter).value = @file
    
    (0...8).each do |_i|
      _id = find_member(VOC.enemy_id[_i]).value
      if _id != 255
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
      else
        _name_jp = 'None'
        _name_us = 'None'
        _name_eu = 'None'
      end
      find_member(VOC.enemy_name_jp[_i]).value = _name_jp
      find_member(VOC.enemy_name_us[_i]).value = _name_us
      find_member(VOC.enemy_name_eu[_i]).value = _name_eu
    end

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :enemies
  attr_accessor :file

end	# class EnemyEncounter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
