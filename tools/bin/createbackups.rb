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
require_relative('../../lib/alx/etc.rb')
require_relative('../../lib/alx/executable.rb')

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
#                                   PUBLIC
#==============================================================================

  public

  def exec
    print("\n")
    
    Dir.glob(File.join(SYS.share_dir, '*')).each do |_game_path|
      unless File.directory?(_game_path)
        next
      end
  
      create_backup(File.join(_game_path, SYS.dol_file))
      create_backup(File.join(_game_path, SYS.evp_file))
      create_backup(File.join(_game_path, SYS.lmt_file))

      _enp_file    = sprintf(SYS.enp_file   , '*')
      Dir.glob(File.join(_game_path, _enp_file   )).each do |_p|
        create_backup(_p)
      end
      _eb_dat_file = sprintf(SYS.eb_dat_file, '*')
      Dir.glob(File.join(_game_path, _eb_dat_file)).each do |_p|
        create_backup(_p)
      end
      _ec_dat_file = sprintf(SYS.ec_dat_file, '*')
      Dir.glob(File.join(_game_path, _ec_dat_file)).each do |_p|
        create_backup(_p)
      end
      _tec_file    = sprintf(SYS.tec_file   , '*')
      Dir.glob(File.join(_game_path, _tec_file   )).each do |_p|
        create_backup(_p)
      end
      
      Dir.glob(File.join(_game_path, SYS.sot_file_de)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, SYS.sot_file_es)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, SYS.sot_file_fr)).each do |_p|
        create_backup(_p)
      end
      Dir.glob(File.join(_game_path, SYS.sot_file_gb)).each do |_p|
        create_backup(_p)
      end
    end
  end

  # Creates a backup.
  # @param _filename [String] Backup to create
  def create_backup(_filename)
    _src = File.expand_path(_filename)
    _dst = File.expand_path(_filename + '.bak')

    print("Create backup: #{_dst}")
    
    begin
      FileUtils.cp(_src, _dst)
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
