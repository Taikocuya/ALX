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

require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a character.
class Character < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Character.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @weapons     = {}
    @armors      = {}
    @accessories = {}

    members << StrVar.new(VOC.name_str[country_id]  , '',      11)
    members << IntVar.new(VOC.age                   ,  0, :int8  )
    members << IntVar.new(VOC.gender_id             ,  0, :int8  )
    members << StrDmy.new(VOC.gender_name           , ''         )
    members << IntVar.new(VOC.width                 ,  0, :int8  )
    members << IntVar.new(VOC.depth                 ,  0, :int8  )
    members << IntVar.new(VOC.maxmp                 ,  0, :int8  )
    members << IntVar.new(VOC.element_id            ,  0, :int8  )
    members << StrDmy.new(VOC.element_name          , ''         )
    members << IntVar.new(padding_hdr               ,  0, :int8  )
    members << IntVar.new(VOC.weapon_id             ,  0, :uint16)
    members << StrDmy.new(VOC.weapon_name           , ''         )
    members << IntVar.new(VOC.armor_id              ,  0, :uint16)
    members << StrDmy.new(VOC.armor_name            , ''         )
    members << IntVar.new(VOC.accessory_id          ,  0, :uint16)
    members << StrDmy.new(VOC.accessory_name        , ''         )
    members << PosVar.new(VOC.movement_flags        ,  0, :int16 )
    members << IntVar.new(VOC.hp                    ,  0, :int16 )
    members << IntVar.new(VOC.maxhp                 ,  0, :int16 )
    members << IntVar.new(VOC.base_hp_increase      ,  0, :int16 )
    members << IntVar.new(VOC.spirit[-1]            ,  0, :int16 )
    members << IntVar.new(VOC.maxspirit[-1]         ,  0, :int16 )
    members << IntVar.new(VOC.counter               ,  0, :int16 )
    members << IntVar.new(padding_hdr               ,  0, :int16 )
    members << IntVar.new(VOC.exp[-1]               ,  0, :uint32)
    members << FltVar.new(VOC.base_mp_increase      ,  0, :float )
    members << FltVar.new(unknown_hdr               ,  0, :float )
    
    (0...6).each do |_i|
      members << IntVar.new(VOC.elements[_i]        ,  0, :int16 )
    end
    (0...9).each do |_i|
      members << IntVar.new(VOC.states[_i]          ,  0, :int16 )
    end
    (9...16).each do |_i|
      members << IntVar.new(unknown_hdr             ,  0, :int16 )
    end

    members << IntVar.new(VOC.power                 ,  0, :int16 )
    members << IntVar.new(VOC.will                  ,  0, :int16 )
    members << IntVar.new(VOC.vigor                 ,  0, :int16 )
    members << IntVar.new(VOC.agile                 ,  0, :int16 )
    members << IntVar.new(VOC.quick                 ,  0, :int16 )
    members << IntVar.new(padding_hdr               ,  0, :int16 )
    members << FltVar.new(VOC.base_power_increase   ,  0, :float )
    members << FltVar.new(VOC.base_will_increase    ,  0, :float )
    members << FltVar.new(VOC.base_vigor_increase   ,  0, :float )
    members << FltVar.new(VOC.base_agile_increase   ,  0, :float )
    members << FltVar.new(VOC.base_quick_increase   ,  0, :float )
    members << IntVar.new(VOC.green_exp[-1]         ,  0, :int32 )
    members << IntVar.new(VOC.red_exp[-1]           ,  0, :int32 )
    members << IntVar.new(VOC.purple_exp[-1]        ,  0, :int32 )
    members << IntVar.new(VOC.blue_exp[-1]          ,  0, :int32 )
    members << IntVar.new(VOC.yellow_exp[-1]        ,  0, :int32 )
    members << IntVar.new(VOC.silver_exp[-1]        ,  0, :int32 )
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(VOC.gender_id).value
    find_member(VOC.gender_name).value = VOC.genders[_id]
    
    _id = find_member(VOC.element_id).value
    find_member(VOC.element_name).value = VOC.elements[_id]
    
    _id = find_member(VOC.weapon_id).value
    if _id != -1
      _entry = @weapons[_id]
      _name  = '???'
      if _entry
        if jp? || us?
          _name = _entry.find_member(VOC.name_str[country_id]).value
        elsif eu?
          _name = _entry.find_member(VOC.name_str['GB']   ).value
        end
      end
    else
      _name = 'None'
    end
    find_member(VOC.weapon_name).value = _name

    _id = find_member(VOC.armor_id).value
    if _id != -1
      _entry = @armors[_id]
      _name  = '???'
      if _entry
        if jp? || us?
          _name = _entry.find_member(VOC.name_str[country_id]).value
        elsif eu?
          _name = _entry.find_member(VOC.name_str['GB']   ).value
        end
      end
    else
      _name = 'None'
    end
    find_member(VOC.armor_name).value = _name

    _id = find_member(VOC.accessory_id).value
    if _id != -1
      _entry = @accessories[_id]
      _name  = '???'
      if _entry
        if jp? || us?
          _name = _entry.find_member(VOC.name_str[country_id]).value
        elsif eu?
          _name = _entry.find_member(VOC.name_str['GB']   ).value
        end
      end
    else
      _name = 'None'
    end
    find_member(VOC.accessory_name).value = _name

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :weapons
  attr_accessor :armors
  attr_accessor :accessories

end	# class Character

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
