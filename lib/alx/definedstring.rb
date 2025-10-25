#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
  def initialize
    super
    init_props

  end

  # Returns the CSV header of the entry.
  # @return [Array] CSV header of entry
  def header
    _header = super
    
    if STRDETR.defined_string_text_only
      _header -= [
        VOC.id,
        VOC.string_pos,
        VOC.string_size,
        VOC.string_encoding,
        VOC.string_data,
      ]
    end
    if !STRDETR.defined_string_append_filter
      _header -= [VOC.string_filter]
    end

    _header
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    self[VOC.string_pos     ] = IntProp.new(:u32,  0, base: 16, ext: true )
    self[VOC.string_size    ] = IntProp.new(:u32,  0,           ext: true )
    self[VOC.string_encoding] = StrProp.new( nil, '',           ext: true )
    self[VOC.string_value   ] = StrProp.new( nil, '',           ext: true )
    self[VOC.string_data    ] = StrProp.new( nil, '',           esc: false)
    self[VOC.string_filter  ] = StrProp.new( nil, '',           ext: true )
  end
  
end	# class DefinedString

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
