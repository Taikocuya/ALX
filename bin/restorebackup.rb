#!/usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to restore backups in +CFG.build_dir+.
class BackupRestorer < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a BackupRestorer.
  def initialize
    super(nil)
  end

  def update
    super
    
    if Worker.child?
      Dir.chdir(Root.dirname) do
        Dir.glob(cfg(:exec_file)).each do |_p|
          restore_backup(_p)
        end
        
        restore_backup(cfg(:evp_file))
        restore_backup(cfg(:level_file))
        
        Dir.glob(cfg(:enp_file)).each do |_p|
          restore_backup(_p)
        end
        Dir.glob(cfg(:eb_file)).each do |_p|
          restore_backup(_p)
        end
        Dir.glob(cfg(:ec_file)).each do |_p|
          restore_backup(_p)
        end
        Dir.glob(cfg(:sct_file)).each do |_p|
          restore_backup(_p)
        end
        Dir.glob(cfg(:tec_file)).each do |_p|
          restore_backup(_p)
        end
        
        Dir.glob(cfg(:sot_file_de)).each do |_p|
          restore_backup(_p)
        end
        Dir.glob(cfg(:sot_file_es)).each do |_p|
          restore_backup(_p)
        end
        Dir.glob(cfg(:sot_file_fr)).each do |_p|
          restore_backup(_p)
        end
        Dir.glob(cfg(:sot_file_gb)).each do |_p|
          restore_backup(_p)
        end
      end
    end
  end

  # Restores a backup.
  # @param _filename [String] File name
  def restore_backup(_filename)
    _dst_file = File.expand_path(_filename, Root.dirname)
    _base_dir = Pathname.new(File.expand_path(CFG.root_dir, Root.dirname))
    _root_dir = Pathname.new(_dst_file)
    _src_file = File.expand_path(
      _root_dir.relative_path_from(_base_dir),
      File.join(Root.dirname, CFG.backup_dir)
    )

    LOG.info(sprintf(VOC.restore, VOC.open_backup, _dst_file))
    begin
      FileUtils.cp(_src_file, _dst_file)
    rescue StandardError
      # Nothing to do.
    end
  end

end # class BackupRestorer

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _br = ALX::BackupRestorer.new
    _br.exec
  end
end
