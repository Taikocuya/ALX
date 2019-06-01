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

require_relative('../../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to create configuration samples in the "etc" directory.
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
    super(Object)
  end
  
  # Creates an entry data object.
  # @param _root [GameRoot] Game root
  # @return [EntryData] Entry data object
  def create_entry_data(_root)
    nil
  end
  
  def exec
    CONFIG_FILES.each_value do |_f|
      _src = File.join(File.dirname(__FILE__), '../../lib/alx', _f)
      _dst = File.join(File.dirname(__FILE__), '../../etc',     _f + '.sample')
      create_sample(_src, _dst)
    end
  end

  # Creates a configuration sample.
  # @param _src [String] Source path
  # @param _dst [String] Destination path
  def create_sample(_src, _dst)
    begin
      FileUtils.cp(_src, _dst)
      _result = File.exist?(_dst)
    rescue
      _result = false
    end

    _msg = sprintf('Create configuration sample: %s', _dst)
    if _result
      _msg += sprintf(' - %s', VOC.done)
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s', VOC.failed)
      ALX::LOG.error(_msg)
    end
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
