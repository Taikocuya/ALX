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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to describe an offset range.
class RangeDescriptor
    
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Enumerable)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a RangeDescriptor.
  # @param _name  [String]      Name
  # @param _addr  [Array,Range] Offset range(s)
  # @param excl   [Array]       Exclusion list
  # @param msgtbl [Boolean]     Use message table
  def initialize(_name = '', _addr = [], excl: [], msgtbl: false)
    unless _name.is_a?(String)
      _msg = '%s is not a string'
      raise(TypeError, sprintf(_msg, _name))
    end
    if !_addr.is_a?(Array) && !_addr.is_a?(Range)
      _msg = '%s is not an array nor a range'
      raise(TypeError, sprintf(_msg, _addr))
    end
    if !excl.is_a?(Array) && !excl.is_a?(Integer) && !excl.is_a?(Range)
      _msg = '%s is not an array, an integer nor a range'
      raise(TypeError, sprintf(_msg, excl))
    end

    unless _addr.is_a?(Array)
      _addr = [_addr]
    end
    unless excl.is_a?(Array)
      excl = [excl]
    end
    
    @name   = _name
    @addr   = []
    @beg    = nil
    @end    = nil
    @excl   = []
    @msgtbl = msgtbl

    _addr.each do |_range|
      init_range(_range)
    end
    excl.each do |_excl|
      init_excl(_excl)
    end
    @excl.uniq!
    @excl.sort!
  end
  
  # Returns +true+ if position is valid, otherwise +false+.
  # @param _pos  [Integer] Position
  # @param _size [Integer] Size
  # @return [Boolean] +true+ if country is valid, otherwise +false+.
  def include?(_pos, _size = 1)
    @addr.any? do |_range|
      _pos >= _range.begin && _pos + _size <= _range.end
    end
  end

  # Calls the given block once for each element in #addr, passing that range 
  # as a parameter.
  # @see Array#each
  def each(&_block)
    @addr.each(&_block)
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :name
  attr_reader :addr
  attr_reader :beg
  attr_reader :end
  attr_reader :excl
  attr_reader :msgtbl
  
#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Initializes the offset range(s).
  # @param _range [Range] Range
  def init_range(_range)
    unless _range.is_a?(Range)
      raise(TypeError, sprintf('%s is not a range', _range))
    end
    
    _range = ALX.rng(_range)
    _beg   = _range.begin
    _end   = _range.end
    _min   = _range.min
    _max   = _range.max

    if !@beg || @beg > _beg
      @beg = _beg
    end
    if !@end || @end < _end
      @end = _end
    end
  
    _overlap = @addr.find do |_addr|
      _addr.cover?(_min) || _addr.cover?(_max)
    end
    if _overlap
      _msg = sprintf(
        'range invalid (given 0x%x...0x%x, overlaps 0x%x...0x%x)',
        _beg, _end, _overlap.begin, _overlap.end
      )
      raise(RangeError, _msg)
    end

    @addr << _range
  end

  # Initializes the exclusion list.
  # @param _excl [Integer,Range] Exclusion
  def init_excl(_excl)
    if !_excl.is_a?(Integer) && !_excl.is_a?(Range)
      raise(TypeError, sprintf('%s is not an integer nor a range', _excl))
    end

    case _excl
    when Integer
      _excl = [_excl]
    when Range
      _excl = _excl.to_a
    end
  
    @excl += _excl
  end

end # class RangeDescriptor

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
