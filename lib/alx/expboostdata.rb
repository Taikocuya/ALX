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

require_relative('characterdata.rb')
require_relative('expboost.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle EXP boosts from binary and/or CSV files.
class ExpBoostData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ExpBoostData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(ExpBoost, _depend)
    self.id_range  = dscrptr(:exp_boost_id_range)
    self.data_file = dscrptr(:exp_boost_data_files)
    self.csv_file  = join(CFG.exp_boost_csv_file)
    self.tpl_file  = File.join(CFG.build_dir, CFG.exp_boost_tpl_file)
        
    if depend
      @character_data = CharacterData.new
    end
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry            = super
    _entry.characters = @character_data&.data
    _entry
  end
  
  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    @character_data&.load_bin
    super
  end

end # class ExpBoostData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
