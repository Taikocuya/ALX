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
    @class    = _class
    @root     = _root
    @cache_id = sprintf(
      '#<%s:%#x>', @class.name.split('::').last, _root.object_id
    )
  end
    
  # Creates an entry.
  # @return [Entry] Entry object
  def create_entry
    @class.new(@root)
  end

  # Returns the value of a SYS attribute. If the value is a Hash, the 
  # instance variables are considered during key selection.
  # @param _sym [Symbol] SYS attribute symbol
  # @return [Object] SYS attribute object
  def sys(_sym)
    @root.sys(_sym)
  end
    
  # Returns a new path formed by joining the strings using '/' relative to 
  # #dir. SYS symbols are resolved as well. If they contain a Hash, the game 
  # root attributes are considered during key selection.
  # 
  # @param _args [String,Symbol] Paths or SYS symbols
  # @return [String] Path
  # @see ::File::join
  def join(*_args)
    @root.join(*_args)
  end
  
  # Expands glob pattern and returns a path of the first matching file or 
  # directory relative to #dir. SYS symbols are resolved as well. If they 
  # contain a Hash, the game root attributes are considered during key 
  # selection.
  # 
  # If a block is given, calls the block once for each matching file or 
  # directory, passing the path as a parameter to the block. 
  # 
  # @param _args [String,Symbol] Glob patterns or SYS attributes
  # @return [String] First matching path
  # @see ::Dir::glob
  def glob(*_args, &block)
    @root.glob(*_args, &block)
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :root
  attr_reader :cache_id

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected
  
  def platform_id
    @root.platform_id
  end
  
  def country_id
    @root.country_id
  end

  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def is_dc?
    @root.is_dc?
  end

  # Returns +true+ if the platform is a Gamecube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Gamecube, otherwise +false+.
  def is_gc?
    @root.is_gc?
  end

  # Returns +true+ if the country is 'EU', otherwise +false+.
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def is_eu?
    @root.is_eu?
  end

  # Returns +true+ if the country is 'JP', otherwise +false+.
  # @return [Boolean] +true+ if country is 'JP', otherwise +false+.
  def is_jp?
    @root.is_jp?
  end

  # Returns +true+ if the country is 'US', otherwise +false+.
  # @return [Boolean] +true+ if country is 'US', otherwise +false+.
  def is_us?
    @root.is_us?
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
