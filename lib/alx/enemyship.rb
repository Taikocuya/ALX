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

# Class to handle a enemy ship.
class EnemyShip < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyShip.
  # @param _root [GameRoot] Game root
  def initialize(_root)
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
    @items = _items
    
    if product_id != '6107110 06' && product_id != '6107810'
      (1..3).each do |_i|
        fetch(VOC.item_id[_i])&.call_proc
      end
    else
      fetch(VOC.item_id[nil])&.call_proc
    end
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
    add_name_props(20)

    self[VOC.maxhp  ] = IntProp.new(:i32, -1)
    self[VOC.will   ] = IntProp.new(:i16, -1)
    self[VOC.defense] = IntProp.new(:i16, -1)
    self[VOC.magdef ] = IntProp.new(:i16, -1)

    if product_id != '6107110 06' && product_id != '6107810'
      self[VOC.quick] = IntProp.new(:i16, -1)
      self[VOC.agile] = IntProp.new(:i16, -1)
      self[VOC.dodge] = IntProp.new(:i16, -1)
    end

    (0...6).each do |_i|
      self[VOC.elements[_i]] = IntProp.new(:i16, -1)
    end
    
    (1..4).each do |_i|
      if eu?
        _de_pos  = VOC.arm_name_de_pos[_i]
        _de_size = VOC.arm_name_de_size[_i]
        _de_str  = VOC.arm_name_de_str[_i]
        _es_pos  = VOC.arm_name_es_pos[_i]
        _es_size = VOC.arm_name_es_size[_i]
        _es_str  = VOC.arm_name_es_str[_i]
        _fr_pos  = VOC.arm_name_fr_pos[_i]
        _fr_size = VOC.arm_name_fr_size[_i]
        _fr_str  = VOC.arm_name_fr_str[_i]
        _gb_pos  = VOC.arm_name_gb_pos[_i]
        _gb_size = VOC.arm_name_gb_size[_i]
        _gb_str  = VOC.arm_name_gb_str[_i]
        
        self[_de_pos ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[_de_size] = IntProp.new(:u32,  0,           ext: true)
        self[_de_str ] = StrProp.new( nil, '',           ext: true)
        self[_es_pos ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[_es_size] = IntProp.new(:u32,  0,           ext: true)
        self[_es_str ] = StrProp.new( nil, '',           ext: true)
        self[_fr_pos ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[_fr_size] = IntProp.new(:u32,  0,           ext: true)
        self[_fr_str ] = StrProp.new( nil, '',           ext: true)
        self[_gb_pos ] = IntProp.new(:u32,  0, base: 16, ext: true)
        self[_gb_size] = IntProp.new(:u32,  0,           ext: true)
        self[_gb_str ] = StrProp.new( nil, '',           ext: true)
      end
      self[VOC.arm_type_id[_i]     ] = IntProp.new(:i16, -1           )
      self[VOC.arm_type_name[_i]   ] = StrProp.new( nil, '', dmy: true)
      self[VOC.arm_attack[_i]      ] = IntProp.new(:i16, -1           )
      self[VOC.arm_range[_i]       ] = IntProp.new(:i16, -1           )
      self[VOC.arm_hit[_i]         ] = IntProp.new(:i16, -1           )
      self[VOC.arm_element_id[_i]  ] = IntProp.new(:i16, -1           )
      self[VOC.arm_element_name[_i]] = StrProp.new( nil, '', dmy: true)
    end
    
    if product_id != '6107110 06' && product_id != '6107810'
      self[padding_hdr] = IntProp.new(:i16, 0)
      self[padding_hdr] = IntProp.new(:i16, 0)
      self[padding_hdr] = IntProp.new(:i16, 0)
      self[padding_hdr] = IntProp.new(:i16, 0)
      self[padding_hdr] = IntProp.new(:i16, 0)
      self[padding_hdr] = IntProp.new(:i16, 0)
    else
      self[VOC.padding[nil]] = IntProp.new(:i16, 0)
    end
    
    self[VOC.exp[nil]] = IntProp.new(:i32, -1)
    self[VOC.gold   ] = IntProp.new(:i32, -1)

    if product_id != '6107110 06' && product_id != '6107810'
      (1..3).each do |_i|
        self[VOC.item_drop_id[_i]  ] = IntProp.new(:i16, -1           )
        self[VOC.item_drop_name[_i]] = StrProp.new( nil, '', dmy: true)
        self[VOC.item_id[_i]       ] = IntProp.new(:i16, -1           )
        self[VOC.item_name[_i]     ] = StrProp.new( nil, '', dmy: true)
      end
    else
      self[VOC.item_drop_id[nil]  ] = IntProp.new(:i16, -1           )
      self[VOC.item_drop_name[nil]] = StrProp.new( nil, '', dmy: true)
      self[VOC.item_id[nil]       ] = IntProp.new(:i16, -1           )
      self[VOC.item_name[nil]     ] = StrProp.new( nil, '', dmy: true)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    (1..4).each do |_i|
      fetch(VOC.arm_type_id[_i]).proc = Proc.new do |_id|
        self[VOC.arm_type_name[_i]] = VOC.ship_cannon_types[_id]
      end
      
      fetch(VOC.arm_element_id[_i]).proc = Proc.new do |_id|
        self[VOC.arm_element_name[_i]] = VOC.elements[_id]
      end
    end

    if product_id != '6107110 06' && product_id != '6107810'
      (1..3).each do |_i|
        fetch(VOC.item_drop_id[_i]).proc = Proc.new do |_id|
          self[VOC.item_drop_name[_i]] = VOC.drops[_id]
        end
      end
      
      (1..3).each do |_i|
        fetch(VOC.item_id[_i]).proc = Proc.new do |_id|
          if _id != -1
            _entry = @items[_id]
            _name  = '???'
            if _entry
              if jp? || us?
                _name = _entry[VOC.name_str[cid]]
              elsif eu?
                _name = _entry[VOC.name_str['GB']]
              end
            end
          else
            _name = 'None'
          end
          self[VOC.item_name[_i]] = _name
        end
      end
    else
      fetch(VOC.item_drop_id[nil]).proc = Proc.new do |_id|
        self[VOC.item_drop_name[nil]] = VOC.drops[_id]
      end

      fetch(VOC.item_id[nil]).proc = Proc.new do |_id|
        if _id != -1
          _entry = @items[_id]
          _name  = '???'
          if _entry
            _name = _entry[VOC.name_str[cid]]
          end
        else
          _name = 'None'
        end
        self[VOC.item_name[nil]] = _name
      end
    end
  end

end	# class EnemyShip

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
