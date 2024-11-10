#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
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
  def initialize
    super
    init_attrs
    init_props
    init_procs
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :characters

  def characters=(_characters)
    @characters = _characters || {}
    fetch(VOC.id)&.call_proc
  end
  
#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @characters ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    self[VOC.character_name(nil)] = StrProp.new(nil, '', dmy: true)
    
    (1..6).each do |_i|
      self[VOC.green_exp(_i) ] = IntProp.new(:u16, 0)
    end
    (1..6).each do |_i|
      self[VOC.red_exp(_i)   ] = IntProp.new(:u16, 0)
    end
    (1..6).each do |_i|
      self[VOC.purple_exp(_i)] = IntProp.new(:u16, 0)
    end
    (1..6).each do |_i|
      self[VOC.blue_exp(_i)  ] = IntProp.new(:u16, 0)
    end
    (1..6).each do |_i|
      self[VOC.yellow_exp(_i)] = IntProp.new(:u16, 0)
    end
    (1..6).each do |_i|
      self[VOC.silver_exp(_i)] = IntProp.new(:u16, 0)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    fetch(VOC.id).proc = Proc.new do |_id|
      _chara = @characters[id]
      _name  = '???'
      if _chara
        _name = _chara[VOC.name_str(cid)]
      end
      self[VOC.character_name(nil)] = _name
    end
  end

end	# class MagicExpCurve

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
