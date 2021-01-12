#!/usr/bin/ruby
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

require('pathname')
require_relative('../lib/alx/entrydata.rb')
require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to clear cache in +SYS.build_dir+.
class CacheClearer < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CacheClearer.
  def initialize
    super(GameRoot)
  end

  # Creates an entry data object.
  # @param _root [GameRoot] Game root
  # @return [EntryData] Entry data object
  def create_entry_data(_root)
    _root
  end

  def exec
    super
    
    _sht_pattern = sprintf(ShtManager::SHT_FILE, '*', '*')
    data.each do |_root|
      Dir.glob(_root.join(:cache_dir, _sht_pattern)).each do |_p|
        remove_snapshot(_p)
      end
    end
  end

  # Removes a snapshot.
  # @param _filename [String] Snapshot to remove
  def remove_snapshot(_filename)
    begin
      FileUtils.rm(_filename)
      _result = !File.exist?(_filename)
    rescue StandardError
      _result = false
    end

    _msg = sprintf('Remove snapshot: %s', _filename)
    if _result
      _msg += sprintf(' - %s', VOC.done)
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s', VOC.failed)
      ALX::LOG.error(_msg)
    end

    begin
      _dirname = File.dirname(_filename)
      if Dir.empty?(_dirname)
        Dir.rmdir(_dirname) 
      end
    rescue StandardError
      # Nothing to do.
    end
  end

end # class CacheClearer

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _sr = ALX::CacheClearer.new
    _sr.exec
  end
end
