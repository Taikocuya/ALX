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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require('pathname')
require_relative('../lib/alx/cachefile.rb')
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
    super(nil)
  end

  # This method is called after #startup and before #shutdown in #exec. It 
  # will be re-executed as long as #repeat is true.
  # @see #exec
  def update
    super

    if Worker.child?
      _pattern = sprintf(CacheFile::CACHE_FILE, '*')
      Dir.glob(join(:cache_dir, _pattern)).each do |_p|
        remove_cache(_p)
      end
    end
  end

  # Removes a cache file.
  # @param _filename [String] File name
  def remove_cache(_filename)
    LOG.info(sprintf(VOC.remove, VOC.open_cache, _filename))
    if File.exist?(_filename)
      File.unlink(_filename)
    end

    _dirname = File.dirname(_filename)
    if Dir.empty?(_dirname)
      Dir.rmdir(_dirname) 
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
