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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write MX000.STD files.
class Mx3StdFile
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # BOF mark 1
  BOF_MARK1 = 0x0
  # BOF mark 2
  BOF_MARK2 = 0x1

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Mx3StdFile.
  # @param _animation_class [Entry] Class which represents animation.
  # @param _movement_class  [Entry] Class which represents movement.
  def initialize(_animation_class, _movement_class)
    @animation_class = _animation_class
    @movement_class  = _movement_class
    
    @animations  = []
    @magics      = {}
    @movements   = []
    @super_moves = {}
  end

  # Creates an animation.
  # @param _id       [Integer] Animation ID
  # @param _filename [String]  File name
  # @return [Entry] Entry object
  def create_animation(_id = -1, _filename = '*')
    _animation             = @animation_class.new
    _animation.id          = _id
    _animation.file        = File.basename(_filename)
    _animation.magics      = @magics
    _animation.super_moves = @super_moves
    _animation
  end
  
  # Creates a movement.
  # @param _id       [Integer] Movement ID
  # @param _filename [String]  File name
  # @return [Entry] Entry object
  def create_movement(_id = -1, _filename = '*')
    _movement             = @movement_class.new
    _movement.id          = _id
    _movement.file        = File.basename(_filename)
    _movement.magics      = @magics
    _movement.super_moves = @super_moves
    _movement
  end

  # Reads a STD file.
  # @param _filename [String] File name
  def load(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CompressedFile.open(_filename, 'rb') do |_f|
      # Header
      _bof_check1 = _f.read_int(:u16)
      _bof_check2 = _f.read_int(:u16)
      if _bof_check1 != BOF_MARK1 || _bof_check2 != BOF_MARK2
        raise(IOError, 'header corrupted')
      end
      
      _unknown_pointer1 = _f.read_int(:u32)
      _motion_count     = _f.read_int(:u32)
      _unknown_pointer2 = _f.read_int(:u32)

      # Animations
      _last_id = 0
      (0..._motion_count).each do |_id|
        _last_id  = _id
        _last_pos = _f.pos
        
        _animation = create_animation(_id, _filename)
        _animation.read_bin(_f)
        
        if _animation[VOC.unknown[1]] == 0 && _animation[VOC.unknown[2]] == 7
          _f.pos = _last_pos
          break
        end
        
        @animations << _animation
      end
      
      # Movements
      (0...(_motion_count - _last_id)).each do |_id|
        _movement = create_movement(_id, _filename)
        _movement.read_bin(_f)
        @movements << _movement
      end

      if _f.pos != _f.size
        _msg = 'file size invalid (given %#x, expected %#x)'
        raise(IOError, sprintf(_msg, _f.pos, _f.size))
      end
    end
  end

  # Writes a STD file.
  # @param _filename [String] File name
  def save(_filename)
    _basename = File.basename(_filename)
    _modified = false
    _animations = @animations.find_all do |_animation|
      _result = (_animation.file == _basename)
      if _result
        _modified ||= _animation.modified
      end
      _result
    end
    _movements = @movements.find_all do |_movement|
      _result = (_movement.file == _basename)
      if _result
        _modified ||= _movement.modified
      end
      _result
    end
    if _animations.empty? || _movements.empty?
      return
    end
    unless _modified
      return
    end

    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    CompressedFile.open(_filename, 'wb') do |_f|
      # Header
      _motion_count = _animations.size + _movements.size
      _f.write_int(BOF_MARK1    , :u16)
      _f.write_int(BOF_MARK2    , :u16)
      _f.write_int(0            , :u32)
      _f.write_int(_motion_count, :u32)
      _f.write_int(0            , :u32)
      
      # Animations
      _last = nil
      (0..._animations.size).each do |_id|
        _animation = _animations[_id]
        if _last && _animation.id != _last.id + 1
          _msg = 'animation ID invalid (given %s, expected %s)'
          raise(IOError, sprintf(_msg, _animation.id, _last.id + 1))
        end
        _animation.write_bin(_f)
        _last = _animation
      end
      
      # Movements
      _last = nil
      (0..._movements.size).each do |_id|
        _movement = _movements[_id]
        if _last && _movement.id != _last.id + 1
          _msg = 'movement ID invalid (given %s, expected %s)'
          raise(IOError, sprintf(_msg, _movement.id, _last.id + 1))
        end
        _movement.write_bin(_f)
        _last = _movement
      end
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :animations
  attr_accessor :enemies
  attr_accessor :magics
  attr_accessor :movements
  attr_accessor :super_moves

end # class Mb3StdFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
