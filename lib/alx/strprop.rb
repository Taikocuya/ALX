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

require_relative('prop.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a string property.
class StrProp < Prop
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a StringProp. If a block is specified, it will be called in 
  # #value=, #string= and #str= when the value has been changed.
  # 
  # @param _size  [Integer] Size
  # @param _value [Integer] Value
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ and +ext+ to +true+
  # @param esc    [Boolean] Escape non-printing characters
  # @param ext    [Boolean] Serialize externally
  def initialize(_size, _value, comp: true, dmy: false, esc: true, ext: false)
    super(_value.to_s, comp: comp, dmy: dmy, ext: ext)
    @size   = _size
    @escape = esc
  end

  # @see ::String#to_s
  def to_s
    self.value.to_s
  end
  
  # @see ::String#to_str
  def to_str
    self.value.to_str
  end
  
  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    if external?
      return 
    end
    
    self.value = _f.read_str(@size)
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    if external?
      return 
    end
    
    _f.write_str(value, @size)
  end

  # Reads one entry from a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def read_csv(_header, _row)
    self.value = _row[_header] || value
    self.value.force_encoding('UTF-8')
    
    if @escape
      self.value.gsub!(/(?<!\\)\\n/) { "\n" }
      self.value.gsub!(/(?<!\\)\\r/) { "\r" }
      self.value.gsub!(/(?<!\\)\\t/) { "\t" }
      self.value.gsub!(/\\\\/      ) { "\\" }
    end
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(_header, _row)
    _value = value.dup
    _value.force_encoding('UTF-8')
    
    if @escape
      _value.gsub!(/\\(?!x[0-9A-Fa-f]{2})/) { '\\\\' }
      _value.gsub!(/\t/                   ) { '\t'   }
      _value.gsub!(/\r/                   ) { '\r'   }
      _value.gsub!(/\n/                   ) { '\n'   }
    end
    
    _row[_header] = _value
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash           = super
    _hash[:@size  ] = @size
    _hash[:@escape] = @escape
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :escape
  
  def size
    if @size
      @size
    else
      self.value.size
    end
  end
  
  def value=(_value)
    super(_value.to_s)
  end
  
  alias str     value
  alias string  value
  alias str=    value=
  alias string= value=

end # class StrProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
