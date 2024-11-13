#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
require_relative('weapon.rb')
require_relative('weaponeffectdata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle weapons from binary and/or CSV files.
class WeaponData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a WeaponData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(Weapon, _depend)
    self.id_range  = dscrptr(:weapon_id_range)
    self.data_file = dscrptr(:weapon_data_files)
    self.name_file = dscrptr(:weapon_name_files)
    self.dscr_file = dscrptr(:weapon_dscr_files)
    self.csv_file  = join(CFG.weapon_csv_file)
    self.tpl_file  = File.join(CFG.build_dir, CFG.weapon_tpl_file)
    
    if depend
      @weapon_effect_data = WeaponEffectData.new
    end
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry                = super
    _entry.weapon_effects = @weapon_effect_data&.data
    _entry
  end
  
  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    @weapon_effect_data&.load_bin
    super
  end
  
end # class WeaponData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
