#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

# Class to handle a shop.
class Shop < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Shop.
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
    self[VOC.id             ] = IntProp.new(:u16, 0          )
    self[padding_hdr        ] = IntProp.new(:i16, 0          )
    self[VOC.message_id(cid)] = IntProp.new(:u32, 0, base: 16)

    add_dscr_props
    
    (1..48).each do |_i|
      self[VOC.item_id(_i)  ] = IntProp.new(:i16, -1           )
      self[VOC.item_name(_i)] = StrProp.new( nil, '', dmy: true)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    (1..48).each do |_i|
      fetch(VOC.item_id(_i)).proc = Proc.new do |_id|
        if _id != -1
          _entry = @items[_id]
          _name  = '???'
          if _entry
            if jp? || us?
              _name = _entry[VOC.name_str(cid)]
            elsif eu?
              _name = _entry[VOC.name_str('GB')]
            end
          end
        else
          _name = 'None'
        end
        self[VOC.item_name(_i)] = _name
      end
    end
  end

end	# class Shop

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
