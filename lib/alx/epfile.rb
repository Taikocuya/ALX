#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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

require_relative('aklzfile.rb')
require_relative('enemy.rb')
require_relative('entrydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write EP files.
class EpFile

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  STR_OPEN       = EntryData::STR_OPEN
  STR_OPEN_READ  = EntryData::STR_OPEN_READ
  STR_OPEN_WRITE = EntryData::STR_OPEN_WRITE
  STR_OPEN_DATA  = EntryData::STR_OPEN_DATA
  STR_READ       = EntryData::STR_READ
  STR_WRITE      = EntryData::STR_WRITE
  STR_CLOSE      = EntryData::STR_CLOSE

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EpFile.
  # @param _region [String] Region ID
  def initialize(_region)
    @region      = _region
    @enemies     = []
    @items       = {}
    @magics      = {}
    @super_moves = {}
  end
  
  # Creates an enemy.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Entry] Enemy object
  def create_enemy(_id = -1, _filename = '*')
    _enemy              = Enemy.new(region)
    _enemy.id           = _id
    _enemy.files       << File.basename(_filename)
    _enemy.items        = @items
    _enemy.magics       = @magics
    _enemy.super_moves  = @super_moves
    _enemy
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :region
  attr_accessor :enemies
  attr_accessor :items
  attr_accessor :magics
  attr_accessor :super_moves

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns an enemy by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Enemy] Enemy
  def find_enemy(_id, _filename)
    _enemies = @enemies.select { |_enemy| _enemy.id == _id }
      
    _enemies.each do |_enemy|
      if _enemy.files.include?(File.basename(_filename))
        return _enemy
      end
    end

    _enemies.each do |_enemy|
      if _enemy.files.include?('*')
        return _enemy
      end
    end
    
    nil
  end

end # class EpFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
