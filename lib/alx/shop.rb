#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2020 Marcel Renner
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

# Class to handle a shop.
class Shop < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Shop.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @items = {}

    members.clear
    members << IntVar.new(VOC.id                    ,  0, :uint16)
    members << IntVar.new(padding_hdr               ,  0, :int16 )
    members << PosVar.new(VOC.message_id[country_id],  0, :uint32)

    add_dscr_members
    
    (0...48).each do |_i|
      members << IntVar.new(VOC.item_id[_i]         , -1, :int16 )
      members << StrDmy.new(VOC.item_name[_i]       , ''         )
    end
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    (0...48).each do |_i|
      _id = find_member(VOC.item_id[_i]).value
      if _id != -1
        _entry = @items[_id]
        _name  = '???'
        if _entry
          if jp? || us?
            _name = _entry.find_member(VOC.name_str[country_id]).value
          elsif eu?
            _name = _entry.find_member(VOC.name_str['GB']).value
          end
        end
      else
        _name = 'None'
      end
      find_member(VOC.item_name[_i]).value = _name
    end
    
    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :items

end	# class Shop

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
