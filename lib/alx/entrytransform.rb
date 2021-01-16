#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2021 Marcel Renner
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

require_relative('executable.rb')
require_relative('gameroot.rb')
require_relative('main.rb')

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
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EntryTransform.
  # @param _class [EntryData] Class which represents entry data.
  def initialize(_class)
    super()
    @class   = _class
    @data    = []
    @command = 'alx.rb'
    @failed  = false
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
    _root = GameRoot.new
    _root.load(_path)
    
    if !_root.valid? || !valid?(_root)
      raise(IOError, 'game directory invalid')
    end
    
    @data << create_entry_data(_root)
  end
  
  # Collects and validates several game directories in +SYS.build_dir+.
  def collect
    if has_ruby?(SYS.ruby_version) && has_dir?(SYS.build_dir)
      _game_dirs = [
        SYS.backup_dir, SYS.cache_dir, SYS.data_dir, 
        SYS.image_dir , SYS.meta_dir , SYS.root_dir,
      ].join(',')
      _game_dirs = sprintf('{%s}', _game_dirs)

      Dir.glob(File.join(SYS.build_dir, SYS.gameroot_dir, '/')).each do |_p|
        if Dir.glob(File.join(_p, _game_dirs, '/')).empty?
          next
        end

        store(_p)
      end
    end
  end
  
  # Returns +true+ if all necessary commands and files exist, otherwise 
  # +false+.
  # 
  # @param _root [GameRoot] Game root
  #
  # @return [Boolean] +true+ if all necessary commands and files exist, 
  #                   otherwise +false+.
  def valid?(_root)
    _valid   = true
    _valid &&= has_file?(_root.dirname, _root.sys(:exec_file))
    _valid &&= has_file?(_root.dirname, _root.sys(:level_file))
    
    if _root.eu?
      _valid &&= has_file?(_root.dirname, _root.sys(:sot_file_gb))
      _valid &&= has_file?(_root.dirname, _root.sys(:sot_file_de))
      _valid &&= has_file?(_root.dirname, _root.sys(:sot_file_es))
      _valid &&= has_file?(_root.dirname, _root.sys(:sot_file_fr))
    end
    
    _valid
  end
  
  # Collects and validates several game directories in +SYS.build_dir+.
  def exec
    collect
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------
  
  attr_reader   :data
  attr_accessor :command

end # class EntryTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
