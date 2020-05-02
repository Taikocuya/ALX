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

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('alx.rb')

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
  def initialize
    @attr_count  = 0
    @define_attr = true
    @verify_type = true
    
    if block_given?
      yield self
    end
    if @attr_count > 0
      @define_attr = false
    end
  end

  # Loads and initializes the configuration core.
  def self.init
    @@initialized ||= false
    if @@initialized
      return @@initialized
    end
    
    CONFIG_FILES.each do |_k, _f|
      ALX.const_set(_k, ETC.new)
      require_relative(_f)
      _etc_file = File.join(File.dirname(__FILE__), '../../etc', _f)
      if File.exist?(_etc_file)
        require_relative(_etc_file)
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
    if @attr_count > 0
      @define_attr = false
    end
  end

  # @see ::BasicObject#method_missing
  def method_missing(_sym, *_args)
    _method = _sym[/.*(?==\z)/m]
    if @define_attr && _method
      if _args.length != 1
        _msg = "wrong number of arguments (#{_size} for 1)"
        raise(ArgumentError, _msg, caller(1))
      end

      singleton_class.class_eval(%Q{
        attr_reader :#{_method}
        def #{_method}=(_value)
          _src = @#{_method}
          _dst = _value
          
          if @verify_type
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
          end
          
          @#{_method} = _value
        end
      })
      instance_variable_set("@#{_method}", _args.first)
      
      @attr_count += 1
    else
      raise(NoMethodError, "undefined method `#{_sym}' for #{self}", caller)
    end
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader   :attr_count
  attr_accessor :define_attr
  attr_accessor :verify_type
  
end # module ETC

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

begin
  ALX::ETC.init
rescue => _e
  print(_e.message, "\n", _e.backtrace.join("\n"), "\n")
  exit(1)
end
