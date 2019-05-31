#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
require_relative('enemyencounter.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write ENP files.
class EnpFile < EpFile
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # File signature
  FILE_SIG       = "\x00\x00\xff\xff".force_encoding('ASCII-8BIT')
  # Size of segment name
  SEG_NAME_SIZE  = 20
  # Maximum number of enemies
  NUM_ENEMIES    = 84
  # Maximum number of encounters
  NUM_ENCOUNTERS = 32
  # Regular expression for multi ENP files
  MULTI_REGEXP   = /^(.+_)(\d*)(ep\.enp)$/

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnpFile.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @encounters = []
  end

  # Creates a header node.
  # @param _id  [Integer] Enemy ID
  # @param _pos [Integer] Enemy position
  # @return [Hash] Hash object
  def create_node(_id, _pos)
    { :id => _id, :pos => _pos }
  end

  # Creates a segment.
  # @param _pos  [Integer] Position
  # @param _size [Integer] Size
  # @return [Hash] Hash object
  def create_segment(_pos, _size)
    { :pos => _pos, :size => _size }
  end
  
  # Creates an encounter.
  # @param _id       [Integer] Encounter ID
  # @param _filename [String]  File name
  # @return [Entry] EnemyEncounter object
  def create_encounter(_id = -1, _filename = '*')
    _encounter         = EnemyEncounter.new(@root)
    _encounter.id      = _id
    _encounter.enemies = enemies
    _encounter.file    = File.basename(_filename)
    _encounter
  end

  # Reads an ENP file.
  # @param _filename [String] File name
  def load(_filename)
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    AklzFile.open(_filename, 'rb') do |_f|
      # Segments
      _signature = _f.read(0x4)
      if _signature == FILE_SIG
        _size  = _f.read_int('s>')
        _check = _f.read_int('s>')
        if _check != -1
          raise(IOError, 'segments corrupted')
        end
        
        _segments = {}
        (0..._size).each do |_|
          _segname   = _f.read_str(SEG_NAME_SIZE)
          _pos       = _f.read_int('l>')
          _size      = _f.read_int('l>')
          _check     = _f.read_int('l>')
          
          if _check != -1
            raise(IOError, 'segments corrupted')
          end
    
          _segname.sub!(/\.bin$/, '.enp')
          _segments[_segname] = create_segment(_pos, _size)
        end
      else
        _segments = { _filename => create_segment(0x0, _f.size) }
      end

      _segments.each do |_segname, _seg|
        # Positions
        _beg = _seg[:pos]
        _end = _seg[:size] + _beg

        # Header
        _nodes = []
        _f.pos = _beg
        (0...NUM_ENEMIES).each do |_|
          _id  = _f.read_int('l>')
          _pos = _f.read_int('l>') + _beg
  
          if _id >= 0 && _pos >= 0
            _nodes << create_node(_id, _pos)
          end
        end
        
        # Encounters
        _size = (_nodes.first[:pos] - _f.pos) / create_encounter.size
        if _size > NUM_ENCOUNTERS
          raise(IOError, "encounter quota of #{NUM_ENCOUNTERS} exceeded")
        end
        (0..._size).each do |_id|
          puts(sprintf(VOC.read, _id, _f.pos))
          _encounter = create_encounter(_id, _segname)
          _encounter.read_from_bin(_f)
          @encounters << _encounter
        end
  
        # Enemies
        _nodes.each do |_node|
          _id    = _node[:id]
          _pos   = _node[:pos]
          _f.pos = _pos
          
          puts(sprintf(VOC.read, _id, _pos))
          load_enemy(_f, _id, _segname)
        end

        if _f.pos > _end
          raise(IOError, 'segments corrupted')
        end
      end
    end
    
    puts(sprintf(VOC.close, _filename))
  end

  # Writes an ENP file.
  # @param _filename [String] File name
  def save(_filename)
    _segments = {}
    @encounters.each do |_encounter|
      _segname = _encounter.file
      if _segname == File.basename(_filename)
        _segments[_segname] = create_segment(0x0, 0xffffffff)
        break
      end
    end
    
    if _segments.empty?
      @encounters.each do |_encounter|
        _segname = _encounter.file
        if _segname.sub(MULTI_REGEXP, '\1\3') == File.basename(_filename)
          unless _segments.include?(_segname)
            _segments[_segname] = create_segment(0x0, 0xffffffff)
          end
        end
      end
    end
    
    if _segments.empty?
      return
    end
    
    print("\n")
    puts(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    AklzFile.open(_filename, 'wb') do |_f|
      # Segments (pre-processing)
      if _segments.size > 1
        _f.pos = _segments.size * 0x20 + 0x8
      end

      _segments.each do |_segname, _seg|
        # Encounters
        _enemies     = []
        _beg         = _f.pos
        _f.pos      += NUM_ENEMIES * 0x8
        _encounters  = @encounters.select do |_encounter|
          _encounter.file == File.basename(_segname)
        end
        if _encounters.size > NUM_ENCOUNTERS
          raise(IOError, "encounter quota of #{NUM_ENCOUNTERS} exceeded")
        end
        (0..._encounters.size).each do |_id|
          puts(sprintf(VOC.write, _id, _f.pos))
          _encounter = _encounters[_id]
          _encounter.write_to_bin(_f)

          (0...8).each do |_i|
            _id = _encounter.find_member(VOC.enemy_id[_i]).value
            if _id != 255
              _enemy = find_enemy(_id, _segname)
              if _enemy
                unless _enemies.include?(_enemy)
                  _enemies << _enemy
                end
              else
                raise(IOError, "enemy ##{_id} not found")
              end
            end
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
          _nodes << create_node(_id, _pos - _beg)
          save_enemy(_f, _enemy, _filename)
        end
        
        # Positions
        _end        = _f.pos
        _seg[:pos]  = _beg
        _seg[:size] = _end - _beg
                  
        # Header
        _f.pos = _beg
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
        _f.pos = _end
      end
      
      # Segments (post-processing)
      if _segments.size > 1
        _f.pos = 0
        _f.write(FILE_SIG)
        _f.write_int(_segments.size, 's>')
        _f.write_int(0xffff        , 's>')
        
        _segments.each do |_segname, _seg|
          _f.write_str(_segname.sub(/\.enp$/, '.bin'), SEG_NAME_SIZE)
          _f.write_int(_seg[:pos] , 'l>')
          _f.write_int(_seg[:size], 'l>')
          _f.write_int(0xffffffff , 'l>')
        end
      end
    end

    puts(sprintf(VOC.close, _filename))
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :encounters

end # class EnpFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
