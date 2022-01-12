#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2022 Marcel Renner
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

require('pathname')
require('zlib')
require_relative('cachedescriptor.rb')
require_relative('executable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write cache files.
class CacheFile

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Name format of cache file
  CACHE_FILE = '%s.marshal.gz'
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CacheFile.
  # @param _prefix [String] Prefix for unique cache key
  # @see #key
  def initialize(_prefix = '')
    @prefix = _prefix.to_s
    clear
  end

  # Clears all attributes to their default values.
  def clear
    @version     = Executable::VERSION
    @dummies     = []
    @descriptors = []
    @storage     = {}
    @obsolete    = false
  end

  # Returns +true+ if the cache storage is obsolete, otherwise +false+.
  # @return [Boolean] +true+ if cache obsolete is empty, otherwise +false+.
  def obsolete?
    @obsolete
  end

  # Returns +true+ if the cache storage is not obsolete, otherwise +false+.
  # @return [Boolean] +true+ if cache storage is not obsolete, otherwise 
  #                   +false+.
  def valid?
    !obsolete?
  end

  # Reads a cache file. If storage is no longer up to date, #obsolete? is set 
  # to +true+, otherwise +false+. If +_pool+ is not given, all range 
  # descriptors are refreshed.
  # 
  # @param _pool [Symbol] Range descriptor pool
  def load(_pool = nil)
    @obsolete = true
    unless SYS.cache
      return
    end

    _filename = Root.join(SYS.cache_dir, sprintf(CACHE_FILE, key))
    unless File.exist?(_filename)
      return
    end
    
    _valid = true
    begin
      _file    = Zlib::GzipReader.open(_filename)
      _valid &&= load_version(_file)
      _valid &&= load_dummies(_file)
      _valid &&= load_descriptors(_file)
      _valid &&= load_storage(_file)
    rescue StandardError
      _valid = false
    ensure
      _file&.close
    end
    
    if _valid
      @obsolete = @descriptors.any? do |_dscr|
        if _pool && _dscr.pool != _pool
          false
        else
          _dscr.refresh
        end
      end
    else
      @descriptors.each do |_dscr|
        _dscr.clear
      end
    end
  end

  # Writes a cache file and resets #obsolete? to +false+. If +_pool+ is not 
  # given, all range descriptors are refreshed.
  # 
  # @param _pool [Symbol] Range descriptor pool
  def save(_pool = nil)
    unless SYS.cache
      return
    end

    _modified = @descriptors.empty?
    @descriptors.each do |_dscr|
      if _pool && _dscr.pool != _pool
        next
      end
      _result     = _dscr.refresh
      _modified ||= _result
    end
    if !_pool && !_modified
      return
    end

    _filename = Root.join(SYS.cache_dir, sprintf(CACHE_FILE, key))
    LOG.info(sprintf(VOC.save, VOC.open_cache, _filename))
    FileUtils.mkdir_p(Root.join(SYS.cache_dir))
    Zlib::GzipWriter.open(_filename, SYS.cache_compression) do |_f|
      Marshal.dump(@version    , _f)
      Marshal.dump(@dummies    , _f)
      Marshal.dump(@descriptors, _f)
      Marshal.dump(@storage    , _f)
    end
    
    @obsolete = false
  end
  
  # Adds a dummy item that ensures the data integrity of the cached object. 
  # This is used to identify and pre-reject possible file format mismatches in 
  # the cache that may lead to undefined behavior. The dummy object must be 
  # identical in both memory and cache to avoid being rejected in #load.
  # 
  # @param _obj [Object] Dummy object except +false+ and +nil+
  def add_dummy(_obj)
    if _obj && !@dummies.include?(_obj)
      @dummies << _obj
    end
  end

  # Adds a range descriptor of the data to be cached. This is primarily used 
  # to determine modification times and checksums of the data in #load and 
  # #save. If a string is specified, the entire file is used.
  # 
  # @param _pool       [String,Symbol]          Range descriptor pool
  # @param _descriptor [RangeDescriptor,String] Range descriptor or file name
  def add_descriptor(_pool, _descriptor)
    if !_descriptor.is_a?(RangeDescriptor) && !_descriptor.is_a?(String)
      return
    end
    if _descriptor.is_a?(String)
      if _descriptor.empty?
        return
      end
      _descriptor = relative_path(_descriptor)
      _descriptor = RangeDescriptor.new(_descriptor, 0x0..0xffffffff)
    end
    
    _descriptor = CacheDescriptor.new(_pool, _descriptor)
    if @descriptors.include?(_descriptor)
      return
    end

    @descriptors << _descriptor
    @descriptors.sort! do |_a, _b|
      _comp = (_a.pool <=> _b.pool)
      _comp = (_a.name <=> _b.name) if _comp == 0
      _comp = (_a.beg  <=> _b.beg ) if _comp == 0
      _comp = (_a.end  <=> _b.end ) if _comp == 0
      _comp = (_a.excl <=> _b.excl) if _comp == 0
      _comp = (_a.msgt <=> _b.msgt) if _comp == 0
      _comp
    end
  end

  # Adds a object to the cache storage.
  # @param _sym [Symbol] Object symbol
  # @param _obj [Object] Object instance
  # @return [Object] Object instance
  def add_storage(_sym, _obj)
    _sym = _sym.to_sym
    _obj = _obj.dup
    if _obj.is_a?(Hash)
      _obj.default_proc = nil
    end
    
    @storage[_sym] = _obj
  end
  
  # @see ::BasicObject#method_missing
  def method_missing(_sym, *_args)
    if self.class.instance_methods(false).include?(_sym)
      return super
    end
    
    if @storage.include?(_sym)
      return @storage[_sym]
    end
    _key = ('@' + _sym.to_s).to_sym
    if @storage.include?(_key)
      return @storage[_key]
    end
    
    super
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :prefix
  attr_reader   :version
  attr_reader   :descriptors
  attr_reader   :dummies
  attr_reader   :storage

  # Returns a unique key which is generated from the prefix and range 
  # descriptors.
  # @return [String] Cache key
  def key
    _digest = Digest::SHA1.new
    @descriptors.each do |_dscr|
      _buffer = Marshal.dump(_dscr.descriptor)
      _digest.update(_buffer)
    end
    
    _key = ''
    unless @prefix.empty?
      _key << @prefix
      _key << '-'
    end
    _key << _digest.to_s
    _key
  end
  
#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # @see Pathname#relative_path_from
  def relative_path(_path)
    Pathname.new(_path).relative_path_from(Root.dirname).to_s
  end

  # Loads the cache version from an I/O stream.
  # @param _f [IO] I/O stream
  # @return [Boolean] +true+ if cache storage is valid, otherwise +false+.
  def load_version(_f)
    _version = Marshal.load(_f)
    _version.is_a?(String) && _version >= '5.0.0'
  end
  
  # Loads the cache dummies from an I/O stream.
  # @param _f [IO] I/O stream
  # @return [Boolean] +true+ if cache dummies are valid, otherwise +false+.
  def load_dummies(_f)
    _dummies = Marshal.load(_f)
    _dummies == @dummies
  end
  
  # Loads the cache descriptors from an I/O stream.
  # @param _f [IO] I/O stream
  # @return [Boolean] +true+ if cache descriptors are valid, otherwise +false+.
  def load_descriptors(_f)
    _descriptors = Marshal.load(_f)
    unless _descriptors.is_a?(Array)
      return false
    end
    
    @descriptors.each_with_index do |_dscr, _id|
      _cache = _descriptors[_id]
      unless _cache
        next
      end
      if _cache != _dscr
        next
      end
      
      _dscr.modified = _cache.modified
      _dscr.checksum = _cache.checksum
    end
    
    true
  end
  
  # Loads the cache storage from an I/O stream.
  # @param _f [IO] I/O stream
  # @return [Boolean] +true+ if cache storage is valid, otherwise +false+.
  def load_storage(_f)
    LOG.info(sprintf(VOC.load, VOC.open_cache, _f.path))
    _storage = Marshal.load(_f)
    unless _storage.is_a?(Hash)
      return false
    end
    
    @storage.each_key do |_sym|
      if _storage.include?(_sym)
        @storage[_sym] = _storage[_sym]
      end
    end
    
    true
  end
  
end # class CacheFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
