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

# Class to handle a treasure chest.
class TreasureChest < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a TreasureChest.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @items = {}

    if product_id != '6107110 06' && product_id != '6107810'
      members << IntVar.new(VOC.item_id[-1]    , -1, :int32)
      members << StrDmy.new(VOC.item_name[-1]  , ''        )
      members << IntVar.new(VOC.item_amount[-1], -1, :int32)
    else
      members << IntVar.new(VOC.item_id[-1]    , -1, :int16)
      members << StrDmy.new(VOC.item_name[-1]  , ''        )
      members << IntVar.new(VOC.item_amount[-1], -1, :int16)
    end
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(VOC.item_id[-1]).value
    if _id != -1
      if _id >= 510
        _name = VOC.gold
      else
        _entry = @items[_id]
        _name  = '???'
        if _entry
          if jp? || us?
            _name = _entry.find_member(VOC.name_str[country_id]).value
          elsif eu?
            _name = _entry.find_member(VOC.name_str['GB']).value
          end
        end
      end
    else
      _name = 'None'
    end
    find_member(VOC.item_name[-1]).value = _name

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :items

end	# class TreasureChest

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
