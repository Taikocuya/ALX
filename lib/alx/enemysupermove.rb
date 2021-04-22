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

# Class to handle a enemy skill.
class EnemySuperMove < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemySuperMove.
  def initialize
    super
    init_attrs
    init_props
    init_procs
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :enemies

  def enemies=(_enemies)
    @enemies = _enemies || []
    
    fetch(VOC.effect_param_id)&.call_proc
  end
  
#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @enemies ||= []
  end
  
  # Initialize the entry properties.
  def init_props
    add_name_props

    if jp? || us?
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
    end
    
    self[VOC.category_id  ] = IntProp.new(:i8,  0           )
    self[VOC.category_name] = StrProp.new(nil, '', dmy: true)
    self[VOC.effect_id    ] = IntProp.new(:i8, -1           )
    self[VOC.effect_name  ] = StrProp.new(nil, '', dmy: true)
    self[VOC.scope_id     ] = IntProp.new(:u8,  0           )
    self[VOC.scope_name   ] = StrProp.new(nil, '', dmy: true)
    
    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
    end
    
    self[VOC.effect_param_id      ] = IntProp.new(:u16,  0           )
    self[VOC.effect_param_name    ] = StrProp.new( nil, '', dmy: true)
    self[VOC.effect_base          ] = IntProp.new(:u16,  0           )
    self[VOC.element_id           ] = IntProp.new( :i8,  0           )
    self[VOC.element_name         ] = StrProp.new( nil, '', dmy: true)
    self[VOC.type_id              ] = IntProp.new( :i8,  0           )
    self[VOC.type_name            ] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_infliction_id  ] = IntProp.new( :i8,  0           )
    self[VOC.state_infliction_name] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_resistance_id  ] = IntProp.new( :i8,  0           )
    self[VOC.state_resistance_name] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_id             ] = IntProp.new( :i8,  0           )
    self[VOC.state_name           ] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_miss           ] = IntProp.new( :i8,  0           )
    self[padding_hdr              ] = IntProp.new( :i8,  0           )
    self[padding_hdr              ] = IntProp.new( :i8,  0           )
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.category_id).proc = Proc.new do |_id|
      self[VOC.category_name] = VOC.enemy_skill_categories(_id)
    end

    fetch(VOC.effect_id).proc = Proc.new do |_id|
      self[VOC.effect_name] = VOC.effects(_id)
      
      fetch(VOC.effect_param_id)&.call_proc
    end

    fetch(VOC.scope_id).proc = Proc.new do |_id|
      self[VOC.scope_name] = VOC.scopes(_id)
    end

    fetch(VOC.element_id).proc = Proc.new do |_id|
      self[VOC.element_name] = VOC.elements(_id)
    end

    fetch(VOC.effect_param_id).proc = Proc.new do |_id|
      case self[VOC.effect_id]
      when 31, 32, 33, 47, 63, 78
        self[VOC.effect_param_name] = VOC.hp
      when 43, 64
        _name  = '???'
        _entry = @enemies.find { |_enemy| _enemy.id == _id }
        
        if _entry
          if jp?
            _name = _entry[VOC.name_str(jp )]
          else
            _name = _entry[VOC.name_opt(cid)]
          end
        end

        self[VOC.effect_param_name] = _name
      else
        self[VOC.effect_param_name] = VOC.traits(_id)
      end
    end

    fetch(VOC.type_id).proc = Proc.new do |_id|
      self[VOC.type_name] = VOC.types(_id)
    end
    
    fetch(VOC.state_infliction_id).proc = Proc.new do |_id|
      self[VOC.state_infliction_name] = VOC.traits(_id)
    end
    
    fetch(VOC.state_resistance_id).proc = Proc.new do |_id|
      self[VOC.state_resistance_name] = VOC.traits(_id)
    end

    fetch(VOC.state_id).proc = Proc.new do |_id|
      self[VOC.state_name] = VOC.states(_id)
    end
  end

end	# class EnemySuperMove

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
