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

# Class to handle a playable ship.
class PlayableShip < StdEntry
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Effectable)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a PlayableShip.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @ship_cannon_data    = {}
    @ship_accessory_data = {}
    add_name_members(20)

    members << IntVar.new(padding_hdr                      ,  0, 'c' )
    members << IntVar.new(padding_hdr                      ,  0, 'c' )
    members << IntVar.new(CsvHdr::MAXHP                    ,  0, 'S>')
    members << IntVar.new(CsvHdr::MAXSPIRIT                ,  0, 's>')
    members << IntVar.new(CsvHdr::SPIRIT                   ,  0, 's>')
    members << IntVar.new(CsvHdr::DEFENSE                  ,  0, 's>')
    members << IntVar.new(CsvHdr::MAGDEF                   ,  0, 's>')
    members << IntVar.new(CsvHdr::QUICK                    ,  0, 's>')
    members << IntVar.new(CsvHdr::DODGE                    ,  0, 's>')
    
    (0...6).each do |_i|
      members << IntVar.new(ELEMENTS[_i]                   ,  0, 's>')
    end
    (1..5).each do |_i|
      members << IntVar.new(CsvHdr::SHIP_CANNON_ID[_i]     , -1, 's>')
      members << StrDmy.new(CsvHdr::SHIP_CANNON_NAME[_i]   , ''      )
    end
    (1..3).each do |_i|
      members << IntVar.new(CsvHdr::SHIP_ACCESSORY_ID[_i]  , -1, 's>')
      members << StrDmy.new(CsvHdr::SHIP_ACCESSORY_NAME[_i], ''      )
    end

    members << IntVar.new(CsvHdr::VALUE                    ,  0, 'L>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(CsvHdr::BASE_HP_INCREASE         ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(unknown_hdr                      ,  0, 's>')
    members << IntVar.new(unknown_hdr                      ,  0, 's>')
    members << IntVar.new(unknown_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
    members << IntVar.new(padding_hdr                      ,  0, 's>')
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    (1..5).each do |_i|
      _id     = find_member(CsvHdr::SHIP_CANNON_ID[_i]).value
      _cannon = @ship_cannon_data[_id]
      if _cannon
        if _id != -1
          case region
          when 'E'
            _name = _cannon.find_member(CsvHdr::NAME_US_STR).value
          when 'J'
            _name = _cannon.find_member(CsvHdr::NAME_JP_STR).value
          when 'P'
            _name = _cannon.find_member(CsvHdr::NAME_GB_STR).value
          end
        else
          _name = 'None'
        end
      else
        _name = '???'
      end
      find_member(CsvHdr::SHIP_CANNON_NAME[_i]).value = _name
    end

    (1..3).each do |_i|
      _id        = find_member(CsvHdr::SHIP_ACCESSORY_ID[_i]).value
      _accessory = @ship_accessory_data[_id]
      if _accessory
        if _id != -1
          case region
          when 'E'
            _name = _accessory.find_member(CsvHdr::NAME_US_STR).value
          when 'J'
            _name = _accessory.find_member(CsvHdr::NAME_JP_STR).value
          when 'P'
            _name = _accessory.find_member(CsvHdr::NAME_GB_STR).value
          end
        else
          _name = 'None'
        end
      else
        _name = '???'
      end
      find_member(CsvHdr::SHIP_ACCESSORY_NAME[_i]).value = _name
    end

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :ship_cannon_data
  attr_accessor :ship_accessory_data

end	# class PlayableShip

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
