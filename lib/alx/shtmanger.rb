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
require_relative('metadata.rb')
require_relative('shtfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read, write and manage snapshots (SHT files).
class ShtManager

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # File name format of SHT file
  SHT_FILE = '%s@%s.sht'
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShtManager with a Locally Unique ID (LUID).
  # @param _root [GameRoot] Game root
  # @param _name [String]   Unique name
  def initialize(_root, _name)
    @root = _root
    @name = _name
    @luid = sprintf('%s-%s', File.basename(@root.dirname), @name).downcase
    
    clear_meta
    clear_snaps
  end

  # Clears metadata.
  def clear_meta
    @meta = MetaData.new(@luid)
  end
    
  # Unloads all snapshots.
  def clear_snaps
    @snaps ||= {}
    @snaps.clear
  end
  
  # Removes all snapshots.
  def delete_snaps
    _dirname  = File.join(@root.dirname, SYS.cache_dir)
    _filename = sprintf(SHT_FILE, @name, '*').downcase
    FileUtils.rm(Dir.glob(File.join(_dirname, _filename)))
  end

  # Reads an object from a SHT file, assigns it to #snaps and returns it.
  # @param _sym [Symbol] Object symbol
  # @return [Object] Object instance
  def load_sht_data(_sym)
    _sym      = _sym.to_sym
    _dirname  = File.join(@root.dirname, SYS.cache_dir)
    _filename = sprintf(SHT_FILE, @name, _sym).downcase
    _filename = File.join(_dirname, _filename)

    unless File.exist?(_filename)
      return nil
    end

    _file = ShtFile.new
    _file.load(_filename)

    if _sym != :meta && !_file.valid?(@meta)
      clear_meta
      clear_snaps
      delete_snaps
    else
      @snaps[_sym] = _file.data
    end
  end

  # Reads the metadata from a SHT file.
  # @return [Object] Object instance
  def load_sht_meta
    @meta = load_sht_data(:meta) || clear_meta
    if !@meta.valid? || @meta.luid != @luid
      clear_meta
      clear_snaps
      delete_snaps
    end
    
    @meta
  end

  # Writes an object to a SHT file, assigns it to #snaps and returns it.
  # @param _sym [Symbol] Object symbol
  # @param _obj [Object] Object instance
  # @return [Object] Object instance
  def save_sht_data(_sym, _obj)
    _sym = _sym.to_sym
    _obj = _obj.dup
    if _obj.is_a?(Hash)
      _obj.default_proc = nil
    end

    _dirname  = File.join(@root.dirname, SYS.cache_dir)
    _filename = sprintf(SHT_FILE, @name, _sym).downcase
    _filename = File.join(_dirname, _filename)

    FileUtils.mkdir_p(_dirname)
    _file      = ShtFile.new
    _file.meta = @meta
    _file.data = _obj
    _file.save(_filename)
    
    @snaps[_sym] = _obj
  end

  # Writes the metadata to a SHT file.
  # @return [Object] Object instance
  def save_sht_meta
    clear_meta
    save_sht_data(:meta, @meta)
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :root
  attr_reader :name
  attr_reader :luid
  attr_reader :meta
  attr_reader :snaps

end # class ShtManager

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
