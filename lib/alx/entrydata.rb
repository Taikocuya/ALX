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

#==============================================================================
#                                   REQUIRES
#==============================================================================

require('fileutils.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle entries from binary and/or CSV files.
class EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  STR_OPEN_READER  = 'Open file "%s" for reading...'
  STR_OPEN_WRITER  = 'Open file "%s" for writing...'
  STR_READ_DATA    = '  Entry data #%d at position %#x has been read.'
  STR_WRITE_DATA   = '  Entry data #%d at position %#x has been written.'
  STR_READ_DSCR    = '  Entry description #%d at position %#x has been read.'
  STR_WRITE_DSCR   = '  Entry description #%d at position %#x has been written.'
  STR_CLOSE_READER = 'File "%s" has been successfully read.'
  STR_CLOSE_WRITER = 'File "%s" has been successfully written.'
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EntryData.
  # 
  # @param _class             [Entry] Class which represents an entry (e.g. 
  #                                   item, magic, super move, etc.).
  # @param _id_range          [Range] ID range of this entry type.
  # @param _data_offset_range [Range] Offset range of the entry data in 
  #                                   binary file.
  # @param _dscr_offset_range [Range] Offset range of the description data in 
  #                                   binary file.
  # @param _dscr_skipped_ids  [Array] Entries without description.
  def initialize(
    _class,
    _id_range,
    _data_offset_range,
    _dscr_offset_range,
    _dscr_skipped_ids
  )
    @class             = _class
    @id_range          = _id_range
    @data_offset_range = _data_offset_range
    @dscr_offset_range = _dscr_offset_range
    @dscr_skipped_ids  = _dscr_skipped_ids
    @data              = {}
  end
  
  # Header of the CSV file.
  # @param _strs [String] Additional headings
  def header(*_strs)
    _header  = []
    _header << 'Entry ID'
    _header << 'Entry name'
    _header += _strs
    _header << '(Description offset)'
    _header << '(Description size)'
    _header << 'Description string'
    _header
  end
  
  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_from_bin(_filename)
    puts(sprintf(STR_OPEN_READER, _filename))
      
    BinaryFile.open(_filename, 'rb') do |_f|
      # Read data
      _id    = @id_range.begin
      _f.pos = @data_offset_range.begin
      while !_f.eof? && _f.pos < @data_offset_range.end && _id < @id_range.end
        _pos  = _f.pos
        _w    = @class.new
        _w.id = _id
        _w.read_from_bin(_f)
        @data[_id] = _w
        
        puts(sprintf(STR_READ_DATA, _id, _pos))
        
        _id += 1
      end

      # Read description
      _id    = @id_range.begin
      _f.pos = @dscr_offset_range.begin
      while !_f.eof? && _f.pos < @dscr_offset_range.end && _id < @id_range.end
        unless @dscr_skipped_ids.include?(_id)
          _pos                = _f.pos
          _w                  = @data[_id]
          _w.description_addr = _f.pos
          
          _block = ''
          _dscr  = ''
          begin
            _block  = _f.read_data(4, 'Z*')
            _dscr  << _block
          end while _block.size == 4
          
          begin
            _dscr.encode!('UTF-8', 'Shift_JIS')
          rescue Encoding::InvalidByteSequenceError
            # Nothing to do.
          end
      
          _w = @data[_id]
          _w.description_size   = _f.pos - _w.description_addr
          _w.description_string = _dscr
  
          puts(sprintf(STR_READ_DSCR, _id, _pos))
        end

        _id += 1
      end
    end
    
    puts(sprintf(STR_CLOSE_READER, _filename))
  end
  
  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_to_bin(_filename)
    puts(sprintf(STR_OPEN_WRITER, _filename))
    
    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b') do |_f|
      # Write data
      @data.each do |_id, _w|
        if _id >= @id_range.begin && _id < @id_range.end
          _pos  = @data_offset_range.begin
          _size = @class::STRUCT_SIZE
          _pos += (_id - @id_range.begin) * _size
  
          if _pos         >= @data_offset_range.begin && 
             _pos + _size <= @data_offset_range.end
            _f.pos = _pos
            _w.write_to_bin(_f)
            
            puts(sprintf(STR_WRITE_DATA, _id, _pos))
          end
        end
      end
      
      # Write description
      @data.each do |_id, _w|
        if _id >= @id_range.begin && _id < @id_range.end
          _pos  = _w.description_addr
          _size = _w.description_size
          _dscr = _w.description_string
          begin
            _dscr.encode!('Shift_JIS', 'UTF-8')
          rescue Encoding::InvalidByteSequenceError
            # Nothing to do.
          end
          
          if _pos         >= @dscr_offset_range.begin && 
             _pos + _size <= @dscr_offset_range.end
            _f.pos = _pos
            
            _1st_part = [_dscr].pack("A#{_size}")
            _2nd_part = [_dscr].pack("Z#{_size}")
            
            _1st_part.slice!(_size - 4, 4)
            _2nd_part.slice!(0, _size - 4)
            _2nd_part[-1] = "\0"
  
            _f.write(_1st_part)
            _f.write(_2nd_part)
            
            puts(sprintf(STR_WRITE_DSCR, _id, _pos))
          end
        end
      end
    end
    
    puts(sprintf(STR_CLOSE_WRITER, _filename))
  end
  
  # Reads all entries from a CSV file.
  # @param _filename [String] File name
  def load_from_csv(_filename)
    puts(sprintf(STR_OPEN_READER, _filename))

    CSV.open(_filename, col_sep: ';', headers: true) do |_f|
      _f.each do |_row|
        _w  = @class.new
        _w.read_from_csv_row(_row)
        _id = _w.id

        if _id != -1
          @data[_id] = _w
          puts(sprintf(STR_READ_DATA, _id, _id))
        end
      end
    end
    
    puts(sprintf(STR_CLOSE_READER, _filename))
  end
  
  # Writes all entries to a CSV file.
  # @param _filename [String] File name
  def save_to_csv(_filename)
    puts(sprintf(STR_OPEN_WRITER, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', col_sep: ';', headers: true) do |_f|
      # Headline
      _header = header
      _f << _header
      # Data
      @data.each do |_id, _w|
        _row = CSV::Row.new(_header, [])
        _w.write_to_csv_row(_row)
        _f << _row
        
        puts(sprintf(STR_WRITE_DATA, _id, _id))
      end
    end
    
    puts(sprintf(STR_CLOSE_WRITER, _filename))
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :data
  
end # class EntryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
