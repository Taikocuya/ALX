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

# Class to handle a character super move.
class CharacterSuperMove < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterSuperMove.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(VOC.element_id        ,  0, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr         ,  0, 'c' )
    end
    
    members << StrDmy.new(VOC.element_name      , ''      )
    members << IntVar.new(VOC.order_priority    ,  0, 's>')
    members << IntVar.new(VOC.occasion_flags    ,  0, 'c' )
    members << StrDmy.new(VOC.occasion_menu     , ''      )
    members << StrDmy.new(VOC.occasion_battle   , ''      )
    members << StrDmy.new(VOC.occasion_ship     , ''      )
    members << IntVar.new(VOC.effect_id         , -1, 'c' )
    members << StrDmy.new(VOC.effect_name       , ''      )
    members << IntVar.new(VOC.scope_id          ,  0, 'C' )
    members << StrDmy.new(VOC.scope_name        , ''      )
    members << IntVar.new(VOC.category_id       ,  0, 'c' )
    members << StrDmy.new(VOC.category_name     , ''      )
    members << IntVar.new(VOC.effect_priority   , -1, 'c' )
    members << IntVar.new(VOC.effect_spirit     , -1, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(VOC.effect_value[-1]  , -1, 's>')
    members << IntVar.new(VOC.type_id           ,  0, 'c' )
    members << StrDmy.new(VOC.type_name         , ''      )
    members << IntVar.new(VOC.state_id          ,  0, 'c' )
    members << StrDmy.new(VOC.state_name        , ''      )
    members << IntVar.new(VOC.state_hit         ,  0, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(VOC.ship_occasion_id  ,  0, 'c' )
    members << StrDmy.new(VOC.ship_occasion_name, ''      )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(VOC.ship_effect_id    , -1, 's>')
    members << StrDmy.new(VOC.ship_effect_name  , ''      )
    members << IntVar.new(VOC.ship_effect_spirit, -1, 'c' )
    members << IntVar.new(VOC.ship_effect_turns , -1, 'c' )
    members << IntVar.new(VOC.ship_effect_value ,  0, 's>')
    members << IntVar.new(VOC.unknown[-1]       , -1, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )
    members << IntVar.new(padding_hdr           ,  0, 'c' )

    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(VOC.element_id).value
    find_member(VOC.element_name).value = VOC.elements[_id]

    _flags = find_member(VOC.occasion_flags).value
    VOC.occasions.each do |_id, _occasion|
      find_member(_occasion).value = _flags & (0x4 >> _id) != 0 ? 'X' : ''
    end
    
    _id = find_member(VOC.effect_id).value
    find_member(VOC.effect_name).value = VOC.effects[_id]
    
    _id = find_member(VOC.scope_id).value
    find_member(VOC.scope_name).value = VOC.scopes[_id]
    
    _id = find_member(VOC.category_id).value
    find_member(VOC.category_name).value = VOC.character_skill_categories[_id]

    _id = find_member(VOC.type_id).value
    find_member(VOC.type_name).value = VOC.types[_id]

    _id = find_member(VOC.state_id).value
    find_member(VOC.state_name).value = VOC.states[_id]
    
    _id = find_member(VOC.ship_occasion_id).value
    find_member(VOC.ship_occasion_name).value = VOC.ship_occasions[_id]
    
    _id = find_member(VOC.ship_effect_id).value
    find_member(VOC.ship_effect_name).value = VOC.effects[_id]
    
    super
  end

end	# class CharacterSuperMove

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
