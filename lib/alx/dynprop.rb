#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2023 Marcel Renner
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

require_relative('prop.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a dynamic property.
class DynProp < Prop
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a DynProp which mimics another property depending on the 
  # assigned value. If a block is specified, it will be called in #value= when 
  # the value has been changed. The block is a prerequisite to migrate to 
  # another property based on the assigned value and the returned Prop 
  # instance of the block.
  # 
  # @param _value [Object] Value
  def initialize(_value)
    @prop = nil
    super(_value)
  end

  # Returns +true+ if property is comparable, otherwise +false+.
  # @return [Boolean] +true+ if property is comparable, otherwise +false+.
  def comparable?
    @prop.comparable
  end
  
  # Returns +true+ if property is serialized externally, otherwise +false+.
  # @return [Boolean] +true+ if property is is serialized externally, 
  #                   otherwise +false+.
  def external?
    @prop.external
  end
  
  # If Prop::new was invoked with a block, call that block.
  def call_proc
    if @proc.is_a?(Proc)
      @prop = @proc.call(@value, self)
      unless @prop.is_a?(Prop)
        raise(TypeError, sprintf('%s is not a prop', @prop.inspect))
      end
    end
  end
  
  # Reads one entry from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def read_bin(...)
    @prop.read_bin(...)
  end
  
  # Write one entry to a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  def write_bin(...)
    @prop.write_bin(...)
  end

  # Reads one entry from a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def read_csv(_header, _row)
    _value = _row[_header] || value
    if _value.is_a?(String)
      _value.force_encoding('UTF-8')
    end
    
    self.value = _value
    @prop.read_csv(_header, _row)
  end

  # Writes one entry to a CSV row.
  # @param _header [String]   Column header
  # @param _row    [CSV::Row] CSV row
  def write_csv(...)
    @prop.write_csv(...)
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash         = super
    _hash[:@prop] = @prop
    _hash
  end

  # @see ::BasicObject#method_missing
  def method_missing(_sym, *_args)
    if @prop.class.instance_methods(false).include?(_sym)
      @prop.send(_sym, _args)
    else
      super
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  def value
    @prop.value
  end

  def to_f(...)
    @prop.value.to_f(...)
  end
  
  def to_i(...)
    @prop.value.to_i(...)
  end
  
  def to_s(...)
    @prop.value.to_s(...)
  end

end # class DynProp

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
