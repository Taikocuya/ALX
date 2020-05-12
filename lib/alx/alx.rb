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

require_relative('rangedescriptor.rb')
require_relative('substitute.rb')

#==============================================================================
#                                   MODULE
#==============================================================================

module ALX

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Converts a path to an absolute path relative to ALX base directory.
  # @param _path [String] Path
  # @return [String] Absolute path
  def self.expand(_path)
    File.expand_path(File.join(File.dirname(__FILE__), '../..', _path))
  end

  # Returns a new path formed by joining the strings using '/'.
  # @param _paths [Hash,String] Path
  # @return [String] Path
  # @see ::File::join
  def self.join(*_paths)
    File.join(_paths)
  end
  
  # Creates a simple glob pattern in which a single asterisk must be used.
  # @param _pattern [String] Glob pattern
  # @return [String] Glob pattern
  def self.glob(*_pattern)
    _pattern = join(_pattern)

    if /^[\[\]{}\?\\]+$/ =~ _pattern
      _msg = "glob pattern invalid - %s (only single asterisk is allowed)"
      raise(ArgumentError, sprintf(_msg, _pattern), caller(1))
    end
    _size = _pattern.count('*')
    if _size != 1
      _msg = "wrong number of asterisks in glob pattern (#{_size} for 1)"
      raise(ArgumentError, _msg, caller(1))
    end
    
    _pattern
  end

  # @see RangeDescriptor::new
  def self.rd(...)
    RangeDescriptor.new(...)
  end
  
  # Initializes and normalizes a range to an accurate begin and end value.
  # @param _range [Range] Range
  # @return [Range] Range
  def self.rng(_range)
    unless _range.is_a?(Range)
      _msg = '%s is not a range'
      raise(TypeError, sprintf(_msg, _range))
    end

    if _range.size > 0
      _min =  _range.begin ? _range.min : 0x0
      _max = (_range.end   ? _range.max : 0xffffffff) + 0x1
    else
      _min = _range.begin
      _max = _range.end
    end

    Range.new(_min, _max, true)
  end
  
  # @see Substitute::new
  def self.gs(...)
    Substitute.new(...)
  end

  # Creates a dynamic CSV header.
  # @param _format [String] Header format
  # @return [Hash] Dynamic CSV header
  def self.hdr(_format)
    _size = _format.scan(/%[ds]/).size
    if _size != 1
      _msg = "wrong number of fields in format sequence (#{_size} for 1)"
      raise(ArgumentError, _msg, caller(1))
    end
    
    _enum  = _format.include?('%d') ? '#%s' : '%s'
    _empty = ''
    _format.sub!('%d', '%s')
    
    if _format =~ /^\[?[^\[]+%s/
      _enum = ' ' + _enum
    end
    if _format =~ /%s[^\]]+\]?$/
      _enum  = _enum + ' '
      _empty = ' '
    end
    
    Hash.new do |_h, _k|
      if (_k.is_a?(Integer) && _k > -1) || (_k.is_a?(String) && !_k.empty?)
        _str = sprintf(_enum, _k)
      else
        _str = _empty
      end
      
      _h[_k] = sprintf(_format, _str)
    end
  end

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
