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
require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a ship item.
class ShipItem < StdEntry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipItem.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::OCCASION_FLAGS    ,  0, 'c' )
    members << StrDmy.new(CsvHdr::OCCASION_MENU     , ''      )
    members << StrDmy.new(CsvHdr::OCCASION_BATTLE   , ''      )
    members << StrDmy.new(CsvHdr::OCCASION_SHIP     , ''      )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_ID    ,  0, 'c' )
    members << StrDmy.new(CsvHdr::SHIP_EFFECT_NAME  , ''      )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_TURNS ,  0, 'c' )
    members << IntVar.new(CsvHdr::CONSUME           ,  0, 'c' )

    if region != 'P'
      members << IntVar.new(padding_hdr             ,  0, 'c' )
    end

    members << IntVar.new(CsvHdr::PURCHASE_PRICE    ,  0, 'S>')
    members << IntVar.new(CsvHdr::RETAIL_PRICE      ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE  ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET    ,  0, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr             ,  0, 'c' )
      members << IntVar.new(padding_hdr             ,  0, 'c' )
    end
    
    members << IntVar.new(CsvHdr::SHIP_EFFECT_VALUE,  0, 's>')
    members << IntVar.new(CsvHdr::ELEMENT_ID       ,  0, 'c' )
    members << StrDmy.new(CsvHdr::ELEMENT_NAME     , ''      )
    members << IntVar.new(unknown_hdr              ,  0, 'c' )
    members << IntVar.new(unknown_hdr              ,  0, 's>')
    members << IntVar.new(CsvHdr::HIT              ,  0, 's>')

    add_dscr_members
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    _flags = find_member(CsvHdr::OCCASION_FLAGS).value
    OCCASIONS.each do |_id, _occasion|
      find_member(_occasion).value = _flags & (0x4 >> _id) != 0 ? 'X' : ''
    end
    
    _id = find_member(CsvHdr::SHIP_EFFECT_ID).value
    find_member(CsvHdr::SHIP_EFFECT_NAME).value = EFFECTS[_id]
    
    _id = find_member(CsvHdr::ELEMENT_ID).value
    find_member(CsvHdr::ELEMENT_NAME).value = ELEMENTS[_id]
    
    super
  end

end	# class ShipItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
