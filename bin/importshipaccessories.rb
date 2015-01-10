#! /usr/bin/ruby
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
#                                   REQUIRES
#==============================================================================

require_relative('../lib/alx/shipaccessorydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to import ship accessories from +INPUT_FILE+ to +OUTPUT_FILE+.
class ShipAccessoryImporter
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Path to the source file
  INPUT_FILE  = '../share/csv/shipaccessories.csv'
  # Path to the destination file
  OUTPUT_FILE = '../share/bin/&&systemdata/Start.dol'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    @data = ShipAccessoryData.new
  end

  def exec
    @data.load_from_csv(INPUT_FILE)
    @data.save_to_bin(OUTPUT_FILE)
  end
  
end	# class ShipAccessoryImporter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  begin
    _si = ALX::ShipAccessoryImporter.new
    _si.exec
  rescue => _e
    print(_e.class, "\n", _e.message, "\n", _e.backtrace.join("\n"), "\n")
  ensure
    system('pause')
  end
end
