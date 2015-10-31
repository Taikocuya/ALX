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

require_relative('dolentrytransform.rb')
require_relative('npcskilldata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to export and/or import enemy skills to and/or from CSV files.
class NpcSkillTransform < DolEntryTransform

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Path to CSV file
  CSV_FILE = 'npcskills.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a NpcSkillTransform.
  def initialize
    super(NpcSkillData)
  end

end # class NpcSkillTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
