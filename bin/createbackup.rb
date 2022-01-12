#!/usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2022 Marcel Renner
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
  
# Class to create backups in +SYS.build_dir+.
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
        Dir.glob(sys(:exec_file)).each do |_p|
          create_backup(_p)
        end
        
        create_backup(sys(:evp_file))
        create_backup(sys(:level_file))

        Dir.glob(sys(:enp_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(sys(:eb_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(sys(:ec_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(sys(:sct_file)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(sys(:tec_file)).each do |_p|
          create_backup(_p)
        end
        
        Dir.glob(sys(:sot_file_de)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(sys(:sot_file_es)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(sys(:sot_file_fr)).each do |_p|
          create_backup(_p)
        end
        Dir.glob(sys(:sot_file_gb)).each do |_p|
          create_backup(_p)
        end
      end
    end
  end

  # Creates a backup.
  # @param _filename [String] File name
  def create_backup(_filename)
    _src_file = File.expand_path(_filename, Root.dirname)
    _base_dir = Pathname.new(File.expand_path(SYS.root_dir, Root.dirname))
    _root_dir = Pathname.new(_src_file)
    _dst_file = File.expand_path(
      _root_dir.relative_path_from(_base_dir),
      File.join(Root.dirname, SYS.backup_dir)
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
