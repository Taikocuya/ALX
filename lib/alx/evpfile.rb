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
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EvpFile.
  def initialize
    super
    @events = []
  end

  # Creates a header node.
  # @param _id  [Integer] Enemy ID
  # @param _pos [Integer] Enemy position
  # @return [OpenStruct] OpenStruct object
  def create_node(_id, _pos)
    OpenStruct.new(id: _id, pos: _pos)
  end
  
  # Creates an event.
  # @param _id [Integer] Event ID
  # @return [Entry] EnemyEvent object
  def create_event(_id = -1)
    _event         = EnemyEvent.new
    _event.id      = _id
    _event.enemies = enemies
    _event
  end

  # Reads an EVP file.
  # @param _filename [String] File name
  def load(_filename)
    _num_enemies = dscrptr(:enemy_event_num_enemies)
    _num_events  = dscrptr(:enemy_event_num_events)
    
    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CompressedFile.open(_filename, 'rb') do |_f|
      # Header
      _nodes = []
      (0..._num_enemies).each do
        _id  = _f.read_int(:i32)
        _pos = _f.read_int(:i32)

        if _id >= 0 && _pos >= 0
          _nodes << create_node(_id, _pos)
        end
      end
      
      # Events
      _dummy = create_event
      (0..._num_events).each do |_id|
        _event = create_event(_id)
        _event.read_bin(_f)
        
        if _event != _dummy
          @events << _event
        end
      end

      # Enemies
      _nodes.each do |_node|
        _id    = _node.id
        _pos   = _node.pos
        _f.pos = _pos

        load_enemy(_f, _id, _filename)
      end
      
      # Forces the event properties to be updated with all collected enemies.
      @events.each do |_event|
        _event.enemies = enemies
      end
    end
  end

  # Writes an EVP file.
  # @param _filename [String] File name
  def save(_filename)
    if @events.empty?
      return
    end
    
    _num_enemies = dscrptr(:enemy_event_num_enemies)
    _num_events  = dscrptr(:enemy_event_num_events)
    _enemies     = []
    _modified    = false
    @events.each_with_index do |_event, _id|
      _modified ||= _event.modified
      (1..7).each do |_i|
        _enemy_id = _event[VOC.enemy_id(_i)]
        if _enemy_id != 255
          _enemy = find_enemy(_enemy_id, _filename)
          if _enemy
            unless _enemies.include?(_enemy)
              _modified ||= _enemy.modified
              _enemies   << _enemy
            end
          else
            raise(IOError, "enemy ##{_enemy_id} not found")
          end
        end
      end
    end
    unless _modified
      return
    end

    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    CompressedFile.open(_filename, 'wb') do |_f|
      # Events
      _dummy = create_event
      _f.pos = _num_enemies * 0x8
      if @events.size > _num_events
        raise(IOError, "event quota of #{_num_events} exceeded")
      end
      (0..._num_events).each do |_id|
        _event = @events[_id]
        if _event
          _event.write_bin(_f)
        else
          _dummy.write_bin(_f)
        end
      end

      # Enemies
      _nodes = []
      if _enemies.size > _num_enemies
        raise(IOError, "enemy quota of #{_num_enemies} exceeded")
      end
      _enemies.each do |_enemy|
        _id  = _enemy.id
        _pos = _f.pos

        _nodes << create_node(_id, _pos)
        save_enemy(_f, _enemy, _filename)
      end

      # Header
      _f.pos = 0
      (0..._num_enemies).each do |_i|
        _node = _nodes[_i]
        if _node
          _f.write_int(_node.id  , :i32)
          _f.write_int(_node.pos , :i32)
        else
          _f.write_int(0xffffffff, :i32)
          _f.write_int(0xffffffff, :i32)
        end
      end
    end
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :events

end # class EvpFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
