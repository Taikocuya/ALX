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

# Class to handle a crew member.
class CrewMember < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CrewMember.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    add_name_members

    members << IntVar.new(VOC.position_id         , -1, :int8 )
    members << StrDmy.new(VOC.position_name       , ''        )

    if product_id != '6107110 06' && product_id != '6107810'
      if eu?
        members << IntVar.new(padding_hdr           ,  0, :int8 )
      end
      
      members << IntVar.new(VOC.feature_id[-1]      , -1, :int8 )
      members << StrDmy.new(VOC.feature_name[-1]    , ''        )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(VOC.feature_value[-1]   ,  0, :int16)
      members << IntVar.new(VOC.ship_effect_id      , -1, :int8 )
      members << StrDmy.new(VOC.ship_effect_name    , ''        )
      members << IntVar.new(VOC.ship_effect_spirit  , -1, :int8 )
      members << IntVar.new(VOC.ship_effect_turns   , -1, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      
      if gc? && jp?
        members << IntVar.new(VOC.unknown[-1]       ,  0, :int16)
        members << IntVar.new(VOC.ship_effect_value ,  0, :int16)
      else
        members << IntVar.new(VOC.ship_effect_value ,  0, :int16)
        members << IntVar.new(VOC.unknown[-1]       ,  0, :int16)
      end
  
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      
      add_dscr_members
    else
      members << IntVar.new(VOC.feature_id[-1]      , -1, :int8 )
      members << StrDmy.new(VOC.feature_name[-1]    , ''        )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(VOC.feature_value[-1]   ,  0, :int16)
      members << IntVar.new(VOC.ship_effect_id      , -1, :uint8)
      members << StrDmy.new(VOC.ship_effect_name    , ''        )
      members << IntVar.new(VOC.ship_effect_turns   , -1, :int8 )
      members << IntVar.new(VOC.ship_effect_value   , -1, :int16)
      members << IntVar.new(unknown_hdr             ,  0, :int16)
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
      members << IntVar.new(padding_hdr             ,  0, :int8 )
    end
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(VOC.position_id).value
    find_member(VOC.position_name).value = VOC.positions[_id]

    _id = find_member(VOC.feature_id[-1]).value
    find_member(VOC.feature_name[-1]).value = VOC.ship_accessory_features[_id]

    _id = find_member(VOC.ship_effect_id).value
    find_member(VOC.ship_effect_name).value = VOC.effects[_id]
    
    super
  end

end	# class CrewMember

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
