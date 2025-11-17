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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an character animation.
class CharacterAnimation < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader   :characters
  attr_reader   :items
  attr_reader   :magics
  attr_reader   :super_moves

  def characters=(_characters)
    @characters = _characters || {}
    
    fetch(VOC.filter)&.call_proc
  end

  def character_id
    self[VOC.character_ref] || -1
  end

  def character_id=(_character_id)
    self[VOC.character_ref] = _character_id
  end
  
  def file
    self[VOC.filter]
  end

  def file=(_file)
    self[VOC.filter] = _file
  end

  def items=(_items)
    @items = _items || {}
    
    fetch(VOC.filter)&.call_proc
  end
  
  def magics=(_magics)
    @magics = _magics || {}
  end
  
  def super_moves=(_super_moves)
    @super_moves = _super_moves || {}
  end
  
#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @characters  ||= {}
    @items       ||= {}
    @magics      ||= {}
    @super_moves ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    super

    self[VOC.filter             ] = StrProp.new( nil, '', ext: true)
    self[VOC.character_ref      ] = IntProp.new(:u32, -1, dmy: true)
    self[VOC.character_name(nil)] = StrProp.new( nil, '', dmy: true)

    self[VOC.state_id       ] = IntProp.new(:i16,    -1                    )
    self[VOC.state_name     ] = StrProp.new( nil, '???', dmy: true         )
    self[unknown_hdr        ] = IntProp.new(:i16,     0                    )
    self[unknown_hdr        ] = IntProp.new(:i16,     0                    )
    self[VOC.motion_id      ] = IntProp.new(:i16,    -1                    )
    self[VOC.motion_name    ] = StrProp.new( nil, '???', dmy: true         )
    self[VOC.motion_flags   ] = IntProp.new(:u32 ,    0, base: 2, width: 34)
    self[VOC.param_id(nil)  ] = IntProp.new(:i16,    -1                    )
    self[VOC.param_name(nil)] = StrProp.new( nil, '???', dmy: true         )
    self[unknown_hdr        ] = IntProp.new(:i16,     0                    )

    self[VOC.blend_time] = FltProp.new(:f32, 0.0, prec: 2)
    self[VOC.play_rate ] = FltProp.new(:f32, 0.0, prec: 2)
  end
  
  # Initialize the entry procs.
  def init_procs
    super
    
    fetch(VOC.filter).proc = Proc.new do |_filter|
      _id = _filter[/\d{3}/]
      if _id
        _id = _id.to_i
      else
        _id = -1
      end
      self[VOC.character_ref] = _id

      _entry = @characters[_id]
      _name  = '???'
      if _entry
        _name = _entry[VOC.name_str(cid)]
      elsif _id >= 10
        _item = @items[_id - 10 + 32]
        _name  = '???'
        if _item
          if jp? || us?
            _name = _item[VOC.name_str(cid)]
          elsif eu?
            _name = _item[VOC.name_opt(gb)]
          end
        end
      end
      self[VOC.character_name(nil)] = _name
    end
    
    fetch(VOC.state_id).proc = Proc.new do |_id|
      self[VOC.state_name] = VOC.anim_states(_id)
    end
    
    fetch(VOC.motion_id).proc = Proc.new do |_id|
      if _id >= 23 && _id <= 58
        _entry = @magics[_id - 23]
        if _entry
          if jp? || us?
            _name = _entry[VOC.name_str(cid)]
          elsif eu?
            _name = _entry[VOC.name_opt(gb)]
          end
        end
      else
        _name = VOC.anim_motions(_id)
      end
      self[VOC.motion_name] = _name
    end
    
    fetch(VOC.param_id(nil)).proc = Proc.new do |_param_id|
      _state_id = self[VOC.state_id]
      _name     = (_param_id != -1) ? '???' : 'None'
      
      case _state_id
      # Magic & S-Move
      when 24
        _entry = @magics[_param_id] || @super_moves[_param_id]
        if _entry
          if jp? || us?
            _name = _entry[VOC.name_str(cid)]
          elsif eu?
            _name = _entry[VOC.name_opt(gb)]
          end
        end
      end

      self[VOC.param_name(nil)] = _name
    end
  end

end # class CharacterAnimation

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
