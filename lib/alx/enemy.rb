#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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

require_relative('effectable.rb')
require_relative('entry.rb')
require_relative('translatable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy.
class Enemy < Entry

#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)
  include(Translatable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Instruction type IDs
  INST_TYPES = Hash.new('???')
  INST_TYPES.store(-1, 'None'    )
  INST_TYPES.store( 0, 'Strategy')
  INST_TYPES.store( 1, 'Action'  )
  
  # Basic action IDs
  BASIC_ACTIONS = Hash.new('???')
  BASIC_ACTIONS.store(550, 'Attack')
  BASIC_ACTIONS.store(551, 'Guard' )
  BASIC_ACTIONS.store(552, 'Run'   )
  
  # Action target IDs
  ACTION_TARGETS = Hash.new('???')
  ACTION_TARGETS.store(-1, 'None')
  ACTION_TARGETS.store( 1, 'Common character')
  ACTION_TARGETS.store( 2, 'Random character')
  ACTION_TARGETS.store( 3, 'Character with most HP')
  ACTION_TARGETS.store( 4, 'Character with least HP')
  ACTION_TARGETS.store( 5, 'Random enemy')
  ACTION_TARGETS.store( 6, 'Common enemy')
  ACTION_TARGETS.store( 7, 'Injured enemy')
  ACTION_TARGETS.store( 8, 'Enemy with highest ID')
  ACTION_TARGETS.store(11, 'Enemy without Strengthen')
  ACTION_TARGETS.store(12, 'Injured enemy but not self')
  ACTION_TARGETS.store(13, 'Character without Stone')
  ACTION_TARGETS.store(14, 'Character without Confusion')
  ACTION_TARGETS.store(15, 'Character without Silence')
  ACTION_TARGETS.store(16, 'Character without Sleep')
  ACTION_TARGETS.store(17, 'Character without Weak')
  ACTION_TARGETS.store(18, 'Character without Fatigue')
  ACTION_TARGETS.store(19, 'Character without Poison')
  ACTION_TARGETS.store(20, 'Character with highest Will')
  ACTION_TARGETS.store(21, 'Character with highest Attack')
  ACTION_TARGETS.store(22, 'Self as target')
  ACTION_TARGETS.store(23, 'Aika as target')

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Enemy.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @items       = {}
    @magics      = {}
    @super_moves = {}
    @files       = []
    
    members << StrDmy.new(CsvHdr::FILTER                , ''      )
    members << StrVar.new(CsvHdr::NAME_JP_STR           , '',   21)
    members << StrDmy.new(CsvHdr::ENEMY_NAME_US[0]      , ''      )
    members << StrDmy.new(CsvHdr::ENEMY_NAME_EU[0]      , ''      )
    members << IntVar.new(CsvHdr::ENEMY_WIDTH           ,  0, 'c' )
    members << IntVar.new(CsvHdr::ENEMY_HEIGHT          ,  0, 'c' )
    members << IntVar.new(CsvHdr::ELEMENT_ID            ,  0, 'c' )
    members << StrDmy.new(CsvHdr::ELEMENT_NAME          , ''      )
    members << IntVar.new(padding_hdr                   , -1, 'c' )
    members << IntVar.new(padding_hdr                   , -1, 'c' )
    members << IntVar.new(CsvHdr::MOVEMENT_FLAGS        ,  0, 's>')
    members << IntVar.new(CsvHdr::COUNTER               ,  0, 's>')
    members << IntVar.new(CsvHdr::EXP[0]                ,  0, 'S>')
    members << IntVar.new(CsvHdr::GOLD                  ,  0, 'S>')
    members << IntVar.new(padding_hdr                   , -1, 'c' )
    members << IntVar.new(padding_hdr                   , -1, 'c' )
    members << IntVar.new(CsvHdr::MAXHP                 ,  0, 'l>')
    members << FltVar.new(unknown_hdr                   ,  0, 'g' )

    (0...6).each do |_i|
      members << IntVar.new(ELEMENTS[_i]                ,  0, 's>')
    end

    (0...9).each do |_i|
      members << IntVar.new(STATES[_i]                  ,  0, 's>')
    end

    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(unknown_hdr                   ,  0, 's>')
    members << IntVar.new(CsvHdr::EFFECT_ID             , -1, 'c' )
    members << StrDmy.new(CsvHdr::EFFECT_NAME           , ''      )
    members << IntVar.new(CsvHdr::STATE_ID              ,  0, 'c' )
    members << StrDmy.new(CsvHdr::STATE_NAME            , ''      )
    members << IntVar.new(CsvHdr::STATE_HIT             ,  0, 'c' )
    members << IntVar.new(padding_hdr                   , -1, 'c' )
    members << IntVar.new(CsvHdr::LEVEL                 ,  0, 's>')
    members << IntVar.new(CsvHdr::WILL                  ,  0, 's>')
    members << IntVar.new(CsvHdr::VIGOR                 ,  0, 's>')
    members << IntVar.new(CsvHdr::AGILE                 ,  0, 's>')
    members << IntVar.new(CsvHdr::QUICK                 ,  0, 's>')
    members << IntVar.new(CsvHdr::ATTACK                ,  0, 's>')
    members << IntVar.new(CsvHdr::DEFENSE               ,  0, 's>')
    members << IntVar.new(CsvHdr::MAGDEF                ,  0, 's>')
    members << IntVar.new(CsvHdr::HIT                   ,  0, 's>')
    members << IntVar.new(CsvHdr::DODGE                 ,  0, 's>')
    members << IntVar.new(padding_hdr                   , -1, 'c' )
    members << IntVar.new(padding_hdr                   , -1, 'c' )

    (1..4).each do |_i|
      members << IntVar.new(CsvHdr::ITEM_PROBABILITY[_i], -1, 's>')
      members << IntVar.new(CsvHdr::ITEM_AMOUNT[_i]     , -1, 's>')
      members << IntVar.new(CsvHdr::ITEM_ID[_i]         , -1, 's>')
      members << StrDmy.new(CsvHdr::ITEM_NAME[_i]       , ''      )
    end

    (1..64).each do |_i|
      members << IntVar.new(CsvHdr::INST_TYPE_ID[_i]    , -1, 's>')
      members << StrDmy.new(CsvHdr::INST_TYPE_NAME[_i]  , ''      )
      members << IntVar.new(CsvHdr::INST_ID[_i]         , -1, 's>')
      members << StrDmy.new(CsvHdr::INST_NAME[_i]       , ''      )
      members << IntVar.new(CsvHdr::INST_PARAM_ID[_i]   , -1, 's>')
      members << StrDmy.new(CsvHdr::INST_PARAM_NAME[_i] , ''      )
    end

    members << IntVar.new(padding_hdr                   ,  0, 's>')
  end

  # Reads one entry from a CSV  file.
  # @param _f [CSV] CSV object
  def read_from_csv(_f)
    super
    @files = find_member(CsvHdr::FILTER).value.split(';')
  end
  
  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    find_member(CsvHdr::FILTER).value           = @files.join(';')
    find_member(CsvHdr::ENEMY_NAME_US[0]).value = ENEMY_US_LIST[id]
    find_member(CsvHdr::ENEMY_NAME_EU[0]).value = ENEMY_EU_LIST[id]
    
    _id = find_member(CsvHdr::ELEMENT_ID).value
    find_member(CsvHdr::ELEMENT_NAME).value = ELEMENTS[_id]

    _id = find_member(CsvHdr::EFFECT_ID).value
    find_member(CsvHdr::EFFECT_NAME).value = EFFECTS[_id]
    
    _id = find_member(CsvHdr::STATE_ID).value
    find_member(CsvHdr::STATE_NAME).value = STATES[_id]
    
    (1..4).each do |_i|
      _id = find_member(CsvHdr::ITEM_ID[_i]).value
      if _id != -1
        _entry = @items[_id]
        _name  = '???'
        if _entry
          case region
          when 'E'
            _name = _entry.find_member(CsvHdr::NAME_US_STR).value
          when 'J'
            _name = _entry.find_member(CsvHdr::NAME_JP_STR).value
          when 'P'
            _name = _entry.find_member(CsvHdr::NAME_GB_STR).value
          end
        end
      else
        _name = 'None'
      end
      find_member(CsvHdr::ITEM_NAME[_i]).value = _name
    end
    
    (1..64).each do |_i|
      _type_id    = find_member(CsvHdr::INST_TYPE_ID[_i] ).value
      _inst_id    = find_member(CsvHdr::INST_ID[_i]      ).value
      _param_id   = find_member(CsvHdr::INST_PARAM_ID[_i]).value
      _type_name  = INST_TYPES[_type_id]
      _inst_name  = _inst_id  != -1 ? '???' : 'None'
      _param_name = _param_id != -1 ? '???' : 'None'

      if _type_id == 1
        # Action
        _entry = nil
        if _inst_id >= 550
          _inst_name = BASIC_ACTIONS[_inst_id]
        elsif _inst_id >= 500
          _entry = @magics[_inst_id - 500]
        elsif _inst_id >= 0
          _entry = @super_moves[_inst_id]
        end
        if _entry
          case region
          when 'E'
            _inst_name = _entry.find_member(CsvHdr::NAME_US_STR).value
          when 'J'
            _inst_name = _entry.find_member(CsvHdr::NAME_JP_STR).value
          when 'P'
            _inst_name = _entry.find_member(CsvHdr::NAME_GB_STR).value
          end
        end

        # Action target
        _param_name = ACTION_TARGETS[_param_id]
      end

      find_member(CsvHdr::INST_TYPE_NAME[_i] ).value = _type_name
      find_member(CsvHdr::INST_NAME[_i]      ).value = _inst_name
      find_member(CsvHdr::INST_PARAM_NAME[_i]).value  = _param_name
    end

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :items
  attr_accessor :magics
  attr_accessor :super_moves
  attr_accessor :files
  
  def order
    _order = 0xff
    
    @files.each do |_filename|
      case File.extname(_filename)
      when '.enp', '*'
        _order = [_order, 0].min
      when '.evp'
        _order = [_order, 1].min
      when '.dat'
        _order = [_order, 2].min
      end
    end
    
    _order
  end

end	# class Enemy

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
