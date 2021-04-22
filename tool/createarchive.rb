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

require('open3')
require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to create archive files in +SYS.data_dir+.
class ArchiveCreator < EntryTransform

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Path to 7-Zip executable file
  SEVENZIP_EXE = File.join(SYS.vendor_dir, '7-Zip/7za.exe')
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
  
  def valid?
    _result = super
    _result &&= has_file?(SEVENZIP_EXE)
    _result &&= has_dir?(File.dirname(join(SYS.script_task_csv_file)))
    _result
  end

  # This method is called after #startup and before #shutdown in #exec. It 
  # will be re-executed as long as #repeat is true.
  # @see #exec
  def update
    super

    if Worker.child?
      create_7z(File.dirname(join(SYS.script_task_csv_file)))
    end
  end

  # Creates a 7Z file.
  # @param _path [String] Path
  def create_7z(_path)
    if File.directory?(_path)
      _pwd = _path
      _src = '*'
      _dst = File.join('..', File.basename(_path) + '.7z')
    else
      _pwd = File.dirname(_path)
      _src = File.basename(_path)
      _dst = File.basename(_path) + '.7z'
    end
    _abs = File.expand_path(File.join(_pwd, _dst))
    
    LOG.info(sprintf(VOC.save, VOC.open_file, _abs))
    if File.exist?(_abs)
      File.unlink(_abs)
    end
    _stdout, _stderr, _status = Open3.capture3(
      SEVENZIP_EXE,
      'a',
      '-m0=lzma2',
      '-mmt1',
      '-mx=9',
      _dst,
      _src,
      chdir: _pwd
    )

    unless _status.success?
      _stderr.strip!
      _stderr.gsub!(/\s+/, ' ')
      raise(IOError, _stderr)
    end
  end

end # class ArchiveCreator

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _sc = ALX::ArchiveCreator.new
    _sc.exec
  end
end
