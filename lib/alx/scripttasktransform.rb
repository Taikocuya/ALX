#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2020 Marcel Renner
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

require_relative('scripttaskdata.rb')
require_relative('entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to export and/or import script tasks to and/or from CSV files.
class ScriptTaskTransform < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ScriptTaskTransform.
  def initialize
    super(ScriptTaskData)
  end

  # Reads all entries from binary files and writes all entries to CSV files.
  def transform_bin_to_csv
    data.each do |_d|
      _d.load_sht
      
      while _d.load_bin(true)
        _d.save_csv(true)
      end
      # Last but not least, write all remaining entries to a CSV file.
      _d.save_csv
      
      _d.save_sht
    end
  end

  # Reads all entries from CSV files and writes all entries to binary files.
  def transform_csv_to_bin
    data.each do |_d|
      _d.load_sht

      while _d.load_csv(true)
        _d.save_bin(true)
      end

      _d.save_sht
    end
  end

end # class ScriptTaskTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
