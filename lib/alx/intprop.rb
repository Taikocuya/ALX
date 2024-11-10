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

require_relative('prop.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an integer property.
class IntProp < Prop
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an IntProp. If a block is specified, it will be called in 
  # #value=, #integer= and #int= when the value has been changed.
  # 
  # @param _type  [Symbol]  Type
  # @param _value [Integer] Value
  # @param base   [Integer] Base
  # @param width  [Integer] Pad with zeros (CSV only)
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ to +false+ and +ext+ to +true+
  # @param ext    [Boolean] Serialize externally
  def initialize(
    _type, _value, base: 10, width: 0, comp: true, dmy: false, ext: false
  )
    super(_value.to_i, comp: comp, dmy: dmy, ext: ext)
    @type  = _type
    @base  = base
    @width = width
  end

  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    if external?
      return 
    end
    
    self.value = _f.read_int(@type)
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    if external?
      return 
    end
    
    _f.write_int(value, @type)
  end

  # Reads one entry from a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def read_csv(_header, _row)
    self.value = Integer(_row[_header] || value, @base)
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(_header, _row)
    case @base
    when 2
      _value = sprintf("%+0#{@width}b", value)
      _value.sub!('+', _value.size <= @width ? '0' : '')
      _value.sub!(/^(-)?(0{1,2}(?!$))?/, '\10b')
    when 8
      _value = sprintf("%+0#{@width}o", value)
      _value.sub!('+', _value.size <= @width ? '0' : '')
      _value.sub!(/^(-)?(0{1,2}(?!$))?/, '\10o')
    when 16
      _value = sprintf("%+0#{@width}x", value)
      _value.sub!('+', _value.size <= @width ? '0' : '')
      _value.sub!(/^(-)?(0{1,2}(?!$))?/, '\10x')
    else
      _value = value.to_s(@base)
      _value = _value.rjust(@width, '0')
    
      if @width > 0 && value < 0
        _value.sub!(/-/, '0')
        _value.sub!(/^(?>0|)/, '-')
      end
    end

    _row[_header] = _value
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash          = super
    _hash[:@type ] = @type
    _hash[:@base ] = @base
    _hash[:@width] = @width
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :type
  attr_accessor :base
  attr_reader   :width

  def value=(_value)
    super(_value.to_i)
  end
  
  def width=(_width)
    @width = [0, _width.to_i].max
  end
  
  alias int      value
  alias integer  value
  alias int=     value=
  alias integer= value=

end # class IntProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
