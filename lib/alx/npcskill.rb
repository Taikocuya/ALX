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

# Class to handle a enemy skill.
class NpcSkill < DolEntry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Category IDs
  CATEGORIES = Hash.new('???')
  CATEGORIES.store( 0, 'Super Move')
  CATEGORIES.store( 1, 'Magic'     )

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a NpcSkill.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    if region != 'P'
      members << IntVar.new(padding_hdr          ,  0, 'c' )
      members << IntVar.new(padding_hdr          ,  0, 'c' )
      members << IntVar.new(padding_hdr          ,  0, 'c' )
      members << IntVar.new(padding_hdr          ,  0, 'c' )
    end
    
    members << IntVar.new(CsvHdr::CATEGORY_ID    ,  0, 'c' )
    members << StrDmy.new(CsvHdr::CATEGORY_NAME  , ''      )
    members << IntVar.new(CsvHdr::EFFECT_ID      , -1, 'c' )
    members << StrDmy.new(CsvHdr::EFFECT_NAME    , ''      )
    members << IntVar.new(CsvHdr::SCOPE_ID       ,  0, 'C' )
    members << StrDmy.new(CsvHdr::SCOPE_NAME     , ''      )
    
    if region == 'P'
      members << IntVar.new(padding_hdr          ,  0, 'c' )
    end
    
    members << IntVar.new(CsvHdr::EFFECT_VALUE[1],  0, 's>')
    members << IntVar.new(CsvHdr::EFFECT_VALUE[2],  0, 's>')
    members << IntVar.new(CsvHdr::ELEMENT_ID     ,  0, 'c' )
    members << StrDmy.new(CsvHdr::ELEMENT_NAME   , ''      )
    members << IntVar.new(CsvHdr::TYPE_ID        ,  0, 'c' )
    members << StrDmy.new(CsvHdr::TYPE_NAME      , ''      )
    members << IntVar.new(unknown_hdr            ,  0, 'c' )
    members << IntVar.new(unknown_hdr            ,  0, 'c' )
    members << IntVar.new(unknown_hdr            ,  0, 'c' )
    members << IntVar.new(CsvHdr::HIT            ,  0, 'c' )
    members << IntVar.new(padding_hdr            ,  0, 'c' )
    members << IntVar.new(padding_hdr            ,  0, 'c' )
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    _id = find_member(CsvHdr::CATEGORY_ID).value
    find_member(CsvHdr::CATEGORY_NAME).value = CATEGORIES[_id]
    
    _id = find_member(CsvHdr::EFFECT_ID).value
    find_member(CsvHdr::EFFECT_NAME).value = EFFECTS[_id]

    _id = find_member(CsvHdr::SCOPE_ID).value
    find_member(CsvHdr::SCOPE_NAME).value = SCOPES[_id]

    _id = find_member(CsvHdr::ELEMENT_ID).value
    find_member(CsvHdr::ELEMENT_NAME).value = ELEMENTS[_id]

    _id = find_member(CsvHdr::TYPE_ID).value
    find_member(CsvHdr::TYPE_NAME).value = TYPES[_id]

    super
  end

end	# class NpcSkill

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
