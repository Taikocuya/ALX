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

# Class to handle a ship cannon.
class ShipCannon < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipCannon.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    init_props
    init_procs
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    add_name_props

    self[VOC.ship_flags] = IntProp.new(:u8, 0, base: 16)

    VOC.ships.each_value do |_ship|
      self[_ship] = StrProp.new(nil, '', dmy: true)
    end

    self[VOC.type_id     ] = IntProp.new(:i8,  0           )
    self[VOC.type_name   ] = StrProp.new(nil, '', dmy: true)
    self[VOC.element_id  ] = IntProp.new(:i8,  0           )
    self[VOC.element_name] = StrProp.new(nil, '', dmy: true)

    if product_id != '6107110 06' && product_id != '6107810'
      if eu?
        self[padding_hdr] = IntProp.new(:i8, 0)
      end
      
      self[VOC.attack           ] = IntProp.new(:i16,  0           )
      self[VOC.hit              ] = IntProp.new(:u16,  0           )
      self[VOC.limit            ] = IntProp.new( :i8,  0           )
      self[VOC.sp[-1]           ] = IntProp.new( :i8,  0           )
      self[VOC.feature_id[-1]   ] = IntProp.new( :i8,  0           )
      self[VOC.feature_name[-1] ] = StrProp.new( nil, '', dmy: true)
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[VOC.feature_value[-1]] = IntProp.new(:i16,  0           )
  
      if dc?
        self[padding_hdr] = IntProp.new(:i8, 0)
        self[padding_hdr] = IntProp.new(:i8, 0)
      end
      
      self[VOC.purchase_price] = IntProp.new(:u16, 0)
  
      if dc?
        self[padding_hdr] = IntProp.new(:i8, 0)
        self[padding_hdr] = IntProp.new(:i8, 0)
      end
      
      self[VOC.retail_price  ] = IntProp.new( :i8, 0)
      self[VOC.order_prio    ] = IntProp.new(:i8, -1)
      self[VOC.order_abc[cid]] = IntProp.new(:i8, -1)
  
      if dc? || eu?
        self[padding_hdr] = IntProp.new(:i8, 0)
      else
        self[VOC.padding[-1]] = IntProp.new(:i8, 0)
      end
    
      add_dscr_props
    else
      self[VOC.purchase_price] = IntProp.new(:u16, 0)
      self[padding_hdr       ] = IntProp.new( :i8, 0)
      self[padding_hdr       ] = IntProp.new( :i8, 0)
      self[VOC.retail_price  ] = IntProp.new( :i8, 0)
      self[padding_hdr       ] = IntProp.new( :i8, 0)
      self[VOC.attack        ] = IntProp.new(:i16, 0)
      self[VOC.hit           ] = IntProp.new(:u16, 0)
      self[VOC.limit         ] = IntProp.new( :i8, 0)
      self[VOC.sp[-1]        ] = IntProp.new( :i8, 0)
  
      (1..4).each do |_i|
        self[VOC.feature_id[_i]   ] = IntProp.new( :i8,  0           )
        self[VOC.feature_name[_i] ] = StrProp.new( nil, '', dmy: true)
        self[padding_hdr          ] = IntProp.new( :i8,  0           )
        self[VOC.feature_value[_i]] = IntProp.new(:i16,  0           )
      end
  
      self[VOC.order_prio    ] = IntProp.new(:i8, -1)
      self[VOC.order_abc[cid]] = IntProp.new(:i8, -1)
      self[padding_hdr       ] = IntProp.new(:i8,  0)
      self[padding_hdr       ] = IntProp.new(:i8,  0)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.ship_flags).proc = Proc.new do |_flags|
      VOC.ships.each do |_id, _ship|
        self[_ship] = (_flags & (0x20 >> _id) != 0) ? 'X' : ''
      end
    end
    
    fetch(VOC.type_id).proc = Proc.new do |_id|
      self[VOC.type_name] = VOC.ship_cannon_types[_id]
    end

    fetch(VOC.element_id).proc = Proc.new do |_id|
      self[VOC.element_name] = VOC.elements[_id]
    end

    if product_id != '6107110 06' && product_id != '6107810'
      fetch(VOC.feature_id[-1]).proc = Proc.new do |_id|
        self[VOC.feature_name[-1]] = VOC.ship_accessory_features[_id]
      end
    else
      (1..4).each do |_i|
        fetch(VOC.feature_id[_i]).proc = Proc.new do |_id|
          self[VOC.feature_name[_i]] = VOC.ship_accessory_features[_id]
        end
      end
    end
  end

end	# class ShipCannon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
