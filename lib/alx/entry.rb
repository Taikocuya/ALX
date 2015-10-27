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

require('csv')
require_relative('binarystringio.rb')
require_relative('csvhdr.rb')
require_relative('intvar.rb')
require_relative('intdmy.rb')
require_relative('strvar.rb')
require_relative('strdmy.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle a entry.
class Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Character IDs
  CHARACTERS = Hash.new('???')
  CHARACTERS.store(0, CsvHdr::CHARA_VYSE   )
  CHARACTERS.store(1, CsvHdr::CHARA_AIKA   )
  CHARACTERS.store(2, CsvHdr::CHARA_FINA   )
  CHARACTERS.store(3, CsvHdr::CHARA_DRACHMA)
  CHARACTERS.store(4, CsvHdr::CHARA_ENRIQUE)
  CHARACTERS.store(5, CsvHdr::CHARA_GILDER )

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Entry.
  # @param _region [String] Region ID
  def initialize(_region)
    @region     = _region
    @members    = []
    @padding_id = 0
    @unknown_id = 0
  end

  # Returns the size of the entry.
  # @return [Integer] Size of entry
  def size
    _strio = BinaryStringIO.new('', 'wb')
    write_to_bin(_strio)
    _strio.pos
  end

  # Returns the CSV header of the entry.
  # @return [Array] CSV header of entry
  def header
    _header = []
    @members.each do |_m|
      if _m.is_a?(DataMember)
        _header << _m.name
      end
    end
    _header
  end
  
  # Returns the first data member by given name, or +nil+ otherwise.
  # @param _name [String] Name of data member
  # @return [DataMember] Object of data member
  def find_member(_name)
    @members.find do |_m|
      _m.name == _name
    end
  end

  # Reads one entry from a binary IO.
  # @param _name [DataMember] Data member
  def read_from_bin(_f)
    @members.each do |_m|
      _m.read_from_bin(_f)
    end
  end
  
  # Write one entry to a binary IO.
  # @param _f [BinaryIO] Binary IO object
  def write_to_bin(_f)
    @members.each do |_m|
      _m.write_to_bin(_f)
    end
  end

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    @members.each do |_m|
      _m.read_from_csv_row(_row)
    end
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    @members.each do |_m|
      _m.write_to_csv_row(_row)
    end
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader   :region
  attr_accessor :members

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns a CSV header with "Padding" as description and an unique 
  # identifier.
  # @return [String] CSV header
  def padding_hdr
    CsvHdr::PADDING[@padding_id += 1]
  end

  # Returns a CSV header with "Unknown" as description and an unique 
  # identifier.
  # @return [String] CSV header
  def unknown_hdr
    CsvHdr::UNKNOWN[@unknown_id += 1]
  end
  
end	# class Entry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
