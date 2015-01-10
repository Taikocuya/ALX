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

# Class to read and write easier in binary files.
class BinaryFile < File

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Reads data from the file.
  # @param _length [Integer] Desired number of bytes to read.
  # @param _format [String]  Format of the data, which will be read.
  def read_data(_length, _format)
    read(_length).unpack(_format).first
  end

  # Write data to the file.
  # @param _data   [Integer,String] Data which will be written to the stream.
  # @param _format [String]         Format of the data, which will be written.
  def write_data(_data, _format)
    write([_data].pack(_format))
  end

end # class BinaryFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
