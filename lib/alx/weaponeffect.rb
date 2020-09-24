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

# Class to handle a weapon effect.
class WeaponEffect < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a WeaponEffect.
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
    self[VOC.name_str['JP']] = StrProp.new( 17, ''           )
    self[VOC.effect_id     ] = IntProp.new(:i8, -1           )
    self[VOC.effect_name   ] = StrProp.new(nil, '', dmy: true)
    self[VOC.state_id      ] = IntProp.new(:i8,  0           )
    self[VOC.state_name    ] = StrProp.new(nil, '', dmy: true)
    self[VOC.state_miss    ] = IntProp.new(:i8,  0           )
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.effect_id).proc = Proc.new do |_id|
      self[VOC.effect_name] = VOC.effects[_id]
    end
    
    fetch(VOC.state_id).proc = Proc.new do |_id|
      self[VOC.state_name] = VOC.states[_id]
    end
  end

end	# class WeaponEffect

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
