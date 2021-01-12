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

# Class to handle an enemy encounter.
class EnemyEncounter < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Enemy.
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

  attr_reader :enemies

  def enemies=(_enemies)
    @enemies = _enemies || []
    
    (1..8).each do |_i|
      fetch(VOC.enemy_id(_i))&.call_proc
    end
  end
  
  def file
    self[VOC.filter]
  end

  def file=(_file)
    self[VOC.filter] = _file
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
    self[VOC.filter    ] = StrProp.new(nil, '', ext: true)
    self[VOC.initiative] = IntProp.new(:u8,  0           )
    self[VOC.magic_exp ] = IntProp.new(:u8,  0           )

    (1..8).each do |_i|
      self[VOC.enemy_id(_i)      ] = IntProp.new(:u8,  0           )
      self[VOC.enemy_name(_i, jp)] = StrProp.new(nil, '', dmy: true)
      
      if us? || eu?
        self[VOC.enemy_name(_i, cid)] = StrProp.new(nil, '', dmy: true)
      end
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    (1..8).each do |_i|
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
  end

end	# class EnemyEncounter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
