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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a special item.
class SpecialItem < Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================
 
  # Size of the binary structure
  STRUCT_SIZE = 22

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super
    @unknown1 = 0
    @unknown2 = -1
    @unknown3 = -1
    @unknown4 = 0
    @unknown5 = 0
  end

  # Reads one special item from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    super
    @unknown1 = _f.read_data(1, 'c')
    @unknown2 = _f.read_data(1, 'c')
    @unknown3 = _f.read_data(1, 'c')
    @unknown4 = _f.read_data(1, 'c')
    @unknown5 = _f.read_data(1, 'c')
  end
  
  # Write one special item to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    super
    _f.write_data(@unknown1, 'c')
    _f.write_data(@unknown2, 'c')
    _f.write_data(@unknown3, 'c')
    _f.write_data(@unknown4, 'c')
    _f.write_data(@unknown5, 'c')
  end

  # Reads one special item from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    @unknown1 = _row['Unknown #1'] || @unknown1
    @unknown2 = _row['Unknown #2'] || @unknown2
    @unknown3 = _row['Unknown #3'] || @unknown3
    @unknown4 = _row['Unknown #4'] || @unknown4
    @unknown5 = _row['Unknown #5'] || @unknown5
    
    @unknown1 = @unknown1.to_i
    @unknown2 = @unknown2.to_i
    @unknown3 = @unknown3.to_i
    @unknown4 = @unknown4.to_i
    @unknown5 = @unknown5.to_i
  end

  # Writes one special item to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _row['Unknown #1'] = @unknown1
    _row['Unknown #2'] = @unknown2
    _row['Unknown #3'] = @unknown3
    _row['Unknown #4'] = @unknown4
    _row['Unknown #5'] = @unknown5
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :unknown1
  attr_accessor :unknown2
  attr_accessor :unknown3
  attr_accessor :unknown4
  attr_accessor :unknown5

end	# class SpecialItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
