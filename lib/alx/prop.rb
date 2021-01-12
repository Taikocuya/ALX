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

# Class to handle a property.
class Prop

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Prop. If a block is specified, it will be called in #value= 
  # when the value has been changed.
  # 
  # @param _value [Object]  Value
  # @param comp   [Boolean] Is comparable
  # @param dmy    [Boolean] Set +comp+ to +false+ and +ext+ to +true+
  # @param ext    [Boolean] Serialize externally
  def initialize(_value, comp: true, dmy: false, ext: false, &_block)
    @value      = _value
    @comparable = comp && !dmy
    @external   = ext  ||  dmy
    @proc       = _block
    call_proc
  end

  # Returns +true+ if property is comparable, otherwise +false+.
  # @return [Boolean] +true+ if property is comparable, otherwise +false+.
  def comparable?
    @comparable
  end
  
  # Returns +true+ if property is serialized externally, otherwise +false+.
  # @return [Boolean] +true+ if property is is serialized externally, 
  #                   otherwise +false+.
  def external?
    @external
  end
  
  # If Prop::new was invoked with a block, call that block.
  def call_proc
    if @proc.is_a?(Proc)
      @proc.call(@value, self)
    end
  end
  
  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    _msg = "undefined method `#{__method__}' for #{self}"
    raise(NoMethodError, _msg, caller)
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    _msg = "undefined method `#{__method__}' for #{self}"
    raise(NoMethodError, _msg, caller)
  end

  # Reads one entry from a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def read_csv(_header, _row)
    _msg = "undefined method `#{__method__}' for #{self}"
    raise(NoMethodError, _msg, caller)
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(_header, _row)
    _msg = "undefined method `#{__method__}' for #{self}"
    raise(NoMethodError, _msg, caller)
  end

  # Provides marshalling support for use by the Marshal library.
  # @param _hash [Hash] Hash object
  def marshal_load(_hash)
    _hash.each do |_key, _value|
      instance_variable_set(_key, _value)
    end
    @proc = nil
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash               = {}
    _hash[:@value     ] = @value
    _hash[:@comparable] = @comparable
    _hash[:@external  ] = @external
    _hash
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :comparable
  attr_accessor :external
  attr_reader   :proc
  attr_reader   :value
  
  def proc=(_proc)
    @proc = _proc
    call_proc
  end

  def value=(_value)
    unless @value.eql?(_value)
      @value = _value
      call_proc
    end
  end
  
  def to_f(...)
    @value.to_f(...)
  end
  
  def to_i(...)
    @value.to_i(...)
  end
  
  def to_s(...)
    @value.to_s(...)
  end

end # class Prop

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
