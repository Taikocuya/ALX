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
require_relative('shipaccessory.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a crew member.
class CrewMember < StdEntry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Position IDs
  POSITIONS = Hash.new('???')
  POSITIONS.store( 0, 'Helmsman')
  POSITIONS.store( 1, 'Engineer')
  POSITIONS.store( 2, 'Gunner'  )
  POSITIONS.store( 3, 'Lookout' )
  POSITIONS.store( 4, 'Merchant')
  POSITIONS.store( 5, 'Builder' )
  POSITIONS.store( 6, 'Cook'    )
  POSITIONS.store( 7, 'Artisan' )
  POSITIONS.store( 8, 'Sailor'  )
  POSITIONS.store( 9, 'Jester'  )
  POSITIONS.store(10, 'Delegate')

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CrewMember.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::POSITION_ID         , -1, 'c' )
    members << StrDmy.new(CsvHdr::POSITION_NAME       , ''      )
    
    if region == 'P'
      members << IntVar.new(padding_hdr               ,  0, 'c' )
    end
    
    members << IntVar.new(CsvHdr::FEATURE_ID[0]       , -1, 'c' )
    members << StrDmy.new(CsvHdr::FEATURE_NAME[0]     , ''      )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    members << IntVar.new(CsvHdr::FEATURE_VALUE[0]    ,  0, 's>')
    members << IntVar.new(CsvHdr::SHIP_EFFECT_ID      , -1, 'c' )
    members << StrDmy.new(CsvHdr::SHIP_EFFECT_NAME    , ''      )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_SPIRIT  , -1, 'c' )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_TURNS   , -1, 'c' )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    
    if region == 'J'
      members << IntVar.new(CsvHdr::UNKNOWN[0]        ,  0, 's>')
      members << IntVar.new(CsvHdr::SHIP_EFFECT_VALUE ,  0, 's>')
    else
      members << IntVar.new(CsvHdr::SHIP_EFFECT_VALUE ,  0, 's>')
      members << IntVar.new(CsvHdr::UNKNOWN[0]        ,  0, 's>')
    end

    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    members << IntVar.new(padding_hdr                 ,  0, 'c' )
    
    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(CsvHdr::POSITION_ID).value
    find_member(CsvHdr::POSITION_NAME).value = POSITIONS[_id]

    _id = find_member(CsvHdr::FEATURE_ID[0]).value
    find_member(CsvHdr::FEATURE_NAME[0]).value = ShipAccessory::FEATURES[_id]

    _id = find_member(CsvHdr::SHIP_EFFECT_ID).value
    find_member(CsvHdr::SHIP_EFFECT_NAME).value = EFFECTS[_id]
    
    super
  end

end	# class CrewMember

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
