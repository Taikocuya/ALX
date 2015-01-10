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
require_relative('usableitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle usable items from binary and/or CSV files.
class UsableItemData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  ID_RANGE_RANGE    = 0xf0...0x140
  DATA_OFFSET_RANGE = 0x2c4c34...0x2c5774
  DSCR_OFFSET_RANGE = 0x2cbc88...0x2cd4ec
  DSCR_SKIPPED_IDS  = (0x12d..0x130).to_a

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super(
      UsableItem,
      ID_RANGE_RANGE,
      DATA_OFFSET_RANGE,
      DSCR_OFFSET_RANGE,
      DSCR_SKIPPED_IDS
    )
  end
  
  # Header of the CSV file.
  def header
    super(
      'Occasion flags',
      'Menu',
      'Battle',
      'Ship battle',
      'Effect ID',
      'Effect name',
      'Scope ID',
      'Scope name',
      'Consume%',
      'Sell price in %',
      'Unknown #1',
      'Unknown #2',
      'Price',
      'Unknown #3',
      'Unknown #4',
      'Effect amount',
      'Unknown #5',
      'Unknown #6',
      'Unknown #7',
      'Unknown #8',
      'Unknown #9',
      'Hit%'
    )
  end
  
end # class UsableItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
