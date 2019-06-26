#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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

require_relative('binaryfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a BNR file.
class BnrFile
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # File signature
  FILE_SIG = 'BNR'.force_encoding('ASCII-8BIT')
  # File version
  FILE_VERS = ['1', '2']
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a BnrFile.
  def initialize
    @product_name = ''
    @maker_name   = ''
    @description  = ''
  end

  # Reads a BNR file.
  # @param _filename [String] File name
  def load(_filename)
    BinaryFile.open(_filename, 'rb', big_endian: true) do |_f|
      _file_sig  = _f.read_str(0x3)
      _file_vers = _f.read_str(0x1)
      if _file_sig != FILE_SIG || !FILE_VERS.include?(_file_vers)
        raise(IOError, 'signature invalid')
      end
      
      _f.pos        = 0x1820
      @product_name = _f.read_str(32)
      @maker_name   = _f.read_str(32)
      _f.pos        = 0x18e0
      @description  = _f.read_str(128)
    end
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :product_name
  attr_reader :maker_name
  attr_reader :description
  
end	# class BnrFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
