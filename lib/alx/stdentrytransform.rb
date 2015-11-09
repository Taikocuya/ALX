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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to export and/or import standard entries to and/or from CSV files.
class StdEntryTransform < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Reads all entries from binary files and writes all entries to CSV files.
  def transform_bin_to_csv
    data.each do |_d|
      _d.load_all_from_bin
      _d.save_all_to_csv
    end
  end

  # Reads all entries from CSV files and writes all entries to binary files.
  def transform_csv_to_bin
    data.each do |_d|
      _d.load_all_from_csv
      _d.save_all_to_bin
    end
  end

end # class StdEntryTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
