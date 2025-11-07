#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

# Class to handle a string table entry.
class StringTableEntry < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  def table_name
    self[VOC.name_str(nil)]
  end
  
  def table_name=(_table_name)
    self[VOC.name_str(nil)] = _table_name
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry properties.
  def init_props
    super

    self[VOC.name_str(nil)] = StrProp.new(nil, '', ext: true)

    sot_files.each do |_p|
      _basename = File.basename(_p)
      self[_basename] = StrProp.new(
        nil, '', blk: 0x1, enc: 'Windows-1252', uesc: true
      )
    end
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # @see Substitution::new
  def gs(...)
    Substitution.new(...)
  end

end # class StringTableEntry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
