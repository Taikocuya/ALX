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

require_relative('property.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to handle a property as string.
class StrVar < Property
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a StrVar
  # @param _name  [String]  Name
  # @param _value [String]  Value
  # @param _size  [Integer] Size
  # @param _esc   [Boolean] Escape non-printing characters
  def initialize(_name, _value, _size, _esc = true)
    super(_name, _value)
    @size = _size
    @esc  = _esc
  end

  # Reads one entry from a binary I/O stream
  # @param _f [IO] Binary I/O stream
  def read_bin(_f)
    super
    self.value = _f.read_str(@size)
  end
  
  # Write one entry to a binary I/O stream
  # @param _f [IO] Binary I/O stream
  def write_bin(_f)
    super
    _f.write_str(value, @size)
  end

  # Reads one entry from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_csv(_row)
    super
    
    self.value = _row[name] || value
    self.value.force_encoding('UTF-8')
    
    if @esc
      self.value.gsub!(/(?<!\\)\\n/                ) { "\n"            }
      self.value.gsub!(/(?<!\\)\\r/                ) { "\r"            }
      self.value.gsub!(/(?<!\\)\\t/                ) { "\t"            }
      self.value.gsub!(/\\\\/                      ) { "\\"            }
    end
  end

  # Writes one entry to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_csv(_row)
    super
    
    _value = value.dup
    _value.force_encoding('UTF-8')
    
    if @esc
      _value.gsub!(/\\(?!x[0-9A-Fa-f]{2})/) { '\\\\' }
      _value.gsub!(/\t/                   ) { '\t'   }
      _value.gsub!(/\r/                   ) { '\r'   }
      _value.gsub!(/\n/                   ) { '\n'   }
    end
    
    _row[name] = _value
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :size
  attr_accessor :esc

  def value=(_value)
    _value = _value.to_s
    super(_value)
  end
  
end # class StrVar

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
