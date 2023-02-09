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

require_relative('prop.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a single precision floating point type property.
class FltProp < Prop
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a FltProp. If a block is specified, it will be called in 
  # #value=, #float= and #flt= when the value has been changed.
  # 
  # @param _type  [Symbol]  Type
  # @param _value [Integer] Value
  # @param width  [Integer] Pad with zeros (CSV only)
  # @param prec   [Integer] Precision after decimal point (CSV only)
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ to +false+ and +ext+ to +true+
  # @param ext    [Boolean] Serialize externally
  def initialize(
    _type, _value, width: 0, prec: 0, comp: true, dmy: false, ext: false
  )
    super(_value.to_f, comp: comp, dmy: dmy, ext: ext)
    @type  = _type
    @width = width
    @prec  = prec
  end

  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    if external?
      return 
    end
    
    self.value = _f.read_flt(@type)
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    if external?
      return 
    end
    
    _f.write_flt(value, @type)
  end

  # Reads one entry from a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def read_csv(_header, _row)
    self.value = Float(_row[_header] || value)
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(_header, _row)
    _value = value
    if @width > 0 || @prec > 0
      _format = '%'
      if @width > 0
        _format << "0#{@width}"
      end
      if @prec  > 0
        _value = _value.round(@prec, half: :even)
        _format << ".0#{@prec}"
      end
      _format << 'f'
      _value = sprintf(_format, _value)
    else
      _value = _value.to_s
    end

    _row[_header] = _value
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash          = super
    _hash[:@type]  = @type
    _hash[:@width] = @width
    _hash[:@prec]  = @prec
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :type
  attr_reader   :width
  attr_reader   :prec

  def value=(_value)
    super(_value.to_f)
  end
  
  def width=(_width)
    @width = [0, _width.to_i].max
  end
  
  def prec=(_prec)
    @prec = [0, _prec.to_i].max
  end
  
  alias flt    value
  alias float  value
  alias flt=   value=
  alias float= value=

end # class FltProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
