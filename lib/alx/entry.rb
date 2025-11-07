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

require('csv')
require_relative('binarystringio.rb')
require_relative('aryprop.rb')
require_relative('fltprop.rb')
require_relative('dynprop.rb')
require_relative('etc.rb')
require_relative('intprop.rb')
require_relative('log.rb')
require_relative('strprop.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle a entry.
class Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Entry.
  def initialize
    init_attrs
    init_props
    init_procs
  end

  # Returns the file size of the entry.
  # @return [Integer] Size of entry
  def size
    _strio = BinaryStringIO.new('', 'wb', endianness: endianness)
    write_bin(_strio)
    _strio.pos
  end

  # Returns the CSV header of the entry.
  # @return [Array] CSV header of entry
  def header
    @props.keys
  end
  
  # Compares two entries based on properties. Returns +true+ if all properties 
  # are equal, or +false+ otherwise.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if all properties are equal, otherwise +false+.
  def ==(_entry)
    _result   = true
    _result &&= _entry.is_a?(self.class)
    _result &&= (id     == _entry.id    )
    _result &&= (header == _entry.header)
    _result &&= @props.all? do |_k, _p|
      _other = _entry.fetch(_k)

      if _other && _p.is_a?(Prop) && _p.comparable?
        _p.value == _other.value
      else
        true
      end
    end
    
    _result
  end

  # Refreshes all entry properties to force a call of entry procs.
  def refresh
    @props.each_value do |_p|
      _p.call_proc
    end
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

  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    @props.each_value do |_p|
      _p.read_bin(_f)
    end
  end
  
  # Write one entry to a binary IO.
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    @props.each_value do |_p|
      _p.write_bin(_f)
    end
  end

  # Reads one entry from a CSV file or CSV row.
  # @param _csv   [CSV, CSV::Row] CSV object or CSV row
  # @param _force [Boolean]       Ignore missing properties.
  def read_csv(_csv, _force = false)
    _row = _csv.is_a?(CSV::Row) ? _csv : _csv.shift
    @props.each do |_key, _prop|
      if !_force || _row.header?(_key)
        _prop.read_csv(_key, _row)
      end
    end
  end

  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_csv(_csv)
    _row = CSV::Row.new(header, [])
    @props.each do |_key, _prop|
      if _row.header?(_key)
        _prop.write_csv(_key, _row)
      end
    end
    _csv << _row
  end

  # Provides marshalling support for use by the Marshal library.
  # @param _hash [Hash] Hash object
  def marshal_load(_hash)
    _hash.each do |_key, _value|
      instance_variable_set(_key, _value)
    end
    init_attrs
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash               = {}
    _hash[:@props     ] = @props
    _hash[:@padding_id] = @padding_id
    _hash[:@unknown_id] = @unknown_id
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader   :props
  attr_accessor :modified

  def clear
    @props.clear
  end
  
  def [](_key)
    @props[_key]&.value
  end
  
  def []=(_key, _value)
    if _value.is_a?(Prop)
      @props[_key] = _value
    else
      _prop = @props[_key]
      if _prop
        _prop.value = _value
      else
        raise(KeyError, sprintf('key not found: "%s"', _key))
      end
    end
  end

  def fetch(_key)
    @props[_key]
  end
  
  def store(_key, _prop)
    unless _prop.is_a?(Prop)
      raise(TypeError, sprintf('%s is not a prop', _prop.inspect))
    end
    
    @props[_key] = _prop
  end
  
  def delete(_key)
    @props.delete(_key)
  end
  
  def id
    self[VOC.id] || -1
  end

  def id=(_id)
    self[VOC.id] = _id
  end

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

  # Initialize the entry attributes.
  def init_attrs
    @props      ||= { VOC.id => IntProp.new(:u32, -1, dmy: true) }
    @padding_id ||= 0
    @unknown_id ||= 0
    @modified   ||= false
  end

  # Initialize the entry properties.
  def init_props
  end
  
  # Initialize the entry procs.
  def init_procs
  end

  # Returns a CSV header with "Padding" as description and an unique 
  # identifier.
  # @return [String] CSV header
  def padding_hdr
    VOC.padding[@padding_id += 1]
  end

  # Returns a CSV header with "Unknown" as description and an unique 
  # identifier.
  # @return [String] CSV header
  def unknown_hdr
    VOC.unknown[@unknown_id += 1]
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
  
end # class Entry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
