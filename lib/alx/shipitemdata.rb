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
require_relative('shipitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle ship items from binary and/or CSV files.
class ShipItemData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  ID_RANGE_RANGE    = 0x1e0...0x1fe
  DATA_OFFSET_RANGE = 0x2d5a2c...0x2d5e64
  DSCR_OFFSET_RANGE = 0x2cfbf0...0x2d05c4
  DSCR_SKIPPED_IDS  = []

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super(
      ShipItem,
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
      'Turns',
      'Consume%',
      'Padding #1',
      'Price',
      'Sell price in %',
      'Unknown #1',
      'Unknown #2',
      'Padding #2',
      'Effect amount',
      'Element ID',
      'Element name',
      'Unknown #3',
      'Unknown #4',
      'Hit%'
    )
  end
  
end # class ShipItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
