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
#                                   REQUIRES
#==============================================================================

require_relative('entrydata.rb')
require_relative('specialitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle special items from binary and/or CSV files.
class SpecialItemData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  ID_RANGE_RANGE    = 0x140...0x190
  DATA_OFFSET_RANGE = 0x2c5774...0x2c5e54
  DSCR_OFFSET_RANGE = 0x2cd4ec...0x2ce220
  DSCR_SKIPPED_IDS  = [0x152, 0x15b, 0x161, 0x162]

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super(
      SpecialItem,
      ID_RANGE_RANGE,
      DATA_OFFSET_RANGE,
      DSCR_OFFSET_RANGE,
      DSCR_SKIPPED_IDS
    )
  end
  
  # Header of the CSV file.
  def header
    super(
      'Unknown #1',
      'Unknown #2',
      'Unknown #3',
      'Unknown #4',
      'Unknown #5'
    )
  end
  
end # class SpecialItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
