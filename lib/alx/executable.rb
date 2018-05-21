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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Mixin for every command line tool.
module Executable
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Version of ALX
  VERSION = '2.4.0'
  # Date of ALX
  DATE    = Time.new(2018, 5, 21)

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Executable.
  def initialize
    show_version
  end

  # Returns +true+ if file exists, otherwise +false+.
  # @param _filename [String] File name
  # @return [Boolean] +true+ if file exists, otherwise +false+.
  def has_file?(_filename)
    print("Check for existing file: #{File.expand_path(_filename)}")

    _result = File.exist?(_filename) && !File.directory?(_filename)

    if _result
      print(" - exists\n")
    else
      print(" - not found\n")
    end
    
    _result
  end

  # Returns +true+ if directory exists, otherwise +false+.
  # @param _dirname [String] Directory name
  # @return [Boolean] +true+ if file exists, otherwise +false+.
  def has_dir?(_dirname)
    print("Check for existing directory: #{File.expand_path(_dirname)}")
    
    _result = Dir.exist?(_dirname) && File.directory?(_dirname)

    if _result
      print(" - exists\n")
    else
      print(" - not found\n")
    end
    
    _result
  end

  # Returns +true+ if environment is a Windows system, otherwise +false+.
  # @return [Boolean] +true+ if environment is a Windows system, otherwise 
  #                   +false+.
  def windows?
    print("Check for platform: #{RUBY_PLATFORM}")
    
    _result = (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil

    if _result
      print(" - compatible\n")
    else
      print(" - incompatible\n")
    end
    
    _result
  end
  
  # Displays version of ALX.
  def show_version
    print("\n")
    print(DATE.strftime("ALX #{VERSION} (%Y-%m-%d)\n"))
    print(DATE.strftime("Copyright (C) %Y Marcel Renner\n"))
  end

end # class Executable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
