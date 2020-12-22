#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2020 Marcel Renner
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
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    super
    
    if product_id != '6107110 06' && product_id != '6107810'
      _pos  = VOC.ship_dscr_pos
      _size = VOC.ship_dscr_size
      _str  = VOC.ship_dscr_str
      
      if jp? || us?
        self[_pos[cid] ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[_size[cid]] = IntProp.new(:u32,  0,           ext: true)
        self[_str[cid] ] = StrProp.new( nil, '',           ext: true)
      elsif eu?
        languages.each do |_l|
          self[_pos[_l] ] = IntProp.new(:u32,  0, base: 16, ext: true)
          self[_size[_l]] = IntProp.new(:u32,  0,           ext: true)
          self[_str[_l] ] = StrProp.new( nil, '',           ext: true)
        end
      end
    end
  end
  
end	# class CharacterMagic

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
