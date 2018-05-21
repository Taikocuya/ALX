#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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
require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a character.
class Character < StdEntry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Character.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @weapons     = {}
    @armors      = {}
    @accessories = {}

    case region
    when 'E'
      members << StrVar.new(CsvHdr::NAME_US_STR   , '',   11)
    when 'J'
      members << StrVar.new(CsvHdr::NAME_JP_STR   , '',   11)
    when 'P'
      members << StrVar.new(CsvHdr::NAME_EU_STR   , '',   11)
    end

    members << IntVar.new(CsvHdr::AGE             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(unknown_hdr             ,  0, 'c' )
    members << IntVar.new(CsvHdr::MAXMP           ,  0, 'c' )
    members << IntVar.new(CsvHdr::ELEMENT_ID      ,  0, 'c' )
    members << StrDmy.new(CsvHdr::ELEMENT_NAME    , ''      )
    members << IntVar.new(padding_hdr             ,  0, 'c' )
    members << IntVar.new(padding_hdr             ,  0, 'c' )
    members << IntVar.new(CsvHdr::WEAPON_ID       ,  0, 'C' )
    members << StrDmy.new(CsvHdr::WEAPON_NAME     , ''      )
    members << IntVar.new(CsvHdr::ARMOR_ID        ,  0, 'S>')
    members << StrDmy.new(CsvHdr::ARMOR_NAME      , ''      )
    members << IntVar.new(CsvHdr::ACCESSORY_ID    ,  0, 'S>')
    members << StrDmy.new(CsvHdr::ACCESSORY_NAME  , ''      )
    members << IntVar.new(unknown_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::HP              ,  0, 's>')
    members << IntVar.new(CsvHdr::MAXHP           ,  0, 's>')
    members << IntVar.new(CsvHdr::BASE_HP_INCREASE,  0, 's>')
    members << IntVar.new(CsvHdr::SPIRIT          ,  0, 's>')
    members << IntVar.new(CsvHdr::MAXSPIRIT       ,  0, 's>')
    members << IntVar.new(CsvHdr::COUNTER         ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::EXP[0]          ,  0, 'S>')
    members << FltVar.new(unknown_hdr             ,  0, 'g' )
    members << FltVar.new(unknown_hdr             ,  0, 'g' )
    
    (0...6).each do |_i|
      members << IntVar.new(ELEMENTS[_i]          ,  0, 's>')
    end

    (0...9).each do |_i|
      members << IntVar.new(STATES[_i]            ,  0, 's>')
    end
    
    (9...16).each do |_i|
      members << IntVar.new(unknown_hdr           ,  0, 's>')
    end

    members << IntVar.new(CsvHdr::POWER           ,  0, 's>')
    members << IntVar.new(CsvHdr::WILL            ,  0, 's>')
    members << IntVar.new(CsvHdr::VIGOR           ,  0, 's>')
    members << IntVar.new(CsvHdr::AGILE           ,  0, 's>')
    members << IntVar.new(CsvHdr::QUICK           ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << FltVar.new(unknown_hdr             ,  0, 'g' )
    members << FltVar.new(unknown_hdr             ,  0, 'g' )
    members << FltVar.new(unknown_hdr             ,  0, 'g' )
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << FltVar.new(unknown_hdr             ,  0, 'g' )
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::GREEN_EXP[0]    ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::RED_EXP[0]      ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::PURPLE_EXP[0]   ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::BLUE_EXP[0]     ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::YELLOW_EXP[0]   ,  0, 's>')
    members << IntVar.new(padding_hdr             ,  0, 's>')
    members << IntVar.new(CsvHdr::SILVER_EXP[0]   ,  0, 's>')
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _id = find_member(CsvHdr::ELEMENT_ID).value
    find_member(CsvHdr::ELEMENT_NAME).value = ELEMENTS[_id]
    
    _id = find_member(CsvHdr::WEAPON_ID).value
    if _id != -1
      _entry = @weapons[_id]
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
    find_member(CsvHdr::WEAPON_NAME).value = _name

    _id = find_member(CsvHdr::ARMOR_ID).value
    if _id != -1
      _entry = @armors[_id]
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
    find_member(CsvHdr::ARMOR_NAME).value = _name

    _id = find_member(CsvHdr::ACCESSORY_ID).value
    if _id != -1
      _entry = @accessories[_id]
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
    find_member(CsvHdr::ACCESSORY_NAME).value = _name

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :weapons
  attr_accessor :armors
  attr_accessor :accessories

end	# class Character

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
