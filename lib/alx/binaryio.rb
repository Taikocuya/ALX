#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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
module BinaryIO

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Reads an integer from the file.
  # @param _format [String] Format of the integer, which will be read.
  # @return [Integer] Integer from the file, which has been read.
  def read_int(_format)
    _size = [0].pack(_format).size
    read(_size).unpack(_format).first
  end

  # Writes an integer to the file.
  # @param _data [Integer] Integer which will be written to the stream.
  # @param _format [String]  Format of the integer, which will be written.
  def write_int(_int, _format)
    write([_int].pack(_format))
  end

  # Reads a null-terminated string from the file.
  # @param _size   [Integer] Desired number of bytes to read.
  # @param _blocks [Integer] Block size in bytes
  # @param _encoding [String]  Character encoding
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
    end
    
    _str.rstrip!
    _str.encode!('UTF-8', _encoding, :invalid => :replace, :undef => :replace)
    _str.gsub!('[', '“')
    _str.gsub!(']', '”')

    _str
  end

  # Writes a null-terminated string to the file.
  # @param _str      [String]  String which will be written to the stream.
  # @param _size     [Integer] Desired number of bytes to write.
  # @param _blocks   [Integer] Block size in bytes
  # @param _encoding [String]  Character encoding
  def write_str(_str, _size, _blocks = nil, _encoding = 'Shift_JIS')
    _str.rstrip!
    _str.encode!(_encoding, 'UTF-8', :invalid => :replace, :undef => :replace)
    _str.gsub!('“', '[')
    _str.gsub!('”', ']')

    if _size > 0
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
        write_int(0, 'C')
      end
    end
  end

end # class BinaryIO

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
