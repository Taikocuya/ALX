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

    case region
    when 'E'
      members << StrDmy.new(CsvHdr::NAME_US_STR   , ''      )
    when 'J'
      members << StrDmy.new(CsvHdr::NAME_JP_STR   , ''      )
    when 'P'
      members << StrDmy.new(CsvHdr::NAME_EU_STR   , ''      )
    end
      
    (1..6).each do |_i|
      members << IntVar.new(CsvHdr::GREEN_EXP[_i] ,  0, 'S>')
    end
    (1..6).each do |_i|
      members << IntVar.new(CsvHdr::RED_EXP[_i]   ,  0, 'S>')
    end
    (1..6).each do |_i|
      members << IntVar.new(CsvHdr::PURPLE_EXP[_i],  0, 'S>')
    end
    (1..6).each do |_i|
      members << IntVar.new(CsvHdr::BLUE_EXP[_i]  ,  0, 'S>')
    end
    (1..6).each do |_i|
      members << IntVar.new(CsvHdr::YELLOW_EXP[_i],  0, 'S>')
    end
    (1..6).each do |_i|
      members << IntVar.new(CsvHdr::SILVER_EXP[_i],  0, 'S>')
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
        _name = _chara.find_member(CsvHdr::NAME_US_STR).value
      when 'J'
        _name = _chara.find_member(CsvHdr::NAME_JP_STR).value
      when 'P'
        _name = _chara.find_member(CsvHdr::NAME_EU_STR).value
      end
    end
    case region
    when 'E'
      find_member(CsvHdr::NAME_US_STR).value = _name
    when 'J'
      find_member(CsvHdr::NAME_JP_STR).value = _name
    when 'P'
      find_member(CsvHdr::NAME_EU_STR).value = _name
    end

    super
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :characters

end	# class MagicExpCurve

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
