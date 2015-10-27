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
#                                 REQUIREMENTS
#==============================================================================

require_relative('crewmember.rb')
require_relative('entrytransform.rb')
require_relative('dolentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle crew members from binary and/or CSV files.
class CrewMemberData < DolEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x0...0x16

  # Offset ranges of data entries
  DATA_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2d5e64...0x2d617c),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2d5aa4...0x2d5dbc),
    'P' => DataRange.new(EntryTransform::DOL_FILE, 0x2f8a4c...0x2f8c5c),
  }

  # Offset ranges of name entries
  NAME_RANGES = {
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1ed75...0x1ee0b),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1eb78...0x1ec0e),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1ed91...0x1ee27),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1e3dd...0x1e473),
    ],
  }

  # Offset ranges of description entries
  DSCR_RANGES = {
    'E' => DataRange.new(EntryTransform::DOL_FILE, 0x2d0ef4...0x2d1600),
    'J' => DataRange.new(EntryTransform::DOL_FILE, 0x2d0dcc...0x2d15dc),
    'P' => [
      DataRange.new(EntryTransform::SOT_DE_FILE, 0x1c085...0x1c7ab),
      DataRange.new(EntryTransform::SOT_ES_FILE, 0x1bc6f...0x1c3da),
      DataRange.new(EntryTransform::SOT_FR_FILE, 0x1be6e...0x1c5fa),
      DataRange.new(EntryTransform::SOT_GB_FILE, 0x1b766...0x1be63),
    ],
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CrewMemberData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(CrewMember, _root)
    self.id_range    = ID_RANGE
    self.data_ranges = DATA_RANGES
    self.name_ranges = NAME_RANGES
    self.dscr_ranges = DSCR_RANGES
  end

end # class CrewMemberData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
