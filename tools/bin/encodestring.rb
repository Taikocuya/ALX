#! /usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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

require_relative('../../lib/alx/executable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to encode a string from Shift_JIS to hexadecimal.
class StringEncoder
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Executable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Input string
  INPUT_STR = ''
  INPUT_STR.encode!('Shift_JIS', 'UTF-8')

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def exec
    print("\n")
    print(sprintf("Input string in %s: %s\n", INPUT_STR.encoding, INPUT_STR))
    _output = INPUT_STR.each_byte.map { |b| b.to_s(16) }.join
    print(sprintf("Output string in hexadecimal: %s\n", _output))
  end

end # class StringEncoder

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  begin
    _se = ALX::StringEncoder.new
    _se.exec
  rescue => _e
    print(_e.class, "\n", _e.message, "\n", _e.backtrace.join("\n"), "\n")
  end
end
