#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2021 Marcel Renner
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
require_relative('weaponeffect.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle weapon effects from binary and/or CSV files.
class WeaponEffectData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a WeaponEffectData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(WeaponEffect, _depend)
    self.id_range  = sys(:weapon_effect_id_range)
    self.data_file = sys(:weapon_effect_data_files)
    self.csv_file  = join(SYS.weapon_effect_csv_file)
    self.tpl_file  = File.join(SYS.build_dir, SYS.weapon_effect_tpl_file)
  end

end # class WeaponEffectData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
