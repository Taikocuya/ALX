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

# Class to handle an enemy event.
class EnemyEvent < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyEvent.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @enemies = []

    members << IntVar.new(VOC.magic_exp            ,  0, :uint8)
    
    (0...4).each do |_i|
      members << IntVar.new(VOC.character_id[_i]   ,  0, :int8 )
      members << StrDmy.new(VOC.character_name[_i] , ''        )
      members << IntVar.new(VOC.character_x[_i]    ,  0, :int8 )
      members << IntVar.new(VOC.character_z[_i]    ,  0, :int8 )
    end
    
    (0...7).each do |_i|
      members << IntVar.new(VOC.enemy_id[_i]       ,  0, :uint8)
      members << StrDmy.new(VOC.enemy_name_jp[_i]  , ''        )
      
      if us?
        members << StrDmy.new(VOC.enemy_name_us[_i], ''        )
      elsif eu?
        members << StrDmy.new(VOC.enemy_name_eu[_i], ''        )
      end
      
      members << IntVar.new(VOC.enemy_x[_i]        ,  0, :int8 )
      members << IntVar.new(VOC.enemy_z[_i]        ,  0, :int8 )
    end

    members << IntVar.new(VOC.party_vigor          ,  0, :uint8)
    members << IntVar.new(VOC.defeat_cond_id       ,  0, :int8 )
    members << StrDmy.new(VOC.defeat_cond_name     , ''        )
    members << IntVar.new(VOC.escape_cond_id       ,  0, :int8 )
    members << StrDmy.new(VOC.escape_cond_name     , ''        )

    members << IntExt.new(VOC.bgm_id               , -1        )
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    (0...4).each do |_i|
      _id = find_member(VOC.character_id[_i]).value
      if _id != -1
        _name = VOC.characters[_id]
      else
        _name = 'None'
      end
      find_member(VOC.character_name[_i]).value = _name
    end
    
    (0...7).each do |_i|
      _id = find_member(VOC.enemy_id[_i]).value
      if _id != 255
        _entry = @enemies.find { |_enemy| _enemy.id == _id }
        if _entry
          _name_jp  = _entry.find_member(VOC.name_str['JP']).value
          _name_voc = voc(:enemies, _id.to_s) || '???'
        else
          _name_jp  = '???'
          _name_voc = '???'
        end
      else
        _name_jp  = 'None'
        _name_voc = 'None'
      end
      find_member(VOC.enemy_name_jp[_i]).value = _name_jp
      if us?
        find_member(VOC.enemy_name_us[_i]).value = _name_voc
      elsif eu?
        find_member(VOC.enemy_name_eu[_i]).value = _name_voc
      end
    end

    _id = find_member(VOC.defeat_cond_id).value
    find_member(VOC.defeat_cond_name).value = VOC.defeats[_id]

    _id = find_member(VOC.escape_cond_id).value
    find_member(VOC.escape_cond_name).value = VOC.escapes[_id]

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :enemies

end	# class EnemyEvent

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
