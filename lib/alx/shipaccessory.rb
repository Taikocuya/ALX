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

# Class to handle a ship accessory.
class ShipAccessory < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipAccessory.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    add_name_members

    members << IntVar.new(VOC.ship_flags                  ,  0, :int8  )
    
    if eu?
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
    end

    VOC.ships.each do |_id, _ship|
      members << StrDmy.new(_ship                         , ''         )
    end

    if product_id != '6107110 06' && product_id != '6107810'
      (0...4).each do |_i|
        members << IntVar.new(VOC.feature_id[_i]          , -1, :int8  )
        members << StrDmy.new(VOC.feature_name[_i]        , ''         )
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
        members << IntVar.new(VOC.feature_value[_i]       ,  0, :int16 )
      end
  
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
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
  
      add_dscr_members
    else
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(VOC.purchase_price            ,  0, :uint16)
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      members << IntVar.new(VOC.retail_price              ,  0, :int8  )
      members << IntVar.new(padding_hdr                   ,  0, :int8  )
      
      (0...4).each do |_i|
        members << IntVar.new(VOC.feature_id[_i]          , -1, :int8  )
        members << StrDmy.new(VOC.feature_name[_i]        , ''         )
        members << IntVar.new(padding_hdr                 ,  0, :int8  )
        members << IntVar.new(VOC.feature_value[_i]       ,  0, :int16 )
      end
      
      members << IntVar.new(VOC.order_priority            ,  0, :int8  )
      members << IntVar.new(VOC.order_alphabet[country_id],  0, :int8  )
    end
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _flags = find_member(VOC.ship_flags).value
    VOC.ships.each do |_id, _ship|
      find_member(_ship).value = _flags & (0x20 >> _id) != 0 ? 'X' : ''
    end

    (0...4).each do |_i|
      _id = find_member(VOC.feature_id[_i]).value
      find_member(VOC.feature_name[_i]).value = VOC.ship_accessory_features[_id]
    end

    super
  end

end	# class ShipAccessory

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
