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
require_relative('shipaccessory.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle ship accessories from binary and/or CSV files.
class ShipAccessoryData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  ID_RANGE_RANGE    = 0x1b8...0x1e0
  DATA_OFFSET_RANGE = 0x2d53ec...0x2d5a2c
  DSCR_OFFSET_RANGE = 0x2ceef8...0x2cfbf0
  DSCR_SKIPPED_IDS  = []

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super(
      ShipAccessory,
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
      'Feature #1 ID',
      'Feature #1 name',
      'Feature #1 padding',
      'Feature #1 value',
      'Feature #2 ID',
      'Feature #2 name',
      'Feature #2 padding',
      'Feature #2 value',
      'Feature #3 ID',
      'Feature #3 name',
      'Feature #3 padding',
      'Feature #3 value',
      'Feature #4 ID',
      'Feature #4 name',
      'Feature #4 padding',
      'Feature #4 value',
      'Price',
      'Sell price in %',
      'Unknown #1',
      'Unknown #2',
      'Padding',
    )
  end
  
end # class ShipAccessoryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
