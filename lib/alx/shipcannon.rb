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

# Class to handle a ship cannon.
class ShipCannon < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    super
    add_name_props

    self[VOC.ship_flags] = IntProp.new(:u8, 0, base: 2, width: 10)

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
      
      self[VOC.attack          ] = IntProp.new(:i16,  0           )
      self[VOC.hit             ] = IntProp.new(:u16,  0           )
      self[VOC.limit           ] = IntProp.new( :i8,  0           )
      self[VOC.sp(nil)         ] = IntProp.new( :i8,  0           )
      self[VOC.trait_id(nil)   ] = IntProp.new( :i8,  0           )
      self[VOC.trait_name(nil) ] = StrProp.new( nil, '', dmy: true)
      self[padding_hdr         ] = IntProp.new( :i8,  0           )
      self[VOC.trait_value(nil)] = IntProp.new(:i16,  0           )
  
      if dc?
        self[padding_hdr] = IntProp.new(:i8, 0)
        self[padding_hdr] = IntProp.new(:i8, 0)
      end
      
      self[VOC.buy] = IntProp.new(:u16, 0)
  
      if dc?
        self[padding_hdr] = IntProp.new(:i8, 0)
        self[padding_hdr] = IntProp.new(:i8, 0)
      end
      
      self[VOC.sell           ] = IntProp.new(:i8,  0)
      self[VOC.order[[cid, 1]]] = IntProp.new(:i8, -1)
      self[VOC.order[[cid, 2]]] = IntProp.new(:i8, -1)
  
      if dc? || eu?
        self[padding_hdr] = IntProp.new(:i8, 0)
      else
        self[VOC.padding(nil)] = IntProp.new(:i8, 0)
      end
    
      add_dscr_props
    else
      self[VOC.buy    ] = IntProp.new(:u16, 0)
      self[padding_hdr] = IntProp.new( :i8, 0)
      self[padding_hdr] = IntProp.new( :i8, 0)
      self[VOC.sell   ] = IntProp.new( :i8, 0)
      self[padding_hdr] = IntProp.new( :i8, 0)
      self[VOC.attack ] = IntProp.new(:i16, 0)
      self[VOC.hit    ] = IntProp.new(:u16, 0)
      self[VOC.limit  ] = IntProp.new( :i8, 0)
      self[VOC.sp(nil)] = IntProp.new( :i8, 0)
  
      (1..4).each do |_i|
        self[VOC.trait_id(_i)   ] = IntProp.new( :i8,  0           )
        self[VOC.trait_name(_i) ] = StrProp.new( nil, '', dmy: true)
        self[padding_hdr        ] = IntProp.new( :i8,  0           )
        self[VOC.trait_value(_i)] = IntProp.new(:i16,  0           )
      end
  
      self[VOC.order[[cid, 1]]] = IntProp.new(:i8, -1)
      self[VOC.order[[cid, 2]]] = IntProp.new(:i8, -1)
      self[padding_hdr        ] = IntProp.new(:i8,  0)
      self[padding_hdr        ] = IntProp.new(:i8,  0)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    super

    add_id_proc(
      -dscrptr(:ship_cannon_id_range).begin,
      name_table: 'ShipWeaponParamP',
      dscr_table: 'ShipHouMessageDataTable'
    )

    fetch(VOC.ship_flags).proc = Proc.new do |_flags|
      VOC.ships.each do |_id, _ship|
        self[_ship] = (_flags & (0x20 >> _id) != 0) ? 'X' : ''
      end
    end
    
    fetch(VOC.type_id).proc = Proc.new do |_id|
      self[VOC.type_name] = VOC.cannon_types(_id)
    end

    fetch(VOC.element_id).proc = Proc.new do |_id|
      self[VOC.element_name] = VOC.elements(_id)
    end

    if product_id != '6107110 06' && product_id != '6107810'
      fetch(VOC.trait_id(nil)).proc = Proc.new do |_id|
        self[VOC.trait_name(nil)] = VOC.ship_traits(_id)
      end
    else
      (1..4).each do |_i|
        fetch(VOC.trait_id(_i)).proc = Proc.new do |_id|
          self[VOC.trait_name(_i)] = VOC.ship_traits(_id)
        end
      end
    end
  end

end # class ShipCannon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
