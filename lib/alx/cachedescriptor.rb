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

require('digest')
require_relative('rangedescriptor.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a cache descriptor.
class CacheDescriptor

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a CacheDescriptor.
  # @param _pool       [String,Symbol]   Descriptor pool
  # @param _descriptor [RangeDescriptor] Range descriptor
  def initialize(_pool, _descriptor)
    @pool       = _pool
    @descriptor = _descriptor
    clear
  end

  # Clears #modified and #checksum to their default values.
  def clear
    @modified = Time.new(0)
    @checksum = ''
  end

  # Compares two cache descriptors based on #descriptor. Returns +true+ if all 
  # properties are equal, or +false+ otherwise.
  # @param _entry [Entry] CacheDescriptor object
  # @return [Boolean] +true+ if all properties are equal, otherwise +false+.
  def ==(_dscr)
    _result   = true
    _result &&= _dscr.is_a?(self.class)
    _result &&= (@pool       == _dscr.pool      )
    _result &&= (@descriptor == _dscr.descriptor)
    _result
  end

  # Refreshes #modified, #checksum and returns +true+ if the data has been 
  # modified, otherwise +false+.
  # @return [Boolean] +true+ if data has been modified, otherwise +false+.
  def refresh
    _filename = Root.glob(@descriptor.name)
    _mtime    = create_mtime(_filename)
    _result   = true
    if _mtime != @modified
      @modified = _mtime
    else
      return false
    end

    _sha1 = create_checksum(_filename)
    if _sha1 != @checksum
      @checksum = _sha1
    else
      return false
    end

    true
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :pool
  attr_accessor :descriptor
  attr_accessor :modified
  attr_accessor :checksum

  def name
    @descriptor.name
  end
  
  def addr
    @descriptor.addr
  end
  
  def beg
    @descriptor.beg
  end
  
  def end
    @descriptor.end
  end
  
  def min
    @descriptor.min
  end
  
  def max
    @descriptor.max
  end
  
  def excl
    @descriptor.excl
  end
  
  def msgtbl
    @descriptor.msgtbl
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private
  
  # @see File.mtime
  def create_mtime(_filename)
    if File.exist?(_filename)
      File.mtime(_filename)
    else
      Time.new
    end
  end
  
  # @see Digest::SHA1.hexdigest
  def create_checksum(_filename)
    _digest = Digest::SHA1.new

    if File.exist?(_filename)
      File.open(_filename, 'rb') do |_f|
        @descriptor.each do |_range|
          _f.pos = _range.begin
          if _range.size == 0x100000000
            _buffer = ''
            while _f.read(16384, _buffer)
              _digest.update(_buffer)
            end
          else
            _buffer = _f.read(_range.size)
            _digest.update(_buffer)
          end
        end
      end
    else
      _digest.update('')
    end
    
    _digest.to_s
  end
  
end # class CacheDescriptor

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
