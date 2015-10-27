#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a data member.
class DataMember
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a DataMember
  # @param _name  [String]         Name
  # @param _value [Integer,String] Value
  def initialize(_name, _value)
    @name  = _name
    @value = _value
  end

  # Reads one entry from a binary IO object.
  # @param _f [BinaryIO] Binary IO object
  def read_from_bin(_f)
    # Nothing to do.
  end
  
  # Write one entry to a binary IO object.
  # @param _f [BinaryIO] Binary IO object
  def write_to_bin(_f)
    # Nothing to do.
  end

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    # Nothing to do.
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    # Nothing to do.
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :name
  attr_accessor :value
  
end # class DataMemberInteger

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
