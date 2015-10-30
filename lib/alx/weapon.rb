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

require_relative('armor.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a weapon.
class Weapon < DolEntry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # State IDs
  STATES = Hash.new('???')
  STATES.store(-1, 'None'         )
  STATES.store( 0, 'Poison'       )
  STATES.store( 1, 'Sleep #1'     )
  STATES.store( 2, 'Weak'         )
  STATES.store( 3, 'Confusion #1)')
  STATES.store( 4, 'Sleep #2'     )
  STATES.store( 5, 'Confusion #2' )
  STATES.store( 6, 'Death #1'     )
  STATES.store( 7, 'Silence #1'   )
  STATES.store( 8, 'Stone #1'     )
  STATES.store( 9, 'Sleep #3'     )
  STATES.store(10, 'Death #2'     )
  STATES.store(11, 'Confusion #3' )
  STATES.store(12, 'Silence #2'   )
  STATES.store(13, 'Stone #2'     )
  STATES.store(14, 'Confusion #4' )
  STATES.store(15, 'Sleep #4'     )
  STATES.store(16, 'Death #3'     )
  STATES.store(17, 'Sleep #5'     )
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Weapon.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::PC_ID           ,  0, 'c' )
    members << StrDmy.new(CsvHdr::PC_NAME         , ''      )
    members << IntVar.new(CsvHdr::RETAIL_PRICE    ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE, -1, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET  , -1, 'c' )
    members << IntVar.new(CsvHdr::STATE_ID        , -1, 'c' )
    members << StrDmy.new(CsvHdr::STATE_NAME      , ''      )
    
    if region == 'P'
      members << IntVar.new(padding_hdr           ,  0, 'c' )
    end
    
    members << IntVar.new(CsvHdr::PURCHASE_PRICE  ,  0, 'S>')
    members << IntVar.new(CsvHdr::ATTACK          ,  0, 's>')
    members << IntVar.new(CsvHdr::HIT             ,  0, 's>')
    members << IntVar.new(CsvHdr::FEATURE_ID[0]   , -1, 'c' )
    members << StrDmy.new(CsvHdr::FEATURE_NAME[0] ,  ''     )
    members << IntVar.new(padding_hdr             ,  0, 'c' )
    members << IntVar.new(CsvHdr::FEATURE_VALUE[0],  0, 's>')

    add_dscr_members
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    _id = find_member(CsvHdr::PC_ID).value
    find_member(CsvHdr::PC_NAME).value = PCS[_id]
    
    _id = find_member(CsvHdr::STATE_ID).value
    find_member(CsvHdr::STATE_NAME).value = STATES[_id]
    
    _id = find_member(CsvHdr::FEATURE_ID[0]).value
    find_member(CsvHdr::FEATURE_NAME[0]).value = Armor::FEATURES[_id]
    
    super
  end

end	# class Weapon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
