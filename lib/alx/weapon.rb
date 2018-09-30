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

require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a weapon.
class Weapon < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Weapon.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(VOC.character_id[-1]        ,  0, 'c' )
    members << StrDmy.new(VOC.character_name[-1]      , ''      )
    members << IntVar.new(VOC.retail_price            ,  0, 'c' )
    members << IntVar.new(VOC.order_priority          , -1, 'c' )
    members << IntVar.new(VOC.order_alphabet[iso_code], -1, 'c' )
    members << IntVar.new(VOC.effect_id               , -1, 'c' )
    members << StrDmy.new(VOC.effect_name             , ''      )
    
    if region == 'P'
      members << IntVar.new(padding_hdr               ,  0, 'c' )
    end
    
    members << IntVar.new(VOC.purchase_price          ,  0, 'S>')
    members << IntVar.new(VOC.attack                  ,  0, 's>')
    members << IntVar.new(VOC.hit                     ,  0, 's>')
    members << IntVar.new(VOC.feature_id[-1]          , -1, 'c' )
    members << StrDmy.new(VOC.feature_name[-1]        ,  ''     )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    members << IntVar.new(VOC.feature_value[-1]       ,  0, 's>')

    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(VOC.character_id[-1]).value
    find_member(VOC.character_name[-1]).value = VOC.characters[_id]
    
    _id = find_member(VOC.effect_id).value
    find_member(VOC.effect_name).value = VOC.weapon_effects[_id]
    
    _id = find_member(VOC.feature_id[-1]).value
    find_member(VOC.feature_name[-1]).value = VOC.accessory_features[_id]
    
    super
  end

end	# class Weapon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
