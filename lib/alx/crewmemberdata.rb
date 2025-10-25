#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

require_relative('crewmember.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle crew members from binary and/or CSV files.
class CrewMemberData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CrewMemberData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(CrewMember, _depend)
    self.id_range  = dscrptr(:crew_member_id_range)
    self.data_file = dscrptr(:crew_member_data_files)
    self.name_file = dscrptr(:crew_member_name_files)
    self.dscr_file = dscrptr(:crew_member_dscr_files)
    self.csv_file  = join(CFG.crew_member_csv_file)
    self.tpl_file  = File.join(CFG.build_dir, CFG.crew_member_tpl_file)
  end

end # class CrewMemberData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
