#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    
    if jp? || us?
      members << IntExt.new(VOC.ship_dscr_pos[country_id] ,  0)
      members << IntExt.new(VOC.ship_dscr_size[country_id],  0)
      members << StrExt.new(VOC.ship_dscr_str[country_id] , '')
    elsif eu?
      members << IntExt.new(VOC.ship_dscr_pos['DE']       ,  0)
      members << IntExt.new(VOC.ship_dscr_size['DE']      ,  0)
      members << StrExt.new(VOC.ship_dscr_str['DE']       , '')
      members << IntExt.new(VOC.ship_dscr_pos['ES']       ,  0)
      members << IntExt.new(VOC.ship_dscr_size['ES']      ,  0)
      members << StrExt.new(VOC.ship_dscr_str['ES']       , '')
      members << IntExt.new(VOC.ship_dscr_pos['FR']       ,  0)
      members << IntExt.new(VOC.ship_dscr_size['FR']      ,  0)
      members << StrExt.new(VOC.ship_dscr_str['FR']       , '')
      members << IntExt.new(VOC.ship_dscr_pos['GB']       ,  0)
      members << IntExt.new(VOC.ship_dscr_size['GB']      ,  0)
      members << StrExt.new(VOC.ship_dscr_str['GB']       , '')
    end
  end

end	# class CharacterMagic

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
