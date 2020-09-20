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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle a standard entry.
class StdEntry < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Add name properties.
  # @param _size [Integer] Size of name properties
  def add_name_props(_size = 17)
    if jp? || us?
      self[VOC.name_str[cid]] = StrProp.new(_size, '')
    elsif eu?
      self[VOC.message_id[cid]] = IntProp.new(:u32, 0, base: 16)
      ['DE', 'ES', 'FR', 'GB'].each do |_l|
        self[VOC.name_pos[_l] ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[VOC.name_size[_l]] = IntProp.new(:u32,  0,           ext: true)
        self[VOC.name_str[_l] ] = StrProp.new( nil, '',           ext: true)
      end
    end
  end

  # Add description properties.
  def add_dscr_props
    if jp? || us?
      self[VOC.dscr_pos[cid] ] = IntProp.new(:u32,  0, base: 16, ext: true)
      self[VOC.dscr_size[cid]] = IntProp.new(:u32,  0,           ext: true)
      self[VOC.dscr_str[cid] ] = StrProp.new( nil, '',           ext: true)
    elsif eu?
      ['DE', 'ES', 'FR', 'GB'].each do |_l|
        self[VOC.dscr_pos[_l] ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[VOC.dscr_size[_l]] = IntProp.new(:u32,  0,           ext: true)
        self[VOC.dscr_str[_l] ] = StrProp.new( nil, '',           ext: true)
      end
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------
  
  def msg_id
    self[VOC.message_id[cid]] || nil
  end

  def msg_id=(_msg_id)
    self[VOC.message_id[cid]] = _msg_id
  end
    
end	# class StdEntry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
