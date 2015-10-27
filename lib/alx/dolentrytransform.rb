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

# Base class to export and/or import menu entries to and/or from CSV files.
class DolEntryTransform < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Reads all entries from binary files and writes all entries to CSV files.
  # @param _filename [String] File name of CSV files
  def transform_bin_to_csv(_filename)
    data.each do |_d|
      _d.load_from_bins
      _d.save_to_csv(File.join(_d.root.path, _filename))
    end
  end

  # Reads all entries from CSV files and writes all entries to binary files.
  # @param _filename [String] File name of CSV files
  def transform_csv_to_bin(_filename)
    data.each do |_d|
      _d.load_from_csv(File.join(_d.root.path, _filename))
      _d.save_to_bins
    end
  end

end # class DolEntryTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
