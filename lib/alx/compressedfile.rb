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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write in files depending on Root#compression.
module CompressedFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # Returns a file object depending on Root#compression. 
  # @return [Object] File object depending on Root#compression
  # @see ::BinaryFile::new
  # @see ::BinaryStringIO::new
  def self.new(*_args)
    _class = Root.compression
    unless _class.included_modules.include?(Serializable)
      raise(TypeError, sprintf('%s is not %s', _class, Serializable.name))
    end
    
    _class.new(*_args, **{ endianness: Root.endianness })
  end

  # Opens a file depending on Root#compression.
  # @see ::BinaryFile::open
  # @see ::BinaryStringIO::open
  def self.open(*_args, &_block)
    _class = Root.compression
    unless _class.included_modules.include?(Serializable)
      raise(TypeError, sprintf('%s is not %s', _class, Serializable.name))
    end
    
    _class.open(*_args, **{ endianness: Root.endianness }, &_block)
  end

end # module CompressedFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
