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

require('pathname')
require('rubygems')
require('rubygems/package')
require('zlib')
require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to create GZ files in +SYS.data_dir+.
class GzipCreator < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an SampleCreator.
  def initialize
    super(GameRoot)
  end
  
  # Creates an entry data object.
  # @param _root [GameRoot] Game root
  # @return [EntryData] Entry data object
  def create_entry_data(_root)
    _root
  end
  
  def exec
    super
    
    data.each do |_root|
      Dir.chdir(_root.dirname) do
        create_gz(_root, File.dirname(_root.sys(:script_task_csv_file)))
      end
    end
  end

  # Creates a GZ file.
  # @param _root [GameRoot] Game root
  # @param _path [String]   Path to compress
  def create_gz(_root, _path)
    _src = File.expand_path(_path, _root.dirname)
    _dst = _src + '.tar.gz'
    _buf = StringIO.new('')

    begin
      Gem::Package::TarWriter.new(_buf) do |_tar|
        Dir.glob(File.join(_src, '**/*')).each do |_filename|
          _rel_path = Pathname.new(_filename)
          _rel_path = _rel_path.relative_path_from(_src).to_s

          if File.directory?(_filename)
            _tar.mkdir(_rel_path, 0755)
          else
            _tar.add_file(_rel_path, 0644) do |tf|
              File.open(_filename, "rb") do |f|
                tf.write f.read
              end
            end
          end
        end
      end

      File.open(_dst, 'wb') do |_f|
        _gz = Zlib::GzipWriter.new(_f, Zlib::BEST_COMPRESSION)
        _gz.write(_buf.string)
        _gz.close
      end
      
      _buf.string.clear
      _result = true
    rescue
      _result = false
    end

    _msg = sprintf('Create archive: %s', _dst)
    if _result
      _msg += sprintf(' - %s', VOC.done)
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s', VOC.failed)
      ALX::LOG.error(_msg)
    end
  end

end # class GzipCreator

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _sc = ALX::GzipCreator.new
    _sc.exec
  end
end
