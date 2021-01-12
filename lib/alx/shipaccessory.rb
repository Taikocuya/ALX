#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2021 Marcel Renner
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

# Class to handle a ship accessory.
class ShipAccessory < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a ShipAccessory.
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

    self[VOC.ship_flags] = IntProp.new(:u8, 0, base: 2, width: 10)

    VOC.ships.each_value do |_ship|
      self[_ship] = StrProp.new(nil, '', dmy: true)
    end

    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
    end

    if product_id != '6107110 06' && product_id != '6107810'
      (1..4).each do |_i|
        self[VOC.trait_id(_i)   ] = IntProp.new( :i8,  0           )
        self[VOC.trait_name(_i) ] = StrProp.new( nil, '', dmy: true)
        self[padding_hdr        ] = IntProp.new( :i8,  0           )
        self[VOC.trait_value(_i)] = IntProp.new(:i16,  0           )
      end
  
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
      self[padding_hdr        ] = IntProp.new(:i8,  0)
  
      add_dscr_props
    else
      self[padding_hdr] = IntProp.new( :i8, 0)
      self[padding_hdr] = IntProp.new( :i8, 0)
      self[VOC.buy    ] = IntProp.new(:u16, 0)
      self[padding_hdr] = IntProp.new( :i8, 0)
      self[padding_hdr] = IntProp.new( :i8, 0)
      self[VOC.sell   ] = IntProp.new( :i8, 0)
      self[padding_hdr] = IntProp.new( :i8, 0)
      
      (1..4).each do |_i|
        self[VOC.trait_id(_i)   ] = IntProp.new( :i8,  0           )
        self[VOC.trait_name(_i) ] = StrProp.new( nil, '', dmy: true)
        self[padding_hdr        ] = IntProp.new( :i8,  0           )
        self[VOC.trait_value(_i)] = IntProp.new(:i16,  0           )
      end
      
      self[VOC.order[[cid, 1]]] = IntProp.new(:i8, -1)
      self[VOC.order[[cid, 2]]] = IntProp.new(:i8, -1)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.ship_flags).proc = Proc.new do |_flags|
      VOC.ships.each do |_id, _ship|
        self[_ship] = (_flags & (0x20 >> _id) != 0) ? 'X' : ''
      end
    end

    (1..4).each do |_i|
      fetch(VOC.trait_id(_i)).proc = Proc.new do |_id|
        self[VOC.trait_name(_i)] = VOC.ship_traits(_id)
      end
    end
  end

end	# class ShipAccessory

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
