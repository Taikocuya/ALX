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

require_relative('property.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a property as external integer.
class IntExt < Property
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    self.value = _row[name] || value
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _row[name] = value
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  def value=(_value)
    _value = _value.to_i
    super(_value)
  end

end # class IntExt

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
