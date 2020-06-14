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

require('observer')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a property.
class Property
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Property
  # @param _name  [String]         Name
  # @param _value [Integer,String] Value
  def initialize(_name, _value)
    self.name  = _name
    self.value = _value
  end

  # Returns +true+ if property is a dummy, otherwise +false+.
  # @return [Boolean] +true+ if property is a dummy, otherwise +false+.
  def dummy?
    false
  end
  
  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    # Nothing to do.
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    # Nothing to do.
  end

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_csv(_row)
    # Nothing to do.
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_csv(_row)
    # Nothing to do.
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :name
  attr_reader :value
  
  def name=(_name)
    @name = _name.dup
  end
  
  def value=(_value)
    @value = _value.dup
  end
  
end # class Property

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
