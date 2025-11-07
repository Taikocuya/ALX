#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    super
    add_name_props(25)

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

  # Initialize the entry procs.
  def init_procs
    super

    add_id_proc(
      -dscrptr(:swashbuckler_id_range).begin,
      name_table: 'OtokogiDataTable'
    )
  end

end # class Swashbuckler

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
