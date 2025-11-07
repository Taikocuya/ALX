#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require('fileutils')
require_relative('cachefile.rb')
require_relative('executable.rb')

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
  # @param _class  [Entry]   Entry object
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_class, _depend = true)
    @class  = _class
    @depend = _depend
    @cache  = CacheFile.new
  end

  # Creates an entry.
  # @return [Entry] Entry object
  def create_entry
    @class.new
  end

  # @see Root#etc
  def etc(...)
    Root.etc(...)
  end

  # @see Root#cfg
  def cfg(...)
    Root.cfg(...)
  end

  # @see Root#dscrptr
  def dscrptr(...)
    Root.dscrptr(...)
  end

  # @see Root#strdetr
  def strdetr(...)
    Root.strdetr(...)
  end

  # @see Root#voc
  def voc(...)
    Root.voc(...)
  end

  # @see Root#join
  def join(...)
    Root.join(...)
  end

  # @see Root#glob
  def glob(...)
    Root.glob(...)
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :depend
  attr_reader :cache

  def product_id
    Root.product_id
  end
  alias pid product_id
  
  def country_id
    Root.country_id
  end
  alias cid country_id

  def sot_files
    Root.sot_files
  end

  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def dc?
    Root.dc?
  end

  # Returns +true+ if the platform is a GameCube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a GameCube, otherwise +false+.
  def gc?
    Root.gc?
  end

  # Returns +true+ if the country is 'EU', otherwise +false+.
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def eu?
    Root.eu?
  end

  # Returns +true+ if the country is 'JP', otherwise +false+.
  # @return [Boolean] +true+ if country is 'JP', otherwise +false+.
  def jp?
    Root.jp?
  end

  # Returns +true+ if the country is 'US', otherwise +false+.
  # @return [Boolean] +true+ if country is 'US', otherwise +false+.
  def us?
    Root.us?
  end

  # Returns +:big+ or +:little+ depending on the platform endianness.
  # @return [Symbol] +:big+ or +:little+ depending on endianness.
  def endianness
    Root.endianness
  end

  # Returns +true+ if the endianness is big-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is big-endian, otherwise +false+.
  def big_endian?
    Root.big_endian?
  end

  # Returns +true+ if the endianness is little-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is little-endian, otherwise +false+.
  def little_endian?
    Root.little_endian?
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache file. This method calls #init_cache_key, 
  # #init_cache_dummies, #init_cache_descriptors and #init_cache_storage.
  def init_cache
    init_cache_object
    init_cache_key
    init_cache_dummies
    init_cache_descriptors
    init_cache_storage
  end

  # Initializes the cache object.
  def init_cache_object
    @cache.clear
  end
  
  # Initializes the cache key.
  def init_cache_key
    @cache.prefix = @class.name.split('::').last.downcase
  end
  
  # Initializes the cache dummies.
  def init_cache_dummies
    @cache.dummies.clear
    @cache.add_dummy(create_entry)
  end

  # Initializes the cache descriptors.
  def init_cache_descriptors
    @cache.descriptors.clear
  end

  # Initializes the cache storage.
  def init_cache_storage
    @cache.storage.clear
  end

  # Assigns the objects from the cache storage beginning with @-characters to 
  # existing instance variables.
  # @param _force [Boolean] Force overwrite even if empty or obsolete
  def assign_cache(_force = false)
    if !_force && @cache.obsolete?
      return
    end

    @cache.storage.each do |_sym, _obj|
      if _sym.to_s.start_with?('@') && instance_variable_defined?(_sym)
        instance_variable_set(_sym, _obj)
      end
    end
  end

  # Reads all entries from a cache file.
  # @param _pool [Symbol] Range descriptor pool
  def load_cache(_pool = nil)
    init_cache
    @cache.load(_pool)
    assign_cache
  end

  # Writes all entries to a cache file.
  # @param _pool [Symbol] Range descriptor pool
  def save_cache(_pool = nil)
    if @cache
      init_cache_storage
    else
      init_cache
    end
    @cache.save(_pool)
  end

  # Returns +true+ if entry ID is valid, otherwise +false+.
  # @param _id         [Integer]         Entry ID
  # @param _range      [Range]           ID range
  # @param _descriptor [RangeDescriptor] Range descriptor
  # @return [Boolean] +true+ if country is valid, otherwise +false+.
  def id_valid?(_id, _range, _descriptor)
    _valid   = true
    _valid &&= _range.include?(_id)
    _valid &&= !_descriptor.excl.include?(_id)
    _valid
  end

  # Finds the range descriptor with given filename.
  # @param _descriptor [RangeDescriptor,Array] Range descriptor(s)
  # @param _filename   [String]                File name
  # @return [RangeDescriptor] Range descriptor
  def find_descriptor(_descriptor, _filename)
    if _descriptor.is_a?(Array)
      _descriptor = _descriptor.find { |_r| _filename.include?(_r.name) }
    end
    unless _descriptor.is_a?(RangeDescriptor)
      _msg = '%s is not a range descriptor'
      raise(TypeError, sprintf(_msg, _descriptor.inspect))
    end
    _descriptor ||= RangeDescriptor.new('', 0x0..0xffffffff)
    _descriptor
  end

  # Calls the given block once for each range descriptor, passing that element 
  # as a parameter.
  # @param _descriptor [RangeDescriptor,Array] Range descriptor(s)
  def each_descriptor(_descriptor)
    [_descriptor].flatten.compact.each do |_dscr|
      yield _dscr
    end
  end

#------------------------------------------------------------------------------
# Protected Member Variables
#------------------------------------------------------------------------------

  def eu
    'EU'
  end

  def jp
    'JP'
  end

  def us
    'US'
  end

  def de
    'DE'
  end

  def es
    'ES'
  end

  def fr
    'FR'
  end

  def gb
    'GB'
  end
  
end # class EntryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
