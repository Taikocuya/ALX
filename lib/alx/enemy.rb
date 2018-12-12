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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy.
class Enemy < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Enemy.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @files        = []
    @items        = {}
    
    members << StrDmy.new(VOC.filter                , ''      )
    members << StrVar.new(VOC.name_str['JP']        , '',   21)
    members << StrDmy.new(VOC.enemy_name_us[-1]     , ''      )
    members << StrDmy.new(VOC.enemy_name_eu[-1]     , ''      )
    members << IntVar.new(VOC.width                 ,  0, 'c' )
    members << IntVar.new(VOC.depth                 ,  0, 'c' )
    members << IntVar.new(VOC.element_id            ,  0, 'c' )
    members << StrDmy.new(VOC.element_name          , ''      )
    members << IntVar.new(padding_hdr               , -1, 'c' )
    members << IntVar.new(padding_hdr               , -1, 'c' )
    members << IntVar.new(VOC.movement_flags        ,  0, 's>')
    members << IntVar.new(VOC.counter               ,  0, 's>')
    members << IntVar.new(VOC.exp[-1]               ,  0, 'S>')
    members << IntVar.new(VOC.gold                  ,  0, 'S>')
    members << IntVar.new(padding_hdr               , -1, 'c' )
    members << IntVar.new(padding_hdr               , -1, 'c' )
    members << IntVar.new(VOC.maxhp                 ,  0, 'l>')
    members << FltVar.new(unknown_hdr               ,  0, 'g' )

    (0...6).each do |_i|
      members << IntVar.new(VOC.elements[_i]        ,  0, 's>')
    end

    (0...9).each do |_i|
      members << IntVar.new(VOC.states[_i]          ,  0, 's>')
    end

    members << IntVar.new(unknown_hdr               ,  0, 's>')
    members << IntVar.new(unknown_hdr               ,  0, 's>')
    members << IntVar.new(unknown_hdr               ,  0, 's>')
    members << IntVar.new(unknown_hdr               ,  0, 's>')
    members << IntVar.new(unknown_hdr               ,  0, 's>')
    members << IntVar.new(unknown_hdr               ,  0, 's>')
    members << IntVar.new(unknown_hdr               ,  0, 's>')
    members << IntVar.new(VOC.effect_id             , -1, 'c' )
    members << StrDmy.new(VOC.effect_name           , ''      )
    members << IntVar.new(VOC.state_id              ,  0, 'c' )
    members << StrDmy.new(VOC.state_name            , ''      )
    members << IntVar.new(VOC.state_hit             ,  0, 'c' )
    members << IntVar.new(padding_hdr               , -1, 'c' )
    members << IntVar.new(VOC.level                 ,  0, 's>')
    members << IntVar.new(VOC.will                  ,  0, 's>')
    members << IntVar.new(VOC.vigor                 ,  0, 's>')
    members << IntVar.new(VOC.agile                 ,  0, 's>')
    members << IntVar.new(VOC.quick                 ,  0, 's>')
    members << IntVar.new(VOC.attack                ,  0, 's>')
    members << IntVar.new(VOC.defense               ,  0, 's>')
    members << IntVar.new(VOC.magdef                ,  0, 's>')
    members << IntVar.new(VOC.hit                   ,  0, 's>')
    members << IntVar.new(VOC.dodge                 ,  0, 's>')
    members << IntVar.new(padding_hdr               , -1, 'c' )
    members << IntVar.new(padding_hdr               , -1, 'c' )

    (0...4).each do |_i|
      members << IntVar.new(VOC.item_probability[_i], -1, 's>')
      members << IntVar.new(VOC.item_amount[_i]     , -1, 's>')
      members << IntVar.new(VOC.item_id[_i]         , -1, 's>')
      members << StrDmy.new(VOC.item_name[_i]       , ''      )
    end
  end

  # Reads one entry from a CSV  file.
  # @param _csv [CSV] CSV object
  def read_from_csv(_csv)
    super
    @files = find_member(VOC.filter).value.split(';')
  end
  
  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_to_csv(_csv)
    find_member(VOC.filter).value            = @files.join(';')
    find_member(VOC.enemy_name_us[-1]).value = VOC.enemies_us[id]
    find_member(VOC.enemy_name_eu[-1]).value = VOC.enemies_eu[id]
    
    _id = find_member(VOC.element_id).value
    find_member(VOC.element_name).value = VOC.elements[_id]

    _id = find_member(VOC.effect_id).value
    find_member(VOC.effect_name).value = VOC.effects[_id]
    
    _id = find_member(VOC.state_id).value
    find_member(VOC.state_name).value = VOC.states[_id]
    
    (0...4).each do |_i|
      _id = find_member(VOC.item_id[_i]).value
      if _id != -1
        _entry = @items[_id]
        _name  = '???'
        if _entry
          case region
          when 'E', 'J'
            _name = _entry.find_member(VOC.name_str[country]).value
          when 'P'
            _name = _entry.find_member(VOC.name_str['GB']   ).value
          end
        end
      else
        _name = 'None'
      end
      find_member(VOC.item_name[_i]).value = _name
    end

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :files
  attr_accessor :items
  
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
