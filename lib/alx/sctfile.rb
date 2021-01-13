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
# You should have received a copy of the GNU General Public License along with 
# ALX. If not, see <http://www.gnu.org/licenses/>.
#******************************************************************************

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('definedstringdetector.rb')
require_relative('scripttask.rb')
require_relative('scriptversion.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write SCT files.
class SctFile

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Size of event name
  EVENT_NAME_SIZE = 16
  # File marks
  MARKS           = {
    :BOF  => 0x00000009,
    :EOF1 => 0x0000000c,
    :EOF2 => 0xffffffe4,
    :FLT  => 0x04000000,
    :STR  => 0x0000001d,
  }

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a SctFile.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    @root     = _root
    @versions = []
    @tasks    = []
  end

  # Creates a script version.
  # @param _id       [Integer] Version ID
  # @param _filename [String]  File name
  # @return [Entry] ScriptVersion object
  def create_version(_id = -1, _filename = '*')
    _version      = ScriptVersion.new(@root)
    _version.id   = _id
    _version.file = File.basename(_filename)
    _version
  end

  # Creates a script event.
  # @param _name [String]  Event name
  # @param _pos  [Integer] Event position
  # @param _size [Integer] Event size
  # @return [OpenStruct] OpenStruct object
  def create_event(_name, _pos, _size)
    OpenStruct.new(name: _name, pos: _pos, size: _size)
  end
  
  # Creates a script task.
  # @param _id       [Integer] Task ID
  # @param _filename [String]  File name
  # @return [Entry] ScriptTask object
  def create_task(_id = -1, _filename = '*')
    _task      = ScriptTask.new(@root)
    _task.id   = _id
    _task.file = File.basename(_filename)
    _task
  end
  
  # Creates a script string.
  # @param _pos      [Integer] Position
  # @param _string   [String]  String
  # @param _encoding [String]  Encoding
  # @return [OpenStruct] OpenStruct object
  def create_string(_pos, _string, _encoding)
    OpenStruct.new(pos: _pos, string: _string, encoding: _encoding)
  end

  # Reads a SCT file.
  # @param _filename [String] File name
  def load(_filename)
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    CompressedFile.open(@root, _filename, 'rb') do |_f|
      # Version
      _version = create_version(@versions.size, _filename)
      _version.read_bin(_f)
      
      unless _version.valid?
        raise(IOError, 'version invalid')
      end

      @versions << _version

      # Events
      _events = load_events(_f)
      load_tasks(_f, _events, _filename)
      
      # Load all leftover strings at the end of the file.
      _entry_id = 0
      until _f.eof?
        _str = load_string(_f, false)
        if _str
          _task            = create_task(_entry_id, _filename)
          _task.event_id   = _events.size
          _task.event_name = ''
          _task.task_id    = _str.string
          _task.task_name  = _str.encoding

          @tasks << _task
          
          _entry_id += 1
        else
          raise(EOFError, sprintf('EOF not reached (at %#x)', _f.pos))
        end
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes a TEC file.
  # @param _filename [String] File name
  def save(_filename)
    _basename = File.basename(_filename)
    _expired  = false
    _tasks    = @tasks.find_all do |_task|
      _result = (_task.file == _basename)
      if _result
        _expired ||= _task.expired
      end
      _result
    end
    if _tasks.empty?
      return
    end
    unless _expired
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    CompressedFile.open(@root, _filename, 'wb') do |_f|
      # Version
      _version = @versions.find do |_v|
        _v.file == _basename
      end
      unless _version
        _date                 = Time.now
        _version              = create_version(@versions.size, _filename)
        _version[VOC.year   ] = _date.year
        _version[VOC.month  ] = _date.month
        _version[VOC.day    ] = _date.day
        _version[VOC.version] = 0
      end
      unless _version.valid?
        raise(IOError, 'version invalid')
      end
      _version.write_bin(_f)
      
      # Events (pre-processing)
      _events = []
      _tasks.each do |_task|
        _event_name = _task.event_name
        unless _event_name.empty?
          unless _events.any? { |_event| _event.name == _event_name }
            _events << create_event(_event_name, 0x0, 0x0)
          end
        end
      end
      _f.pos = _version.size + 0x4 + _events.size * 0x14

      # Tasks
      save_tasks(_f, _events, _filename)

      # Events (post-processing)
      _f.pos = _version.size
      save_events(_f, _events)
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :root
  attr_accessor :versions
  attr_accessor :tasks

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected
  
  # Returns script tasks by filename and event name, or +nil+ otherwise.
  # @param _filename   [String] File name
  # @param _event_name [String] Event name
  # @return [Array] Script tasks
  def find_tasks(_filename, _event_name)
    _basename = File.basename(_filename)
    _tasks    = @tasks.find_all do |_task|
      _task.file == _basename && _task.event_name == _event_name
    end
    _tasks.sort! do |_a, _b|
      _a.id <=> _b.id
    end
    
    _tasks
  end
  
  # Loads script events from a binary I/O stream.
  # @param _f [IO] Binary I/O stream
  # @return [Array] Script events
  def load_events(_f)
    _num_events = _f.read_int(:i32)
    if _num_events < 0
      raise(IOError, 'events corrupted')
    end
    
    _events = []
    (0..._num_events).each do |_id|
      _pos  = _f.read_int(:i32                 )
      _name = _f.read_str(length: EVENT_NAME_SIZE)
      if _name.empty?
        _msg = 'event name invalid (given %s)'
        raise(IOError, sprintf(_msg, _name))
      end

      _events << create_event(_name, _pos, 0)
    end
    _events.sort! do |_a, _b|
      _a.pos <=> _b.pos
    end
    
    _beg = _f.pos
    (0..._num_events).each do |_id|
      _event = _events[_id    ]
      _last  = _events[_id - 1]

      _event.pos += _beg
      if _id == _num_events - 1
        _event.size = _f.size - _event.pos
      end
      if _last
        _last.size = _event.pos - _last.pos
        if _id <= _num_events - 1
          if _last.pos % 0x4 != 0
            _msg  = 'event BOF alignment invalid - %s '
            _msg << '(given %#x, expected %#x or %#x)'
            _msg  = sprintf(
              _msg,
              _event.name,
              _last.pos,
              _last.pos - _last.pos % 0x4,
              _last.pos + (0x4 - _last.pos % 0x4)
            )
            raise(IOError, _msg)
          end
          if _last.size % 0x4 != 0
            _msg  = 'event EOF alignment invalid - %s '
            _msg << '(given %#x, expected %#x or %#x)'
            _msg  = sprintf(
              _msg,
              _event.name,
              _last.pos,
              _last.pos - _last.pos % 0x4,
              _last.pos + (0x4 - _last.pos % 0x4)
            )
            raise(IOError, _msg)
          end
        end
      end
    end
    
    _events
  end

  # Loads a script string from a binary I/O stream.
  # @param _f     [IO]      Binary I/O stream
  # @param _block [Boolean] Read blocks of 0x4 bytes
  # @return [OpenStruct] OpenStruct object
  def load_string(_f, _block = true)
    _align = _block ? 0x4 : 0x1

    clear_detector
    @detector.beg_alignment = _align
    @detector.end_alignment = _align
    @detector.detect(_f)
    
    _result   = true
    _result &&= @detector.valid?
    _result &&= !@detector.shifted?
    if _block
      _result &&= !!(/^\\h/ =~ @detector.string)
    end
    
    if _result
      create_string(@detector.pos, @detector.string, @detector.encoding)
    else
      nil
    end
  end
  
  # Loads script tasks from a binary I/O stream.
  # @param _f        [IO]     Binary I/O stream
  # @param _events   [Array]  Script events
  # @param _filename [String] File name
  def load_tasks(_f, _events, _filename)
    _buf = BinaryStringIO.new('', 'rb', endianness: @root.endianness)
    
    _events.each.with_index do |_event, _event_id|
      _f.pos = _event.pos

      LOG.info(sprintf(VOC.read, _event_id, _f.pos))

      _buf.string = _f.read(_event.size) || ''
      if _buf.size != _event.size
        _msg = 'event size invalid - %s (given %#x, expected %#x)'
        raise(IOError, sprintf(_msg, _event.name, _buf.size, _event.size))
      end

      # Detect the message at the end of the buffer, if any. Leftover strings 
      # are only allowed in the last event. If something goes wrong here, the 
      # error is caught with a 'task EOF invalid' exception further down when 
      # loading the tasks.
      _buf.pos    = _buf.size - _buf.size % 0x4 - 0x4
      _msg_pos    = _buf.size
      _last_event = (_event_id == _events.size - 1)
      loop do
        _task_id = _buf.read_int(:u32)
        if _last_event && [MARKS[:EOF1], MARKS[:EOF2]].include?(_task_id)
          _leftover  = _buf.string.slice!(_buf.pos..-1)
          _f.pos    -= _leftover.size
          break
        elsif _task_id == MARKS[:STR]
          _str = load_string(_buf)
          if _str
            _msg_pos = _str.pos
            if _last_event
              _leftover  = _buf.string.slice!(_buf.pos..-1)
              _f.pos    -= _leftover.size
            end
          end
          
          break
        end

        if _buf.pos >= 0x8
          _buf.pos -= 0x8
        else
          break
        end
      end
      _buf.rewind

      # Read all task IDs at the beginning of the buffer.
      _entry_id  = 0
      _task_id   = nil
      _task_name = nil
      until _buf.eof?
        _task_pos = _buf.pos
        if _task_id && _task_id.is_a?(Integer)
          _task_id = _task_id & 0xffffffff
        end

        # String
        if _buf.pos >= _msg_pos
          _str = load_string(_buf)
          if _str
            _task_id   = _str.string
            _task_name = _str.encoding
          else
            _msg = sprintf(
              'task EOF invalid - %s (at %#x of %#x)',
              _event.name,
              _event.pos + _buf.pos,
              _event.pos + _buf.size
            )
            raise(IOError, _msg)
          end
        # Numeric
        else
          case _task_id
          when MARKS[:FLT]
            _task_id = _buf.read_flt(:f32)
          else
            _task_id = _buf.read_int(:i32)
          end
        end

        if !_task_id
          _msg = sprintf(
            'task ID invalid - %s (at %#x of %#x)',
            _event.name,
            _event.pos + _task_pos,
            _event.pos + _buf.size
          )
          raise(IOError, _msg)
        elsif _task_pos == 0 && _task_id != MARKS[:BOF]
          _msg = sprintf(
            'task BOF invalid - %s (at %#x of %#x)',
            _event.name,
            _event.pos + _task_pos,
            _event.pos + _buf.size
          )
          raise(IOError, _msg)
        end
          
        _task            = create_task(_entry_id, _filename)
        _task.event_id   = _event_id
        _task.event_name = _event.name
        _task.refresh_predecessors(@tasks)
        
        _task.task_id = _task_id
        if _task_name
          _task.task_name = _task_name
        end

        @tasks << _task
        
        _entry_id += 1
      end
    end
  end

  # Saves script events to a binary I/O stream.
  # @param _f      [IO]    Binary I/O stream
  # @param _events [Array] Script events
  def save_events(_f, _events)
    _f.write_int(_events.size, :i32)
    
    _events.each do |_event|
        if _event.pos % 0x4 != 0
          _msg  = 'event BOF alignment invalid - %s '
          _msg << '(given %#x, expected %#x or %#x)'
          _msg  = sprintf(
            _msg,
            _event.name,
            _event.pos,
            _event.pos - _event.pos % 0x4,
            _event.pos + (0x4 - _event.pos % 0x4)
          )
          raise(IOError, _msg)
        end
    
      _f.write_int(_event.pos , :i32                   )
      _f.write_str(_event.name, length: EVENT_NAME_SIZE)
    end
  end

  # Saves script tasks to a binary I/O stream.
  # @param _f        [IO]     Binary I/O stream
  # @param _events   [Array]  Script events
  # @param _filename [String] File name
  def save_tasks(_f, _events, _filename)
    _beg = _f.pos
  
    _events.each_with_index do |_event, _event_id|
      LOG.info(sprintf(VOC.write, _event_id, _f.pos))
      
      _last        = nil
      _event.pos   = _f.pos - _beg
      _event_tasks = find_tasks(_filename, _event.name)
      _event_tasks.each do |_task|
        if _task.id == 0 && _task.task_id != MARKS[:BOF]
          _msg = 'task BOF invalid - %s (at %#x)'
          raise(IOError, sprintf(_msg, _event.name, _f.pos))
        elsif _task.task_id.is_a?(Float) && _last.task_id != MARKS[:FLT]
          _msg = 'task float invalid - %s (at %#x)'
          raise(IOError, sprintf(_msg, _event.name, _f.pos))
        elsif _task.task_id.is_a?(String)
          if _last.task_id != MARKS[:STR] || !(/^\\h/ =~ _task.task_id)
            _msg = 'task string invalid - %s (at %#x)'
            raise(IOError, sprintf(_msg, _event.name, _f.pos))
          end
        elsif _event_id == _events.size      - 1 &&
              _task.id  == _event_tasks.size - 1 &&
              ![MARKS[:EOF1], MARKS[:EOF2]].include?(_task.task_id)
          _msg = 'task EOF invalid - %s (at %#x)'
          raise(IOError, sprintf(_msg, _event.name, _f.pos))
        end
      
        _task.write_bin(_f)
        
        _last = _task
      end
    end

    LOG.info(sprintf(VOC.write, _events.size, _f.pos))
    
    _event_tasks = find_tasks(_filename, '')
    _event_tasks.each do |_task|
      _task.write_bin(_f)
    end
  end
  
#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # @see Substitution::new
  def gs(...)
    Substitution.new(...)
  end

  # Clears the string detector.
  def clear_detector
    unless @detector
      @detector                = DefinedStringDetector.new(@root)
      @detector.char_table     = @detector.char_table.dup << 0x7f
      @detector.filters        = [gs(/\x7f/n, ' ', verify: false)]
      @detector.ignore_filter  = false
      @detector.invert_filter  = false
      @detector.diff_support   = false
      @detector.beg_alignment  = 0x4
      @detector.end_alignment  = 0x4
      @detector.min_byte_size  = 1
      @detector.min_char_size  = 1
    else
      @detector.clear
    end
  end
  
end # class SctFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
