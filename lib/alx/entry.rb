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

require('csv.rb')
require_relative('binaryfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle an entry (e.g. items, magic, super moves, etc.).
class Entry

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Size of the binary structure
  STRUCT_SIZE = 17
  
  # Character IDs
  CHARACTERS = Hash.new('???')
  CHARACTERS.store(0, 'Vyse'   )
  CHARACTERS.store(1, 'Aika'   )
  CHARACTERS.store(2, 'Fina'   )
  CHARACTERS.store(3, 'Drachma')
  CHARACTERS.store(4, 'Enrique')
  CHARACTERS.store(5, 'Gilder' )

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    @id                 = -1
    @name               = ''
    @description_addr   = 0
    @description_size   = 0
    @description_string = ''
  end

  # Reads one entry from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    @name = _f.read_data(17, 'Z*')
    begin
      @name.encode!('UTF-8', 'Shift_JIS')
    rescue Encoding::InvalidByteSequenceError
      # Nothing to do.
    end
  end
  
  # Write one entry to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    _name = @name
    begin
      _name.encode!('Shift_JIS', 'UTF-8')
    rescue Encoding::InvalidByteSequenceError
      # Nothing to do.
    end
    
    _f.write_data(_name, 'Z16')
    _f.write_data("\0" , 'Z'  )
  end

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    @id                 = _row['Entry ID'            ] || @id
    @name               = _row['Entry name'          ] || @name
    @description_addr   = _row['(Description offset)'] || @description_addr
    @description_size   = _row['(Description size)'  ] || @description_size
    @description_string = _row['Description string'  ] || @description_string

    @id                 = @id.to_i
    @name               = @name.to_s
    @description_addr   = @description_addr.to_i
    @description_size   = @description_size.to_i
    @description_string = @description_string.to_s.gsub('\n', "\n")
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    _row['Entry ID'            ] = @id
    _row['Entry name'          ] = @name
    _row['(Description offset)'] = @description_addr
    _row['(Description size)'  ] = @description_size
    _row['Description string'  ] = @description_string.gsub("\n", '\n')
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :id
  attr_accessor :name
  attr_accessor :description_addr
  attr_accessor :description_size
  attr_accessor :description_string
  
end	# class Entry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
