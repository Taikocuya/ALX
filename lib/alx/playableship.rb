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

# Class to handle a playable ship.
class PlayableShip < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a PlayableShip.
  def initialize
    super
    init_attrs
    init_props
    init_procs
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader   :ship_cannons
  attr_accessor :ship_cannon_size
  attr_reader   :ship_accessories

  def ship_cannons=(_ship_cannons)
    @ship_cannons = _ship_cannons || {}
    (1..@ship_cannon_size).each do |_i|
      fetch(VOC.cannon_id(_i))&.call_proc
    end
  end
  
  def ship_accessories=(_ship_accessories)
    @ship_accessories = _ship_accessories || {}
    (1..3).each do |_i|
      fetch(VOC.accessory_id(_i))&.call_proc
    end
  end
  
#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super

    if product_id == '6107110 06' || product_id == '6107810'
      @ship_cannon_size ||= 4
    else
      @ship_cannon_size ||= 5
    end
    
    @ship_cannons     ||= {}
    @ship_accessories ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    add_name_props(20)

    self[VOC.maxhp] = IntProp.new(:u32, 0)
    
    if product_id != '6107110 06' && product_id != '6107810'
      self[VOC.maxsp(nil)] = IntProp.new(:i16, 0)
      self[VOC.sp(nil)   ] = IntProp.new(:i16, 0)
    end
    
    self[VOC.defense] = IntProp.new(:i16, 0)
    self[VOC.magdef ] = IntProp.new(:i16, 0)
    self[VOC.quick  ] = IntProp.new(:i16, 0)
    
    if product_id != '6107110 06' && product_id != '6107810'
      self[VOC.dodge] = IntProp.new(:i16, 0)
    end
    
    (0...6).each do |_i|
      self[VOC.elements(_i)] = IntProp.new(:i16, 0)
    end

    (1..@ship_cannon_size).each do |_i|
      self[VOC.cannon_id(_i)  ] = IntProp.new(:i16, -1           )
      self[VOC.cannon_name(_i)] = StrProp.new( nil, '', dmy: true)
    end
    
    (1..3).each do |_i|
      self[VOC.accessory_id(_i)  ] = IntProp.new(:i16, -1           )
      self[VOC.accessory_name(_i)] = StrProp.new( nil, '', dmy: true)
    end

    if product_id != '6107110 06' && product_id != '6107810'
      self[VOC.value         ] = IntProp.new(:u32, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
      self[VOC.maxhp_growth  ] = IntProp.new(:i32, 0)
      self[VOC.maxsp_growth  ] = IntProp.new(:i16, 0)
      self[VOC.sp_growth     ] = IntProp.new(:i16, 0)
      self[VOC.defense_growth] = IntProp.new(:i16, 0)
      self[VOC.magdef_growth ] = IntProp.new(:i16, 0)
      self[VOC.quick_growth  ] = IntProp.new(:i16, 0)
      self[VOC.dodge_growth  ] = IntProp.new(:i16, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
      self[padding_hdr       ] = IntProp.new(:i16, 0)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    (1..@ship_cannon_size).each do |_i|
      fetch(VOC.cannon_id(_i)).proc = Proc.new do |_id|
        if _id != -1
          _entry = @ship_cannons[_id]
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
        self[VOC.cannon_name(_i)] = _name
      end
    end

    (1..3).each do |_i|
      fetch(VOC.accessory_id(_i)).proc = Proc.new do |_id|
        if _id != -1
          _entry = @ship_accessories[_id]
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
        self[VOC.accessory_name(_i)] = _name
      end
    end
  end

end	# class PlayableShip

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
