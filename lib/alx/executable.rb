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

require('date')
require_relative('fileable.rb')
require_relative('main.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Mixin for every command line tool.
module Executable

#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Fileable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Version of ALX
  VERSION = '4.1.0'
  # Date of ALX
  DATE    = Date.new(2020, 5, 18)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Executable.
  def initialize
    show_version
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

end # class Executable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
