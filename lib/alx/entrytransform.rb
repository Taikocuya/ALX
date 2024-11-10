#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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

require_relative('etc.rb')
require_relative('executable.rb')
require_relative('log.rb')
require_relative('root.rb')

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
    @data    = nil
    @command = 'alx.rb'
  end
  
  # Creates an entry data object.
  # @return [EntryData] Entry data object
  def create_entry_data
    @class&.new
  end
  
  # @see Root#etc
  def etc(...)
    Root.etc(...)
  end

  # @see Root#sys
  def sys(...)
    Root.sys(...)
  end

  # @see Root#voc
  def voc(...)
    Root.voc(...)
  end

  # @see Root#join
  def join(...)
    Root.join(...)
  end

  # @see Root#glob
  def glob(...)
    Root.glob(...)
  end

  # Loads and validates a game directory.
  # @param _path [String] Game directory
  def load(_path)
    Root.load(_path)
    
    if !Root.valid? || !valid?
      raise(IOError, 'game directory invalid')
    end
    
    @data = create_entry_data
  end
  
  # Collects the game directories in +SYS.build_dir+ and spawns worker 
  # processes for them.
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

        Worker.wait(SYS.worker_max + 1)
        Worker.spawn(_p)
      end
      Worker.wait
    end
  end
  
  # Returns +true+ if all necessary commands and files exist, otherwise 
  # +false+.
  # 
  # @return [Boolean] +true+ if all necessary commands and files exist, 
  #                   otherwise +false+.
  def valid?
    _valid   = true
    _valid &&= has_file?(Root.dirname, sys(:exec_file))
    _valid &&= has_file?(Root.dirname, sys(:level_file))
    
    if Root.eu?
      _valid &&= has_file?(Root.dirname, sys(:sot_file_gb))
      _valid &&= has_file?(Root.dirname, sys(:sot_file_de))
      _valid &&= has_file?(Root.dirname, sys(:sot_file_es))
      _valid &&= has_file?(Root.dirname, sys(:sot_file_fr))
    end
    
    _valid
  end
  
  # This method is called before #update respectively as first in #exec.
  # @see #exec
  def startup
    super
    if Worker.parent?
      collect
    else
      load(Worker.key)
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------
  
  attr_reader   :data
  attr_accessor :command

  def product_id
    Root.product_id
  end
  alias pid product_id
  
  def country_id
    Root.country_id
  end
  alias cid country_id

  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def dc?
    Root.dc?
  end

  # Returns +true+ if the platform is a GameCube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a GameCube, otherwise +false+.
  def gc?
    Root.gc?
  end

  # Returns +true+ if the country is 'EU', otherwise +false+.
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def eu?
    Root.eu?
  end

  # Returns +true+ if the country is 'JP', otherwise +false+.
  # @return [Boolean] +true+ if country is 'JP', otherwise +false+.
  def jp?
    Root.jp?
  end

  # Returns +true+ if the country is 'US', otherwise +false+.
  # @return [Boolean] +true+ if country is 'US', otherwise +false+.
  def us?
    Root.us?
  end

  # Returns +:big+ or +:little+ depending on the platform endianness.
  # @return [Symbol] +:big+ or +:little+ depending on endianness.
  def endianness
    Root.endianness
  end

  # Returns +true+ if the endianness is big-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is big-endian, otherwise +false+.
  def big_endian?
    Root.big_endian?
  end

  # Returns +true+ if the endianness is little-endian, otherwise +false+.
  # @return [Boolean] +true+ if endianness is little-endian, otherwise +false+.
  def little_endian?
    Root.little_endian?
  end

end # class EntryTransform

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
