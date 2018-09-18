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

# Module to cache data.
module Cache

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # @see ::Hash#clear
  def self.clear
    @@cache = {}
  end
  
  # @see ::Hash#[]
  def self.[](_key)
    @@cache ||= {}
    @@cache[_key]
  end

  # @see ::Hash#[]=
  def self.[]=(_key, _value)
    @@cache ||= {}
    @@cache[_key] = _value
  end

  # @see ::Hash#has_key?
  def self.has_key?(_key)
    @@cache ||= {}
    @@cache.has_key?(_key)
  end

  # @see ::Hash#has_value?
  def self.has_value?(_key)
    @@cache ||= {}
    @@cache.has_value?(_key)
  end

  # @see ::Hash#empty?
  def self.empty?
    @@cache ||= {}
    @@cache.empty?
  end
  
end # module Cache

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
