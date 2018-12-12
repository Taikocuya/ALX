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

require_relative('epfile.rb')
require_relative('enemyevent.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write EVP files.
class EvpFile < EpFile
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Maximum number of enemies
  NUM_ENEMIES  = 200
  # Maximum number of events
  NUM_EVENTS   = 250

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EvpFile.
  # @param _region [String] Region ID
  def initialize(_region)
    super
    @events = []
  end

  # Creates a header node.
  # @param _id  [Integer] Enemy ID
  # @param _pos [Integer] Enemy position
  # @return [Hash] Hash object
  def create_node(_id, _pos)
    { :id => _id, :pos => _pos }
  end
  
  # Creates an event.
  # @param _id [Integer] Event ID
  # @return [Entry] EnemyEvent object
  def create_event(_id = -1)
    _event         = EnemyEvent.new(region)
    _event.id      = _id
    _event.enemies = enemies
    _event
  end

  # Reads an EVP file.
  # @param _filename [String] File name
  def load(_filename)
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    AklzFile.open(_filename, 'rb') do |_f|
      # Header
      _nodes = []
      (0...NUM_ENEMIES).each do |_|
        _id  = _f.read_int('l>')
        _pos = _f.read_int('l>')

        if _id >= 0 && _pos >= 0
          _nodes << create_node(_id, _pos)
        end
      end
      
      # Events
      _dummy = create_event
      (0...NUM_EVENTS).each do |_id|
        puts(sprintf(VOC.read, _id, _f.pos))
        _event = create_event(_id)
        _event.read_from_bin(_f)
        
        if _event != _dummy
          @events << _event
        end
      end

      # Enemies
      _nodes.each do |_node|
        _id    = _node[:id]
        _pos   = _node[:pos]
        _f.pos = _pos
        
        puts(sprintf(VOC.read, _id, _pos))
        load_enemy(_f, _id, _filename)
      end
    end
    
    puts(sprintf(VOC.close, _filename))
  end

  # Writes an EVP file.
  # @param _filename [String] File name
  def save(_filename)
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))
      
    AklzFile.open(_filename, 'wb') do |_f|
      # Events
      _enemies = []
      _dummy   = create_event
      _f.pos   = NUM_ENEMIES * 0x8
      if @events.size > NUM_EVENTS
        raise(IOError, "event quota of #{NUM_EVENTS} exceeded")
      end
      (0...NUM_EVENTS).each do |_id|
        puts(sprintf(VOC.write, _id, _f.pos))
        _event = @events[_id]
        if _event
          _event.write_to_bin(_f)
          
          (0...7).each do |_i|
            _id = _event.find_member(VOC.enemy_id[_i]).value
            if _id != 255
              _enemy = find_enemy(_id, _filename)
              if _enemy
                if !_enemies.include?(_enemy)
                  _enemies << _enemy
                end
              else
                raise(IOError, "enemy ##{_id} not found")
              end
            end
          end
        else
          _dummy.write_to_bin(_f)
        end
      end

      # Enemies
      _nodes = []
      if _enemies.size > NUM_ENEMIES
        raise(IOError, "enemy quota of #{NUM_ENEMIES} exceeded")
      end
      _enemies.each do |_enemy|
        _id  = _enemy.id
        _pos = _f.pos
          
        puts(sprintf(VOC.write, _id, _pos))
        _nodes << create_node(_id, _pos)
        save_enemy(_f, _enemy, _filename)
      end

      # Header
      _f.pos = 0
      (0...NUM_ENEMIES).each do |_i|
        _node = _nodes[_i]
        if _node
          _f.write_int(_node[:id] , 'l>')
          _f.write_int(_node[:pos], 'l>')
        else
          _f.write_int(0xffffffff , 'l>')
          _f.write_int(0xffffffff , 'l>')
        end
      end
    end

    puts(sprintf(VOC.close, _filename))
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :events

end # class EvpFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
