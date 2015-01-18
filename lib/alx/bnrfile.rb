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

# Class to handle a BNR file.
class BnrFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Opens a BNR file.
  # @param _filename [String] File name of BNR file.
  def initialize(_filename)
    @game_title      = ''
    @developer       = ''
    @full_game_title = ''
    @full_developer  = ''
    @description     = ''
    
    if File.exist?(_filename)
      BinaryFile.open(_filename, 'rb') do |_f|
        if _f.read_data(4, 'a*') == 'BNR1'
          _f.pos           = 0x1820
          @game_title      = _f.read_data( 32, 'Z*')
          @developer       = _f.read_data( 32, 'Z*')
          @full_game_title = _f.read_data( 64, 'Z*')
          @full_developer  = _f.read_data( 64, 'Z*')
          @description     = _f.read_data(128, 'Z*')
        end
      end
     end
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :game_title
  attr_accessor :developer
  attr_accessor :full_game_title
  attr_accessor :full_developer
  attr_accessor :description
  
end	# class BnrFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
