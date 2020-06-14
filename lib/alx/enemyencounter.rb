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
    @file    = ''
    @enemies = []

    members << StrDmy.new(VOC.filter               , ''        )
    members << IntVar.new(VOC.initiative           ,  0, :uint8)
    members << IntVar.new(VOC.magic_exp            ,  0, :uint8)

    (0...8).each do |_i|
      members << IntVar.new(VOC.enemy_id[_i]       ,  0, :uint8)
      members << StrDmy.new(VOC.enemy_name_jp[_i]  , ''        )
      
      if us?
        members << StrDmy.new(VOC.enemy_name_us[_i], ''        )
      elsif eu?
        members << StrDmy.new(VOC.enemy_name_eu[_i], ''        )
      end
    end
  end

  # Checks the entry with a snapshot. Assigns +true+ to #expired if the entry 
  # differs from the snapshot, otherwise nothing happens. Returns +true+ if 
  # the entry matches the snapshot, otherwise +false+.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if entry matches the snapshot, otherwise +false+.
  def check_expiration(_entry)
    _found   = true
    _found &&= _entry.is_a?(EnemyEncounter)
    _found &&= (id    == _entry.id  )
    _found &&= (@file == _entry.file)

    if _found
      super
    end
    
    _found
  end

  # Reads one entry from a CSV  file.
  # @param _csv [CSV] CSV object
  def read_csv(_csv)
    super
    @file = find_member(VOC.filter).value
  end
  
  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_csv(_csv)
    find_member(VOC.filter).value = @file
    
    (0...8).each do |_i|
      _id = find_member(VOC.enemy_id[_i]).value
      if _id != 255
        _entry = @enemies.find { |_enemy| _enemy.id == _id }
        if _entry
          _name_jp  = _entry.find_member(VOC.name_str['JP']).value
          _name_voc = voc(:enemies, _id.to_s) || '???'
        else
          _name_jp  = '???'
          _name_voc = '???'
        end
      else
        _name_jp  = 'None'
        _name_voc = 'None'
      end
      find_member(VOC.enemy_name_jp[_i]).value = _name_jp
      if us?
        find_member(VOC.enemy_name_us[_i]).value = _name_voc
      elsif eu?
        find_member(VOC.enemy_name_eu[_i]).value = _name_voc
      end
    end

    super
  end

  # Provides marshalling support for use by the Marshal library.
  # @param _hash [Hash] Hash object
  def marshal_load(_hash)
    _hash.each do |_key, _value|
      instance_variable_set(_key, _value)
    end
    @enemies = []
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash         = super
    _hash[:@file] = @file
    _hash
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :enemies
  attr_accessor :file

end	# class EnemyEncounter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
