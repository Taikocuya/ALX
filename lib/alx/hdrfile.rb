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

  # Opens a HDR file.
  # @param _filename [String] File name of HDR file.
  def initialize(_filename)
    @game_id  = ''
    @region   = ''
    @maker_id = ''
    @name     = ''

    if File.exist?(_filename)
      BinaryFile.open(_filename, 'rb') do |_f|
        @game_id  = _f.read_data(6, 'a*')
        @region   = @game_id[3]
        @maker_id = @game_id[4, 2]
        
        _f.pos    = 0x20
        @name     = _f.read_data(64, 'Z*')
      end
    end
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :game_id
  attr_accessor :region
  attr_accessor :maker_id
  attr_accessor :name
  
end	# class HdrFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
