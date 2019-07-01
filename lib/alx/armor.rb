#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
    add_name_members

    members << IntVar.new(VOC.character_flags           ,  0, :int8  )
    VOC.characters.each_value do |_chara|
      members << StrDmy.new(VOC.character_opt[_chara]   , ''         )
    end
    
    members << IntVar.new(VOC.retail_price              ,  0, :int8  )
    members << IntVar.new(VOC.order_priority            , -1, :int8  )
    members << IntVar.new(VOC.order_alphabet[country_id], -1, :int8  )
    
    if jp? || us?
      members << IntVar.new(padding_hdr                 ,  0, :int8  )
    end

    members << IntVar.new(VOC.purchase_price            ,  0, :uint16)
    
    (0...4).each do |_i|
      members << IntVar.new(VOC.feature_id[_i]          , -1, :int8  )
      members << StrDmy.new(VOC.feature_name[_i]        , ''         )
      members << IntVar.new(padding_hdr                 ,  0, :int8  )
      members << IntVar.new(VOC.feature_value[_i]       ,  0, :int16 )
    end

    if eu?
      members << IntVar.new(padding_hdr                 ,  0, :int8  )
      members << IntVar.new(padding_hdr                 ,  0, :int8  )
    end

    add_dscr_members
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _flags = find_member(VOC.character_flags).value
    VOC.characters.each do |_id, _chara|
      _member = VOC.character_opt[_chara]
      find_member(_member).value = _flags & (0x20 >> _id) != 0 ? 'X' : ''
    end

    (0...4).each do |_i|
      _id = find_member(VOC.feature_id[_i]).value
      find_member(VOC.feature_name[_i]).value = VOC.accessory_features[_id]
    end

    super
  end

end	# class Armor

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
