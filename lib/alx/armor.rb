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

# Class to handle an armor.
class Armor < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Armor.
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

    self[VOC.character_flags] = IntProp.new(:u8, 0, base: 16)

    VOC.characters.each_value do |_name|
      self[VOC.character_opt[_name.chr]] = StrProp.new(nil, '', dmy: true)
    end

    self[VOC.retail_price  ] = IntProp.new(:i8,  0)
    self[VOC.order_prio    ] = IntProp.new(:i8, -1)
    self[VOC.order_abc[cid]] = IntProp.new(:i8, -1)
    
    if jp? || us?
      self[padding_hdr] = IntProp.new(:i8, 0)
    end

    self[VOC.purchase_price] = IntProp.new(:u16, 0)
    
    (1..4).each do |_i|
      self[VOC.feature_id[_i]   ] = IntProp.new( :i8,  0           )
      self[VOC.feature_name[_i] ] = StrProp.new( nil, '', dmy: true)
      self[padding_hdr          ] = IntProp.new( :i8,  0           )
      self[VOC.feature_value[_i]] = IntProp.new(:i16,  0           )
    end

    if eu?
      self[padding_hdr] = IntProp.new(:i8, 0)
      self[padding_hdr] = IntProp.new(:i8, 0)
    end

    add_dscr_props
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.character_flags).proc = Proc.new do |_flags|
      VOC.characters.each do |_id, _name|
        _key       = VOC.character_opt[_name.chr]
        self[_key] = (_flags & (0x20 >> _id) != 0) ? 'X' : ''
      end
    end
    
    (1..4).each do |_i|
      fetch(VOC.feature_id[_i]).proc = Proc.new do |_id|
        self[VOC.feature_name[_i]] = VOC.accessory_features[_id]
      end
    end
  end

end	# class Armor

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
