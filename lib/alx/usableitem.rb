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

require_relative('dolentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a usable item.
class UsableItem < DolEntry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Occasion IDs
  OCCASIONS = Hash.new('???')
  OCCASIONS.store(0, CsvHdr::OCCASION_MENU  )
  OCCASIONS.store(1, CsvHdr::OCCASION_BATTLE)
  OCCASIONS.store(2, CsvHdr::OCCASION_SHIP  )

  # Effect IDs
  EFFECTS = Hash.new('???')
  EFFECTS.store(-1, 'None'                       )
  EFFECTS.store( 0, 'Damage'                     )
  EFFECTS.store( 6, 'Add state: Unconscious'     )
  EFFECTS.store( 9, 'Add state: Sleep'           )
  EFFECTS.store(11, 'Add state: Confusion'       )
  EFFECTS.store(12, 'Add state: Silence'         )
  EFFECTS.store(20, 'Add state: Quickened'       )
  EFFECTS.store(21, 'Add state: Strengthen'      )
  EFFECTS.store(26, 'Add state: Weak'            )
  EFFECTS.store(27, 'Revive and recover HP: 50%' )
  EFFECTS.store(28, 'Revive and recover HP: 100%')
  EFFECTS.store(30, 'Remove adverse states'      )
  EFFECTS.store(31, 'Recover HP'                 )
  EFFECTS.store(32, 'Recover HP: 100%'           )
  EFFECTS.store(33, 'Add state: Regenerate'      )
  EFFECTS.store(35, 'Recover SP'                 )
  EFFECTS.store(48, 'Recover MP'                 )
  EFFECTS.store(49, 'Recover MP: 100%'           )
  EFFECTS.store(51, 'Recover HP and MP'          )
  EFFECTS.store(52, 'Moonberry'                  )
  EFFECTS.store(53, 'Evolve Cupil: Cham'         )
  EFFECTS.store(54, 'Increase: Power'            )
  EFFECTS.store(55, 'Increase: Will'             )
  EFFECTS.store(56, 'Increase: Vigor'            )
  EFFECTS.store(57, 'Increase: Agile'            )
  EFFECTS.store(58, 'Increase: Quick'            )
  EFFECTS.store(59, 'Increase: HP'               )
  EFFECTS.store(60, 'Increase: MP'               )
  EFFECTS.store(75, 'Evolve Cupil: Abirik Cham'  )
  EFFECTS.store(76, 'Reset Cupil'                )

  # Scope IDs
  SCOPES = Hash.new('???')
  SCOPES.store( 0, 'None'                  )
  SCOPES.store( 1, 'One ally'              )
  SCOPES.store( 2, 'All allies'            )
  SCOPES.store( 3, 'One enemy'             )
  SCOPES.store( 4, 'All enemies'           )
  SCOPES.store( 5, 'User'                  )
  SCOPES.store( 6, 'All allies and enemies')
  SCOPES.store(32, 'Enemy area: Small'     )
  SCOPES.store(33, 'Enemy area: Medium'    )
  SCOPES.store(34, 'Enemy area: Large'     )
  SCOPES.store(36, 'Enemy line: Small'     )
  SCOPES.store(37, 'Enemy line: Medium'    )
  SCOPES.store(38, 'Enemy line: Large'     )
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an UsableItem.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::OCCASION_FLAGS  ,  0, 'c' )
    members << StrDmy.new(CsvHdr::OCCASION_MENU   , ''      )
    members << StrDmy.new(CsvHdr::OCCASION_BATTLE , ''      )
    members << StrDmy.new(CsvHdr::OCCASION_SHIP   , ''      )
    members << IntVar.new(CsvHdr::EFFECT_ID       , -1, 'c' )
    members << StrDmy.new(CsvHdr::EFFECT_NAME     , ''      )
    members << IntVar.new(CsvHdr::SCOPE_ID        ,  0, 'c' )
    members << StrDmy.new(CsvHdr::SCOPE_NAME      , ''      )
    members << IntVar.new(CsvHdr::CONSUME         ,  0, 'c' )
    members << IntVar.new(CsvHdr::RETAIL_PRICE    ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET  , -1, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr           ,  0, 'c' )
    end
    
    members << IntVar.new(CsvHdr::PURCHASE_PRICE  ,  0, 'S>')
    members << IntVar.new(padding_hdr             ,  0, 'c' )
    members << IntVar.new(padding_hdr             ,  0, 'c' )
    members << IntVar.new(CsvHdr::EFFECT_AMOUNT   ,  0, 's>')
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(padding_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(padding_hdr             ,  0, 'c' )
    members << IntVar.new(CsvHdr::HIT             ,  0, 'c' )
    
    add_dscr_members
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    _flags = find_member(CsvHdr::OCCASION_FLAGS).value
    OCCASIONS.each do |_id, _occasion|
      find_member(_occasion).value = _flags & (0x4 >> _id) != 0 ? 'X' : ''
    end
    
    _id = find_member(CsvHdr::EFFECT_ID).value
    find_member(CsvHdr::EFFECT_NAME).value = EFFECTS[_id]
    
    _id = find_member(CsvHdr::SCOPE_ID).value
    find_member(CsvHdr::SCOPE_NAME).value = SCOPES[_id]
    
    super
  end

end	# class UsableItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
