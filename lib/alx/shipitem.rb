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

# Class to handle a ship item.
class ShipItem < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipItem.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    add_name_members

    members << IntVar.new(VOC.occasion_flags            ,  0, 'c' )
    members << StrDmy.new(VOC.occasion_menu             , ''      )
    members << StrDmy.new(VOC.occasion_battle           , ''      )
    members << StrDmy.new(VOC.occasion_ship             , ''      )
    members << IntVar.new(VOC.ship_effect_id            ,  0, 'c' )
    members << StrDmy.new(VOC.ship_effect_name          , ''      )
    members << IntVar.new(VOC.ship_effect_turns         ,  0, 'c' )
    members << IntVar.new(VOC.consume                   ,  0, 'c' )

    unless is_eu?
      members << IntVar.new(padding_hdr                 ,  0, 'c' )
    end

    members << IntVar.new(VOC.purchase_price            ,  0, 'S>')
    members << IntVar.new(VOC.retail_price              ,  0, 'c' )
    members << IntVar.new(VOC.order_priority            ,  0, 'c' )
    members << IntVar.new(VOC.order_alphabet[country_id],  0, 'c' )
    members << IntVar.new(padding_hdr                   ,  0, 'c' )
    
    if is_eu?
      members << IntVar.new(padding_hdr                 ,  0, 'c' )
      members << IntVar.new(padding_hdr                 ,  0, 'c' )
    end
    
    members << IntVar.new(VOC.ship_effect_value         ,  0, 's>')
    members << IntVar.new(VOC.element_id                ,  0, 'c' )
    members << StrDmy.new(VOC.element_name              , ''      )
    members << IntVar.new(unknown_hdr                   ,  0, 'c' )
    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(VOC.hit                       ,  0, 's>')

    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _flags = find_member(VOC.occasion_flags).value
    VOC.occasions.each do |_id, _occasion|
      find_member(_occasion).value = _flags & (0x4 >> _id) != 0 ? 'X' : ''
    end
    
    _id = find_member(VOC.ship_effect_id).value
    find_member(VOC.ship_effect_name).value = VOC.effects[_id]
    
    _id = find_member(VOC.element_id).value
    find_member(VOC.element_name).value = VOC.elements[_id]
    
    super
  end

end	# class ShipItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
