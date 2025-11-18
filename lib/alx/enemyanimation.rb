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

# Class to handle an enemy animation.
class EnemyAnimation < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader   :enemies
  attr_reader   :magics
  attr_reader   :super_moves

  def enemies=(_enemies)
    @enemies = _enemies || []
    
    fetch(VOC.filter)&.call_proc
  end

  def enemy_id
    self[VOC.enemy_ref] || -1
  end

  def enemy_id=(_enemy_id)
    self[VOC.enemy_ref] = _enemy_id
  end
  
  def file
    self[VOC.filter]
  end

  def file=(_file)
    self[VOC.filter] = _file
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
    @enemies     ||= []
    @magics      ||= {}
    @super_moves ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    super

    self[VOC.filter             ] = StrProp.new( nil, '', ext: true)
    self[VOC.enemy_ref          ] = IntProp.new(:u32, -1, dmy: true)
    self[VOC.enemy_name(nil, jp)] = StrProp.new( nil, '', dmy: true)
    
    if us? || eu?
      self[VOC.enemy_name(nil, cid)] = StrProp.new(nil, '', dmy: true)
    end

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
      _mg_pattern = File.basename(cfg(:mg_std_file)).sub('*', '\d{3}')
      _is_boss    = !!(Regexp.new(_mg_pattern) =~ _filter)

      _id = _filter[/\d{3}/]
      if _id
        _id = _id.to_i
        if _is_boss
          _id += 0x80
        end
      else
        _id = -1
      end
      self[VOC.enemy_ref] = _id

      _entry = @enemies.find { |_entry| _entry.id == _id }
      if _entry
        _name_jp  = _entry[VOC.name_str(jp )]
        _name_opt = _entry[VOC.name_opt(cid)]
      else
        _name_jp  = '???'
        _name_opt = '???'
      end
      self[VOC.enemy_name(nil, 'JP')] = _name_jp
      if us? || eu?
        self[VOC.enemy_name(nil, cid)] = _name_opt
      end
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
      # Magic
      when 24
        _entry = @magics[_param_id]
        if _entry
          if jp? || us?
            _name = _entry[VOC.name_str(cid)]
          elsif eu?
            _name = _entry[VOC.name_opt(gb)]
          end
        end
      # S-Move
      when 29
        _entry = @super_moves[_param_id]
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

end # class EnemyAnimation

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
