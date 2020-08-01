#!/usr/bin/ruby
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

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to rebuild images in +SYS.build_dir+.
class ImageRebuilder < EntryTransform

#==============================================================================
#                                  CONSTANTS
#==============================================================================
  
  # Path to 'thirdparty/dolphin/Games' directory
  GAMES_DIR = File.expand_path(
    File.join(File.dirname(__FILE__), '../vendor/dolphin/Games')
  )
  # Path to 'thirdparty/gcr/gcr.exe' file
  GCR_FILE  = File.expand_path(
    File.join(File.dirname(__FILE__), '../vendor/thirdparty/gcr/gcr.exe')
  )

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ImageRebuilder.
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
      rebuild_image(
        File.join(_root.dirname, SYS.root_dir),
        File.join(GAMES_DIR, File.basename(_root.dirname)) + '.iso'
      )
    end
  end

  # Rebuilds an image.
  # @param _game_path  [String] Path of game root
  # @param _image_path [String] Path of game image
  def rebuild_image(_game_path, _image_path)
    begin
      FileUtils.mkdir_p(File.dirname(_image_path))
      if File.exist?(_image_path)
        FileUtils.remove_file(_image_path)
      end
      system("\"#{GCR_FILE}\" \"#{_game_path}\" \"#{_image_path}\"")
      _result = File.size?(_image_path)
    rescue StandardError
      _result = false
    end

    _msg = sprintf('Rebuild image: %s', _image_path)
    if _result
      _msg += sprintf(' - %s', VOC.done)
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s', VOC.failed)
      ALX::LOG.error(_msg)
    end
  end

end # class ImageRebuilder

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _ir = ALX::ImageRebuilder.new
    _ir.exec
  end
end
