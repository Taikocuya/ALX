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

# Class to handle a ship cannon.
class ShipCannon < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipCannon.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(VOC.ship_flags              ,  0, 'c' )
    members << StrDmy.new(VOC.ship_littlejack[1]      , ''      )
    members << StrDmy.new(VOC.ship_littlejack[2]      , ''      )
    members << StrDmy.new(VOC.ship_delphinus[1]       , ''      )
    members << StrDmy.new(VOC.ship_delphinus[2]       , ''      )
    members << StrDmy.new(VOC.ship_delphinus[3]       , ''      )
    members << IntVar.new(VOC.type_id                 ,  0, 'c' )
    members << StrDmy.new(VOC.type_name               , ''      )
    members << IntVar.new(VOC.element_id              ,  0, 'c' )
    members << StrDmy.new(VOC.element_name            , ''      )
    
    if region == 'P'
      members << IntVar.new(padding_hdr               ,  0, 'c' )
    end
    
    members << IntVar.new(VOC.attack                  ,  0, 's>')
    members << IntVar.new(VOC.hit                     ,  0, 'S>')
    members << IntVar.new(VOC.limit                   ,  0, 'c' )
    members << IntVar.new(VOC.spirit                  ,  0, 'c' )
    members << IntVar.new(unknown_hdr                 ,  0, 'c' )
    members << IntVar.new(unknown_hdr                 ,  0, 'c' )
    members << IntVar.new(unknown_hdr                 ,  0, 'c' )
    members << IntVar.new(unknown_hdr                 ,  0, 'c' )
    members << IntVar.new(VOC.purchase_price          ,  0, 'S>')
    members << IntVar.new(VOC.retail_price            ,  0, 'c' )
    members << IntVar.new(VOC.order_priority          ,  0, 'c' )
    members << IntVar.new(VOC.order_alphabet[iso_code],  0, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr               ,  0, 'c' )
    else
      members << IntVar.new(VOC.padding[-1]           ,  0, 'c' )
    end

    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _flags = find_member(VOC.ship_flags).value
    VOC.ships.each do |_id, _ship|
      find_member(_ship).value = _flags & (0x20 >> _id) != 0 ? 'X' : ''
    end
    
    _id = find_member(VOC.type_id).value
    find_member(VOC.type_name).value = VOC.ship_cannon_types[_id]
    
    _id = find_member(VOC.element_id).value
    find_member(VOC.element_name).value = VOC.elements[_id]
    
    super
  end

end	# class ShipCannon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
