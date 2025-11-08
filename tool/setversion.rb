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

require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to update version in the "executable.rb" file.
class VersionSetter < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an VersionSetter.
  def initialize
    super(nil)
  end

  # This method is called before #update respectively as first in #exec.
  # @see #exec
  def startup
  end
  
  # This method is called after #startup and before #shutdown in #exec. It 
  # will be re-executed as long as #repeat is true.
  # @see #exec
  def update
    super
    _path = File.join(File.dirname(__FILE__), '../lib/alx/executable.rb')
    _time = Time.now.gmtime

    LOG.info(sprintf(VOC.load, VOC.open_file, _path))
    _text = File.read(_path)

    _text.gsub!(/(DATE *= *Time.new\()[^\)]+/) do
      Regexp.last_match(1) + 
      _time.year.to_s      + ', ' +
      _time.month.to_s     + ', ' +
      _time.day.to_s       + ', ' +
      _time.hour.to_s      + ', ' +
      _time.min.to_s       + ', ' +
      _time.sec.to_s       + ', ' +
      '0'
    end

    _text.gsub!(/(VERSION *= *')(\d+\.\d+\.\d+)[^']+/) do
      (
        Regexp.last_match(1) + 
        Regexp.last_match(2) + 
        '.pre.' + Time.now.strftime('%Y%m%d%H%M%S')
      )
    end

    LOG.info(sprintf(VOC.save, VOC.open_file, _path))
    File.write(_path, _text)
  end

end # class VersionSetter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _vs = ALX::VersionSetter.new
    _vs.exec
  end
end
