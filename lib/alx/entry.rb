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

require('csv')
require_relative('binarystringio.rb')
require_relative('etc.rb')
require_relative('fltvar.rb')
require_relative('fltdmy.rb')
require_relative('intvar.rb')
require_relative('intdmy.rb')
require_relative('strvar.rb')
require_relative('strdmy.rb')

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
    @padding_id = -1
    @unknown_id = -1
  end

  # Returns the size of the entry.
  # @return [Integer] Size of entry
  def size
    _strio = BinaryStringIO.new('', 'wb')
    write_to_bin(_strio)
    _strio.pos
  end

  # Returns the CSV header of the entry.
  # @return [Array] CSV header of entry
  def header
    _header = []
    @members.each do |_m|
      if _m.is_a?(DataMember)
        _header << _m.name
      end
    end
    _header
  end
  
  # Returns the first data member by given name, or +nil+ otherwise.
  # @param _name [String] Name of data member
  # @return [DataMember] Object of data member
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
  # @param _entry [Entry] Entry
  # @return [Boolean] +true+ if all member values are equal, otherwise +false+.
  def ==(_entry)
    unless _entry.is_a?(Entry)
      return false
    end

    _result   = true
    _result &&= (id == _entry.id)
    if _result
      _result &&= @members.all? do |_m|
        _other = _entry.find_member(_m.name)
        if _other && (_m.is_a?(FltVar) || _m.is_a?(IntVar) || _m.is_a?(StrVar))
          _m.value == _other.value
        else
          true
        end
      end
    end
    
    _result
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

  # Reads one entry from a binary I/O stream..
  # @param _f [IO] Binary I/O stream.
  def read_from_bin(_f)
    @members.each do |_m|
      _m.read_from_bin(_f)
    end
  end
  
  # Write one entry to a binary IO.
  # @param _f [IO] Binary I/O stream.
  def write_to_bin(_f)
    @members.each do |_m|
      _m.write_to_bin(_f)
    end
  end

  # Reads one entry from a CSV file or CSV row.
  # @param _csv   [CSV, CSV::Row] CSV object or CSV row
  # @param _force [Boolean]       Ignore missing data members.
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

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader   :root
  attr_accessor :members

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
