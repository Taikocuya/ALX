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

require('securerandom')
require_relative('executable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle metadata for snapshots.
class MetaData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # Constructs a MetaData.
  # @param _luid [String] Locally Unique ID (LUID)
  def initialize(_luid)
    @version   = Executable::VERSION
    @luid      = _luid
    @uuid      = SecureRandom.uuid
    @created   = Time.new
    @modified  = Time.new + 1
    @checksums = {}
    
    ObjectSpace.each_object(ETC).to_a.each do |_etc|
      @checksums[_etc.symbol] = _etc.checksum
    end
  end

  # Returns +true+ if the metadata is valid, otherwise +false+.
  # @return [Boolean] +true+ if metadata is valid, otherwise +false+.
  def valid?
    _result   = true
    _result &&= (@version == Executable::VERSION)
    _result &&= @luid.is_a?(String)
    _result &&= @uuid.is_a?(String)
    _result &&= @checksums.is_a?(Hash)
    _result &&= @created.is_a?(Time)
    _result &&= @modified.is_a?(Time)
    
    if SYS.snapshot_watch_config
      _result &&= ObjectSpace.each_object(ETC).to_a.all? do |_etc|
        @checksums[_etc.symbol] == _etc.checksum
      end
    end

    _result
  end

  # Returns +true+ if the metadata has been modified, otherwise +false+.
  # @return [Boolean] +true+ if metadata has been modified, otherwise +false+.
  def updated?
    @modified > @created
  end

  # Stores the modification time of the given file.
  # @param _filename [String] File name
  def store_mtime(_filename)
    _mtime = File.mtime(_filename)
    if _mtime > @modified
      @modified = _mtime
    end
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @param _hash [Hash] Hash object
  def marshal_load(_hash)
    _hash.each do |_sym, _value|
      instance_variable_set(_sym, _value)
    end
    @modified = Time.new(0)
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash              = {}
    _hash[:@version  ] = @version
    _hash[:@luid     ] = @luid
    _hash[:@uuid     ] = @uuid
    _hash[:@created  ] = @created
    _hash[:@checksums] = @checksums
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :version
  attr_accessor :luid
  attr_accessor :uuid
  attr_accessor :created
  attr_accessor :modified
  attr_accessor :checksums

end # class MetaData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
