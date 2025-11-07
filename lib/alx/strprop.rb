#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

require_relative('prop.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a string property.
class StrProp < Prop
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a StrProp. If a block is specified, it will be called in 
  # #value=, #string= and #str= when the value has been changed.
  # 
  # @param _size  [Integer] Size
  # @param _value [Integer] Value
  # @param blk    [Integer] Block size in bytes
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ to +false+ and +ext+ to +true+
  # @param enc    [Boolean] Character encoding
  # @param esc    [Boolean] Escape \, \r, \x00-\x08, \x0b-\x1f, \x7f
  # @param ext    [Boolean] Serialize externally
  # @param form   [Hash]    Additional string substitutions for each method
  # @param uesc   [Boolean] Unescape \\r\\n and \\n
  def initialize(
    _size             ,
    _value            ,
    blk:   nil        ,
    comp:  true       ,
    dmy:   false      ,
    enc:   'Shift_JIS',
    esc:   true       ,
    ext:   false      ,
    form:  {}         ,
    uesc:  false
  )
    super(_value.to_s, comp: comp, dmy: dmy, ext: ext)
    @size      = _size
    @blocks    = blk
    @encoding  = enc
    @escape    = esc
    @format    = form
    @unescape  = uesc
  end

  # Returns +true+ if property has a fixed size, otherwise +false+.
  # @return [Boolean] +true+ if property has a fixed size, otherwise +false+.
  def fixed?
    !!@size
  end
  
  # @see ::String#to_s
  def to_s
    self.value.to_s
  end
  
  # @see ::String#to_str
  def to_str
    self.value.to_str
  end
  
  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    if external?
      return 
    end

    _value = _f.read_str(length: @size, blocks: @blocks, enc: @encoding)

    if @unescape
      _value.gsub!('\r\n'.b, "\n".b)
      _value.gsub!('\n'.b  , "\n".b)
    end

    format(__method__, _value)
    
    self.value = _value
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    if external?
      return 
    end

    _value = value.dup

    if @unescape
      _value.gsub!("\r\n".b, '\n'.b)
      _value.gsub!("\n".b  , '\n'.b)
    end

    format(__method__, _value)
    
    _f.write_str(_value, length: @size, blocks: @blocks, enc: @encoding)
  end

  # Reads one entry from a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def read_csv(_header, _row)
    _value = _row[_header] || value.dup
    _value.force_encoding('UTF-8')

    if @escape
      _value.gsub!(/[\u2400-\u241f\u2421]/) do
        _byte = Regexp.last_match(0).ord & 0xff
        if _byte == 0x21
          _byte = 0x7f
        end
        _byte.chr
      end
      _value.gsub!("\r\n", "\n")
    end

    format(__method__, _value)

    self.value = _value
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(_header, _row)
    _value = value.dup
    _value.force_encoding('UTF-8')
    
    if @escape
      _value.gsub!(/[\x00-\x08\x0b-\x1f\x7f]/) do
        _byte = Regexp.last_match(0).ord
        if _byte == 0x7f
          _byte = 0x21
        end
        (0x2400 + _byte).chr(Encoding::UTF_8)
      end
    end

    format(__method__, _value)

    _row[_header] = _value
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash             = super
    _hash[:@size    ] = @size
    _hash[:@blocks  ] = @blocks
    _hash[:@encoding] = @encoding
    _hash[:@escape  ] = @escape
    _hash[:@format  ] = @format
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_writer   :size
  attr_accessor :blocks
  attr_accessor :encoding
  attr_accessor :escape
  attr_accessor :format
  attr_accessor :unescape
  
  def size
    if @size
      @size
    else
      self.value.size
    end
  end
  
  def bytesize
    self.value.bytesize
  end
  
  def value=(_value)
    super(_value.to_s)
  end
  
  alias str     value
  alias string  value
  alias str=    value=
  alias string= value=

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Formats the string according to the regular expressions.
  # @param _sym [Symbol] Method symbol
  # @param _str [String] String value
  def format(_sym, _str)
    _format = @format[_sym]
    unless _format
      return
    end
    unless _format.is_a?(Array)
      raise(TypeError, sprintf('%s is not an array', _format.inspect))
    end

    _format.each do |_sub|
      unless _sub.is_a?(Substitution)
        raise(TypeError, sprintf('%s is not a substitution', _sub.inspect))
      end

      _result = _str.gsub!(_sub.pattern, _sub.replacement)
      unless !!_result
        next
      end
      if _sub.stop
        break
      end
    end
  end
  
end # class StrProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
