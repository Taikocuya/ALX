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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Mixin for every command line tool.
module Fileable
 
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Returns +true+ if file exists, otherwise +false+.
  # @param _paths [String] File name
  # @return [Boolean] +true+ if file exists, otherwise +false+.
  def has_file?(*_paths)
    _path = File.join(*_paths)
    _msg  = sprintf(VOC.check_file, File.expand_path(_path))

    _basename = nil
    _result   = File.exist?(_path) && !File.directory?(_path)
    unless _result
      _path = Dir.glob(_path).find_all do |_p|
        File.file?(_p)
      end
      if _path && !_path.empty?
        _basename = File.basename(_path.first)
        _result   = true
      end
    end
    if _result
      if _basename
        _msg += sprintf(' - %s (%s)', VOC.exists, _basename)
      else
        _msg += sprintf(' - %s', VOC.exists)
      end
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s', VOC.not_found)
      ALX::LOG.warn(_msg)
    end
    
    _result
  end

  # Returns +true+ if directory exists, otherwise +false+.
  # @param _paths [String] Directory name
  # @return [Boolean] +true+ if directory exists, otherwise +false+.
  def has_dir?(*_paths)
    _path = File.join(*_paths)
    _msg  = sprintf(VOC.check_dir, File.expand_path(_path))

    _basename = nil
    _result   = Dir.exist?(_path) && File.directory?(_path)
    unless _result
      _path = Dir.glob(_path).find_all do |_p|
        File.directory?(_p)
      end
      if _path && !_path.empty?
        _basename = File.basename(_path.first)
        _result   = true
      end
    end
    if _result
      if _basename
        _msg += sprintf(' - %s (%s)', VOC.exists, _basename)
        ALX::LOG.info(_msg)
      else
        _msg += sprintf(' - %s', VOC.exists)
        ALX::LOG.info(_msg)
      end
    else
      _msg += sprintf(' - %s', VOC.not_found)
      ALX::LOG.warn(_msg)
    end
    
    _result
  end

end # class Fileable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
