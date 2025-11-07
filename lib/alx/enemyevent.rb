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

# Class to handle an enemy event.
class EnemyEvent < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :enemies

  def enemies=(_enemies)
    @enemies = _enemies || []
    
    (1..7).each do |_i|
      fetch(VOC.enemy_id(_i))&.call_proc
    end
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
    super

    self[VOC.magic_exp] = IntProp.new(:u8, 0)
    
    (1..4).each do |_i|
      self[VOC.character_id(_i)  ] = IntProp.new(:i8,  0           )
      self[VOC.character_name(_i)] = StrProp.new(nil, '', dmy: true)
      self[VOC.character_x(_i)   ] = IntProp.new(:i8,  0           )
      self[VOC.character_z(_i)   ] = IntProp.new(:i8,  0           )
    end
    
    (1..7).each do |_i|
      self[VOC.enemy_id(_i)      ] = IntProp.new(:u8,  0           )
      self[VOC.enemy_name(_i, jp)] = StrProp.new(nil, '', dmy: true)
      
      if us? || eu?
        self[VOC.enemy_name(_i, cid)] = StrProp.new(nil, '', dmy: true)
      end
      
      self[VOC.enemy_x(_i)] = IntProp.new(:i8, 0)
      self[VOC.enemy_z(_i)] = IntProp.new(:i8, 0)
    end

    self[VOC.initiative      ] = IntProp.new( :u8,  0           )
    self[VOC.defeat_cond_id  ] = IntProp.new( :i8,  0           )
    self[VOC.defeat_cond_name] = StrProp.new( nil, '', dmy: true)
    self[VOC.escape_cond_id  ] = IntProp.new( :i8,  0           )
    self[VOC.escape_cond_name] = StrProp.new( nil, '', dmy: true)
    self[VOC.bgm_id          ] = IntProp.new(:u32, -1, ext: true)
  end
  
  # Initialize the entry procs.
  def init_procs
    super

    (1..4).each do |_i|
      fetch(VOC.character_id(_i)).proc = Proc.new do |_id|
        _name = (_id != -1) ? VOC.characters(_id) : 'None'
        self[VOC.character_name(_i)] = _name
      end
    end
    
    (1..7).each do |_i|
      fetch(VOC.enemy_id(_i)).proc = Proc.new do |_id|
        if _id != 255
          _entry = @enemies.find { |_enemy| _enemy.id == _id }
          if _entry
            _name_jp  = _entry[VOC.name_str(jp )]
            _name_opt = _entry[VOC.name_opt(cid)]
          else
            _name_jp  = '???'
            _name_opt = '???'
          end
        else
          _name_jp  = 'None'
          _name_opt = 'None'
        end
        self[VOC.enemy_name(_i, jp)] = _name_jp
        if us? || eu?
          self[VOC.enemy_name(_i, cid)] = _name_opt
        end
      end
    end

    fetch(VOC.defeat_cond_id).proc = Proc.new do |_id|
      self[VOC.defeat_cond_name] = VOC.defeats(_id)
    end

    fetch(VOC.escape_cond_id).proc = Proc.new do |_id|
      self[VOC.escape_cond_name] = VOC.escapes(_id)
    end
  end

end # class EnemyEvent

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
