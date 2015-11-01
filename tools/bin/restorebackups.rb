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
#                                 REQUIREMENTS
#==============================================================================

require('fileutils')
require_relative('../../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to restore backups in the "share" directory.
class BackupRestorer
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Executable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================
  
  # Path to 'share' directory
  SHARE_DIR   = EntryTransform::SHARE_DIR
  # Path to DOL file relative to game root.
  DOL_FILE    = EntryTransform::DOL_FILE
  # Path to LMT file relative to game root.
  LMT_FILE    = EntryTransform::LMT_FILE
  # Path to German SOT file relative to game root (PAL-E only).
  SOT_DE_FILE = EntryTransform::SOT_DE_FILE
  # Path to Spanish SOT file relative to game root (PAL-E only).
  SOT_ES_FILE = EntryTransform::SOT_ES_FILE
  # Path to French SOT file relative to game root (PAL-E only).
  SOT_FR_FILE = EntryTransform::SOT_FR_FILE
  # Path to English SOT file relative to game root (PAL-E only).
  SOT_GB_FILE = EntryTransform::SOT_GB_FILE

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def exec
    print("\n")
    restore_file(File.join(SHARE_DIR, 'geae8p', DOL_FILE   ))
    restore_file(File.join(SHARE_DIR, 'geaj8p', DOL_FILE   ))
    restore_file(File.join(SHARE_DIR, 'geap8p', DOL_FILE   ))
    restore_file(File.join(SHARE_DIR, 'geae8p', LMT_FILE   ))
    restore_file(File.join(SHARE_DIR, 'geaj8p', LMT_FILE   ))
    restore_file(File.join(SHARE_DIR, 'geap8p', LMT_FILE   ))
    restore_file(File.join(SHARE_DIR, 'geap8p', SOT_DE_FILE))
    restore_file(File.join(SHARE_DIR, 'geap8p', SOT_ES_FILE))
    restore_file(File.join(SHARE_DIR, 'geap8p', SOT_FR_FILE))
    restore_file(File.join(SHARE_DIR, 'geap8p', SOT_GB_FILE))
  end

  # Restores a file.
  # @param _filename [String] File to restore
  def restore_file(_filename)
    _src  = File.expand_path(_filename + '.bak')
    _dest = File.expand_path(_filename)

    print("Restore file: #{_dest}")
    
    begin
      FileUtils::cp(_src, _dest)
      _result = File.exist?(_src)
    rescue
      _result = false
    end

    if _result
      print(" - done\n")
    else
      print(" - failed\n")
    end
  end

end # class BackupRestorer

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  begin
    _br = ALX::BackupRestorer.new
    _br.exec
  rescue => _e
    print(_e.class, "\n", _e.message, "\n", _e.backtrace.join("\n"), "\n")
  end
end
