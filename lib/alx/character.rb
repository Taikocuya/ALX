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

# Class to handle a character.
class Character < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Character.
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

  attr_reader :weapons
  attr_reader :armors
  attr_reader :accessories

  def weapons=(_weapons)
    @weapons = _weapons || {}
    fetch(VOC.weapon_id)&.call_proc
  end
  
  def armors=(_armors)
    @armors = _armors || {}
    fetch(VOC.armor_id)&.call_proc
  end
  
  def accessories=(_accessories)
    @accessories = _accessories || {}
    fetch(VOC.accessory_id(nil))&.call_proc
  end
  
#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @weapons     ||= {}
    @armors      ||= {}
    @accessories ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    self[VOC.name_str(cid)      ] = StrProp.new(  11,  ''                    )
    self[VOC.age                ] = IntProp.new( :i8,   0                    )
    self[VOC.gender_id          ] = IntProp.new( :i8,   0                    )
    self[VOC.gender_name        ] = StrProp.new( nil,  '', dmy: true         )
    self[VOC.width              ] = IntProp.new( :i8,   0                    )
    self[VOC.depth              ] = IntProp.new( :i8,   0                    )
    self[VOC.maxmp              ] = IntProp.new( :i8,   0                    )
    self[VOC.element_id         ] = IntProp.new( :i8,   0                    )
    self[VOC.element_name       ] = StrProp.new( nil,  '', dmy: true         )
    self[padding_hdr            ] = IntProp.new( :i8,   0                    )
    self[VOC.weapon_id          ] = IntProp.new(:u16,   0                    )
    self[VOC.weapon_name        ] = StrProp.new( nil,  '', dmy: true         )
    self[VOC.armor_id           ] = IntProp.new(:u16,   0                    )
    self[VOC.armor_name         ] = StrProp.new( nil,  '', dmy: true         )
    self[VOC.accessory_id(nil)  ] = IntProp.new(:u16,   0                    )
    self[VOC.accessory_name(nil)] = StrProp.new( nil,  '', dmy: true         )
    self[VOC.movement_flags     ] = IntProp.new(:i16,   0, base: 2, width: 14)
    
    VOC.movements.each do |_id, _movement|
      self[_movement] = StrProp.new(nil, '', dmy: true)
    end

    self[VOC.hp                 ] = IntProp.new(:i16,   0)
    self[VOC.maxhp              ] = IntProp.new(:i16,   0)
    self[VOC.hp_growth          ] = IntProp.new(:i16,   0)
    self[VOC.sp(nil)            ] = IntProp.new(:i16,   0)
    self[VOC.maxsp(nil)         ] = IntProp.new(:i16,   0)
    self[VOC.counter            ] = IntProp.new(:i16,   0)
    self[padding_hdr            ] = IntProp.new(:i16,   0)
    self[VOC.exp(nil)           ] = IntProp.new(:u32,   0)
    self[VOC.mp_growth          ] = FltProp.new(:f32, 0.0)
    self[unknown_hdr            ] = FltProp.new(:f32, 0.0)
    
    (0...6).each do |_i|
      self[VOC.elements(_i)] = IntProp.new(:i16, 0)
    end
    (0...15).each do |_i|
      self[VOC.states(_i)  ] = IntProp.new(:i16, 0)
    end

    self[VOC.danger         ] = IntProp.new(:i16,   0)
    self[VOC.power          ] = IntProp.new(:i16,   0)
    self[VOC.will           ] = IntProp.new(:i16,   0)
    self[VOC.vigor          ] = IntProp.new(:i16,   0)
    self[VOC.agile          ] = IntProp.new(:i16,   0)
    self[VOC.quick          ] = IntProp.new(:i16,   0)
    self[padding_hdr        ] = IntProp.new(:i16,   0)
    self[VOC.power_growth   ] = FltProp.new(:f32, 0.0)
    self[VOC.will_growth    ] = FltProp.new(:f32, 0.0)
    self[VOC.vigor_growth   ] = FltProp.new(:f32, 0.0)
    self[VOC.agile_growth   ] = FltProp.new(:f32, 0.0)
    self[VOC.quick_growth   ] = FltProp.new(:f32, 0.0)
    self[VOC.green_exp(nil) ] = IntProp.new(:i32,   0)
    self[VOC.red_exp(nil)   ] = IntProp.new(:i32,   0)
    self[VOC.purple_exp(nil)] = IntProp.new(:i32,   0)
    self[VOC.blue_exp(nil)  ] = IntProp.new(:i32,   0)
    self[VOC.yellow_exp(nil)] = IntProp.new(:i32,   0)
    self[VOC.silver_exp(nil)] = IntProp.new(:i32,   0)
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.gender_id).proc = Proc.new do |_id|
      self[VOC.gender_name] = VOC.genders(_id)
    end
    
    fetch(VOC.element_id).proc = Proc.new do |_id|
      self[VOC.element_name] = VOC.elements(_id)
    end

    fetch(VOC.weapon_id).proc = Proc.new do |_id|
      if _id != -1
        _entry = @weapons[_id]
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
      self[VOC.weapon_name] = _name
    end
    
    fetch(VOC.armor_id).proc = Proc.new do |_id|
      if _id != -1
        _entry = @armors[_id]
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
      self[VOC.armor_name] = _name
    end

    fetch(VOC.accessory_id(nil)).proc = Proc.new do |_id|
      if _id != -1
        _entry = @accessories[_id]
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
      self[VOC.accessory_name(nil)] = _name
    end
    
    fetch(VOC.movement_flags).proc = Proc.new do |_flags|
      VOC.movements.each do |_id, _movement|
        self[_movement] = (_flags & (0x800 >> _id) != 0) ? 'X' : ''
      end
    end
  end

end	# class Character

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
