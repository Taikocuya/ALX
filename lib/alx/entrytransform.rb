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
    if _root.valid? && valid?(_root)
      @data << create_entry_data(_root)
    end
  end
  
  # Collects and validates several game subdirectories in a given directory.
  # @param _path [String] Directory with game subdirectories inside it
  def collect(_path)
    if has_ruby?(SYS.ruby_version) && has_dir?(_path)
      Dir.glob(File.join(_path, '*')).each do |_p|
        unless File.directory?(_p)
          next
        end
        
        store(_p)
      end
    end
  end
  
  # Collects and validates several game subdirectories in +SYS.build_dir+ by 
  # default.
  def exec
    collect(SYS.build_dir)
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
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------
  
  attr_reader   :data
  attr_accessor :command

end # class EntryTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
