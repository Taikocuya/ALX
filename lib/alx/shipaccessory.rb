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

# Class to handle a ship accessory.
class ShipAccessory < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipAccessory.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(VOC.ship_flags              ,  0, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr               ,  0, 'c' )
    end
    
    members << StrDmy.new(VOC.ship_littlejack[1]      , ''      )
    members << StrDmy.new(VOC.ship_littlejack[2]      , ''      )
    members << StrDmy.new(VOC.ship_delphinus[1]       , ''      )
    members << StrDmy.new(VOC.ship_delphinus[2]       , ''      )
    members << StrDmy.new(VOC.ship_delphinus[3]       , ''      )

    (0...4).each do |_i|
      members << IntVar.new(VOC.feature_id[_i]        , -1, 'c' )
      members << StrDmy.new(VOC.feature_name[_i]      , ''      )
      members << IntVar.new(padding_hdr               ,  0, 'c' )
      members << IntVar.new(VOC.feature_value[_i]     ,  0, 's>')
    end

    members << IntVar.new(VOC.purchase_price          ,  0, 'S>')
    members << IntVar.new(VOC.retail_price            ,  0, 'c' )
    members << IntVar.new(VOC.order_priority          ,  0, 'c' )
    members << IntVar.new(VOC.order_alphabet[iso_code],  0, 'c' )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )

    add_dscr_members
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
