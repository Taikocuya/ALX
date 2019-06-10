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

require_relative('executable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a meta data.
class MetaData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # Constructs a MetaData.
  # @param _cache_id [String] Cache ID
  def initialize(_cache_id)
    @version  = Executable::VERSION
    @cache_id = _cache_id
    @created  = Time.new
    @modified = Time.new(0)
  end

  # Returns +true+ if the meta data version is valid, otherwise +false+.
  # @return [Boolean] +true+ if meta data version is valid, otherwise +false+.
  def valid?
    @version != Executable::VERSION || !@cache_id.is_a?(String)
  end

  # Returns +true+ if the meta data has modified, otherwise +false+.
  # @return [Boolean] +true+ if meta data has modified, otherwise +false+.
  def updated?
    @modified > @created
  end

  # Checks the modification time of the given file and updates #modified if it 
  # is newer.
  # @param _filename [String] File name
  def check_mtime(_filename)
    _mtime = File.mtime(_filename)
    if _mtime > @modified
      @modified = _mtime
    end
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @param _array [Array] Array object
  def marshal_load(_array)
    @version  = _array.shift
    @cache_id = _array.shift
    @created  = _array.shift
    @modified = Time.new(0)
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Array] Array object
  def marshal_dump
    [@version, @cache_id, @created]
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :version
  attr_accessor :cache_id
  attr_accessor :created
  attr_accessor :modified

end # class MetaData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
