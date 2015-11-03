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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle a menu entry (e.g. items, magic, super moves, etc.).
class DolEntry < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an DolEntry.
  # @param _region [String] Region ID
  def initialize(_region)
    super(_region)
    members << IntDmy.new(CsvHdr::ID, -1)
  end

  # Add name data members.
  # @param _size [Integer] Size of name data members
  def add_name_members(_size = 17)
    case region
    when 'E'
      members << StrVar.new(CsvHdr::NAME_US_STR , '', _size)
    when 'J'
      members << StrVar.new(CsvHdr::NAME_JP_STR , '', _size)
    when 'P'
      members << IntVar.new(CsvHdr::MESSAGE_ID  ,  0, 'L>' )
      members << IntDmy.new(CsvHdr::NAME_DE_POS ,  0       )
      members << IntDmy.new(CsvHdr::NAME_DE_SIZE,  0       )
      members << StrDmy.new(CsvHdr::NAME_DE_STR , '', '\n' )
      members << IntDmy.new(CsvHdr::NAME_ES_POS ,  0       )
      members << IntDmy.new(CsvHdr::NAME_ES_SIZE,  0       )
      members << StrDmy.new(CsvHdr::NAME_ES_STR , '', '\n' )
      members << IntDmy.new(CsvHdr::NAME_FR_POS ,  0       )
      members << IntDmy.new(CsvHdr::NAME_FR_SIZE,  0       )
      members << StrDmy.new(CsvHdr::NAME_FR_STR , '', '\n' )
      members << IntDmy.new(CsvHdr::NAME_GB_POS ,  0       )
      members << IntDmy.new(CsvHdr::NAME_GB_SIZE,  0       )
      members << StrDmy.new(CsvHdr::NAME_GB_STR , '', '\n' )
    end
  end

  # Add description data members.
  def add_dscr_members
    case region
    when 'E'
      members << IntDmy.new(CsvHdr::DSCR_US_POS ,  0      )
      members << IntDmy.new(CsvHdr::DSCR_US_SIZE,  0      )
      members << StrDmy.new(CsvHdr::DSCR_US_STR , ''      )
    when 'J'
      members << IntDmy.new(CsvHdr::DSCR_JP_POS ,  0      )
      members << IntDmy.new(CsvHdr::DSCR_JP_SIZE,  0      )
      members << StrDmy.new(CsvHdr::DSCR_JP_STR , ''      )
    when 'P'
      members << IntDmy.new(CsvHdr::DSCR_DE_POS ,  0      )
      members << IntDmy.new(CsvHdr::DSCR_DE_SIZE,  0      )
      members << StrDmy.new(CsvHdr::DSCR_DE_STR , '', '\n')
      members << IntDmy.new(CsvHdr::DSCR_ES_POS ,  0      )
      members << IntDmy.new(CsvHdr::DSCR_ES_SIZE,  0      )
      members << StrDmy.new(CsvHdr::DSCR_ES_STR , '', '\n')
      members << IntDmy.new(CsvHdr::DSCR_FR_POS ,  0      )
      members << IntDmy.new(CsvHdr::DSCR_FR_SIZE,  0      )
      members << StrDmy.new(CsvHdr::DSCR_FR_STR , '', '\n')
      members << IntDmy.new(CsvHdr::DSCR_GB_POS ,  0      )
      members << IntDmy.new(CsvHdr::DSCR_GB_SIZE,  0      )
      members << StrDmy.new(CsvHdr::DSCR_GB_STR , '', '\n')
    end
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------
  
  def id
    _member = find_member(CsvHdr::ID)
    if _member
      _member.value
    else
      -1
    end
  end

  def id=(_id)
    _member = find_member(CsvHdr::ID)
    if _member
      _member.value = _id
    else
      _id
    end
  end

end	# class DolEntry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
