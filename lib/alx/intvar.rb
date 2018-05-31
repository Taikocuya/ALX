#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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

require_relative('datamember.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a data member as integer.
class IntVar < DataMember
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a IntVar
  # @param _name   [String]  Name
  # @param _value  [Integer] Value
  # @param _format [String]  Format
  def initialize(_name, _value, _format)
    super(_name, _value)
    @format = _format
  end

  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_from_bin(_f)
    super
    self.value = _f.read_int(@format)
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_to_bin(_f)
    super
    _f.write_int(value, @format)
  end

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    self.value = _row[name] || value
    self.value = value.to_i
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _row[name] = value.to_i
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :format
  
end # class IntVar

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
