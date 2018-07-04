#! /usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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
require_relative('../../lib/alx/entrydata.rb')
require_relative('../../lib/alx/enemydata.rb')
require_relative('../../lib/alx/enemyshiptaskdata.rb')
require_relative('../../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to create backups in the "share" directory.
class BackupCreator
  
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
  DOL_FILE    = EntryData::DOL_FILE
  # Path to DAT files of boss enemies
  EB_DAT_FILE = sprintf(EnemyData::EB_DAT_FILE, '[0-9][0-9][0-9]')
  # Path to DAT files of standard enemies
  EC_DAT_FILE = sprintf(EnemyData::EC_DAT_FILE, '[0-9][0-9][0-9]')
  # Path to ENP file
  ENP_FILE    = sprintf(EnemyData::ENP_FILE, '*')
  # Path to EVP file
  EVP_FILE    = EnemyData::EVP_FILE
  # Path to TEC files
  TEC_FILE    = sprintf(EnemyShipTaskData::TEC_FILE, '[0-9][0-9][0-9]*')
  # Path to LMT file relative to game root.
  LMT_FILE    = EntryData::LMT_FILE
  # Path to German SOT file relative to game root (PAL-E only).
  SOT_FILE_DE = EntryData::SOT_FILE_DE
  # Path to Spanish SOT file relative to game root (PAL-E only).
  SOT_FILE_ES = EntryData::SOT_FILE_ES
  # Path to French SOT file relative to game root (PAL-E only).
  SOT_FILE_FR = EntryData::SOT_FILE_FR
  # Path to English SOT file relative to game root (PAL-E only).
  SOT_FILE_GB = EntryData::SOT_FILE_GB

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def exec
    print("\n")
    
    Dir.glob(File.join(SHARE_DIR, '*')).each do |_game_path|
      unless File.directory?(_game_path)
        next
      end
  
      create_backup(File.join(_game_path, DOL_FILE))
      create_backup(File.join(_game_path, EVP_FILE))
      create_backup(File.join(_game_path, LMT_FILE))
        
      Dir.glob(File.join(_game_path, ENP_FILE   )).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, ENP_FILE   )).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, ENP_FILE   )).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, EB_DAT_FILE)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, EC_DAT_FILE)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, TEC_FILE   )).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, SOT_FILE_DE)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, SOT_FILE_ES)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, SOT_FILE_FR)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, SOT_FILE_GB)).each do |_p|
        create_backup(_p)
      end
    end
  end

  # Creates a backup.
  # @param _filename [String] Backup to create
  def create_backup(_filename)
    _src  = File.expand_path(_filename)
    _dest = File.expand_path(_filename + '.bak')

    print("Create backup: #{_dest}")
    
    begin
      FileUtils.cp(_src, _dest)
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

end # class BackupCreator

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  begin
    _br = ALX::BackupCreator.new
    _br.exec
  rescue => _e
    print(_e.class, "\n", _e.message, "\n", _e.backtrace.join("\n"), "\n")
  end
end
