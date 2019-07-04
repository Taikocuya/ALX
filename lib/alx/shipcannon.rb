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

# Class to handle a ship cannon.
class ShipCannon < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipCannon.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    add_name_members

    members << IntVar.new(VOC.ship_flags                  ,  0, :int8  )

    VOC.ships.each_value do |_ship|
      members << StrDmy.new(_ship                         , ''         )
    end

    members << IntVar.new(VOC.type_id                     ,  0, :int8  )
    members << StrDmy.new(VOC.type_name                   , ''         )
    members << IntVar.new(VOC.element_id                  ,  0, :int8  )
    members << StrDmy.new(VOC.element_name                , ''         )

    if product_id != '6107110 06' && product_id != '6107810'
      if eu?
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
      end
      
      members << IntVar.new(VOC.attack                    ,  0, :int16 )
      members << IntVar.new(VOC.hit                       ,  0, :uint16)
      members << IntVar.new(VOC.limit                     ,  0, :int8  )
      members << IntVar.new(VOC.spirit[-1]                ,  0, :int8  )
      members << IntVar.new(VOC.feature_id[-1]            , -1, :int8  )
      members << StrDmy.new(VOC.feature_name[-1]          , ''         )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(VOC.feature_value[-1]         ,  0, :int16 )
  
      if dc?
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
      end
      
      members << IntVar.new(VOC.purchase_price            ,  0, :uint16)
  
      if dc?
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
      end
      
      members << IntVar.new(VOC.retail_price              ,  0, :int8  )
      members << IntVar.new(VOC.order_priority            ,  0, :int8  )
      members << IntVar.new(VOC.order_alphabet[country_id],  0, :int8  )
  
      if dc? || eu?
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
      else
        members << IntVar.new(VOC.padding[-1]             ,  0, :int8  )
      end
    
      add_dscr_members
    else
      members << IntVar.new(VOC.purchase_price            ,  0, :uint16)
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(VOC.retail_price              ,  0, :int8  )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(VOC.attack                    ,  0, :int16 )
      members << IntVar.new(VOC.hit                       ,  0, :uint16)
      members << IntVar.new(VOC.limit                     ,  0, :int8  )
      members << IntVar.new(VOC.spirit[-1]                ,  0, :int8  )
  
      (0...4).each do |_i|
        members << IntVar.new(VOC.feature_id[_i]          , -1, :int8  )
        members << StrDmy.new(VOC.feature_name[_i]        , ''         )
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
        members << IntVar.new(VOC.feature_value[_i]       ,  0, :int16 )
      end
  
      members << IntVar.new(VOC.order_priority            ,  0, :int8  )
      members << IntVar.new(VOC.order_alphabet[country_id],  0, :int8  )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
    end
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

    if product_id != '6107110 06' && product_id != '6107810'
      _id   = find_member(VOC.feature_id[-1]).value
      _name = VOC.ship_accessory_features[_id]
      find_member(VOC.feature_name[-1]).value = _name
    else
      (0...4).each do |_i|
        _id   = find_member(VOC.feature_id[_i]).value
        _name = VOC.ship_accessory_features[_id]
        find_member(VOC.feature_name[_i]).value = _name
      end
    end
    
    super
  end

end	# class ShipCannon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
