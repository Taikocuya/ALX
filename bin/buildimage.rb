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

require('open3')
require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to build images in +SYS.image_dir+.
class ImageBuilder < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ImageBuilder.
  def initialize
    super(GameRoot)
  end
  
  # Creates an entry data object.
  # @param _root [GameRoot] Game root
  # @return [EntryData] Entry data object
  def create_entry_data(_root)
    _root
  end

  def valid?(_root)
    _result = super
    if _root.dc?
      _result &&= has_file?(_root.dirname, SYS.image_dir, 'game.gdi')
    end
    _result
  end

  def exec
    super

    data.each do |_root|
      if _root.dc?
        build_gdi(_root)
      elsif _root.gc?
        build_gcm(_root)
      end
    end
  end

  # Builds a GDI image.
  # @param _root [GameRoot] Game root
  def build_gdi(_root)
    _root_dir  = ALX.join(_root.dirname, SYS.root_dir )
    _image_dir = ALX.join(_root.dirname, SYS.image_dir)
    _gdi_file  = ALX.join(_image_dir   , 'game.gdi'   )
    _ip_file   = ALX.join(_root.dirname, SYS.ip_file  )

    begin
      FileUtils.mkdir_p(_image_dir)
      _result = true
      Open3.popen3(
        SYS.gdi_builder_exe,
        '-data'  , _root_dir ,
        '-gdi'   , _gdi_file ,
        '-ip'    , _ip_file  ,
        '-output', _image_dir
      ) do |_, _stdout, _, _thread|
        _thread.pid
        _result = /Done!/.match?(_stdout.gets)
      end
    rescue StandardError
      _result = false
    end

    _msg = sprintf(VOC.build_gdi, _gdi_file)
    if _result
      _msg += sprintf(' - %s', VOC.done)
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s', VOC.failed)
      ALX::LOG.error(_msg)
    end
  end
  
  # Builds a GCM image.
  # @param _root [GameRoot] Game root
  def build_gcm(_root)
    _root_dir  = ALX.join(_root.dirname, SYS.root_dir )
    _image_dir = ALX.join(_root.dirname, SYS.image_dir)
    _gcm_file  = ALX.join(_image_dir   , 'game.iso'   )

    begin
      FileUtils.mkdir_p(_image_dir)
      if File.exist?(_gcm_file)
        FileUtils.remove_file(_gcm_file)
      end
      system(SYS.gcm_builder_exe, _root_dir, _gcm_file)
      _result = File.size?(_gcm_file)
    rescue StandardError
      _result = false
    end

    _msg = sprintf(VOC.build_gcm, _gcm_file)
    if _result
      _msg += sprintf(' - %s', VOC.done)
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s', VOC.failed)
      ALX::LOG.error(_msg)
    end
  end

end # class ImageBuilder

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _ir = ALX::ImageBuilder.new
    _ir.exec
  end
end
