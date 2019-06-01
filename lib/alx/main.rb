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

require_relative('etc.rb')
require_relative('log.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Module to handle the main function.
module Main

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Executes the given block in the main function.
  def self.call
    begin
      yield
    rescue Exception => _exception
      exception(_exception)
    end
  end

  # Raises an excepetion.
  # @param _exception [Exception] Exception object
  def self.exception(_exception)
    begin
      ALX::LOG.fatal(_exception.message)
      _exception.backtrace.each do |_trace|
        ALX::LOG.fatal(_trace)
      end
    rescue StandardError => _fallback
      print(_exception.message, "\n", _exception.backtrace.join("\n"), "\n")
      print( _fallback.message, "\n",  _fallback.backtrace.join("\n"), "\n")
    ensure
      exit(1)
    end
  end
  
end # module ETC

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
