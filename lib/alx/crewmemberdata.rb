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
require_relative('crewmember.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle crew members from binary and/or CSV files.
class CrewMemberData < EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  ID_RANGE_RANGE    = 0x0...0x16
  DATA_OFFSET_RANGE = 0x2d5e64...0x2d617c
  DSCR_OFFSET_RANGE = 0x2d0ef4...0x2d1600
  DSCR_SKIPPED_IDS  = []

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super(
      CrewMember,
      ID_RANGE_RANGE,
      DATA_OFFSET_RANGE,
      DSCR_OFFSET_RANGE,
      DSCR_SKIPPED_IDS
    )
  end
  
  # Header of the CSV file.
  def header
    super(
      'Position ID',
      'Position name',
      'Feature ID',
      'Feature name',
      'Feature padding',
      'Feature value',
      'Effect ID',
      'Effect name',
      'Effect spirit',
      'Effect turns',
      'Unknown #1',
      'Unknown #2',
      'Unknown #3',
      'Effect amount',
      'Unknown #4',
      'Unknown #5',
      'Unknown #6',
      'Unknown #7',
      'Unknown #8'
    )
  end
  
end # class CrewMemberData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
