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

# Class to handle a character skill.
class PcSkill < DolEntry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Category IDs
  CATEGORIES = Hash.new('???')
  CATEGORIES.store(0, PCS[0] )
  CATEGORIES.store(1, PCS[1] )
  CATEGORIES.store(2, PCS[2] )
  CATEGORIES.store(3, PCS[3] )
  CATEGORIES.store(4, PCS[4] )
  CATEGORIES.store(5, PCS[5] )
  CATEGORIES.store(6, 'Magic')

  # Ship occasion IDs
  SHIP_OCCASIONS = Hash.new('???')
  SHIP_OCCASIONS.store(-1, 'Never')
  SHIP_OCCASIONS.store( 0, 'Magic Cannon')
  SHIP_OCCASIONS.store( 1, 'Always')
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a PcSkill.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(CsvHdr::ELEMENT_ID        ,  0, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr             ,  0, 'c' )
    end
    
    members << StrDmy.new(CsvHdr::ELEMENT_NAME      , ''      )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE  ,  0, 's>')
    members << IntVar.new(CsvHdr::OCCASION_FLAGS    ,  0, 'c' )
    members << StrDmy.new(CsvHdr::OCCASION_MENU     , ''      )
    members << StrDmy.new(CsvHdr::OCCASION_BATTLE   , ''      )
    members << StrDmy.new(CsvHdr::OCCASION_SHIP     , ''      )
    members << IntVar.new(CsvHdr::EFFECT_ID         , -1, 'c' )
    members << StrDmy.new(CsvHdr::EFFECT_NAME       , ''      )
    members << IntVar.new(CsvHdr::SCOPE_ID          ,  0, 'C' )
    members << StrDmy.new(CsvHdr::SCOPE_NAME        , ''      )
    members << IntVar.new(CsvHdr::CATEGORY_ID       ,  0, 'c' )
    members << StrDmy.new(CsvHdr::CATEGORY_NAME     , ''      )
    members << IntVar.new(CsvHdr::EFFECT_PRIORITY   , -1, 'c' )
    members << IntVar.new(CsvHdr::EFFECT_SPIRIT     , -1, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(CsvHdr::EFFECT_VALUE[0]   , -1, 's>')
    members << IntVar.new(CsvHdr::TYPE_ID           ,  0, 'c' )
    members << StrDmy.new(CsvHdr::TYPE_NAME         , ''      )
    members << IntVar.new(unknown_hdr               , -1, 'c' )
    members << IntVar.new(CsvHdr::HIT               ,  0, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(CsvHdr::SHIP_OCCASION_ID  ,  0, 'c' )
    members << StrDmy.new(CsvHdr::SHIP_OCCASION_NAME, ''      )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_ID    , -1, 's>')
    members << StrDmy.new(CsvHdr::SHIP_EFFECT_NAME  , ''      )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_SPIRIT, -1, 'c' )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_TURNS , -1, 'c' )
    members << IntVar.new(CsvHdr::SHIP_EFFECT_VALUE ,  0, 's>')
    members << IntVar.new(unknown_hdr               , -1, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )
    members << IntVar.new(padding_hdr               ,  0, 'c' )

    add_dscr_members
    
    case region
    when 'E'
      members << IntDmy.new(CsvHdr::SHIP_DSCR_US_POS ,  0      )
      members << IntDmy.new(CsvHdr::SHIP_DSCR_US_SIZE,  0      )
      members << StrDmy.new(CsvHdr::SHIP_DSCR_US_STR , ''      )
    when 'J'
      members << IntDmy.new(CsvHdr::SHIP_DSCR_JP_POS ,  0      )
      members << IntDmy.new(CsvHdr::SHIP_DSCR_JP_SIZE,  0      )
      members << StrDmy.new(CsvHdr::SHIP_DSCR_JP_STR , ''      )
    when 'P'
      members << IntDmy.new(CsvHdr::SHIP_DSCR_DE_POS ,  0      )
      members << IntDmy.new(CsvHdr::SHIP_DSCR_DE_SIZE,  0      )
      members << StrDmy.new(CsvHdr::SHIP_DSCR_DE_STR , '', '\n')
      members << IntDmy.new(CsvHdr::SHIP_DSCR_ES_POS ,  0      )
      members << IntDmy.new(CsvHdr::SHIP_DSCR_ES_SIZE,  0      )
      members << StrDmy.new(CsvHdr::SHIP_DSCR_ES_STR , '', '\n')
      members << IntDmy.new(CsvHdr::SHIP_DSCR_FR_POS ,  0      )
      members << IntDmy.new(CsvHdr::SHIP_DSCR_FR_SIZE,  0      )
      members << StrDmy.new(CsvHdr::SHIP_DSCR_FR_STR , '', '\n')
      members << IntDmy.new(CsvHdr::SHIP_DSCR_GB_POS ,  0      )
      members << IntDmy.new(CsvHdr::SHIP_DSCR_GB_SIZE,  0      )
      members << StrDmy.new(CsvHdr::SHIP_DSCR_GB_STR , '', '\n')
    end
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    _id = find_member(CsvHdr::ELEMENT_ID).value
    find_member(CsvHdr::ELEMENT_NAME).value = ELEMENTS[_id]

    _flags = find_member(CsvHdr::OCCASION_FLAGS).value
    OCCASIONS.each do |_id, _occasion|
      find_member(_occasion).value = _flags & (0x4 >> _id) != 0 ? 'X' : ''
    end
    
    _id = find_member(CsvHdr::EFFECT_ID).value
    find_member(CsvHdr::EFFECT_NAME).value = EFFECTS[_id]
    
    _id = find_member(CsvHdr::SCOPE_ID).value
    find_member(CsvHdr::SCOPE_NAME).value = SCOPES[_id]
    
    _id = find_member(CsvHdr::CATEGORY_ID).value
    find_member(CsvHdr::CATEGORY_NAME).value = CATEGORIES[_id]

    _id = find_member(CsvHdr::TYPE_ID).value
    find_member(CsvHdr::TYPE_NAME).value = TYPES[_id]
    
    _id = find_member(CsvHdr::SHIP_OCCASION_ID).value
    find_member(CsvHdr::SHIP_OCCASION_NAME).value = SHIP_OCCASIONS[_id]
    
    _id = find_member(CsvHdr::SHIP_EFFECT_ID).value
    find_member(CsvHdr::SHIP_EFFECT_NAME).value = EFFECTS[_id]
    
    super
  end

end	# class PcSkill

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
