#! /usr/bin/ruby
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

require_relative('../lib/alx/executable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to export weapons to CSV files.
class Exporter
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Executable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Executables of exporters
  EXEC_FILES = File.join(File.dirname(__FILE__), 'export[a-z]*.rb')

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  def initialize
    super
    @exec_files = Dir.glob(EXEC_FILES)
    @exec_files.select! do |_p|
      File.file?(_p) && File.basename(_p) != 'exportdefinedstring.rb'
    end
  end
  
  def valid?
    _valid = true
    @exec_files.each do |_p|
      _valid &&= has_file?(_p)
    end

    _valid
  end
  
  def exec
    if valid?
      @exec_files.each do |_p|
        require(_p)
      end
    end
  end

end	# class WeaponExporter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _exporter = ALX::Exporter.new
    _exporter.exec
  end
end
