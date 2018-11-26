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
require('pathname')
require_relative('../../lib/alx/etc.rb')
require_relative('../../lib/alx/executable.rb')

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
#                                   PUBLIC
#==============================================================================

  public

  def exec
    print("\n")

    Dir.glob(File.join(SYS.share_dir, '*')).each do |_game_path|
      unless File.directory?(_game_path)
        next
      end
  
      restore_backup(_game_path, SYS.dol_file)
      restore_backup(_game_path, SYS.evp_file)
      restore_backup(_game_path, SYS.lmt_file)

      Dir.chdir(_game_path) do
        Dir.glob(sprintf(SYS.enp_file, '*')).each do |_p|
          restore_backup(_game_path, _p)
        end
        Dir.glob(sprintf(SYS.eb_dat_file, '*')).each do |_p|
          restore_backup(_game_path, _p)
        end
        Dir.glob(sprintf(SYS.ec_dat_file, '*')).each do |_p|
          restore_backup(_game_path, _p)
        end
        Dir.glob(sprintf(SYS.tec_file, '*')).each do |_p|
          restore_backup(_game_path, _p)
        end
        
        Dir.glob(SYS.sot_file_de).each do |_p|
          restore_backup(_game_path, _p)
        end
        Dir.glob(SYS.sot_file_es).each do |_p|
          restore_backup(_game_path, _p)
        end
        Dir.glob(SYS.sot_file_fr).each do |_p|
          restore_backup(_game_path, _p)
        end
        Dir.glob(SYS.sot_file_gb).each do |_p|
          restore_backup(_game_path, _p)
        end
      end
    end
  end

  # Restores a backup.
  # @param _game_path [String] Path to game root
  # @param _filename  [String] Backup to create
  def restore_backup(_game_path, _filename)
    _dst_file = File.expand_path(_filename, _game_path)
    _base_dir = Pathname.new(File.expand_path(SYS.root_dir, _game_path))
    _root_dir = Pathname.new(_dst_file)
    _src_file = File.expand_path(
      _root_dir.relative_path_from(_base_dir),
      File.join(_game_path, SYS.bak_dir)
    )

    print("Restore backup: #{_dst_file}")

    begin
      FileUtils.cp(_src_file, _dst_file)
      _result = File.exist?(_src_file)
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
