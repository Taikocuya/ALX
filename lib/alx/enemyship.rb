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

require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a enemy ship.
class EnemyShip < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemyShip.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @items = {}
    add_name_members(20)
    
    members << IntVar.new(VOC.maxhp                   , -1, :int32)
    members << IntVar.new(VOC.will                    , -1, :int16)
    members << IntVar.new(VOC.defense                 , -1, :int16)
    members << IntVar.new(VOC.magdef                  , -1, :int16)
    members << IntVar.new(VOC.quick                   , -1, :int16)
    members << IntVar.new(VOC.agile                   , -1, :int16)
    members << IntVar.new(VOC.dodge                   , -1, :int16)
    
    (0...6).each do |_i|
      members << IntVar.new(VOC.elements[_i]          , -1, :int16)
    end
    (0...4).each do |_i|
      if eu?
        members << IntExt.new(VOC.arm_name_de_pos[_i] ,  0        )
        members << IntExt.new(VOC.arm_name_de_size[_i],  0        )
        members << StrExt.new(VOC.arm_name_de_str[_i] , ''        )
        members << IntExt.new(VOC.arm_name_es_pos[_i] ,  0        )
        members << IntExt.new(VOC.arm_name_es_size[_i],  0        )
        members << StrExt.new(VOC.arm_name_es_str[_i] , ''        )
        members << IntExt.new(VOC.arm_name_fr_pos[_i] ,  0        )
        members << IntExt.new(VOC.arm_name_fr_size[_i],  0        )
        members << StrExt.new(VOC.arm_name_fr_str[_i] , ''        )
        members << IntExt.new(VOC.arm_name_gb_pos[_i] ,  0        )
        members << IntExt.new(VOC.arm_name_gb_size[_i],  0        )
        members << StrExt.new(VOC.arm_name_gb_str[_i] , ''        )
      end
      members << IntVar.new(VOC.arm_type_id[_i]       , -1, :int16)
      members << StrDmy.new(VOC.arm_type_name[_i]     , ''        )
      members << IntVar.new(VOC.arm_attack[_i]        , -1, :int16)
      members << IntVar.new(VOC.arm_range[_i]         , -1, :int16)
      members << IntVar.new(VOC.arm_hit[_i]           , -1, :int16)
      members << IntVar.new(VOC.arm_element_id[_i]    , -1, :int16)
      members << StrDmy.new(VOC.arm_element_name[_i]  , ''        )
    end

    members << IntVar.new(padding_hdr                 ,  0, :int16)
    members << IntVar.new(padding_hdr                 ,  0, :int16)
    members << IntVar.new(padding_hdr                 ,  0, :int16)
    members << IntVar.new(padding_hdr                 ,  0, :int16)
    members << IntVar.new(padding_hdr                 ,  0, :int16)
    members << IntVar.new(padding_hdr                 ,  0, :int16)
    members << IntVar.new(VOC.exp[-1]                 , -1, :int32)
    members << IntVar.new(VOC.gold                    , -1, :int32)

    (0...3).each do |_i|
      members << IntVar.new(VOC.item_drop_id[_i]      , -1, :int16)
      members << StrDmy.new(VOC.item_drop_name[_i]    , ''        )
      members << IntVar.new(VOC.item_id[_i]           , -1, :int16)
      members << StrDmy.new(VOC.item_name[_i]         , ''        )
    end
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    (0...4).each do |_i|
      _id = find_member(VOC.arm_type_id[_i]).value
      find_member(VOC.arm_type_name[_i]).value = VOC.ship_cannon_types[_id]
      
      _id = find_member(VOC.arm_element_id[_i]).value
      find_member(VOC.arm_element_name[_i]).value = VOC.elements[_id]
    end

    (0...3).each do |_i|
      _id = find_member(VOC.item_id[_i]).value
      if _id != -1
        _entry = @items[_id]
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
      find_member(VOC.item_name[_i]).value = _name
    end

    (0...3).each do |_i|
      _id = find_member(VOC.item_drop_id[_i]).value
      find_member(VOC.item_drop_name[_i]).value = VOC.drops[_id]
    end
    
    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :items

end	# class EnemyShip

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
