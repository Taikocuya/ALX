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
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    add_name_members

    members << IntVar.new(VOC.retail_price              ,  0, 'c' )
    members << IntVar.new(VOC.order_priority            , -1, 'c' )
    members << IntVar.new(VOC.order_alphabet[country_id], -1, 'c' )
    
    if is_eu?
      members << IntVar.new(padding_hdr                 ,  0, 'c' )
    end
    
    members << IntVar.new(VOC.purchase_price            ,  0, 'S>')

    if is_eu?
      members << IntVar.new(padding_hdr                 ,  0, 'c' )
      members << IntVar.new(padding_hdr                 ,  0, 'c' )
    end

    add_dscr_members
  end

end	# class SpecialItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
