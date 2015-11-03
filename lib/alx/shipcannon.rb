#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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

require_relative('effectable.rb')
require_relative('dolentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a ship cannon.
class ShipCannon < DolEntry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Type IDs
  TYPES = Hash.new('???')
  TYPES.store(-1, 'None'            )
  TYPES.store( 0, 'Main cannon'     )
  TYPES.store( 1, 'Secondary cannon')
  TYPES.store( 2, 'Torpedo'         )
  TYPES.store( 3, 'Special'         )

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipCannon.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::SHIP_FLAGS      ,  0, 'c' )
    members << StrDmy.new(CsvHdr::SHIP_MODEL1     , ''      )
    members << StrDmy.new(CsvHdr::SHIP_MODEL2     , ''      )
    members << StrDmy.new(CsvHdr::SHIP_MODEL3     , ''      )
    members << StrDmy.new(CsvHdr::SHIP_MODEL4     , ''      )
    members << StrDmy.new(CsvHdr::SHIP_MODEL5     , ''      )
    members << IntVar.new(CsvHdr::TYPE_ID         ,  0, 'c' )
    members << StrDmy.new(CsvHdr::TYPE_NAME       , ''      )
    members << IntVar.new(CsvHdr::ELEMENT_ID      ,  0, 'c' )
    members << StrDmy.new(CsvHdr::ELEMENT_NAME    , ''      )
    
    if region == 'P'
      members << IntVar.new(padding_hdr           ,  0, 'c' )
    end
    
    members << IntVar.new(CsvHdr::ATTACK          ,  0, 's>')
    members << IntVar.new(CsvHdr::HIT             ,  0, 'S>')
    members << IntVar.new(CsvHdr::LIMIT           ,  0, 'c' )
    members << IntVar.new(CsvHdr::SPIRIT          ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(CsvHdr::PURCHASE_PRICE  ,  0, 'S>')
    members << IntVar.new(CsvHdr::RETAIL_PRICE    ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET  ,  0, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr           ,  0, 'c' )
    else
      members << IntVar.new(CsvHdr::PADDING[0]    ,  0, 'c' )
    end

    add_dscr_members
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    _flags = find_member(CsvHdr::SHIP_FLAGS).value
    SHIPS.each do |_id, _ship|
      find_member(_ship).value = _flags & (0x20 >> _id) != 0 ? 'X' : ''
    end
    
    _id = find_member(CsvHdr::TYPE_ID).value
    find_member(CsvHdr::TYPE_NAME).value = TYPES[_id]
    
    _id = find_member(CsvHdr::ELEMENT_ID).value
    find_member(CsvHdr::ELEMENT_NAME).value = ELEMENTS[_id]
    
    super
  end

end	# class ShipCannon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
