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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy instruction.
class EnemyInstruction < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyShipTask.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    init_attrs
    init_props
    init_procs
  end

  # Compares two entries based on properties. Returns +true+ if all properties 
  # are equal, or +false+ otherwise.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if all properties are equal, otherwise +false+.
  def ==(_entry)
    _result   = true
    _result &&= _entry.is_a?(self.class)
    _result &&= (id       == _entry.id      )
    _result &&= (enemy_id == _entry.enemy_id)
    _result &&= @props.all? do |_k, _p|
      _other = _entry.fetch(_k)
      if _other && _p.is_a?(Prop) && _p.comparable?
        _p.value == _other.value
      else
        true
      end
    end
    
    _result
  end

  # Checks the entry with a snapshot. Assigns +true+ to #expired if the entry 
  # differs from the snapshot, otherwise nothing happens. Returns +true+ if 
  # the entry matches the snapshot, otherwise +false+.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if entry matches the snapshot, otherwise +false+.
  def check_expiration(_entry)
    _found   = true
    _found &&= _entry.is_a?(self.class)
    _found &&= (id       == _entry.id      )
    _found &&= (enemy_id == _entry.enemy_id)
    _found &&= (files    == _entry.files   )

    if _found
      super
    end
    
    _found
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :enemies
  attr_reader :magics
  attr_reader :super_moves

  def enemies=(_enemies)
    @enemies = _enemies
    
    fetch(VOC.instr_enemy_id)&.call_proc
  end
  
  def magics=(_magics)
    @magics = _magics
    
    fetch(VOC.param_id)&.call_proc
  end

  def super_moves=(_super_moves)
    @super_moves = _super_moves
    
    fetch(VOC.param_id)&.call_proc
  end
  
  def files
    self[VOC.filter]
  end
  
  def files=(_files)
    self[VOC.filter] = _files
  end

  def enemy_id
    self[VOC.instr_enemy_id] || -1
  end
  
  def enemy_id=(_enemy_id)
    self[VOC.instr_enemy_id] = _enemy_id
  end

  def group_key
    [enemy_id] + self[VOC.filter]
  end

  def type_id
    self[VOC.type_id] || -1
  end
  
  def type_id=(_type_id)
    self[VOC.type_id] = _type_id
  end

  def order
    _order    = 0xff
    _enp_file = File.basename(sys(:enp_file))
    _evp_file = File.basename(sys(:evp_file))
    _eb_file  = File.basename(sys(:eb_file ))
    _ec_file  = File.basename(sys(:ec_file ))

    self[VOC.filter].each do |_filename|
      _filename = _filename.sub(EnpFile::MULTI_REGEXP, '\1\3')

      if _filename == '*'
        _order = [_order, 0].min
        break
      elsif File.fnmatch?(_enp_file, _filename, File::FNM_CASEFOLD)
        _order = [_order, 0].min
        break
      elsif File.fnmatch?(_evp_file, _filename, File::FNM_CASEFOLD)
        _order = [_order, 1].min
      elsif File.fnmatch?(_eb_file , _filename, File::FNM_CASEFOLD)
        _order = [_order, 2].min
      elsif File.fnmatch?(_ec_file , _filename, File::FNM_CASEFOLD)
        _order = [_order, 2].min
      end
    end
    
    _order
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @enemies     = []
    @magics      = {}
    @super_moves = {}
  end
  
  # Initialize the entry properties.
  def init_props
    self[VOC.filter           ] = AryProp.new(      [], dmy: true)
    self[VOC.instr_enemy_id   ] = IntProp.new(:u32, -1, dmy: true)
    self[VOC.enemy_name_jp[-1]] = StrProp.new( nil, '', dmy: true)
    
    if us?
      self[VOC.enemy_name_us[-1]] = StrProp.new(nil, '', dmy: true)
    elsif eu?
      self[VOC.enemy_name_eu[-1]] = StrProp.new(nil, '', dmy: true)
    end
    
    self[VOC.type_id   ] = IntProp.new(:i16, -1           )
    self[VOC.type_name ] = StrProp.new( nil, '', dmy: true)
    self[VOC.instr_id  ] = IntProp.new(:i16, -1           )
    self[VOC.instr_name] = StrProp.new( nil, '', dmy: true)
    self[VOC.param_id  ] = IntProp.new(:i16, -1           )
    self[VOC.param_name] = StrProp.new( nil, '', dmy: true)
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.instr_enemy_id).proc = Proc.new do |_id|
      _entry = @enemies.find { |_enemy| _enemy.id == _id }
      if _entry
        _name_jp  = _entry[VOC.name_str['JP']]
        _name_voc = voc(:enemies, _id.to_s) || '???'
      else
        _name_jp  = '???'
        _name_voc = '???'
      end
      self[VOC.enemy_name_jp[-1]] = _name_jp
      if us?
        self[VOC.enemy_name_us[-1]] = _name_voc
      elsif eu?
        self[VOC.enemy_name_eu[-1]] = _name_voc
      end
    end
    
    fetch(VOC.type_id).proc = Proc.new do
      fetch(VOC.param_id)&.call_proc
    end
  
    fetch(VOC.instr_id).proc = Proc.new do
      fetch(VOC.param_id)&.call_proc
    end

    fetch(VOC.param_id).proc = Proc.new do |_param_id|
      _type_id    = self[VOC.type_id]
      _instr_id   = self[VOC.instr_id     ]
      _type_name  = VOC.instr_types[_type_id]
      _instr_name = (_instr_id != -1) ? '???' : 'None'
      _param_name = (_param_id != -1) ? '???' : 'None'
      
      case _type_id
      # Branch
      when 0
        _instr_name = VOC.branches[_instr_id]
        _param_name = sprintf(VOC.jump_to, _param_id)
      # Action
      when 1
        # Type
        _entry = nil
        if _instr_id >= 550
          _instr_name = VOC.basic_actions[_instr_id]
        elsif _instr_id >= 500
          _entry = @magics[_instr_id - 500]
        elsif _instr_id >= 0
          _entry = @super_moves[_instr_id]
        end
        if _entry
          if jp? || us?
            _instr_name = _entry[VOC.name_str[cid]]
          elsif eu?
            _instr_name = _entry[VOC.name_str['GB']]
          end
        end
      
        # Target
        _param_name = VOC.action_targets[_param_id]
      end

      self[VOC.type_name ] = _type_name
      self[VOC.instr_name] = _instr_name
      self[VOC.param_name] = _param_name
    end
  end

end	# class EnemyInstruction

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
