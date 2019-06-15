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

# Class to handle a enemy skill.
class EnemySuperMove < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemySuperMove.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    add_name_members

    unless eu?
      members << IntVar.new(padding_hdr      ,  0, 'c' )
      members << IntVar.new(padding_hdr      ,  0, 'c' )
      members << IntVar.new(padding_hdr      ,  0, 'c' )
      members << IntVar.new(padding_hdr      ,  0, 'c' )
    end
    
    members << IntVar.new(VOC.category_id    ,  0, 'c' )
    members << StrDmy.new(VOC.category_name  , ''      )
    members << IntVar.new(VOC.effect_id      , -1, 'c' )
    members << StrDmy.new(VOC.effect_name    , ''      )
    members << IntVar.new(VOC.scope_id       ,  0, 'C' )
    members << StrDmy.new(VOC.scope_name     , ''      )
    
    if eu?
      members << IntVar.new(padding_hdr      ,  0, 'c' )
    end
    
    members << IntVar.new(VOC.effect_value[1],  0, 's>')
    members << IntVar.new(VOC.effect_value[2],  0, 's>')
    members << IntVar.new(VOC.element_id     ,  0, 'c' )
    members << StrDmy.new(VOC.element_name   , ''      )
    members << IntVar.new(VOC.type_id        ,  0, 'c' )
    members << StrDmy.new(VOC.type_name      , ''      )
    members << IntVar.new(unknown_hdr        ,  0, 'c' )
    members << IntVar.new(unknown_hdr        ,  0, 'c' )
    members << IntVar.new(VOC.state_id       ,  0, 'c' )
    members << StrDmy.new(VOC.state_name     , ''      )
    members << IntVar.new(VOC.state_hit      ,  0, 'c' )
    members << IntVar.new(padding_hdr        ,  0, 'c' )
    members << IntVar.new(padding_hdr        ,  0, 'c' )
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(VOC.category_id).value
    find_member(VOC.category_name).value = VOC.enemy_skill_categories[_id]
    
    _id = find_member(VOC.effect_id).value
    find_member(VOC.effect_name).value = VOC.effects[_id]

    _id = find_member(VOC.scope_id).value
    find_member(VOC.scope_name).value = VOC.scopes[_id]

    _id = find_member(VOC.element_id).value
    find_member(VOC.element_name).value = VOC.elements[_id]

    _id = find_member(VOC.type_id).value
    find_member(VOC.type_name).value = VOC.types[_id]

    _id = find_member(VOC.state_id).value
    find_member(VOC.state_name).value = VOC.states[_id]

    super
  end

end	# class EnemySuperMove

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
