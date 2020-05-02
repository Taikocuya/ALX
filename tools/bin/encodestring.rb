#! /usr/bin/ruby
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

require_relative('../../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to encode a string from Shift_JIS to hexadecimal.
class StringEncoder < EntryTransform

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Input string
  IN_STR = ''
  IN_STR.encode!('Shift_JIS', 'UTF-8')

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an StringEncoder.
  def initialize
    super(Object)
  end
  
  # Creates an entry data object.
  # @param _root [GameRoot] Game root
  # @return [EntryData] Entry data object
  def create_entry_data(_root)
    nil
  end
  
  def exec
    unless has_ruby?(SYS.ruby_version)
      return
    end
  
    ALX::LOG.info(sprintf('Input string in %s: %s', IN_STR.encoding, IN_STR))
    _output = IN_STR.each_byte.map { |_b| sprintf('%02x', _b) }
    _output = _output.join(' ')
    ALX::LOG.info(sprintf('Output string in hexadecimal: %s', _output))
  end

end # class StringEncoder

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _se = ALX::StringEncoder.new
    _se.exec
  end
end
