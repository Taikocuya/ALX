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
require_relative('../../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to rebuild images from the "share" to "thirdparty/dolphin/Games" 
# directory.
class ImageRebuilder
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Executable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================
  
  # Path to 'share' directory
  SHARE_DIR = EntryTransform::SHARE_DIR
  # Path to 'thirdparty/dolphin/Games' directory
  GAMES_DIR = File.expand_path(
    File.join(File.dirname(__FILE__), '../../thirdparty/dolphin/Games')
  )
  # Path to 'thirdparty/gcr/gcr.exe' file
  GCR_FILE  = File.expand_path(
    File.join(File.dirname(__FILE__), '../../thirdparty/gcr/gcr.exe')
  )

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
  
      rebuild_image(
        File.join(_game_path, 'root'),
        File.join(GAMES_DIR, File.basename(_game_path)) + '.iso'
      )
    end
  end

  # Rebuilds an image.
  # @param _game_path  [String] Path of game root
  # @param _image_path [String] Path of game image
  def rebuild_image(_game_path, _image_path)
    print("Rebuild image: #{_image_path}")

    begin
      FileUtils.remove_file(_image_path)
      FileUtils.mkdir_p(File.dirname(_image_path))
      system("\"#{GCR_FILE}\" \"#{_game_path}\" \"#{_image_path}\"")
      _result = File.exist?(_image_path)
    rescue
      _result = false
    end

    if _result
      print(" - done\n")
    else
      print(" - failed\n")
    end
  end

end # class ImageRebuilder

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  begin
    _ir = ALX::ImageRebuilder.new
    _ir.exec
  rescue => _e
    print(_e.class, "\n", _e.message, "\n", _e.backtrace.join("\n"), "\n")
  end
end
