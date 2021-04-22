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

# Class to handle a character super move.
class CharacterSuperMove < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CharacterSuperMove.
  def initialize
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

    self[VOC.element_id  ] = IntProp.new(:i8,  0           )
    self[VOC.element_name] = StrProp.new(nil, '', dmy: true)
    
    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
    end
    
    self[VOC.order(nil)    ] = IntProp.new(:i16, -1                   )
    self[VOC.occasion_flags] = IntProp.new( :u8,  0, base: 2, width: 6)
    
    VOC.occasions.each do |_id, _occasion|
      self[_occasion] = StrProp.new(nil, '', dmy: true)
    end

    self[VOC.effect_id         ] = IntProp.new( :i8, -1           )
    self[VOC.effect_name       ] = StrProp.new( nil, '', dmy: true)
    self[VOC.scope_id          ] = IntProp.new( :u8,  0           )
    self[VOC.scope_name        ] = StrProp.new( nil, '', dmy: true)
    self[VOC.category_id       ] = IntProp.new( :i8,  0           )
    self[VOC.category_name     ] = StrProp.new( nil, '', dmy: true)
    self[VOC.effect_speed      ] = IntProp.new( :i8, -1           )
    self[VOC.effect_sp         ] = IntProp.new( :i8, -1           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[VOC.effect_base       ] = IntProp.new(:i16,  0           )
    self[VOC.type_id           ] = IntProp.new( :i8,  0           )
    self[VOC.type_name         ] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_id          ] = IntProp.new( :i8,  0           )
    self[VOC.state_name        ] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_miss        ] = IntProp.new( :i8,  0           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[VOC.ship_occasion_id  ] = IntProp.new( :i8,  0           )
    self[VOC.ship_occasion_name] = StrProp.new( nil, '', dmy: true)
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[VOC.ship_effect_id    ] = IntProp.new(:i16, -1           )
    self[VOC.ship_effect_name  ] = StrProp.new( nil, '', dmy: true)
    self[VOC.ship_effect_sp    ] = IntProp.new( :i8, -1           )
    self[VOC.ship_effect_turns ] = IntProp.new( :i8, -1           )
    self[VOC.ship_effect_base  ] = IntProp.new(:i16,  0           )
    self[VOC.unknown(nil)      ] = IntProp.new( :i8, -1           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )
    self[padding_hdr           ] = IntProp.new( :i8,  0           )

    add_dscr_props
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.element_id).proc = Proc.new do |_id|
      self[VOC.element_name] = VOC.elements(_id)
    end
    
    fetch(VOC.occasion_flags).proc = Proc.new do |_flags|
      VOC.occasions.each do |_id, _occasion|
        self[_occasion] = (_flags & (0x4 >> _id) != 0) ? 'X' : ''
      end
    end
    
    fetch(VOC.effect_id).proc = Proc.new do |_id|
      self[VOC.effect_name] = VOC.effects(_id)
    end
    
    fetch(VOC.scope_id).proc = Proc.new do |_id|
      self[VOC.scope_name] = VOC.scopes(_id)
    end
    
    fetch(VOC.category_id).proc = Proc.new do |_id|
      self[VOC.category_name] = VOC.character_skill_categories(_id)
    end
    
    fetch(VOC.type_id).proc = Proc.new do |_id|
      self[VOC.type_name] = VOC.types(_id)
    end

    fetch(VOC.state_id).proc = Proc.new do |_id|
      self[VOC.state_name] = VOC.states(_id)
    end
    
    fetch(VOC.ship_occasion_id).proc = Proc.new do |_id|
      self[VOC.ship_occasion_name] = VOC.ship_occasions(_id)
    end
    
    fetch(VOC.ship_effect_id).proc = Proc.new do |_id|
      self[VOC.ship_effect_name] = VOC.effects(_id)
    end
  end

end	# class CharacterSuperMove

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
