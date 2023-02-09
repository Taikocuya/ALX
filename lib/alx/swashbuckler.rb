#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2023 Marcel Renner
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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
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

# Class to handle a swashbuckler rating.
class Swashbuckler < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Swashbuckler.
  def initialize
    super
    init_props
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    if jp? || us?
      self[VOC.name_str(cid)] = StrProp.new(25, '')
    elsif eu?
      self[VOC.message_id(cid)] = IntProp.new(:u32, 0, base: 16)
      languages.each do |_l|
        self[VOC.name_pos(_l) ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[VOC.name_size(_l)] = IntProp.new(:u32,  0,           ext: true)
        self[VOC.name_str(_l) ] = StrProp.new( nil, '',           ext: true)
      end
    end
    
    self[VOC.rating] = IntProp.new( :u8, 0)
    
    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
    end
    
    self[VOC.regular_attack   ] = IntProp.new(:i16, 0)
    self[VOC.super_move_attack] = IntProp.new(:i16, 0)
    self[VOC.dodge            ] = IntProp.new(:i16, 0)
    self[VOC.run              ] = IntProp.new(:i16, 0)
    
    if eu?
      self[padding_hdr] = IntProp.new(:i16, 0)
    end
  end

end	# class Swashbuckler

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
