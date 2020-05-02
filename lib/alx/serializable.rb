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

# Mixin to read and write easily in binary IOs.
module Serializable
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Byte order mark
  BO_MARK    = 0xfeff
  # Endianness of this host (do not edit).
  ENDIANNESS = ([BO_MARK].pack('s') == [BO_MARK].pack('n') ? :be : :le)

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
    int_directive(:int8)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int16
    int_directive(:int16)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int32
    int_directive(:int32)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def int64
    int_directive(:int64)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint8
    int_directive(:uint8)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint16
    int_directive(:uint16)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint32
    int_directive(:uint32)
  end
  
  # Returns the required integer directive depending on the platform 
  # endianness.
  # @return [String] Integer directive
  # @see ::Array#pack
  # @see ::String#unpack
  def uint64
    int_directive(:uint64)
  end

  # Returns the required floating-point directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def float
    flt_directive(:float)
  end

  # Returns the required floating-point directive depending on the platform 
  # endianness.
  # @see ::Array#pack
  # @see ::String#unpack
  def double
    flt_directive(:double)
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
      _msg = '%s is not an integer'
      raise(TypeError, sprintf(_msg, _int))
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
      _flt.unpack(_format).first
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
      _msg = '%s is not a floating-point value'
      raise(TypeError, sprintf(_msg, _flt))
    end

    _format = flt_directive(_type)
    write([_flt].pack(_format))
  end

  # Reads a null-terminated string from the file.
  # @param _size     [Integer] Desired number of bytes to read.
  # @param _blocks   [Integer] Block size in bytes
  # @param _encoding [String]  Character encoding
  # @return [String] String from the file, which has been read.
  def read_str(_size, _blocks = nil, _encoding = 'Shift_JIS')
    _str = ''
    
    if _size > 0
      if _blocks && _blocks > 0
        begin
          _blk  = read(_blocks).unpack('Z*').first
          _str << _blk
        end while _blk.size == _blocks && _str.bytesize < _size
      else
        _str << read(_size).unpack('Z*').first
      end
      _str.force_encoding(_encoding)
    end

    _str.encode!('UTF-8')
    if _encoding == 'Windows-1252'
      _str.gsub!('[', '“')
      _str.gsub!(']', '”')
    end
    
    _str
  end

  # Writes a null-terminated string to the file.
  # @param _str      [String]  String which will be written to the stream.
  # @param _size     [Integer] Desired number of bytes to write.
  # @param _blocks   [Integer] Block size in bytes
  # @param _encoding [String]  Character encoding
  def write_str(_str, _size, _blocks = nil, _encoding = 'Shift_JIS')
    if _encoding == 'Windows-1252'
      _str.gsub!('“', '[')
      _str.gsub!('”', ']')
    end
    _str.encode!(_encoding)

    if _size > 0
      if _str.bytesize + 1 > _size
        _msg = 'string size invalid (given %s, expected %s)'
        raise(IOError, sprintf(_msg, _str.bytesize + 1, _size))
      end
      if _blocks && _blocks > 0
        _1st_part = [_str].pack("A#{_size}")
        _2nd_part = [_str].pack("Z#{_size}")
        
        _1st_part.slice!(_size - _blocks, _blocks)
        _2nd_part.slice!(0, _size - _blocks)
        _2nd_part[-1] = "\0"
    
        write(_1st_part)
        write(_2nd_part)
      else
        write([_str].pack("Z#{_size - 1}"))
        write_int(0, :uint8)
      end
    end
  end
  
#------------------------------------------------------------------------------
# Public member variables
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
      _msg = '%s is not a symbol nor a string'
      raise(TypeError, sprintf(_msg, _type))
    end

    _type = _type.to_sym
    case _type
    when :int8
      'c'
    when :int16
      big_endian? ? 's>' : 's<'
    when :int32
      big_endian? ? 'l>' : 'l<'
    when :int64
      big_endian? ? 'q>' : 'q<'
    when :uint8
      'C'
    when :uint16
      big_endian? ? 'S>' : 'S<'
    when :uint32
      big_endian? ? 'L>' : 'L<'
    when :uint64
      big_endian? ? 'Q>' : 'Q<'
    else
      _msg = '%s is not an integer type'
      raise(TypeError, sprintf(_msg, _type))
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
      _msg = '%s is not a symbol nor a string'
      raise(TypeError, sprintf(_msg, _type))
    end

    _type = _type.to_sym
    case _type
    when :float
      big_endian? ? 'g' : 'e'
    when :double
      big_endian? ? 'G' : 'E'
    else
      _msg = '%s is not a floating-point type'
      raise(TypeError, sprintf(_msg, _type))
    end
  end

end # class Serializable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
