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
#                                   REQUIRES
#==============================================================================

require_relative('bnrfile.rb')
require_relative('hdrfile.rb')

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
  VERSION  = '1.0.1'
  # Date of ALX
  DATE     = Time.new(2015, 01, 26)
  # Path to BNR file
  BNR_FILE = '../share/root/opening.bnr'
  # Path to HDR file
  HDR_FILE = '../share/root/&&systemdata/ISO.hdr'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EntryData.
  def initialize
    show_version
  end
  
  # Returns +true+ if all necessary commands and files exist, otherwise 
  # +false+.
  # 
  # @return [Boolean] +true+ if all necessary commands and files exist, 
  #                   otherwise +false+.
  def valid?
    print("\n")
    _valid   = check_bnr
    _valid &&= check_hdr
  end

  # Returns +true+ if file exists, otherwise +false+.
  # @param _file [String] File name
  # @return [Boolean] +true+ if file exists, otherwise +false+.
  def has_file?(_file)
    print("Check for existing file: #{File.basename(_file)}")
    
    _result = File.exist?(_file)

    if _result
      print(" - exists\n")
    else
      print(" - not found\n")
    end
    
    _result
  end

  # Returns +true+ if BNR file is valid, otherwise +false+.
  # @param _file [String] File name
  # @return [Boolean] +true+ if BNR file is valid, otherwise +false+.
  def check_bnr
    unless has_file?(BNR_FILE)
      return false
    end
    
    _bnr    = BnrFile.new(BNR_FILE)
    _result = false

    print('Check BNR file: Game title')
    if _bnr.game_title == "Skies of Arcadia Legends"
      _result = true
      print(" - valid")
    else
      print(" - incorrect")
    end
    print(" (#{_bnr.game_title})\n")
    
    if _result
      print('Check BNR file: Developer')
      if _bnr.developer == "SEGA"
        _result = true
        print(" - valid")
      else
        print(" - incorrect")
      end
      print(" (#{_bnr.developer})\n")
    end
    
    _result
  end

  # Returns +true+ if HDR file is valid, otherwise +false+.
  # @param _file [String] File name
  # @return [Boolean] +true+ if HDR file is valid, otherwise +false+.
  def check_hdr
    unless has_file?(HDR_FILE)
      return false
    end
    
    _hdr    = HdrFile.new(HDR_FILE)
    _result = false

    print('Check HDR file: Game ID')
    if _hdr.game_id == "GEAE8P"
      _result = true
      print(" - valid")
    else
      print(" - incorrect")
    end
    print(" (#{_hdr.game_id})\n")
    
    if _result
      print('Check HDR file: Name')
      if _hdr.name == "Skies of Arcadia Legends"
        _result = true
        print(" - valid")
      else
        print(" - incorrect")
      end
      print(" (#{_hdr.name})\n")
    end
    
    _result
  end

  # Displays version of ALX.
  def show_version
    print("\n")
    print(DATE.strftime("ALX #{VERSION} (%Y-%m-%d)\n"))
    print("Copyright (C) 2015 Marcel Renner\n")
  end
  
end # class Executable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
