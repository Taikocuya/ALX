#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2021 Marcel Renner
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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a script version.
class ScriptVersion < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ScriptVersion.
  def initialize
    super
    init_props
  end
  
  # Returns +true+ if the script version is valid, otherwise +false+.
  # @return [Boolean] +true+ if script version is valid, otherwise +false+.
  def valid?
    _result = true
    
    begin
      _result &&= !!Time.new(self[VOC.year], self[VOC.month], self[VOC.day])
    rescue ArgumentError
      result = false
    end
    
    _result &&= self[VOC.version] >= 0
    _result
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  def file
    self[VOC.filter]
  end

  def file=(_file)
    self[VOC.filter] = _file
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    self[VOC.filter ] = StrProp.new( nil, '', ext: true)
    self[VOC.year   ] = IntProp.new(:i16, -1           )
    self[VOC.month  ] = IntProp.new(:i16, -1           )
    self[VOC.day    ] = IntProp.new(:i16, -1           )
    self[VOC.version] = IntProp.new(:i16, -1           )
  end

end	# class ScriptVersion

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
