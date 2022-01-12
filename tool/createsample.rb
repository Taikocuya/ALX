#!/usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2022 Marcel Renner
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

require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to create configuration samples in the "config" directory.
class SampleCreator < EntryTransform

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Configuration files
  CONFIG_FILES = ETC::CONFIG_FILES

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an SampleCreator.
  def initialize
    super(nil)
  end

  # This method is called before #update respectively as first in #exec.
  # @see #exec
  def startup
  end
  
  # This method is called after #startup and before #shutdown in #exec. It 
  # will be re-executed as long as #repeat is true.
  # @see #exec
  def update
    super

    CONFIG_FILES.each_value do |_basename|
      _src = File.join(
        File.dirname(__FILE__), '../lib/alx', _basename
      )
      _dst = File.join(
        File.dirname(__FILE__), '../config' , _basename + '.sample'
      )
      create_sample(_src, _dst)
    end
  end

  # Creates a configuration sample.
  # @param _src [String] Source path
  # @param _dst [String] Destination path
  def create_sample(_src, _dst)
    LOG.info(sprintf(VOC.save, VOC.open_file, _dst))
    FileUtils.cp(_src, _dst)
  end

end # class SampleCreator

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _sc = ALX::SampleCreator.new
    _sc.exec
  end
end
