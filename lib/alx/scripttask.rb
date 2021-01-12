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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a script task.
class ScriptTask < Entry

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Maximum of task predecessors (do not edit)
  PREDECESSOR_MAX = (VOC.script_tasks.keys.max { |_key| _key.size }).size

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ScriptTask.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    init_attrs
    init_props
    init_procs
  end
  
  # Checks the entry with a snapshot. Assigns +true+ to #expired if the entry 
  # differs from the snapshot, otherwise nothing happens. Returns +true+ if 
  # the entry matches the snapshot, otherwise +false+.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if entry matches the snapshot, otherwise +false+.
  def check_expiration(_entry)
    _found   = true
    _found &&= _entry.is_a?(ScriptTask)
    _found &&= (id   == _entry.id  )
    _found &&= (file == _entry.file)

    if _found
      super
    end

    _found
  end

  # Refreshes the predecessors by considering the last +PREDECESSOR_MAX+ 
  # script tasks.
  # @param _tasks [Array] Script tasks
  def refresh_predecessors(_tasks)
    _event_id = self[VOC.event_id]
    @predecessors = _tasks.last(PREDECESSOR_MAX).collect do |_t|
      if _t.event_id == _event_id
        _t.task_id
      end
    end
    @predecessors.reverse!
    @predecessors.compact!
  end

  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash                 = super
    _hash[:@file]         = @file
    _hash[:@predecessors] = @predecessors
    _hash
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :file
  attr_accessor :predecessors
  
  def event_id
    self[VOC.event_id]
  end

  def event_id=(_event_id)
    self[VOC.event_id] = _event_id
  end
  
  def event_name
    self[VOC.event_name]
  end

  def event_name=(_event_name)
    self[VOC.event_name] = _event_name
  end
  
  def task_id
    self[VOC.task_id]
  end

  def task_id=(_task_id)
    self[VOC.task_id] = _task_id
  end
  
  def task_name
    self[VOC.task_name]
  end

  def task_name=(_task_name)
    self[VOC.task_name] = _task_name
  end

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @file         ||= ''
    @predecessors ||= []
  end
  
  # Initialize the entry properties.
  def init_props
    self[VOC.event_id  ] = IntProp.new(:u32, -1, ext: true)
    self[VOC.event_name] = StrProp.new( nil, '', ext: true)
    self[VOC.task_id   ] = DynProp.new(      -1           )
    self[VOC.task_name ] = StrProp.new( nil, '', ext: true)
  end
  
  # Initialize the entry procs.
  def init_procs
    _proc = Proc.new do |_task_id|
      if _task_id.is_a?(Numeric)
        _key = VOC.script_tasks.keys.find do |_key|
          _result = true
          _key.each_with_index do |_value, _id|
            if _value
              _result &&= _value.eql?(@predecessors[_id])
            end
            unless _result
              break
            end
          end
          _result
        end
        if _key
          self[VOC.task_name] = VOC.script_tasks[_key]
        else
          self[VOC.task_name] = '???'
        end
      end
    end

    fetch(VOC.task_id).proc = Proc.new do |_id|
      _prop = nil
      
      case _id
      when Float
        _prop = flt_prop(_id)
      when Integer
        _prop = int_prop(_id)
      when String
        if self.task_name != 'Shift_JIS' && self.task_name != 'Windows-1252'
          if Integer(_id, exception: false)
            _prop = int_prop(_id)
          elsif Float(_id, exception: false)
            _prop = flt_prop(_id)
          end
        end
        
        unless _prop
          _prop = str_prop(_id)
        end
      end
      
      unless _prop
        _msg = '%s is not a float, an integer nor a string'
        raise(TypeError, sprintf(_msg, _id))
      end
      
      _prop.proc = _proc
      _prop
    end

    fetch(VOC.task_name).proc = Proc.new do
      fetch(VOC.task_id)&.call_proc
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

  def flt_prop(_value)
    FltProp.new(:f32, (_value))
  end

  def int_prop(_value)
    IntProp.new(:i32, (_value))
  end

  def str_prop(_value)
    _blocks = !event_name.empty? ? 0x4 : 0x1
    _format = { :write_bin => [gs(' ', "\x7f")] }

    StrProp.new(nil, _value, blk: _blocks, enc: task_name, form: _format)
  end
  
end	# class ScriptTask

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
