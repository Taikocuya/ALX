#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2023 Marcel Renner
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

require_relative('stdentrydata.rb')
require_relative('usableitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle usable items from binary and/or CSV files.
class UsableItemData < StdEntryData
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an UsableItemData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(UsableItem, _depend)
    self.id_range  = sys(:usable_item_id_range)
    self.data_file = sys(:usable_item_data_files)
    self.name_file = sys(:usable_item_name_files)
    self.dscr_file = sys(:usable_item_dscr_files)
    self.csv_file  = join(SYS.usable_item_csv_file)
    self.tpl_file  = File.join(SYS.build_dir, SYS.usable_item_tpl_file)
  end

end # class UsableItemData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
