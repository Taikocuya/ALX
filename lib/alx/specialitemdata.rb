#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2022 Marcel Renner
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
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a SpecialItemData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(SpecialItem, _depend)
    self.id_range   = sys(:special_item_id_range)
    self.data_file = sys(:special_item_data_files)
    self.name_file = sys(:special_item_name_files)
    self.dscr_file = sys(:special_item_dscr_files)
    self.csv_file   = join(SYS.special_item_csv_file)
    self.tpl_file   = File.join(SYS.build_dir, SYS.special_item_tpl_file)
  end

end # class SpecialItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
