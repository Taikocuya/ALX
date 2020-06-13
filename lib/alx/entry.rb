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

require('csv')
require_relative('binarystringio.rb')
require_relative('fltdmy.rb')
require_relative('fltext.rb')
require_relative('fltvar.rb')
require_relative('hexdmy.rb')
require_relative('hexext.rb')
require_relative('hexvar.rb')
require_relative('intdmy.rb')
require_relative('intext.rb')
require_relative('intvar.rb')
require_relative('main.rb')
require_relative('strdmy.rb')
require_relative('strext.rb')
require_relative('strvar.rb')

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
  # @param _root [GameRoot] Game root
  def initialize(_root)
    @root       = _root
    @members    = [IntDmy.new(VOC.id, id)]
    @padding_id = 0
    @unknown_id = 0
    @expired    = false
  end

  # Returns the file size of the entry.
  # @return [Integer] Size of entry
  def size
    _strio = BinaryStringIO.new('', 'wb', endianness: @root.endianness)
    write_to_bin(_strio)
    _strio.pos
  end

  # Returns the CSV header of the entry.
  # @return [Array] CSV header of entry
  def header
    _header = []
    @members.each do |_m|
      if _m.is_a?(Property)
        _header << _m.name
      end
    end
    _header
  end
  
  # Returns the first property by given name, or +nil+ otherwise.
  # @param _name [String] Name of property
  # @return [Property] Object of property
  def find_member(_name)
    if @members
      @members.find do |_m|
        _m.name == _name
      end
    else
      nil
    end
  end

  # Compares two entries based on +FltVar+, +IntVar+ and +StrVar+ members. 
  # Returns +true+ if all member values are equal, or +false+ otherwise.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if all member values are equal, otherwise +false+.
  def ==(_entry)
    _result   = true
    _result &&= _entry.is_a?(Entry)
    _result &&= (id == _entry.id)
    _result &&= @members.all? do |_m|
      _other = _entry.find_member(_m.name)
      if _other && _m.is_a?(Property) && !_m.dummy?
        _m.value == _other.value
      else
        true
      end
    end
    
    _result
  end

  # Checks the entry with a snapshot. Assigns +true+ to #expired if the entry 
  # differs from the snapshot, otherwise nothing happens. Returns +true+ if 
  # the entry matches the snapshot, otherwise +false+.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if entry matches the snapshot, otherwise +false+.
  def check_expiration(_entry)
    _found   = true
    _found &&= _entry.is_a?(Entry)
    _found &&= (id == _entry.id)

    if _found && self != _entry
      @expired = true
    end
    
    _found
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

  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_from_bin(_f)
    @members.each do |_m|
      _m.read_from_bin(_f)
    end
  end
  
  # Write one entry to a binary IO.
  # @param _f [IO] Binary I/O stream
  def write_to_bin(_f)
    @members.each do |_m|
      _m.write_to_bin(_f)
    end
  end

  # Reads one entry from a CSV file or CSV row.
  # @param _csv   [CSV, CSV::Row] CSV object or CSV row
  # @param _force [Boolean]       Ignore missing properties.
  def read_from_csv(_csv, _force = false)
    _row = _csv.is_a?(CSV::Row) ? _csv : _csv.shift
    @members.each do |_m|
      if !_force || _row.header?(_m.name)
        _m.read_from_csv_row(_row)
      end
    end
  end

  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_to_csv(_csv)
    _row = CSV::Row.new(header, [])
    @members.each do |_m|
      _m.write_to_csv_row(_row)
    end
    _csv << _row
  end

  # Provides marshalling support for use by the Marshal library.
  # @param _hash [Hash] Hash object
  def marshal_load(_hash)
    _hash.each do |_key, _value|
      instance_variable_set(_key, _value)
    end
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash               = {}
    _hash[:@root]       = @root
    _hash[:@members]    = @members
    _hash[:@padding_id] = @padding_id
    _hash[:@unknown_id] = @unknown_id
    _hash
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader   :root
  attr_reader   :members
  attr_accessor :expired

  def id
    _member = find_member(VOC.id)
    if _member
      _member.value
    else
      -1
    end
  end

  def id=(_id)
    _member = find_member(VOC.id)
    if _member
      _member.value = _id
    else
      _id
    end
  end

  def product_id
    @root.product_id
  end
  
  def country_id
    @root.country_id
  end
  
  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def dc?
    @root.dc?
  end

  # Returns +true+ if the platform is a Gamecube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Gamecube, otherwise +false+.
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
  
end	# class Entry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
