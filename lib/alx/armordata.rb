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

require_relative('armor.rb')
require_relative('entrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle armors from binary and/or CSV files.
class ArmorData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  ID_RANGE_RANGE    = 0x50...0xa0
  DATA_OFFSET_RANGE = 0x2c3190...0x2c3e10
  DSCR_OFFSET_RANGE = 0x2c9714...0x2ca880
  DSCR_SKIPPED_IDS  = []

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super(
      Armor,
      ID_RANGE_RANGE,
      DATA_OFFSET_RANGE,
      DSCR_OFFSET_RANGE,
      DSCR_SKIPPED_IDS
    )
  end
  
  # Header of the CSV file.
  def header
    super(
      'Character flags',
      'Vyse',
      'Aika',
      'Fina',
      'Drachma',
      'Gilder',
      'Enrique',
      'Sell price in %',
      'Unknown #1',
      'Unknown #2',
      'Padding',
      'Price',
      'Feature #1 ID',
      'Feature #1 Name',
      'Feature #1 Padding',
      'Feature #1 Value',
      'Feature #2 ID',
      'Feature #2 Name',
      'Feature #2 Padding',
      'Feature #2 Value',
      'Feature #3 ID',
      'Feature #3 Name',
      'Feature #3 Padding',
      'Feature #3 Value',
      'Feature #4 ID',
      'Feature #4 Name',
      'Feature #4 Padding',
      'Feature #4 Value'
    )
  end
  
end # class ArmorData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
