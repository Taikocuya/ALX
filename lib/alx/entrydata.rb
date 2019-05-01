#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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

require_relative('cache.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle entries from binary and/or CSV files.
class EntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EntryData.
  # @param _class [Entry]    Entry object
  # @param _root  [GameRoot] Game root
  def initialize(_class, _root)
    @class      = _class
    @root       = _root
    _class_name = self.class.name.split('::').last
    @cache_id   = sprintf('%s_%s', region, _class_name).downcase.to_sym
  end
    
  # Creates an entry.
  # @return [Entry] Entry object
  def create_entry
    @class.new(region)
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------
  
  attr_reader :class
  attr_reader :root
  attr_reader :cache_id

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  def region
    @root.hdr.region_id
  end
    
  def country
    SYS.country_ids[@root.hdr.region_id]
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private
  
  # Determines the data range with given filename.
  #
  # @param _range    [DataRange,Array] Data range
  # @param _filename [String]          Filename
  #
  # @return [DataRange] Data range
  def determine_range(_range, _filename)
    if _range.is_a?(Array)
      _range = _range.find { |_r| _filename.include?(_r.name) }
    end
    _range ||= DataRange.new('', 0x0...0xffffffff)
    _range
  end

end # class EntryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
