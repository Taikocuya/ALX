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
      members << IntDmy.new(VOC.ship_dscr_us_pos ,  0      )
      members << IntDmy.new(VOC.ship_dscr_us_size,  0      )
      members << StrDmy.new(VOC.ship_dscr_us_str , ''      )
    when 'J'
      members << IntDmy.new(VOC.ship_dscr_jp_pos ,  0      )
      members << IntDmy.new(VOC.ship_dscr_jp_size,  0      )
      members << StrDmy.new(VOC.ship_dscr_jp_str , ''      )
    when 'P'
      members << IntDmy.new(VOC.ship_dscr_de_pos ,  0      )
      members << IntDmy.new(VOC.ship_dscr_de_size,  0      )
      members << StrDmy.new(VOC.ship_dscr_de_str , '', '\n')
      members << IntDmy.new(VOC.ship_dscr_es_pos ,  0      )
      members << IntDmy.new(VOC.ship_dscr_es_size,  0      )
      members << StrDmy.new(VOC.ship_dscr_es_str , '', '\n')
      members << IntDmy.new(VOC.ship_dscr_fr_pos ,  0      )
      members << IntDmy.new(VOC.ship_dscr_fr_size,  0      )
      members << StrDmy.new(VOC.ship_dscr_fr_str , '', '\n')
      members << IntDmy.new(VOC.ship_dscr_gb_pos ,  0      )
      members << IntDmy.new(VOC.ship_dscr_gb_size,  0      )
      members << StrDmy.new(VOC.ship_dscr_gb_str , '', '\n')
    end
  end

end	# class CharacterMagic

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
