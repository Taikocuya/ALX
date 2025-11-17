#!/usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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
  
# Class to create backups in +CFG.build_dir+.
class BackupCreator < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a BackupCreator.
  def initialize
    super(nil)
  end

  def update
    super
    
    if Worker.child?
      Dir.chdir(Root.dirname) do
        Dir.glob(cfg(:exec_file)).each do |_p|
          create_backup(_p)
        end
        
        sot_files.each do |_p|
          create_backup(_p)
        end
        
        create_backup(cfg(:evp_file))
        create_backup(cfg(:level_file))

        Dir.glob(cfg(:enp_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(cfg(:eb_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(cfg(:ec_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(cfg(:ma_std_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(cfg(:mb_std_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(cfg(:mg_std_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(cfg(:sct_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(cfg(:tec_file)).each do |_p|
          create_backup(_p)
        end
      end
    end
  end

  # Creates a backup.
  # @param _filename [String] File name
  def create_backup(_filename)
    _src_file = File.expand_path(_filename, Root.dirname)
    _base_dir = Pathname.new(File.expand_path(CFG.root_dir, Root.dirname))
    _root_dir = Pathname.new(_src_file)
    _dst_file = File.expand_path(
      _root_dir.relative_path_from(_base_dir),
      File.join(Root.dirname, CFG.backup_dir)
    )

    LOG.info(sprintf(VOC.create, VOC.open_backup, _dst_file))
    begin
      FileUtils.mkdir_p(File.dirname(_dst_file))
      FileUtils.cp(_src_file, _dst_file)
    rescue StandardError
      # Nothing to do.
    end
  end

end # class BackupCreator

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _br = ALX::BackupCreator.new
    _br.exec
  end
end
