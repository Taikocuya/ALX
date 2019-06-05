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
      '%s-%s', File.basename(@root.dirname), self.class.name.split('::').last
    ).downcase
    @snapshot = {}
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
  
  # Unloads all snapshots.
  def clear_snapshot
    @snapshot.clear
  end

  # Reads an instance variable to a MARSHAL file.
  # @param _sym [Symbol] Instance variable symbol
  def load_snapshot(_sym)
    _sym  = _sym.to_sym
    _attr = '@' + _sym.to_s
    _obj  = instance_variable_get(_attr)
    if !_obj && !instance_variable_defined?(_attr)
      raise(ArgumentError, "#{_attr} is not an instance variable")
    end
    if @snapshot.include?(_sym)
      raise(ArgumentError, "snapshot #{_sym.inspect} cannot be overwritten")
    end

    _dirname  = File.join(@root.dirname, SYS.snapshot_dir)
    _filename = sprintf(
      '%s%s.marshal', self.class.name.split('::').last, _attr
    ).downcase
    _filename = File.join(_dirname, _filename)
    unless File.exist?(_filename)
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_snapshot))

    File.open(_filename, 'rb') do |_f|
      LOG.info(sprintf(VOC.read, 0, _f.pos))
      @snapshot[_sym] = Marshal.load(_f)
    end

    LOG.info(sprintf(VOC.close, _filename))
  end
  
  # Writes an instance variable to a MARSHAL file.
  # @param _sym [Symbol] Instance variable symbol
  def save_snapshot(_sym)
    _sym  = _sym.to_sym
    _attr = '@' + _sym.to_s
    _obj  = instance_variable_get(_attr)
    if !_obj && !instance_variable_defined?(_attr)
      raise(ArgumentError, "#{_attr} is not an instance variable")
    end
    if @snapshot.include?(_sym)
      raise(ArgumentError, "snapshot #{_sym.inspect} cannot be overwritten")
    end

    _dirname  = File.join(@root.dirname, SYS.snapshot_dir)
    _filename = sprintf(
      '%s%s.marshal', self.class.name.split('::').last, _attr
    ).downcase
    _filename = File.join(_dirname, _filename)
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_snapshot))
    
    case _obj
    when Array
      _obj = _obj.map do |_entry|
        _entry.checksum
      end
    when Hash
      _obj = _obj.map do |_id, _entry|
        [_id, _entry.checksum]
      end
      _obj = Hash[_obj]
    end
    @snapshot[_sym] = _obj

    FileUtils.mkdir_p(_dirname)
    File.open(_filename, 'wb') do |_f|
      LOG.info(sprintf(VOC.write, 0, _f.pos))
      Marshal.dump(_obj, _f)
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :root
  attr_reader :cache_id
  attr_reader :snapshot

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
#                                  PROTECTED
#==============================================================================

  protected

  # Returns +true+ if entry ID is valid, otherwise +false+.
  # @param _id    [Integer]   Entry ID
  # @param _range [DataRange] Data range
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def id_valid?(_id, _range)
    _valid = true
    if @id_range
      _valid &&= _id >= @id_range.begin
      _valid &&= _id < @id_range.end
    end
    _valid &&= !_range.exclusions.include?(_id)
    _valid
  end

  # Returns +true+ if I/O position is valid, otherwise +false+.
  # @param _pos   [Integer]  I/O position
  # @param _size  [Integer]  Entry size
  # @param _range [DataRang] Data range
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def pos_valid?(_pos, _size, _range)
    _valid   = true
    _valid &&= _pos >= _range.begin
    _valid &&= _pos + _size <= _range.end
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
