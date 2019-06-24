#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
module CompressionFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # Returns a file object depending on GameRoot#compression. 
  # @return [Object] File class depending on GameRoot#compression
  # @see ::File::new
  def self.new(_root, *_args)
    unless _root.is_a?(GameRoot)
      _msg = 'no implicit conversion of %s into %s'
      raise(TypeError, sprintf(_msg, _root.class.name, GameRoot.name))
    end
    
    _class = _root.compression
    _class.new(*_args)
  end

  # Opens a file depending on GameRoot#compression. 
  # @see ::File::open
  def self.open(_root, *_args, &_block)
    unless _root.is_a?(GameRoot)
      _msg = 'no implicit conversion of %s into %s'
      raise(TypeError, sprintf(_msg, _root.class.name, GameRoot.name))
    end
    
    _class = _root.compression
    _class.open(*_args, &_block)
  end

end # module CompressionFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
