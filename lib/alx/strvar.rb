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

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('datamember.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to handle a data member as string.
class StrVar < DataMember
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a StrVar
  # @param _name  [String]  Name
  # @param _value [String]  Value
  # @param _size  [Integer] Size
  # @param _eol   [String]  End of line marker
  def initialize(_name, _value, _size, _eol = "\n")
    super(_name, _value)
    @size = _size
    @eol  = _eol
  end

  # Reads one entry from a binary IO object.
  # @param _f [BinaryIO] Binary IO object
  def read_from_bin(_f)
    super
    self.value = _f.read_str(@size)
  end
  
  # Write one entry to a binary IO object.
  # @param _f [BinaryIO] Binary IO object
  def write_to_bin(_f)
    super
    _f.write_str(self.value, @size)
  end

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    self.value = _row[self.name] || self.value
    self.value = self.value.to_s
    self.value.force_encoding('UTF-8')
    self.value.gsub!('\n', @eol)
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _value = self.value.to_s
    _value.force_encoding('UTF-8')
    _value.gsub!(@eol, '\n')
    _row[self.name] = _value
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :size
  attr_accessor :eol
  
end # class StrVar

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
