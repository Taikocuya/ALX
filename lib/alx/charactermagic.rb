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

require_relative('charactersupermove.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a character magic.
class CharacterMagic < CharacterSuperMove

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterMagic.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    
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

end	# class CharacterMagic

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
