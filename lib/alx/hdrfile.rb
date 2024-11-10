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

require_relative('binaryfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a HDR file.
class HdrFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a HdrFile.
  def initialize
    @product_id   = ''
    @product_name = ''
    @region_id    = ''
    @maker_id     = ''
  end

  # Reads a HDR file.
  # @param _filename [String] File name
  def load(_filename)
    BinaryFile.open(_filename, 'rb', big_endian: true) do |_f|
      @product_id   = _f.read_str(length: 0x03)
      @region_id    = _f.read_str(length: 0x01)
      @maker_id     = _f.read_str(length: 0x02)
      
      _f.pos        = 0x20
      @product_name = _f.read_str(length: 0x64).strip
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :product_id
  attr_reader :product_name
  attr_reader :region_id
  attr_reader :maker_id

end	# class HdrFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
