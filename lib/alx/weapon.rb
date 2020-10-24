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

# Class to handle a weapon.
class Weapon < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Weapon.
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

  attr_reader :weapon_effects

  def weapon_effects=(_weapon_effects)
    @weapon_effects = _weapon_effects
    fetch(VOC.effect_id)&.call_proc
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @weapon_effects ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    add_name_props
    
    self[VOC.character_id[nil]  ] = IntProp.new(:i8,  0           )
    self[VOC.character_name[nil]] = StrProp.new(nil, '', dmy: true)
    self[VOC.sell               ] = IntProp.new(:i8,  0           )
    self[VOC.order_123          ] = IntProp.new(:i8, -1           )
    self[VOC.order_abc[cid]     ] = IntProp.new(:i8, -1           )
    self[VOC.effect_id          ] = IntProp.new(:u8, -1           )
    self[VOC.effect_name        ] = StrProp.new(nil, '', dmy: true)
    
    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
    end
    
    self[VOC.buy             ] = IntProp.new(:u16,  0           )
    self[VOC.attack          ] = IntProp.new(:i16,  0           )
    self[VOC.hit             ] = IntProp.new(:i16,  0           )
    self[VOC.trait_id[nil]   ] = IntProp.new( :i8,  0           )
    self[VOC.trait_name[nil] ] = StrProp.new( nil, '', dmy: true)
    self[padding_hdr         ] = IntProp.new( :i8,  0           )
    self[VOC.trait_value[nil]] = IntProp.new(:i16,  0           )
    
    add_dscr_props
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.character_id[nil]).proc = Proc.new do |_id|
      self[VOC.character_name[nil]] = VOC.characters[_id]
    end
    
    fetch(VOC.effect_id).proc = Proc.new do |_id|
      if _id != -1
        _entry = @weapon_effects[_id]
        _name  = '???'
        if _entry
          _hit  = 100 - _entry[VOC.state_miss]
          _name = sprintf('%s %d%%', _entry[VOC.state_name], _hit)
        end
      else
        _name = 'None'
      end
      self[VOC.effect_name] = _name
    end
    
    fetch(VOC.trait_id[nil]).proc = Proc.new do |_id|
      self[VOC.trait_name[nil]] = VOC.traits[_id]
    end
  end

end	# class Weapon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
