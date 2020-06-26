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
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ and +ext+ to +true+
  # @param ext    [Boolean] Serialize externally
  def initialize(_type, _value, comp: true, dmy: false, ext: false)
    super(_value.to_f, comp: comp, dmy: dmy, ext: ext)
    @type = _type
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
    _row[_header] = value
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash         = super
    _hash[:@type] = @type
    _hash
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :type

  def value=(_value)
    super(_value.to_f)
  end
  
  alias flt    value
  alias float  value
  alias flt=   value=
  alias float= value=

end # class FltProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
