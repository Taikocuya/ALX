#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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

require_relative('characterdata.rb')
require_relative('magicexpcurve.rb')
require_relative('stdentrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle Magic EXP curves from binary and/or CSV files.
class MagicExpCurveData < StdEntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a MagicExpCurveData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(MagicExpCurve, _root)
    self.id_range   = sys(:magic_exp_curve_id_range)
    self.data_file  = sys(:magic_exp_curve_data_files)
    self.csv_file   = SYS.magic_exp_curve_csv_file
    self.tpl_file   = SYS.magic_exp_curve_tpl_file
    @character_data = CharacterData.new(_root)
  end

  # Creates an entry.
  # @param _id [Integer] Entry ID
  # @return [Entry] Entry object
  def create_entry(_id = -1)
    _entry            = super
    _entry.characters = @character_data.data
    _entry
  end
  
  # Reads all entries from binary files.
  def load_all_from_bin
    @character_data.load_all_from_bin
    super
  end

end # class MagicExpCurveData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
