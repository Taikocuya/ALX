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

require('fileutils')
require('ostruct')
require_relative('executable.rb')
require_relative('metadata.rb')
require_relative('shtfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle entries from binary and/or CSV files.
class EntryData

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # File name format of SHT file
  SHT_FILE = '%s@%s.sht'
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EntryData.
  # @param _class [Entry]    Entry object
  # @param _root  [GameRoot] Game root
  def initialize(_class, _root)
    @class     = _class
    @root      = _root
    @cache_id  = sprintf(
      '%s-%s', File.basename(@root.dirname), self.class.name.split('::').last
    ).downcase
    clear_meta
    clear_snapshots
  end
    
  # Clears metadata.
  def clear_meta
    @meta = MetaData.new(@cache_id)
  end
    
  # Unloads all snapshots.
  def clear_snapshots
    @snapshots ||= {}
    @snapshots.clear
  end
  
  # Removes all snapshots.
  def remove_snapshots
    _dirname  = File.join(@root.dirname, SYS.snapshot_dir)
    _filename = sprintf(
      SHT_FILE, self.class.name.split('::').last, '*'
    ).downcase
    FileUtils.rm(Dir.glob(File.join(_dirname, _filename)))
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
  def glob(*_args, &_block)
    @root.glob(*_args, &_block)
  end

  # Reads an object from a SHT file, assigns it to #snapshots and returns it.
  # @param _sym [Symbol] Object symbol
  # @return [Object] Object instance
  def load_data_from_sht(_sym)
    _sym      = _sym.to_sym
    _class    = self.class.name.split('::').last
    _dirname  = File.join(@root.dirname, SYS.snapshot_dir)
    _filename = sprintf(SHT_FILE, _class, _sym).downcase
    _filename = File.join(_dirname, _filename)

    unless File.exist?(_filename)
      return nil
    end

    _file = ShtFile.new
    _file.load(_filename)

    if _sym != :meta && !_file.valid?(@meta)
      clear_meta
      clear_snapshots
      remove_snapshots
    else
      @snapshots[_sym] = _file.data
    end
  end

  # Reads all snaphots (instance variables) from SHT files.
  def load_all_from_sht
    @meta = load_data_from_sht(:meta) || clear_meta
    if !@meta.valid? || @meta.cache_id != @cache_id
      clear_meta
      clear_snapshots
      remove_snapshots
    end
  end

  # Writes an object to a SHT file, assigns it to #snapshots and returns it.
  # @param _sym [Symbol] Object symbol
  # @param _obj [Object] Object instance
  # @return [Object] Object instance
  def save_data_to_sht(_sym, _obj)
    _sym = _sym.to_sym
    _obj = _obj.dup
    if _obj.is_a?(Hash)
      _obj.default_proc = nil
    end

    _class    = self.class.name.split('::').last
    _dirname  = File.join(@root.dirname, SYS.snapshot_dir)
    _filename = sprintf(SHT_FILE, _class, _sym).downcase
    _filename = File.join(_dirname, _filename)

    FileUtils.mkdir_p(_dirname)
    _file      = ShtFile.new
    _file.meta = @meta
    _file.data = _obj
    _file.save(_filename)
    
    @snapshots[_sym] = _obj
  end

  # Writes all snaphots (instance variables) to SHT files.
  def save_all_to_sht
    clear_meta
    save_data_to_sht(:meta, @meta)
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :root
  attr_reader :cache_id
  attr_reader :meta
  attr_reader :snapshots

  def platform_id
    @root.platform_id
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

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def int8
    @root.int8
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def int16
    @root.int16
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def int32
    @root.int32
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def int64
    @root.int64
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def uint8
    @root.uint8
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def uint16
    @root.uint16
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def uint32
    @root.uint32
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def uint64
    @root.uint64
  end

  # Returns the required float directive depending on the platform endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def float
    @root.float
  end

  # Returns the required float directive depending on the platform endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def double
    @root.double
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns +true+ if entry ID is valid, otherwise +false+.
  # @param _id         [Integer]   Entry ID
  # @param _id_range   [Range]     ID range
  # @param _data_range [DataRange] Data range
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def id_valid?(_id, _id_range, _data_range)
    _valid   = true
    _valid &&= (_id >= _id_range.begin)
    _valid &&= (_id < _id_range.end)
    _valid &&= !_data_range.exclusions.include?(_id)
    _valid
  end

  # Returns +true+ if I/O position is valid, otherwise +false+.
  # @param _pos   [Integer]  I/O position
  # @param _size  [Integer]  Entry size
  # @param _range [DataRang] Data range
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def pos_valid?(_pos, _size, _range)
    _valid   = true
    _valid &&= (_pos >= _range.begin)
    _valid &&= (_pos + _size <= _range.end)
    _valid
  end

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
