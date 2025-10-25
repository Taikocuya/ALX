#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

  # Returns formatted strings of the exception line by line as array. The 
  # returned string is formatted using the same format that Ruby uses when 
  # printing an uncaught exceptions to +stderr+.
  # 
  # @param _exception [Exception] Exception object
  # @param highlight  [Boolean]   Format colored messages
  # @param chomp      [Boolean]   Remove line endings in each line
  # 
  # @return [Array] Full message
  def self.trace(_exception, highlight: true, chomp: true)
    _exception.full_message(highlight: highlight).lines(chomp: chomp)
  end

  # Raises an excepetion.
  # @param _exception [Exception] Exception object
  def self.exception(_exception)
    begin
      _std_trace = trace(_exception, highlight: true )
      _log_trace = trace(_exception, highlight: false)
      _zip_trace = _std_trace.zip(_log_trace).flatten.compact

      if ALX.const_defined?(:LOG)
        _zip_trace.each_slice(2) do |_a, _b|
          LOG.fatal(_a, _b)
        end
      else
        raise(_exception)
      end
    rescue Exception => _fallback
      _bak_trace = trace(_fallback , highlight: true, chomp: false)
      _bak_trace.each do |_trace|
        print(_trace)
      end
    ensure
      if ALX.const_defined?(:Worker)
        Worker.kill(false)
      end
      exit(1)
    end
  end
  
  # Executes the given block in the main function.
  def self.call
    begin
      yield
    rescue Exception => _exception
      exception(_exception)
    end
  end
  
end # module Main

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
