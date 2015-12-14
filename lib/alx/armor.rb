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

require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an armor.
class Armor < StdEntry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Feature IDs
  FEATURES = Hash.new('???')
  FEATURES.store(-1, 'None'                 )
  FEATURES.store( 1, 'Will'                 )
  FEATURES.store( 4, 'Quick'                )
  FEATURES.store(16, 'Attack'               )
  FEATURES.store(17, 'Defense'              )
  FEATURES.store(18, 'MagDef'               )
  FEATURES.store(19, 'Hit%'                 )
  FEATURES.store(20, 'Dodge%'               )
  FEATURES.store(32, 'Green'                )
  FEATURES.store(33, 'Red'                  )
  FEATURES.store(34, 'Purple'               )
  FEATURES.store(35, 'Blue'                 )
  FEATURES.store(36, 'Yellow'               )
  FEATURES.store(37, 'Silver'               )
  FEATURES.store(48, 'Poison'               )
  FEATURES.store(49, 'Death'                )
  FEATURES.store(50, 'Stone'                )
  FEATURES.store(51, 'Sleep'                )
  FEATURES.store(52, 'Confuse'              )
  FEATURES.store(53, 'Silence'              )
  FEATURES.store(54, 'Fatigue'              )
  FEATURES.store(56, 'Weak'                 )
  FEATURES.store(65, 'Block attacks'        )
  FEATURES.store(68, 'Reduce spirit'        )
  FEATURES.store(73, 'Counter%'             )
  FEATURES.store(77, 'Recover spirit'       )
  FEATURES.store(79, 'Block negative states')
  FEATURES.store(80, 'First strike%'        )
  FEATURES.store(81, 'Run%'                 )
  FEATURES.store(83, 'Enemy run%'           )
  FEATURES.store(84, 'Random encounter%'    )
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Armor.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::CHARACTER_FLAGS        ,  0, 'c' )
    CHARACTERS.each_value do |_chara|
      members << StrDmy.new(CsvHdr::CHARACTER_OPT[_chara], ''      )
    end
    
    members << IntVar.new(CsvHdr::RETAIL_PRICE           ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE       , -1, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET         , -1, 'c' )
    
    if region != 'P'
      members << IntVar.new(padding_hdr                  ,  0, 'c' )
    end

    members << IntVar.new(CsvHdr::PURCHASE_PRICE         ,  0, 'S>')
    
    (1..4).each do |_i|
      members << IntVar.new(CsvHdr::FEATURE_ID[_i]       , -1, 'c' )
      members << StrDmy.new(CsvHdr::FEATURE_NAME[_i]     , ''      )
      members << IntVar.new(padding_hdr                  ,  0, 'c' )
      members << IntVar.new(CsvHdr::FEATURE_VALUE[_i]    ,  0, 's>')
    end

    if region == 'P'
      members << IntVar.new(padding_hdr                  ,  0, 'c' )
      members << IntVar.new(padding_hdr                  ,  0, 'c' )
    end

    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _flags = find_member(CsvHdr::CHARACTER_FLAGS).value
    CHARACTERS.each do |_id, _chara|
      _member = CsvHdr::CHARACTER_OPT[_chara]
      find_member(_member).value = _flags & (0x20 >> _id) != 0 ? 'X' : ''
    end

    (1..4).each do |_i|
      _id = find_member(CsvHdr::FEATURE_ID[_i]).value
      find_member(CsvHdr::FEATURE_NAME[_i]).value = FEATURES[_id]
    end

    super
  end

end	# class Armor

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
