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
require_relative('shipcannon.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle ship cannons from binary and/or CSV files.
class ShipCannonData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  ID_RANGE_RANGE    = 0x190...0x1b8
  DATA_OFFSET_RANGE = 0x2d4e4c...0x2d53ec
  DSCR_OFFSET_RANGE = 0x2ce220...0x2ceef8
  DSCR_SKIPPED_IDS  = []

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super(
      ShipCannon,
      ID_RANGE_RANGE,
      DATA_OFFSET_RANGE,
      DSCR_OFFSET_RANGE,
      DSCR_SKIPPED_IDS
    )
  end
  
  # Header of the CSV file.
  def header
    super(
      'Ship flags',
      'Little Jack: Harpoon Cannon',
      'Little Jack: Standard',
      'Delphinus: Prototype',
      'Delphinus: Standard',
      'Delphinus: Upgraded',
      'Type ID',
      'Type name',
      'Element ID',
      'Element name',
      'Attack',
      'Hit%',
      'Limit',
      'Spirit',
      'Unknown #1',
      'Unknown #2',
      'Unknown #3',
      'Unknown #4',
      'Price',
      'Sell price in %',
      'Unknown #5',
      'Unknown #6',
      'Padding'
    )
  end
  
end # class ShipCannonData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
