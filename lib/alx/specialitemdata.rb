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

require_relative('entrytransform.rb')
require_relative('specialitem.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle special items from binary and/or CSV files.
class SpecialItemData < StdEntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Range of entry IDs
  ID_RANGE    = 0x140...0x190

  # Offset ranges of data entries
  DATA_FILES = {
    'E' => DataRange.new(DOL_FILE, 0x2c5774...0x2c5e54),
    'J' => DataRange.new(DOL_FILE, 0x2c4c6c...0x2c534c),
    'P' => DataRange.new(DOL_FILE, 0x2f4aa8...0x2f4e68),
  }

  # Offset ranges of name entries
  NAME_FILES = {
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x1dede...0x1e2b1),
      DataRange.new(SOT_FILE_ES, 0x1dc62...0x1e028),
      DataRange.new(SOT_FILE_FR, 0x1ded3...0x1e2a2),
      DataRange.new(SOT_FILE_GB, 0x1d556...0x1d929),
    ],
  }

  # Offset ranges of description entries
  DSCR_FILES = {
    'E' => DataRange.new(
      DOL_FILE, 0x2cd4ec...0x2ce220,
      [0x152, 0x15b, 0x161, 0x162]
    ),
    'J' => DataRange.new(
      DOL_FILE, 0x2cd644...0x2ce2b4,
      [0x152, 0x15b, 0x161, 0x162]
    ),
    'P' => [
      DataRange.new(SOT_FILE_DE, 0x18262...0x1918c),
      DataRange.new(SOT_FILE_ES, 0x17e6f...0x18dd2),
      DataRange.new(SOT_FILE_FR, 0x17f59...0x18ef6),
      DataRange.new(SOT_FILE_GB, 0x179f9...0x189df),
    ],
  }

  # Path to CSV file
  CSV_FILE = 'specialitems.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a SpecialItemData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(SpecialItem, _root)
    self.id_range   = ID_RANGE
    self.data_files = DATA_FILES
    self.name_files = NAME_FILES
    self.dscr_files = DSCR_FILES
    self.csv_file   = CSV_FILE
  end

end # class SpecialItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
