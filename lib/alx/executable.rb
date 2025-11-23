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

require('date')
require_relative('fileable.rb')
require_relative('worker.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Mixin for command-line tool.
module Executable

#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Fileable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Date of ALX
  DATE    = Time.new(2025, 11, 23, 22, 7, 3, 0).freeze
  # Version of ALX
  VERSION = '5.1.0.pre.20251123230703'.freeze

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Executable.
  def initialize
    @repeat = false
    if Worker.parent?
      show_version
    end
  end
  
  # Destructs an Executable.
  def self.finalize(name)
    proc { IL.DeleteImages(1, [name]) }
  end
  
  # Displays version of ALX.
  def show_version
    LOG.info(DATE.strftime("ALX #{VERSION} (%Y-%m-%d)"))
    LOG.info(DATE.strftime('Copyright (C) %Y Marcel Renner'))
  end

  # Returns +true+ if Ruby version is valid, otherwise +false+.
  # @param _version [String] Version
  # @return [Boolean] +true+ if Ruby version is valid, otherwise +false+.
  def has_ruby?(_version)
    _msg = sprintf(VOC.check_ruby, _version)

    _result = RUBY_VERSION >= _version
    if _result
      _msg += sprintf(' - %s (%s)', VOC.valid, RUBY_VERSION)
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s (%s)', VOC.not_matched, RUBY_VERSION)
      ALX::LOG.error(_msg)
    end
    
    _result
  end

  # Executes #startup, #update and #shutdown. The #update method will be 
  # re-executed as long as #repeat is true.
  def exec
    startup
    
    loop do
      update
      unless @repeat
        break
      end
    end
    
    shutdown
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

    attr_accessor :repeat

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # This method is called before #update respectively as first in #exec.
  # @see #exec
  def startup
  end
  
  # This method is called after #startup and before #shutdown in #exec. It 
  # will be re-executed as long as #repeat is true.
  # @see #exec
  def update
  end
  
  # This method is called after #update respectively as last in #exec.
  # @see #exec
  def shutdown
  end

end # class Executable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
