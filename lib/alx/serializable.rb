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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Mixin to read and write easily in binary IOs.
module Serializable
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Endianness of this host (do not edit).
  ENDIANNESS  = ([0xfeff].pack('s') == [0xfeff].pack('n') ? :be : :le)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Returns +true+ if the endianness is big-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is big-endian, otherwise +false+.
  def big_endian?
    @endianness == :be
  end

  # Returns +true+ if the endianness is little-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is little-endian, otherwise +false+.
  def little_endian?
    @endianness == :le
  end

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int8
    int_directive(:i8)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int16
    int_directive(:i16)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int32
    int_directive(:i32)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int64
    int_directive(:i64)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint8
    int_directive(:u8)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint16
    int_directive(:u16)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint32
    int_directive(:u32)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint64
    int_directive(:u64)
  end

  # Returns the required floating-point directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def float
    flt_directive(:f32)
  end

  # Returns the required floating-point directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def double
    flt_directive(:f64)
  end

  # Reads an integer from the file.
  # @param _type [Symbol] Type of the integer, which will be read.
  # @return [Integer] Integer from the file, which has been read.
  def read_int(_type)
    _format = int_directive(_type)
    _size   = [0].pack(_format).size
    _int    = read(_size)

    if _int && _int.size == _size
      _int.unpack(_format).first
    else
      nil
    end
  end

  # Writes an integer to the file.
  # @param _int  [Integer] Integer which will be written to the stream.
  # @param _type [Symbol]  Type of the integer, which will be written.
  def write_int(_int, _type)
    unless _int.is_a?(Integer)
      raise(TypeError, sprintf('%s is not an integer', _int))
    end

    _format = int_directive(_type)
    write([_int].pack(_format))
  end

  # Reads a floating-point value from the file.
  # @param _type [Symbol] Type of the floating-point value, which will be read.
  # @return [Float] Floating-point value from the file, which has been read.
  def read_flt(_type)
    _format = flt_directive(_type)
    _size   = [0.0].pack(_format).size
    _flt    = read(_size)
    
    if _flt && _flt.size == _size
      _flt = _flt.unpack(_format).first
      if _type == :f32
        _flt = _flt.round(6)
      end
      
      _flt
    else
      nil
    end
  end

  # Writes a floating-point value to the file.
  # @param _flt  [Float]  Floating-point value which will be written to the 
  #                       stream.
  # @param _type [Symbol] Type of the floating-point value, which will be 
  #                       written.
  def write_flt(_flt, _type)
    unless _flt.is_a?(Float)
      raise(TypeError, sprintf('%s is not a floating-point value', _flt))
    end
    
    if _type == :f32
      _flt = _flt.round(6)
    end

    _format = flt_directive(_type)
    write([_flt].pack(_format))
  end

  # Reads a string from the file. If +_size+ is omitted or +_block+ is given,
  # the string have to be null-terminated.
  # 
  # @param _size     [Integer] Desired number of bytes to read.
  # @param _blocks   [Integer] Block size in bytes
  # @param _encoding [String]  Character encoding
  # 
  # @return [String] String from the file, which has been read.
  def read_str(_size = nil, _blocks = nil, _encoding = 'Shift_JIS')
    if _size
      if _blocks && _blocks > 0
        if _size % _blocks != 0
          _msg = sprintf(
            'string size invalid (given %#x, expected %#x or %#x)',
            _size,
            _size - _size % _blocks,
            _size + (_blocks - _size % _blocks)
          )
          raise(IOError, _msg)
        end
      end
    else
      _blocks ||= 0x1
    end
    
    _beg = pos
    _str = ''.force_encoding('ASCII-8BIT')
    if _size
      _str << read(_size)
    else
      _str  << readline("\x00")
      _diff  = pos - _beg
      if _blocks && _diff % _blocks != 0
        _str << read(_blocks - _diff % _blocks)
      end
    end
    _str = _str.unpack('Z*').first
    
    _diff = pos - _beg
    if _blocks && _blocks > 0 && _diff % _blocks != 0
      _msg = sprintf(
        'string size invalid (given %#x, expected %#x)',
        _size,
        _diff + (_blocks - _diff % _blocks)
      )
      raise(IOError, _msg)
    end

    if _str.empty?
      return _str
    end
    
    if _encoding == 'Windows-1252'
      _str.gsub!("\x81\x63".force_encoding('ASCII-8BIT'), "\x85")
    end
    
    _str.force_encoding(_encoding)
    _str.encode!('UTF-8')
    
    if _encoding == 'Windows-1252'
      _str.gsub!('[', '“')
      _str.gsub!(']', '”')
    end
    
    _str
  end

  # Writes a string to the file. If +_size+ is omitted or +_block+ is given,
  # the string will be null-terminated. If the string is less than +_size+
  # and +_block+ is given, the string is additionally padded with spaces.
  # 
  # @param _str      [String]  String which will be written to the stream.
  # @param _size     [Integer] Desired number of bytes to write.
  # @param _blocks   [Integer] Block size in bytes
  # @param _encoding [String]  Character encoding
  def write_str(_str, _size = nil, _blocks = nil, _encoding = 'Shift_JIS')
    _str = _str.dup

    if _encoding == 'Windows-1252'
      _str.gsub!('“', '[')
      _str.gsub!('”', ']')
    end
    
    if _encoding == 'ASCII-8BIT'
      _str.force_encoding('ASCII-8BIT')
    else
      _str.encode!(_encoding)
    end

    if _size
      if _str.bytesize > _size
        _msg = 'string size invalid (given %#x, expected %#x)'
        _exp = _str.bytesize
        if _blocks && _blocks > 0
          _exp += _blocks - _str.bytesize % _blocks
        end
        raise(IOError, sprintf(_msg, _size, _exp))
      end
      if _blocks && _blocks > 0
        if _str.bytesize + (_blocks - _str.bytesize % _blocks) > _size
          _msg = sprintf(
            'string size invalid (given %#x, expected %#x)',
            _size,
            _str.bytesize + (_blocks - _str.bytesize % _blocks)
          )
          raise(IOError, _msg)
        end
        if _size % _blocks != 0
          _msg = sprintf(
            'string size invalid (given %#x, expected %#x or %#x)',
            _size,
            _size - _size % _blocks,
            _size + (_blocks - _size % _blocks)
          )
          raise(IOError, _msg)
        end
        
        _str = _str.ljust(_size - _blocks)
      end
    else
      _size     = _str.bytesize
      _blocks ||= 0x1
      _size    += _blocks - _size % _blocks
    end

    if _size > 0
      write([_str].pack("Z#{_size}"))
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :endianness

  def endianness=(_endianness)
    case _endianness
    when :be, :big_endian
      @endianness = :be
    when :le, :little_endian
      @endianness = :le
    else
      @endianness = ENDIANNESS
    end
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns the required integer directive depending on the platform 
  # endianness.
  # @param _type [Symbol] Type of the integer
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int_directive(_type)
    if !_type.is_a?(String) && !_type.is_a?(Symbol)
      raise(TypeError, sprintf('%s is not a symbol nor a string', _type))
    end

    _type = _type.to_sym
    case _type
    when :i8
      'c'
    when :i16
      big_endian? ? 's>' : 's<'
    when :i32
      big_endian? ? 'l>' : 'l<'
    when :i64
      big_endian? ? 'q>' : 'q<'
    when :u8
      'C'
    when :u16
      big_endian? ? 'S>' : 'S<'
    when :u32
      big_endian? ? 'L>' : 'L<'
    when :u64
      big_endian? ? 'Q>' : 'Q<'
    else
      raise(TypeError, sprintf('%s is not an integer type', _type))
    end
  end

  # Returns the required floating-point directive depending on the platform 
  # endianness.
  # @param _type [Symbol] Type of the floating-point value
  # @return [String] Floating-point directive
  # @see ::Array#pack
  # @see ::String#unpack
  def flt_directive(_type)
    if !_type.is_a?(String) && !_type.is_a?(Symbol)
      raise(TypeError, sprintf('%s is not a symbol nor a string', _type))
    end

    _type = _type.to_sym
    case _type
    when :f32
      big_endian? ? 'g' : 'e'
    when :f64
      big_endian? ? 'G' : 'E'
    else
      raise(TypeError, sprintf('%s is not a floating-point type', _type))
    end
  end

end # class Serializable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
