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

require_relative('bnrfile.rb')
require_relative('executable.rb')
require_relative('gameroot.rb')
require_relative('hdrfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to export and/or import entries to and/or from CSV files.
class EntryTransform
  
#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Executable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================
  
  # Path to 'share' directory
  SHARE_DIR  = File.expand_path(
    File.join(File.dirname(__FILE__), '../../share')
  )
  # Path to BNR file relative to game root.
  BNR_FILE   = 'opening.bnr'
  # Path to DOL file relative to game root.
  DOL_FILE   = '&&systemdata/Start.dol'
  # Path to HDR file relative to game root.
  HDR_FILE   = '&&systemdata/ISO.hdr'
  # Path to English SOT file relative to game root (PAL-E only).
  SOT_GB_FILE = 'english.sot'
  # Path to German SOT file relative to game root (PAL-E only).
  SOT_DE_FILE = 'german.sot'
  # Path to Spanish SOT file relative to game root (PAL-E only).
  SOT_ES_FILE = 'spanish.sot'
  # Path to French SOT file relative to game root (PAL-E only).
  SOT_FR_FILE = 'french.sot'
  
  # Game ID
  GAME_ID    = 'GEA'
  # Region IDs
  REGION_IDS = {
    'E'  => 'NTSC-U',
    'J'  => 'NTSC-J',
    'P'  => 'PAL-E',
  }
  # Maker ID
  MAKER_ID   = '8P'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EntryTransform.
  # @param _class [EntryData] Class which represents entry data.
  def initialize(_class)
    @class = _class
    @data  = []
  end
  
  # Creates an entry data object.
  # @param _root [GameRoot] Game root
  # @return [EntryData] Entry data object
  def create_entry_data(_root)
    @class.new(_root)
  end
  
  # Stores and validates a game directory.
  # @param _path [String] Game directory
  def store(_path)
    _root      = GameRoot.new
    _root.path = _path
    _root.bnr  = BnrFile.new(File.join(_path, BNR_FILE))
    _root.hdr  = HdrFile.new(File.join(_path, HDR_FILE))
    
    if valid?(_root)
      unless @data.any? { |_d| _d.root.path == _path }
        @data << create_entry_data(_root)
      end
    end
  end
  
  # Collects and validates several game subdirectories in a given directory.
  # @param _path [String] Directory with game subdirectories inside it
  def collect(_path)
    Dir.glob(File.join(_path, '*')).each do |_p|
      unless File.directory?(_p)
        next
      end
      
      store(_p)
    end
  end
  
  # Collects and validates several game subdirectories in +SHARE_DIR+ by 
  # default.
  def exec
    collect(SHARE_DIR)
  end
  
  # Returns +true+ if all necessary commands and files exist, otherwise 
  # +false+.
  # 
  # @param _root [GameRoot] Game root
  #
  # @return [Boolean] +true+ if all necessary commands and files exist, 
  #                   otherwise +false+.
  def valid?(_root)
    print("\n")

    _path    = _root.path
    _bnr     = _root.bnr
    _hdr     = _root.hdr
    _valid   = true
    
    _valid &&= has_dir?(_path)
    _valid &&= check_bnr(_bnr)
    _valid &&= check_hdr(_hdr)
    _valid &&= has_file?(File.join(_path, DOL_FILE))
    
    if _hdr.region_id == 'P'
      _valid &&= has_file?(File.join(_path, SOT_GB_FILE))
      _valid &&= has_file?(File.join(_path, SOT_DE_FILE))
      _valid &&= has_file?(File.join(_path, SOT_ES_FILE))
      _valid &&= has_file?(File.join(_path, SOT_FR_FILE))
    end
    
    _valid
  end
  
  # Returns +true+ if BNR file is valid, otherwise +false+.
  # @param _bnr [BnrFile] BNR file
  # @return [Boolean] +true+ if BNR file is valid, otherwise +false+.
  def check_bnr(_bnr)
    unless has_file?(_bnr.filename)
      return false
    end
    
    _result = false

    print('Check BNR file: Game title')
    if _bnr.game_title =~ /^(Skies of Arcadia Legends|ｴﾀｰﾅﾙｱﾙｶﾃﾞｨｱ ﾚｼﾞｪﾝﾄﾞ)$/
      _result = true
      print(' - valid')
    else
      print(' - incorrect')
    end
    print(" (#{_bnr.game_title})\n")
    
    if _result
      print('Check BNR file: Developer')
      if _bnr.developer =~ /^(SEGA|セガ)$/
        _result = true
        print(' - valid')
      else
        print(' - incorrect')
      end
      print(" (#{_bnr.developer})\n")
    end
    
    _result
  end

  # Returns +true+ if HDR file is valid, otherwise +false+.
  # @param _hdr [HdrFile] HDR file
  # @return [Boolean] +true+ if HDR file is valid, otherwise +false+.
  def check_hdr(_hdr)
    unless has_file?(_hdr.filename)
      return false
    end
    
    _result = false
    
    print('Check HDR file: Game ID')
    if _hdr.game_id == GAME_ID
      _result = true
      print(' - valid')
    else
      print(' - incorrect')
    end
    print(" (#{_hdr.game_id})\n")

    if _result
      print('Check HDR file: Region ID')
      if REGION_IDS.include?(_hdr.region_id)
        _result = true
        print(' - valid')
      else
        print(' - incorrect')
      end
      print(" (#{_hdr.region_id})\n")
    end

    if _result
      print('Check HDR file: Maker ID')
      if _hdr.maker_id == MAKER_ID
        _result = true
        print(' - valid')
      else
        print(' - incorrect')
      end
      print(" (#{_hdr.maker_id})\n")
    end
    
    if _result
      print('Check HDR file: Name')
      if _hdr.name =~ /^(Skies of|Eternal) Arcadia Legends$/
        _result = true
        print(' - valid')
      else
        print(' - incorrect')
      end
      print(" (#{_hdr.name})\n")
    end
    
    _result
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------
  
  attr_reader :class
  attr_reader :data

end # class EntryTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
