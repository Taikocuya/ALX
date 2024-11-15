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
  def initialize
    super
    init_attrs
    init_props
    init_procs
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :items

  def items=(_items)
    @items = _items || {}
    fetch(VOC.item_id(nil))&.call_proc
  end
  
#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @items ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    self[VOC.location] = StrProp.new(nil, '', dmy: true)
      
    if product_id != '6107110 06' && product_id != '6107810'
      self[VOC.item_id(nil)    ] = IntProp.new(:i32, -1           )
      self[VOC.item_name(nil)  ] = StrProp.new( nil, '', dmy: true)
      self[VOC.item_amount(nil)] = IntProp.new(:i32, -1           )
    else
      self[VOC.item_id(nil)    ] = IntProp.new(:i16, -1           )
      self[VOC.item_name(nil)  ] = StrProp.new( nil, '', dmy: true)
      self[VOC.item_amount(nil)] = IntProp.new(:i16, -1           )
    end
  end

  # Initialize the entry procs.
  def init_procs
    fetch(VOC.id).proc = Proc.new do |_id|
      _name = voc(:treasure_chests, id.to_s) || '???'
      self[VOC.location] = _name
    end

    fetch(VOC.item_id(nil)).proc = Proc.new do |_id|
      if _id != -1
        if _id >= 0x200
          _name = VOC.gold
        else
          _entry = @items[_id]
          _name  = '???'
          if _entry
            if jp? || us?
              _name = _entry[VOC.name_str(cid)]
            elsif eu?
              _name = _entry[VOC.name_str('GB')]
            end
          end
        end
      else
        _name = 'None'
      end
      self[VOC.item_name(nil)] = _name
    end
  end

end	# class TreasureChest

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
