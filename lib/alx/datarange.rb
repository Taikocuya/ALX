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
  # @param _name     [String] Name
  # @param _range    [Range]  Offset range
  # @param _exlusion [Array]  ID exclusion
  def initialize(_name, _range, _exclusion = [])
    @name      = _name
    @range     = _range
    @exclusion = _exclusion
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
  attr_accessor :exclusion
  
end # class DataRange

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
