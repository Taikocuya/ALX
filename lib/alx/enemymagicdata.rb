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
# You should have received a copy of the GNU General Public License along with 
# ALX. If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('enemymagic.rb')
require_relative('enemydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy magics from binary and/or CSV files.
class EnemyMagicData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyMagicData.
  # @param _root   [GameRoot] Game root
  # @param _depend [Boolean]  Resolve dependencies
  def initialize(_root, _depend = true)
    super(EnemyMagic, _root, _depend)
    self.id_range  = sys(:enemy_magic_id_range)
    self.data_file = sys(:enemy_magic_data_files)
    self.name_file = sys(:enemy_magic_name_files)
    self.csv_file  = SYS.enemy_magic_csv_file
    self.tpl_file  = SYS.enemy_magic_tpl_file
    
    if depend
      @enemy_data = EnemyData.new(_root)
    end
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry         = super
    _entry.enemies = @enemy_data&.enemies
    _entry
  end
  
  # Reads all entries from binary files.
  def load_bin
    @enemy_data&.load_bin
    super
  end

end # class EnemyMagicData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
