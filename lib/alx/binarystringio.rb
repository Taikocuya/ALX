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

require('delegate')
require('stringio')
require_relative('serializable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write easily in binary strings.
class BinaryStringIO < DelegateClass(::StringIO)
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Serializable)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # @see ::StringIO::new
  def initialize(*_args, **_opts)
    _be   = _opts[:be]
    _be ||= _opts[:big_endian]
    _le   = _opts[:le]
    _le ||= _opts[:little_endian]
    if _be && !_le
      self.endianness = _be
    elsif !_be && _le
      self.endianness = _le
    else
      self.endianness = _opts[:endianness]
    end

    @stringio = StringIO.new(*_args)
    super(@stringio)
  end

  # @see ::StringIO::open
  def self.open(*_args, **_opts)
    _stringio = new(*_args, **_opts)
  
    if block_given?
      begin
        yield(_stringio)
      ensure
        _stringio.close
      end
    else
      _stringio
    end
  end

end # class BinaryStringIO

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
