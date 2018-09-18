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

require_relative('stdentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a Magic EXP curve.
class MagicExpCurve < StdEntry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a MagicExpCurve.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @characters = {}

    members << StrDmy.new(VOC.character_name[-1], ''      )
    (0...6).each do |_i|
      members << IntVar.new(VOC.green_exp[_i]   ,  0, 'S>')
    end
    (0...6).each do |_i|
      members << IntVar.new(VOC.red_exp[_i]     ,  0, 'S>')
    end
    (0...6).each do |_i|
      members << IntVar.new(VOC.purple_exp[_i]  ,  0, 'S>')
    end
    (0...6).each do |_i|
      members << IntVar.new(VOC.blue_exp[_i]    ,  0, 'S>')
    end
    (0...6).each do |_i|
      members << IntVar.new(VOC.yellow_exp[_i]  ,  0, 'S>')
    end
    (0...6).each do |_i|
      members << IntVar.new(VOC.silver_exp[_i]  ,  0, 'S>')
    end
  end

  # Writes one entry to a CSV file.
  # @param _f [CSV] CSV object
  def write_to_csv(_f)
    _chara = @characters[id]
    _name  = '???'
    if _chara
      case region
      when 'E'
        _name = _chara.find_member(VOC.name_us_str).value
      when 'J'
        _name = _chara.find_member(VOC.name_jp_str).value
      when 'P'
        _name = _chara.find_member(VOC.name_eu_str).value
      end
    end
    find_member(VOC.character_name[-1]).value = _name

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :characters

end	# class MagicExpCurve

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
