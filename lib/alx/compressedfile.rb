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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write in files depending on GameRoot#compression.
module CompressedFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # Returns a file object depending on GameRoot#compression. 
  # @return [Object] File object depending on GameRoot#compression
  # @param _root [GameRoot] Game root
  # @see ::BinaryFile::new
  # @see ::BinaryStringIO::new
  def self.new(_root, *_args)
    unless _root.is_a?(GameRoot)
      _msg = '%s is not a %s'
      raise(TypeError, sprintf(_msg, _root, GameRoot.name))
    end
    
    _class = _root.compression
    unless _class.included_modules.include?(Serializable)
      _msg = '%s is not %s'
      raise(TypeError, sprintf(_msg, _class, Serializable.name))
    end
    
    _class.new(*_args, endianness: _root.endianness)
  end

  # Opens a file depending on GameRoot#compression.
  # @param _root [GameRoot] Game root
  # @see ::BinaryFile::open
  # @see ::BinaryStringIO::open
  def self.open(_root, *_args, &_block)
    unless _root.is_a?(GameRoot)
      _msg = '%s is not a %s'
      raise(TypeError, sprintf(_msg, _root, GameRoot.name))
    end
    
    _class = _root.compression
    unless _class.included_modules.include?(Serializable)
      _msg = '%s is not %s'
      raise(TypeError, sprintf(_msg, _class, Serializable.name))
    end
    
    _class.open(*_args, endianness: _root.endianness, &_block)
  end

end # module CompressedFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
