#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2023 Marcel Renner
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
require_relative('binarystringio.rb')
require_relative('cachefile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and detect a string in binary file.
class DefinedStringDetector

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Translation of string characters by swapping +TRANSL[0]+ to +TRANSL[1]+.
  TRANSL = Serializable::TRANSL

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a StringDetector.
  def initialize
    @range          = ALX.rng(0x0..0xffffffff)
    @char_table     = SYS.defined_string_char_table
    @char_encodings = SYS.defined_string_char_encodings
    @filters        = SYS.defined_string_filters
    @ignore_filter  = SYS.defined_string_ignore_filter
    @invert_filter  = SYS.defined_string_invert_filter
    @diff_support   = SYS.defined_string_diff_support
    @beg_alignment  = SYS.defined_string_beg_alignment
    @end_alignment  = SYS.defined_string_end_alignment
    @min_byte_size  = SYS.defined_string_min_byte_size
    @min_char_size  = SYS.defined_string_min_char_size
    @translate      = false
    @cache          = CacheFile.new(self.class.name.split('::').last.downcase)
    @dictionary     = nil
    @enum           = nil
  end

  # Clears all attributes to their default values.
  def clear
    @valid        = false
    @pos          = 0
    @real_pos     = 0
    @shifted      = 0
    @bytes        = ''
    @real_bytes   = ''
    @substitution = ''
    @string       = ''
    @encoding     = ''
  end

  # Returns +true+ if the string is valid, otherwise +false+.
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def valid?
    @valid
  end

  # Returns +true+ if the string is shifted, otherwise +false+.
  # @return [Boolean] +true+ if string is shifted, otherwise +false+.
  def shifted?
    @shifted != 0
  end

  # Detects the next null-terminated string from a binary I/O stream. If a 
  # string cache has been sucessfully loaded, the next available entry of this 
  # cache is restored.
  # 
  # @param _f [IO] Binary I/O stream
  # 
  # @return [Boolean] +true+ if string is valid, otherwise +false+. The 
  #                   +SYS.defined_string_keep_everything+ is considered.
  def detect(_f)
    clear
    
    @valid   = false
    @valid ||= next_from_cache(_f)
    @valid ||= next_from_file(_f) && verify && store_in_cache
    unless @valid
      return false
    end
    
    @valid &&= apply_filter
    @valid   = invert_results
    @valid &&= encode
    @valid ||= keep_all_results
    @valid
  end

  # Initializes and reads the dictionary if available. If you use the 
  # dictionary for defined strings, all valid strings are cached even before 
  # the filter #apply_filter is applied. This dictionary will be used later to 
  # skip the entire string detection in future runs. This can be useful, for 
  # example, to quickly check the effects of filter changes without scanning 
  # the whole file again.
  # 
  # @param _descriptor [RangeDescriptor,String] Range descriptor or file name
  def load_dictionary(_descriptor)
    @cache.clear
    @cache.add_dummy(@range        )
    @cache.add_dummy(@char_table   )
    @cache.add_dummy(@beg_alignment)
    @cache.add_dummy(@end_alignment)
    @cache.add_dummy(@min_byte_size)
    @cache.add_dummy(create_dictionary_entry)
    @cache.add_descriptor(:bin, _descriptor)
    @cache.add_storage(:dictionary, @dictionary)
    @cache.load
    
    if @cache.valid?
      @dictionary = @cache.dictionary
      @enum       = @dictionary.each
    else
      @dictionary = []
      @enum       = nil
    end
  end

  # Writes the dictionary if available. If you use the dictionary for defined 
  # strings, all valid strings are cached even before the filter #apply_filter 
  # is applied. This dictionary will be used later to skip the entire string 
  # detection in future runs. This can be useful, for example, to quickly 
  # check the effects of filter changes without scanning the whole file again.
  def save_dictionary
    unless @dictionary
      return
    end
    @cache.add_storage(:dictionary, @dictionary)
    @cache.save
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :range
  attr_accessor :char_table
  attr_accessor :char_encodings
  attr_accessor :filters
  attr_accessor :ignore_filter
  attr_accessor :invert_filter
  attr_accessor :diff_support
  attr_accessor :beg_alignment
  attr_accessor :end_alignment
  attr_accessor :min_byte_size
  attr_accessor :min_char_size
  attr_accessor :translate
  attr_accessor :pos
  attr_accessor :shifted
  attr_accessor :bytes
  attr_accessor :substitution
  attr_accessor :string
  attr_accessor :encoding
  
  def size
    @bytes.size
  end
  
  def dump
    @bytes.dump
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Clears the byte and string data.
  def clear_bytes
    @bytes.clear
    @string.clear
  end

  # Returns +true+ if the first character is a valid single-byte or if the 
  # first and second single-byte characters are valid double-bytes, otherwise 
  # +false+.
  # 
  # @param _char1 [String] 1st single-byte character
  # @param _char2 [String] 2nd single-byte character
  # 
  # @return [Boolean] +true+ if first character is a valid single-byte or if 
  #                   first and second single-byte characters are valid 
  #                   double-bytes, otherwise +false+.
  def char_valid?(_char1, _char2 = nil)
    if !_char1.is_a?(String)
      return false
    end

    if !_char2.is_a?(String)
      @char_table.include?(_char1.ord)
    else
      @char_table.include?((_char1.ord << 8) + _char2.ord)
    end
  end
  
  # Shifts, trims and aligns the begin of the string.
  # @param _pos [Integer] String position
  def shift_beg(_pos)
    if _pos <= 0
      return
    end
  
    _pos      = (_pos - 1) / @beg_alignment * @beg_alignment + @beg_alignment
    @pos     += _pos
    @shifted += _pos
    @bytes    = @bytes[[_pos, @bytes.size].min..-1]
  end

  # Retrieves the next available null-terminated string from the cache if 
  # available.
  # 
  # @param _f [IO] Binary I/O stream
  # 
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def next_from_cache(_f)
    if !@enum || (@dictionary && @dictionary.empty?)
      return false
    end

    begin
      _result = true
      _entry  = @enum.next
      
      @pos   = _entry.pos
      @bytes = _entry.bytes
      store_in_cache

      _f.pos = @pos
    rescue StopIteration
      _result = false
      _f.seek(0, IO::SEEK_END)
    end

    _result
  end

  # Searches the next available null-terminated string from a binary I/O 
  # stream.
  # 
  # @param _f [IO] Binary I/O stream
  # 
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def next_from_file(_f)
    _result = false
    while !_result && !_f.eof? && @range.include?(_f.pos)
      if _f.pos % @beg_alignment != 0
        @shifted = @beg_alignment - _f.pos % @beg_alignment
        _f.pos   = _f.pos + @shifted
      end
    
      @pos   = _f.pos
      @bytes = _f.readline("\x00")
      if !_f.eof? && _f.pos % @end_alignment != 0
        @bytes << _f.read(@end_alignment - _f.pos % @end_alignment)
      end
      
      _result   = _f.pos % @end_alignment == 0
      _result &&= !!@bytes.slice!(/\x00+\z/n)
      _result &&= @bytes.size >= @min_byte_size
    end

    _result &&= @range.include?(_f.pos - 1)
  end

  # Verifies the string.
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def verify
    _beg  = 0
    _skip = false
    _size = @bytes.size

    @bytes.chars.each_cons(2).with_index do |_chars, _id|
      _char1 = _chars[0]
      _char2 = _chars[1]

      if _skip
        _skip = false
        if _id + 1 == _size - 1 && !char_valid?(_char2)
          _beg = _size
        end
        
        next
      end

      if char_valid?(_char1, _char2)
        _skip = true
      elsif _id + 1 == _size - 1 && !char_valid?(_char2)
        _beg = _size
      elsif !char_valid?(_char1)
        _beg = _id + 1
      end
    end
    if _size == 1 && !char_valid?(@bytes.chr)
      _beg = _size
    end
    shift_beg(_beg)

    @bytes.size >= @min_byte_size
  end

  # Creates a dictionary entry.
  # @param _pos   [Integer] I/O position
  # @param _bytes [String]  Binary string
  # @return [OpenStruct] OpenStruct object
  def create_dictionary_entry(_pos = 0, _bytes = 0)
    OpenStruct.new(pos: @real_pos, bytes: @real_bytes) 
  end

  # Stores the string in the cache (if available).
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def store_in_cache
    @real_pos   = @pos
    @real_bytes = @bytes.dup

    if @dictionary && !@enum
      @dictionary << create_dictionary_entry(@real_pos, @real_bytes)
    end

    true
  end

  # Applies the filters to the string according to the regular expressions.
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def apply_filter
    if @ignore_filter
      return true
    end

    _bytes = @bytes.dup
    @filters.each do |_sub|
      _str      = nil
      _platform = _sub.platform
      _country  = _sub.country
      
      if !_platform.empty? && _platform != Root.platform_id
        next
      end
      if !_country.empty?  && _country  != Root.country_id 
        next
      end

      if _sub.partial?
        _str = _bytes.gsub!(_sub.pattern, _sub.replacement)
      elsif _sub.pattern.match?(_bytes)
        _str = ''
      end
      unless _str
        next
      end

      if _sub.verify
        if @bytes.end_with?(_str)
          _beg = @bytes.size - _str.size
          if _beg > 0
            shift_beg(_beg)
            verify
          end
          @substitution = _sub.source
          
          if _sub.stop
            break
          end
        else
          _msg = sprintf(
            'gsub replacement invalid - %s (given %s, expected %s)',
            _sub.pattern.inspect, _str.dump, @bytes.dump
          )
          raise(RegexpError, _msg)
        end
      else
        @bytes.gsub!(_sub.pattern, _sub.replacement)
      end
    end

    @bytes.size >= @min_byte_size
  end

  # Restores the unfiltered position and byte data.
  def restore_from_cache
    @pos   = @real_pos
    @bytes = @real_bytes.dup
  end

  # Inverts the results if required. If you enable the filter inversion in 
  # #invert_filter, only the rejected strings will be collected.
  # 
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def invert_results
    if @invert_filter
      @valid = !@valid
      if @valid
        restore_from_cache
      end
    end
    
    @valid
  end

  # Encodes the string.
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def encode
    _encoding = @char_encodings.find do |_, _sub|
      _sub.pattern.match?(@bytes)
    end
    _encoding = _encoding&.first

    if _encoding
      begin
        @string = String.new(@bytes)
        @string.force_encoding(_encoding)
        @string.encode!('UTF-8')
      rescue Encoding::InvalidByteSequenceError => _e
        _error = _e.error_bytes.force_encoding('ASCII-8BIT')
        _beg   = @bytes.index(_error) + _error.size
        shift_beg(_beg)
        verify
        retry
      rescue Encoding::UndefinedConversionError => _e
        _error = _e.error_char.force_encoding('ASCII-8BIT')
        _beg   = @bytes.index(_error) + _error.size
        shift_beg(_beg)
        verify
        retry
      end
      if @translate
        @string.tr!(TRANSL[0], TRANSL[1])
      end
    else
      _encoding = 'ASCII-8BIT'
      @string   = @bytes.dump.gsub!(/(?>\A"|"\z)/, '')
    end
    
    _result   = true
    _result &&= @bytes.size  >= @min_byte_size
    _result &&= @string.size >= @min_char_size
    
    if _result
      @encoding = _encoding
    end

    _result
  end

  # Keeps all results if required. If you enable the diff utility support in 
  # #diff_support, even empty and rejected strings will also be collected. 
  # This can be useful, for example, to compare the impact of filter changes 
  # with a diff utility.
  # 
  # @return [Boolean] +true+ if string is valid, otherwise +false+.
  def keep_all_results
    if @diff_support && !@valid
      @valid = true
      restore_from_cache
      clear_bytes
    end
    
    @valid
  end
  
end # class DefinedStringDetector

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
