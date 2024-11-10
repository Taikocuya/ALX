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

# Class to handle a array property.
class AryProp < Prop
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a AryProp. This property is serialized externally. The keyword 
  # +ext+ is unsupported and the methods #read_bin and #write_bin are 
  # therefore unused. If a block is specified, it will be called in #value=, 
  # #array= and #ary= when the value has been changed.
  # 
  # @param _value [Integer] Value
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ to +true+
  def initialize(_value, comp: true, dmy: false)
    super(_value.to_a, comp: comp, dmy: dmy, ext: true)
  end

  # @see ::Array#to_s
  def to_a
    self.value.to_a
  end
  
  # @see ::Array#to_ary
  def to_ary
    self.value.to_ary
  end

  # This property is serialized externally. The methods #read_bin and 
  # #write_bin are therefore unused.
  def read_bin(_f)
    nil
  end
  
  # This property is serialized externally. The methods #read_bin and 
  # #write_bin are therefore unused.
  def write_bin(_f)
    nil
  end

  # Reads one entry from a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def read_csv(_header, _row)
    _value = _row[_header] || ''
    _value.force_encoding('UTF-8')
    self.value = _value.split(';')
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(_header, _row)
    _row[_header] = value.join(';')
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  def value=(_value)
    super(_value.to_a)
  end
  
  alias ary    value
  alias array  value
  alias ary=   value=
  alias array= value=

end # class AryProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
