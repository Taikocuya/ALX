#!/usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2023 Marcel Renner
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
    super(nil)
  end
  
  def valid?
    _result = super
    if Root.dc?
      _result &&= has_file?(Root.dirname, SYS.image_dir, 'game.gdi')
    end
    _result
  end

  # This method is called before #update respectively as first in #exec.
  # @see #exec
  def startup
    # Image building is very write intensive. Therefore, only one active and 
    # passive worker process is allowed.
    Worker.limit = 2
    super
  end

  # This method is called after #startup and before #shutdown in #exec. It 
  # will be re-executed as long as #repeat is true.
  # @see #exec
  def update
    super

    if Worker.child?
      if dc?
        build_gdi
      elsif gc?
        build_gcm
      end
    end
  end

  # Builds a GDI image.
  def build_gdi
    _root_dir  = ALX.join(Root.dirname, SYS.root_dir )
    _image_dir = ALX.join(Root.dirname, SYS.image_dir)
    _gdi_file  = ALX.join(_image_dir  , 'game.gdi'   )
    _ip_file   = ALX.join(Root.dirname, SYS.ip_file  )

    LOG.info(sprintf(VOC.build_gdi, _gdi_file))

    FileUtils.mkdir_p(_image_dir)
    _stdout, _stderr, _status = Open3.capture3(
      SYS.gdi_builder_exe,
      '-data'  , _root_dir ,
      '-gdi'   , _gdi_file ,
      '-ip'    , _ip_file  ,
      '-output', _image_dir
    )

    unless _status.success?
      _stderr.strip!
      _stderr.gsub!(/\s+/, ' ')
      raise(IOError, _stderr)
    end
  end
  
  # Builds a GCM image.
  def build_gcm
    _root_dir  = ALX.join(Root.dirname, SYS.root_dir )
    _image_dir = ALX.join(Root.dirname, SYS.image_dir)
    _gcm_file  = ALX.join(_image_dir  , 'game.iso'   )

    LOG.info(sprintf(VOC.build_gcm, _gcm_file))

    if File.exist?(_gcm_file)
      File.unlink(_gcm_file)
    end
    FileUtils.mkdir_p(_image_dir)
    system(SYS.gcm_builder_exe, _root_dir, _gcm_file)
    
    unless File.size?(_gcm_file)
      raise(IOError, 'image invalid')
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
