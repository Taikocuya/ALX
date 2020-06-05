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

# Class to handle a playable ship.
class PlayableShip < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a PlayableShip.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @ship_cannons     = {}
    @ship_accessories = {}
    add_name_members(20)

    members << IntVar.new(VOC.maxhp                    ,  0, :uint32)
    
    if product_id != '6107110 06' && product_id != '6107810'
      members << IntVar.new(VOC.maxspirit[-1]          ,  0, :int16 )
      members << IntVar.new(VOC.spirit[-1]             ,  0, :int16 )
    end
    
    members << IntVar.new(VOC.defense                  ,  0, :int16 )
    members << IntVar.new(VOC.magdef                   ,  0, :int16 )
    members << IntVar.new(VOC.quick                    ,  0, :int16 )
    
    if product_id != '6107110 06' && product_id != '6107810'
      members << IntVar.new(VOC.dodge                  ,  0, :int16 )
    end
    
    (0...6).each do |_i|
      members << IntVar.new(VOC.elements[_i]           ,  0, :int16 )
    end

    _size = product_id == '6107110 06' || product_id == '6107810' ? 4 : 5
    (0..._size).each do |_i|
      members << IntVar.new(VOC.ship_cannon_id[_i]     , -1, :int16 )
      members << StrDmy.new(VOC.ship_cannon_name[_i]   , ''         )
    end
    
    (0...3).each do |_i|
      members << IntVar.new(VOC.ship_accessory_id[_i]  , -1, :int16 )
      members << StrDmy.new(VOC.ship_accessory_name[_i], ''         )
    end

    if product_id != '6107110 06' && product_id != '6107810'
      members << IntVar.new(VOC.value                ,  0, :uint32)
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(VOC.base_hp_increase     ,  0, :int32 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(VOC.base_defense_increase,  0, :int16 )
      members << IntVar.new(VOC.base_magdef_increase ,  0, :int16 )
      members << IntVar.new(VOC.base_quick_increase  ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
      members << IntVar.new(padding_hdr              ,  0, :int16 )
    end
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _size = product_id == '6107110 06' || product_id == '6107810' ? 4 : 5
    (0..._size).each do |_i|
      _id = find_member(VOC.ship_cannon_id[_i]).value
      if _id != -1
        _entry = @ship_cannons[_id]
        _name  = '???'
        if _entry
          if jp? || us?
            _name = _entry.find_member(VOC.name_str[country_id]).value
          elsif eu?
            _name = _entry.find_member(VOC.name_str['GB']).value
          end
        end
      else
        _name = 'None'
      end
      find_member(VOC.ship_cannon_name[_i]).value = _name
    end

    (0...3).each do |_i|
      _id = find_member(VOC.ship_accessory_id[_i]).value
      if _id != -1
        _entry = @ship_accessories[_id]
        _name  = '???'
        if _entry
          if jp? || us?
            _name = _entry.find_member(VOC.name_str[country_id]).value
          elsif eu?
            _name = _entry.find_member(VOC.name_str['GB']).value
          end
        end
      else
        _name = 'None'
      end
      find_member(VOC.ship_accessory_name[_i]).value = _name
    end

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :ship_cannons
  attr_accessor :ship_accessories

end	# class PlayableShip

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
