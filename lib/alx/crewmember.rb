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

# Class to handle a crew member.
class CrewMember < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CrewMember.
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

    self[VOC.position_id  ] = IntProp.new(:i8, -1           )
    self[VOC.position_name] = StrProp.new(nil, '', dmy: true)

    if product_id != '6107110 06' && product_id != '6107810'
      if eu?
        self[padding_hdr] = IntProp.new(:i8, 0)
      end
      
      self[VOC.trait_id(nil)    ] = IntProp.new( :i8, -1           )
      self[VOC.trait_name(nil)  ] = StrProp.new( nil, '', dmy: true)
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[VOC.trait_value(nil) ] = IntProp.new(:i16,  0           )
      self[VOC.ship_effect_id   ] = IntProp.new( :i8, -1           )
      self[VOC.ship_effect_name ] = StrProp.new( nil, '', dmy: true)
      self[VOC.ship_effect_sp   ] = IntProp.new( :i8, -1           )
      self[VOC.ship_effect_turns] = IntProp.new( :i8, -1           )
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      
      if gc? && jp?
        self[VOC.unknown(nil)    ] = IntProp.new(:i16, 0)
        self[VOC.ship_effect_base] = IntProp.new(:i16, 0)
      else
        self[VOC.ship_effect_base] = IntProp.new(:i16, 0)
        self[VOC.unknown(nil)    ] = IntProp.new(:i16, 0)
      end
  
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
      
      add_dscr_props
    else
      self[VOC.trait_id(nil)    ] = IntProp.new( :i8, -1           )
      self[VOC.trait_name(nil)  ] = StrProp.new( nil, '', dmy: true)
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[VOC.trait_value(nil) ] = IntProp.new(:i16,  0           )
      self[VOC.ship_effect_id   ] = IntProp.new( :i8, -1           )
      self[VOC.ship_effect_name ] = StrProp.new( nil, '', dmy: true)
      self[VOC.ship_effect_turns] = IntProp.new( :i8, -1           )
      self[VOC.ship_effect_base ] = IntProp.new(:i16, -1           )
      self[unknown_hdr          ] = IntProp.new(:i16,  0           )
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.position_id).proc = Proc.new do |_id|
      self[VOC.position_name] = VOC.positions(_id)
    end

    fetch(VOC.trait_id(nil)).proc = Proc.new do |_id|
      self[VOC.trait_name(nil)] = VOC.ship_traits(_id)
    end

    fetch(VOC.ship_effect_id).proc = Proc.new do |_id|
      self[VOC.ship_effect_name] = VOC.effects(_id)
    end
  end

end	# class CrewMember

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
