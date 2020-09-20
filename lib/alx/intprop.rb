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

# Class to handle a integer property.
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
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ and +ext+ to +true+
  # @param ext    [Boolean] Serialize externally
  def initialize(_type, _value, base: 10, comp: true, dmy: false, ext: false)
    super(_value.to_i, comp: comp, dmy: dmy, ext: ext)
    @type = _type
    @base = base
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
    case @base
    when 2, 10, 16
      self.value = Integer(_row[_header] || value)
    else
      self.value = (_row[_header] || value).to_i(@base)
    end
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(_header, _row)
    _value = value.to_s(@base)
    
    case @base
    when 2
      _value.sub!(/^(-?)/, '\10b')
    when 8
      _value.sub!(/^(-?)/, '\10o')
    when 16
      _value.sub!(/^(-?)/, '\10x')
    end
    
    _row[_header] = _value
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash         = super
    _hash[:@type] = @type
    _hash[:@base] = @base
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :type
  attr_accessor :base

  def value=(_value)
    super(_value.to_i)
  end
  
  alias int      value
  alias integer  value
  alias int=     value=
  alias integer= value=

end # class IntProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
