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

require_relative('shipcannon.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a ship accessory.
class ShipAccessory < StdEntry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Feature IDs
  FEATURES = Hash.new('???')
  FEATURES.store(-1, 'None')
  FEATURES.store( 2, 'Defense')
  FEATURES.store( 3, 'MagDef')
  FEATURES.store( 4, 'Quick')
  FEATURES.store( 6, 'Dodge%')
  FEATURES.store( 7, 'Value')
  FEATURES.store(48, 'Attack: Main cannon')
  FEATURES.store(64, 'Attack: Secondary cannon')
  FEATURES.store(81, 'Hit%: Torpedo')
  FEATURES.store(96, 'Attack: S-Cannon')
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipAccessory.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::SHIP_FLAGS         ,  0, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr              ,  0, 'c' )
    end
    
    members << StrDmy.new(CsvHdr::SHIP_LITTLEJACK[1] , ''      )
    members << StrDmy.new(CsvHdr::SHIP_LITTLEJACK[2] , ''      )
    members << StrDmy.new(CsvHdr::SHIP_DELPHINUS[1]  , ''      )
    members << StrDmy.new(CsvHdr::SHIP_DELPHINUS[2]  , ''      )
    members << StrDmy.new(CsvHdr::SHIP_DELPHINUS[3]  , ''      )

    (1..4).each do |_i|
      members << IntVar.new(CsvHdr::FEATURE_ID[_i]   , -1, 'c' )
      members << StrDmy.new(CsvHdr::FEATURE_NAME[_i] , ''      )
      members << IntVar.new(padding_hdr              ,  0, 'c' )
      members << IntVar.new(CsvHdr::FEATURE_VALUE[_i],  0, 's>')
    end

    members << IntVar.new(CsvHdr::PURCHASE_PRICE     ,  0, 'S>')
    members << IntVar.new(CsvHdr::RETAIL_PRICE       ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE   ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET     ,  0, 'c' )
    members << IntVar.new(padding_hdr                ,  0, 'c' )

    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _flags = find_member(CsvHdr::SHIP_FLAGS).value
    SHIPS.each do |_id, _ship|
      find_member(_ship).value = _flags & (0x20 >> _id) != 0 ? 'X' : ''
    end

    (1..4).each do |_i|
      _id = find_member(CsvHdr::FEATURE_ID[_i]).value
      find_member(CsvHdr::FEATURE_NAME[_i]).value = FEATURES[_id]
    end

    super
  end

end	# class ShipAccessory

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
