#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2021 Marcel Renner
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

# Class to handle a special item.
class SpecialItem < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a SpecialItem.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    init_props
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    add_name_props

    self[VOC.sell           ] = IntProp.new(:i8,  0)
    self[VOC.order[[cid, 1]]] = IntProp.new(:i8, -1)
    self[VOC.order[[cid, 2]]] = IntProp.new(:i8, -1)
    
    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
    end
    
    self[VOC.buy] = IntProp.new(:u16, 0)

    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
    end

    add_dscr_props
  end

end	# class SpecialItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
