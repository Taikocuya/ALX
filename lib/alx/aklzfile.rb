#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require('ostruct')
require_relative('binaryfile.rb')
require_relative('binarystringio.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to compress and decompress files with AKLZ. The file format is
# big-endian throughout. 
# @see https://github.com/nickworonekin/puyotools
class AklzFile < BinaryStringIO

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # File signature
  FILE_SIG    = "AKLZ\x7e\x3f\x51\x64\x3d\xcc\xcc\xcd".force_encoding(
    'ASCII-8BIT'
  )
  # Begin of match amount (do not edit)
  MATCH_BEG   = 0x3
  # Size of match amount (do not edit)
  MATCH_SIZE  = 0xf
  # End of match amount (do not edit)
  MATCH_END   = MATCH_BEG + MATCH_SIZE
  # Size of buffer (do not edit)
  BUFFER_SIZE = 0x1000
  # Begin of buffer pointer (do not edit)
  BUFFER_BEG  = BUFFER_SIZE - MATCH_END
  # Size of dictionary (do not edit)
  DICT_SIZE   = 0x100
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # @see BinaryStringIO::new
  def initialize(_filename, *_args, **_opts)
    super('', *_args, **_opts)
    @filename      = _filename
    @buffio        = BinaryStringIO.open('', 'r+b', **_opts)
    @buffio.string = self.string

    unless closed_read?
      decompress
      unless closed_write?
        raise(IOError, 'duplex IO stream not supported')
      end
    end
  end

  # @see BinaryStringIO::open
  def self.open(...)
    _aklzfile = new(...)
  
    if block_given?
      begin
        yield(_aklzfile)
      ensure
        _aklzfile.close
      end
    else
      _aklzfile
    end
  end
  
  # @see BinaryStringIO#close
  def close
    close_write unless closed_write?
    close_read  unless closed_read?
  end
  
  # @see BinaryStringIO#close_write
  def close_write
    unless self.closed_write?
      compress
    end
    super
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  # @see BinaryStringIO#string=
  def string=(_string)
    super(_string)
    @buffio.string = self.string
  end
  
#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Initializes the buffer.
  # @param _beg [Integer] Default value of buffer pointer.
  def init_buffer(_beg = 0)
    @buffer     = Array.new(BUFFER_SIZE) { 0 }
    @buffer_ptr = _beg
  end
  
  # Clears the buffer.
  def clear_buffer
    @buffer     = nil
    @buffer_ptr = nil
  end
  
  # Initializes the dictionary.
  def init_dictionary
    @dictionary = Array.new(DICT_SIZE) { [] }
  end
  
  # Clears the dictionary.
  def clear_dictionary
    @dictionary = nil
  end

  # Compresses the file.
  def compress
    init_dictionary
    init_buffer

    BinaryFile.open(@filename, 'wb', endianness: endianness) do |_dst|
      # Initialization
      _file_size = @buffio.size
      
      # Header
      _dst.write(FILE_SIG)
      _dst.write_int(_file_size, :u32)

      # Compression
      while !@buffio.eof?
        _flag  = 0x0
        _bytes = []
      
        (0...8).each do |_i|
          _match      = find_in_dictionary
          _match_pos  = _match.pos
          _match_size = _match.size

          add_in_dictionary(@buffio.pos, _match_size)
          
          if _match_size > 0
            _b1  = _match_pos & 0xff
            _b2  = (_match_pos & 0xf00) >> 4
            _b2 |= (_match_size - MATCH_BEG) & MATCH_SIZE
            
            _bytes << _b1
            _bytes << _b2
            
            @buffio.pos += _match_size
          else
            _flag  |= 0x1 << _i
            _bytes << @buffio.read_int(:u8)
          end
          
          if @buffio.eof?
            break
          end
        end
        
        _dst.write_int(_flag, :u8)
        _dst.write(_bytes.pack('C*'))
      end
    end

    clear_buffer
    clear_dictionary
  end

  # Decompresses the file.
  def decompress
    init_buffer(BUFFER_BEG)

    BinaryFile.open(@filename, 'rb', endianness: endianness) do |_src|
      # Header
      _file_sig  = _src.read(0xc)
      _file_size = _src.read_int(:u32)
      if _file_sig != FILE_SIG
        raise(IOError, 'signature invalid')
      end
      
      # Decompression
      while !_src.eof?
        _flag = _src.read_int(:u8)
        (0...8).each do |_i|
          # Compressed
          if _flag & 0x1 == 0
            _b1 = _src.read_int(:u8) || 0
            _b2 = _src.read_int(:u8) || 0

            _match_pos  = _b1 | (_b2 & ~MATCH_SIZE) << 4
            _match_size = (_b2 & MATCH_SIZE) + MATCH_BEG
            _match_size = [_match_size, _file_size - @buffio.size].min
            
            (0..._match_size).each do |_i|
              _byte = @buffer[(_match_pos + _i) & (BUFFER_SIZE - 1)]
              @buffio.write_int(_byte, :u8)

              @buffer[@buffer_ptr] = _byte
              @buffer_ptr          = (@buffer_ptr + 1) & (BUFFER_SIZE - 1)
            end
          # Not compressed
          else
            _byte = _src.read_int(:u8) || 0
            @buffio.write_int(_byte, :u8)
            
            @buffer[@buffer_ptr] = _byte
            @buffer_ptr          = (@buffer_ptr + 1) & (BUFFER_SIZE - 1)
          end
          
          if _src.eof?
            break
          end
          
          _flag >>= 1;
        end
      end

      if @buffio.size != _file_size
        _msg = 'file size invalid (given %#x, expected %#x)'
        raise(IOError, sprintf(_msg, @buffio.size, _file_size))
      end
    end

    clear_buffer
  end

  # Adds an entry to the dictionary.
  # @param _match_pos  [Integer] Match position
  # @param _match_size [Integer] Match size
  def add_in_dictionary(_match_pos, _match_size = 1)
    if _match_size > 1
      (_match_pos...(_match_pos + _match_size)).each do |_i|
        add_in_dictionary(_i)
      end
    else
      _byte = read_byte_at_pos(_match_pos)
      @buffer[(BUFFER_BEG + @buffer_ptr) & (BUFFER_SIZE - 1)] = _byte
      @dictionary[_byte] << @buffer_ptr
      @buffer_ptr += 1
    end
  end

  # Returns the first match, or +OpenStruct.new(pos: 0x0, size: 0x0)+ 
  # otherwise.
  # @return [OpenStruct] OpenStruct object
  def find_in_dictionary
    compact_dictionary
    _pos   = @buffio.pos
    _size  = @buffio.size
    _match = OpenStruct.new(pos: 0x0, size: 0x0)
    
    # Cannot find matches if there isn't enough data left.
    if _pos < MATCH_BEG || _size - _pos < MATCH_BEG
      return _match
    end
    
    # Initialization
    _dict = @dictionary[read_byte_at_pos(@buffio.pos)]

    _dict.reverse_each do |_d|
      _match_beg  = _d
      _match_size = 1
      _buffer_pos = (BUFFER_BEG + _match_beg) & (BUFFER_SIZE - 1)

      while _match_size              < MATCH_END   && 
            _match_size              < BUFFER_SIZE && 
            _match_beg + _match_size < _pos        && 
            _pos + _match_size       < _size       && 
            read_byte_at_pos(_pos + _match_size) == @buffer[
              (_buffer_pos + _match_size) & (BUFFER_SIZE - 1)
            ]
        _match_size += 1
      end

      if _match_size >= MATCH_BEG && _match_size > _match.size
        _match.pos  = _buffer_pos
        _match.size = _match_size
          
        if _match_size == MATCH_END
          break
        end
      end
    end

    _match
  end
  
  # Removes all unnecessary entries from the dictionary.
  def compact_dictionary
    _dict = @dictionary[read_byte_at_pos(@buffio.pos)]
    while !_dict.empty?
      if _dict.first >= @buffer_ptr - BUFFER_SIZE
        break
      end
      _dict.shift
    end
  end

  # Reads a byte from the buffer I/O position. After reading the I/O position 
  # will be reset to the last offset.
  # @param _pos [Integer] I/O position
  # @return [Integer] Unsigned integer from the file, which has been read.
  def read_byte_at_pos(_pos)
    _last = @buffio.pos
    @buffio.pos = _pos
    
    _byte = @buffio.read_int(:u8)
    @buffio.pos = _last
    
    _byte
  end

end # class AklzFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
