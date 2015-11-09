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
#                                 REQUIREMENTS
#==============================================================================

require_relative('characterskill.rb')
require_relative('entrytransform.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle character skills from binary and/or CSV files.
class CharacterSkillData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x3e

  # Offset ranges of data entries
  BIN_FILES_DATA = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2c1bf0...0x2c2790),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2c10e8...0x2c1c88),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f22b0...0x2f2b68),
  }

  # Offset ranges of name entries
  BIN_FILES_NAMES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_FILE_DE, 0x1cc3a...0x1ce93),
      DataRange.new(EntryTransform::SOT_FILE_ES, 0x1c88d...0x1cb04),
      DataRange.new(EntryTransform::SOT_FILE_FR, 0x1cafd...0x1cd83),
      DataRange.new(EntryTransform::SOT_FILE_GB, 0x1c2f4...0x1c555),
    ],
  }

  # Offset ranges of description entries
  BIN_FILES_DSCR = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2c6668...0x2c7d9c),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2c5b60...0x2c72c0),
    'P' => [
      DataRange.new(EntryTransform::SOT_FILE_DE, 0x11025...0x126e4),
      DataRange.new(EntryTransform::SOT_FILE_ES, 0x10d2f...0x12410),
      DataRange.new(EntryTransform::SOT_FILE_FR, 0x1093f...0x1244e),
      DataRange.new(EntryTransform::SOT_FILE_GB, 0x1093f...0x12056),
    ],
  }

  # Offset ranges of ship description entries
  BIN_FILES_DSCR_SHIP = {
    'E' => DataRange.new(
      EntryTransform::DOL_FILE, 0x2d05c4...0x2d0ef4,
      [0x8, 0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'J' => DataRange.new(
      EntryTransform::DOL_FILE, 0x2d058c...0x2d0dcc,
      [0xa, 0xb, 0xc, (0xe..0x13).to_a].flatten!
    ),
    'P' => [
      DataRange.new(EntryTransform::SOT_FILE_DE, 0x1b603...0x1c085),
      DataRange.new(EntryTransform::SOT_FILE_ES, 0x1b23a...0x1bc6f),
      DataRange.new(EntryTransform::SOT_FILE_FR, 0x1b3e9...0x1be6e),
      DataRange.new(EntryTransform::SOT_FILE_GB, 0x1ad4b...0x1b766),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'characterskills.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterSkillData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(CharacterSkill, _root)
    self.id_range        = ID_RANGE
    self.bin_files_data  = BIN_FILES_DATA
    self.bin_files_names = BIN_FILES_NAMES
    self.bin_files_dscr  = BIN_FILES_DSCR
    self.csv_file        = CSV_FILE
    @bin_files_dscr_ship = BIN_FILES_DSCR_SHIP
  end

  # Reads all ship description entries from a binary file.
  # @param _filename [String] File name
  def load_ship_dscr_from_bin(_filename)
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_READ, STR_OPEN_DSCR))

    BinaryFile.open(_filename, 'rb') do |_f|
      _range = determine_range(@bin_files_dscr_ship[region], _filename)
      _f.pos = _range.begin
      
      @id_range.each do |_id|
        if _f.eof? || _f.pos < _range.begin || _f.pos >= _range.end
          break 
        end
        if _range.exclusion.include?(_id)
          next
        end

        _entry = @data[_id]
    
        case region
        when 'E'
          _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_US_POS )
          _size = _entry.find_member(CsvHdr::SHIP_DSCR_US_SIZE)
          _str  = _entry.find_member(CsvHdr::SHIP_DSCR_US_STR )
        when 'J'
          _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_JP_POS )
          _size = _entry.find_member(CsvHdr::SHIP_DSCR_JP_SIZE)
          _str  = _entry.find_member(CsvHdr::SHIP_DSCR_JP_STR )
        when 'P'
          case determine_lang(_filename)
          when 'DE'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_DE_POS )
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_DE_SIZE)
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_DE_STR )
          when 'ES'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_ES_POS )
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_ES_SIZE)
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_ES_STR )
          when 'FR'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_FR_POS )
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_FR_SIZE)
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_FR_STR )
          when 'GB'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_GB_POS )
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_GB_SIZE)
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_GB_STR )
          end
        end
        
        puts(sprintf(STR_READ, _id, _f.pos))
        _pos.value  = _f.pos
        if region != 'P'
          _str.value  = _f.read_str(0xff, 0x4)
        else
          _str.value  = _f.read_str(0xff, 0x1, 'ISO8859-1')
        end
        _size.value = _f.pos - _pos.value
      end
    end

    puts(sprintf(STR_CLOSE, _filename))
  end

  # Reads all entries from binary files.
  def load_all_from_bin
    super
  
    _ranges = @bin_files_dscr_ship[region]
    if _ranges
      unless _ranges.is_a?(Array)
        _ranges = [_ranges]
      end
      _ranges.each do |_range|
        load_ship_dscr_from_bin(File.join(root.path, _range.name))
      end
    end
  end

  # Writes all ship description entries to a binary file.
  # @param _filename [String] File name
  def save_ship_dscr_to_bin(_filename)
    if @data.empty?
      return
    end
    
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_WRITE, STR_OPEN_DSCR))
  
    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b') do |_f|
      _range = determine_range(@bin_files_dscr_ship[region], _filename) 
  
      @data.each do |_id, _entry|
        if _id < @id_range.begin && _id >= @id_range.end
          next
        end
        if _range.exclusion.include?(_id)
          next
        end
  
        case region
        when 'E'
          _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_US_POS ).value
          _size = _entry.find_member(CsvHdr::SHIP_DSCR_US_SIZE).value
          _str  = _entry.find_member(CsvHdr::SHIP_DSCR_US_STR ).value
        when 'J'
          _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_JP_POS ).value
          _size = _entry.find_member(CsvHdr::SHIP_DSCR_JP_SIZE).value
          _str  = _entry.find_member(CsvHdr::SHIP_DSCR_JP_STR ).value
        when 'P'
          case determine_lang(_filename)
          when 'DE'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_DE_POS ).value
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_DE_SIZE).value
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_DE_STR ).value
          when 'ES'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_ES_POS ).value
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_ES_SIZE).value
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_ES_STR ).value
          when 'FR'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_FR_POS ).value
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_FR_SIZE).value
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_FR_STR ).value
          when 'GB'
            _pos  = _entry.find_member(CsvHdr::SHIP_DSCR_GB_POS ).value
            _size = _entry.find_member(CsvHdr::SHIP_DSCR_GB_SIZE).value
            _str  = _entry.find_member(CsvHdr::SHIP_DSCR_GB_STR ).value
          else
            _pos  = 0
            _size = 0
          end
        end
        
        if _pos <= 0 || _size <= 0
          next
        end
        
        _f.pos = _pos
  
        if _f.eof? || _f.pos < _range.begin || _f.pos + _size > _range.end
          next
        end
        
        puts(sprintf(STR_WRITE, _id, _pos))
        if region != 'P'
          _f.write_str(_str, _size, 0x4)
        else
          _f.write_str(_str, _size, 0x1, 'ISO8859-1')
        end
      end
    end
  
    puts(sprintf(STR_CLOSE, _filename))
  end
    
  # Writes all entries to binary files.
  def save_all_to_bin
    super
  
    _ranges = @bin_files_dscr_ship[region]
    if _ranges
      unless _ranges.is_a?(Array)
        _ranges = [_ranges]
      end
      _ranges.each do |_range|
        save_ship_dscr_to_bin(File.join(root.path, _range.name))
      end
    end
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :bin_files_dscr_ship

end # class CharacterSkillData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
