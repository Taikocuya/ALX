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

require('delegate')
require_relative('serializable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write easily in binary files.
class BinaryFile < DelegateClass(::File)
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Serializable)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # @see ::IO::new
  def initialize(*_args, **_opts)
    _be   = _opts[:be]
    _be ||= _opts[:big_endian]
    _le   = _opts[:le]
    _le ||= _opts[:little_endian]
    if _be && !_le
      self.endianness = :be
    elsif !_be && _le
      self.endianness = :le
    else
      self.endianness = _opts[:endianness]
    end

    @file = File.new(*_args, **_opts)
    @file.set_encoding('ASCII-8BIT')
    
    super(@file)
  end

  # @see ::IO::open
  def self.open(...)
    _file = new(...)
  
    if block_given?
      begin
        yield(_file)
      ensure
        _file.close
      end
    else
      _file
    end
  end

end # class BinaryFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
