#! /usr/bin/ruby
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

require('fileutils')
require_relative('../../lib/alx/etc.rb')
require_relative('../../lib/alx/executable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to create configuration samples in the "etc" directory.
class SampleCreator
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Executable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================
  
  # Configuration files
  CONFIG_FILES = ETC::CONFIG_FILES

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def exec
    print("\n")
    
    CONFIG_FILES.each_value do |_f|
      _src = File.join('../../lib/alx', _f)
      _dst = File.join('../../etc',     _f + '.sample')
      create_sample(_src, _dst)
    end
  end

  # Creates a configuration sample.
  # @param _src [String] Source path
  # @param _dst [String] Destination path
  def create_sample(_src, _dst)
    print("Create configuration sample: #{File.expand_path(_dst)}")
    
    begin
      FileUtils.cp(_src, _dst)
      _result = File.exist?(_dst)
    rescue
      _result = false
    end

    if _result
      print(" - done\n")
    else
      print(" - failed\n")
    end
  end

end # class SampleCreator

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  begin
    _br = ALX::SampleCreator.new
    _br.exec
  rescue => _e
    print(_e.class, "\n", _e.message, "\n", _e.backtrace.join("\n"), "\n")
  end
end
