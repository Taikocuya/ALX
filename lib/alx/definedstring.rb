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

# Class to handle a defined string.
class DefinedString < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a DefinedString.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super

    members << PosExt.new(VOC.string_pos     ,  0       )
    members << IntExt.new(VOC.string_size    ,  0       )
    members << StrExt.new(VOC.string_encoding, ''       )
    members << StrExt.new(VOC.string_value   , ''       )
    members << StrExt.new(VOC.string_data    , '', false)
    
    if SYS.defined_string_append_filter
      members << StrExt.new(VOC.string_filter, '')
    end
  end

end	# class DefinedString

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
