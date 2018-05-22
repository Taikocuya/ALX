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

require_relative('armor.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a weapon.
class Weapon < StdEntry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Effect IDs
  EFFECTS = Hash.new('???')
  EFFECTS.store(-1, 'None'            )
  EFFECTS.store( 0, 'Add Poison'      )
  EFFECTS.store( 1, 'Add Sleep #1'    )
  EFFECTS.store( 2, 'Add Weak'        )
  EFFECTS.store( 3, 'Add Confusion #1')
  EFFECTS.store( 4, 'Add Sleep #2'    )
  EFFECTS.store( 5, 'Add Confusion #2')
  EFFECTS.store( 6, 'Add Death #1'    )
  EFFECTS.store( 7, 'Add Silence #1'  )
  EFFECTS.store( 8, 'Add Stone #1'    )
  EFFECTS.store( 9, 'Add Sleep #3'    )
  EFFECTS.store(10, 'Add Death #2'    )
  EFFECTS.store(11, 'Add Confusion #3')
  EFFECTS.store(12, 'Add Silence #2'  )
  EFFECTS.store(13, 'Add Stone #2'    )
  EFFECTS.store(14, 'Add Confusion #4')
  EFFECTS.store(15, 'Add Sleep #4'    )
  EFFECTS.store(16, 'Add Death #3'    )
  EFFECTS.store(17, 'Add Sleep #5'    )
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Weapon.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::CHARACTER_ID[0]  ,  0, 'c' )
    members << StrDmy.new(CsvHdr::CHARACTER_NAME[0], ''      )
    members << IntVar.new(CsvHdr::RETAIL_PRICE     ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE , -1, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET   , -1, 'c' )
    members << IntVar.new(CsvHdr::EFFECT_ID        , -1, 'c' )
    members << StrDmy.new(CsvHdr::EFFECT_NAME      , ''      )
    
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

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(CsvHdr::CHARACTER_ID[0]).value
    find_member(CsvHdr::CHARACTER_NAME[0]).value = CHARACTERS[_id]
    
    _id = find_member(CsvHdr::EFFECT_ID).value
    find_member(CsvHdr::EFFECT_NAME).value = EFFECTS[_id]
    
    _id = find_member(CsvHdr::FEATURE_ID[0]).value
    find_member(CsvHdr::FEATURE_NAME[0]).value = Armor::FEATURES[_id]
    
    super
  end

end	# class Weapon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
