#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
require('etc')
require_relative('alx.rb')
require_relative('main.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an editable text configuration.
class ETC

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Configuration directories
  CONFIG_DIRS = [
    File.dirname(__FILE__), File.join(File.dirname(__FILE__), '../../config'),
  ]
  
  # Configuration files
  CONFIG_FILES = {
    :SYS => 'sys.rb',
    :VOC => 'voc.rb',
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # Constructs an ETC.
  def initialize(_symbol, _filename)
    @symbol     = _symbol
    @filename   = _filename
    @size       = 0
    @checksum   = '0'
    @modifiable = true

    _buffer = ''
    CONFIG_DIRS.each do |_dirname|
      _path = File.join(_dirname, _filename)
      if File.exist?(_path)
        File.open(_path, 'r') do |_f|
          _buffer << _f.read
        end
      end
    end
    unless _buffer.empty?
      @checksum = Digest::SHA2.hexdigest(_buffer)
    end

    if block_given?
      yield self
    end
    if @size > 0
      @modifiable = false
    end
  end

  # Loads and initializes the configuration core.
  def self.init
    @@initialized ||= false
    if @@initialized
      return @@initialized
    end

    CONFIG_FILES.each do |_sym, _basename|
      ALX.const_set(_sym, ETC.new(_sym, _basename))
      CONFIG_DIRS.each do |_dirname|
        _path = File.join(_dirname, _basename)
        if File.exist?(_path)
          require(_path)
        end
      end
    end
    
    @@initialized = true
  end

  # @see ::Enumerable#each
  def self.configure(&_block)
    _config = self.new
    _config.configure(&_block)
    _config
  end

  # @see ::Enumerable#each
  def configure
    yield self
    if @size > 0
      @modifiable = false
    end
  end

  # @see ::BasicObject#method_missing
  def method_missing(_sym, *_args)
    _method = _sym[/.*(?==\z)/m]
    if @modifiable && _method
      if _args.length != 1
        _msg = "wrong number of arguments (#{_size} for 1)"
        raise(ArgumentError, _msg, caller(1))
      end

      singleton_class.class_eval(%Q{
        def #{_method}(*_args)
          if _args.size > 1
            @#{_method}[_args]
          elsif _args.size == 1
            @#{_method}[*_args]
          else
            @#{_method}
          end
        end

        def #{_method}=(_value)
          _src = @#{_method}
          _dst = _value
          
          _valid   = _src.class == _dst.class
          _valid ||= _src == true  && [true, false].include?(_dst)
          _valid ||= _src == false && [true, false].include?(_dst)
          unless _valid
            _src = _src.class.name
            _dst = _dst.class.name
            _msg = sprintf(
              'no implicit conversion of %s into %s', _src, _dst
            )
            raise(TypeError, _msg, caller)
          end
          
          @#{_method} = _value
        end
      })
      instance_variable_set("@#{_method}", _args.first)
      
      @size += 1
    else
      raise(NoMethodError, "undefined method `#{_sym}' for #{self}", caller)
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :symbol
  attr_reader :filename
  attr_reader :size
  attr_reader :checksum
  attr_reader :modifiable

end # module ETC

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

ALX::Main.call do
  ALX::ETC.init
end
