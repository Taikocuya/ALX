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

require('fileutils')
require_relative('executable.rb')
require_relative('metadata.rb')
require_relative('shtmanger.rb')

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
  # @param _class  [Entry]    Entry object
  # @param _root   [GameRoot] Game root
  # @param _depend [Boolean]  Resolve dependencies
  def initialize(_class, _root, _depend = true)
    @@cache ||= {}
    @class    = _class
    @root     = _root
    @depend   = _depend
    @sht      = ShtManager.new(_root, self.class.name.split('::').last)
  end
  
  # Creates an entry.
  # @return [Entry] Entry object
  def create_entry
    @class.new(@root)
  end

  # Returns an object from cache for the given symbol. If the symbol cannot 
  # be found, then default will be stored in cache and returned.
  # 
  # @param _sym     [Symbol] Object symbol
  # @param _default [Object] Object instance
  # 
  # @return [Object] Object instance
  def fetch_cache(_sym, _default)
    _luid = sprintf('%s-%s', luid, _sym.to_s)
    _data = @@cache[_luid]
    
    if depend && !_data
      @@cache[_luid] = _default
    end
    
    _data || _default
  end

  # Refreshes all objects in cache to force an update of entry properties.
  def refresh
    @@cache.each do |_sym, _obj|
      if _sym.start_with?(luid)
        case _obj
        when Array
          _obj.each do |_entry|
            _entry.refresh
          end
        when Hash
          _obj.each_value do |_entry|
            _entry.refresh
          end
        end
      end
    end
  end

  # @see GameRoot#etc
  def etc(*_args)
    @root.etc(*_args)
  end

  # @see GameRoot#sys
  def sys(*_args)
    @root.sys(*_args)
  end

  # @see GameRoot#voc
  def voc(*_args)
    @root.voc(*_args)
  end

  # @see GameRoot#join
  def join(*_args)
    @root.join(*_args)
  end

  # @see GameRoot#glob
  def glob(*_args, &_block)
    @root.glob(*_args, &_block)
  end

  # Reads an object from a SHT file and returns it.
  # @param _sym [Symbol] Object symbol
  # @return [Object] Object instance
  def load_sht_data(_sym)
    unless SYS.snapshot_use_cache
      return nil
    end
    
    @sht.load_sht_data(_sym)
  end

  # Reads all snaphots (instance variables) from SHT files.
  def load_sht
    unless SYS.snapshot_use_cache
      return
    end
    
    @sht.load_sht_meta
  end

  # Writes an object to a SHT file and returns it.
  # @param _sym [Symbol] Object symbol
  # @param _obj [Object] Object instance
  # @return [Object] Object instance
  def save_sht_data(_sym, _obj)
    unless SYS.snapshot_use_cache
      return nil
    end

    @sht.save_sht_data(_sym, _obj)
  end

  # Writes all snaphots (instance variables) to SHT files.
  def save_sht
    unless SYS.snapshot_use_cache
      return
    end
    
    @sht.save_sht_meta
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :root
  attr_reader :depend
  attr_reader :sht

  def luid
    @sht.luid
  end
  
  def meta
    @sht.meta
  end
  
  def snaps
    @sht.snaps
  end
  
  def product_id
    @root.product_id
  end
  alias pid product_id
  
  def country_id
    @root.country_id
  end
  alias cid country_id

  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def dc?
    @root.dc?
  end

  # Returns +true+ if the platform is a GameCube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a GameCube, otherwise +false+.
  def gc?
    @root.gc?
  end

  # Returns +true+ if the country is 'EU', otherwise +false+.
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def eu?
    @root.eu?
  end

  # Returns +true+ if the country is 'JP', otherwise +false+.
  # @return [Boolean] +true+ if country is 'JP', otherwise +false+.
  def jp?
    @root.jp?
  end

  # Returns +true+ if the country is 'US', otherwise +false+.
  # @return [Boolean] +true+ if country is 'US', otherwise +false+.
  def us?
    @root.us?
  end

  # Returns +:big+ or +:little+ depending on the platform endianness.
  # @return [Symbol] +:big+ or +:little+ depending on endianness.
  def endianness
    @root.endianness
  end

  # Returns +true+ if the endianness is big-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is big-endian, otherwise +false+.
  def big_endian?
    @root.big_endian?
  end

  # Returns +true+ if the endianness is little-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is little-endian, otherwise +false+.
  def little_endian?
    @root.little_endian?
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

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
      raise(TypeError, sprintf('%s is not a range descriptor', _descriptor))
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
    
  def languages
    SYS.language_names.keys
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
