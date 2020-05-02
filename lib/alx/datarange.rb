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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a offset range.
class DataRange
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a DataRange
  # @param _name      [String]  Name
  # @param _range     [Range]   Offset range
  # @param exclusions [Array]   Exclusions
  # @param msg_table  [Boolean] Use message table
  def initialize(_name, _range, exclusions: [], msg_table: false)
    unless _name.is_a?(String)
      _msg = '%s is not a string'
      raise(TypeError, sprintf(_msg, _name))
    end
    unless _range.is_a?(Range)
      _msg = '%s is not a range'
      raise(TypeError, sprintf(_msg, _range))
    end
    
    if _range.size > 0
      _min = _range.min
      _max = _range.max + 1
    else
      _min = _range.begin
      _max = _range.end
    end

    @name       = _name
    @range      = Range.new(_min, _max)
    @exclusions = exclusions
    @msg_table  = msg_table
  end

  def begin
    @range.begin
  end

  def end
    @range.end
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :name
  attr_accessor :range
  attr_accessor :exclusions
  attr_accessor :msg_table
  
end # class DataRange

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
