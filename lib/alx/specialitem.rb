#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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

require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a special item.
class SpecialItem < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a SpecialItem.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    add_name_members

    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(CsvHdr::ORDER_IMPORTANCE, -1, 'c' )
    members << IntVar.new(CsvHdr::ORDER_ALPHABET  , -1, 'c' )
    
    if region == 'P'
      members << IntVar.new(padding_hdr           ,  0, 'c' )
    end
    
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )

    if region == 'P'
      members << IntVar.new(padding_hdr           ,  0, 'c' )
      members << IntVar.new(padding_hdr           ,  0, 'c' )
    end

    add_dscr_members
  end

end	# class SpecialItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
