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

require('fileutils')
require('tmpdir')
require_relative('entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to compress and decompress files with AKLZ.
class AklzFile < BinaryFile

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Path to AKLZ executable
  AKLZ_EXE  = File.join(EntryTransform::THIRDPARTY_DIR, 'aklz/bin/aklz.exe')

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # @see ::File::new.
  def initialize(_filename, _mode = 'r', *_args)
    @filename = _filename
    @mode     = _mode
    _tempname = make_tmpname(@filename)
    
    if @mode.is_a?(String) && /[r+]/ =~ @mode
      FileUtils.mkdir_p(EntryTransform::BUILD_DIR)
      decompress(@filename, _tempname)
    end

    super(_tempname, _mode, *_args)
  end

  # @see +::File#close+.
  def close
    super
    
    if @mode.is_a?(String) && /[aw+]/ =~ @mode
      if File.exist?(@filename)
        File.unlink(@filename)
      end
      compress(to_path, @filename)
    end
    
    File.unlink(to_path)
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Makes a unique filename in +BUILD_DIR+.
  # @return [DataRange] Unique filename
  def make_tmpname(_filename)
    _base   = File.basename(_filename, ".*") << '-'
    _ext    = File.extname(_filename)
    _prefix = [File.join(EntryTransform::BUILD_DIR, _base), _ext]
    _pass   = nil
    _path   = nil
    
    loop do
      _path = Dir::Tmpname.make_tmpname(_prefix, _pass)
      
      if File.exist?(_path)
        _pass ||= 0
        _pass  += 1
      else
        break
      end
    end
    
    _path
  end

  # Compresses the file.
  # @param _src [String] Source
  # @param _dst [String] Destination
  def compress(_src, _dst)
    if File.exist?(AKLZ_EXE) && File.executable?(AKLZ_EXE) && File.exist?(_src)
      system(sprintf('%s -c -o "%s" "%s"', AKLZ_EXE, _dst, _src))
    end
    
    File.exist?(_dst)
  end

  # Decompresses the file.
  # @param _src [String] Source
  # @param _dst [String] Destination
  def decompress(_src, _dst)
    if File.exist?(AKLZ_EXE) && File.executable?(AKLZ_EXE) && File.exist?(_src)
      system(sprintf('%s -d -o "%s" "%s"', AKLZ_EXE, _dst, _src))
    end
      
    File.exist?(_dst)
  end

end # class AklzFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
