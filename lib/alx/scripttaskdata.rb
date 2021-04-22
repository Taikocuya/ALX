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

require('fiber')
require_relative('entrydata.rb')
require_relative('sctfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle script tasks from binary and/or CSV files.
class ScriptTaskData < EntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an ScriptTaskData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(ScriptTask, _depend)

    @sct_file         = sys(:sct_file)
    @version_csv_file = join(SYS.script_version_csv_file)
    @task_csv_file    = SYS.script_task_csv_file

    @fibers   = {}
    @versions = []
    @tasks    = []
    @cache    = CacheFile.new
  end

  # Does nothing.
  def create_entry
    nil
  end

  # Creates a script version.
  # @param _id [Integer] Script version ID
  # @return [Entry] ScriptVersion object
  def create_version(_id = -1)
    _version    = ScriptVersion.new
    _version.id = _id
    _version
  end

  # Creates a script task.
  # @param _id [Integer] Script task ID
  # @return [Entry] ScriptTask object
  def create_task(_id = -1)
    _task    = ScriptTask.new
    _task.id = _id
    _task
  end

  # Reads all entries from binary files.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
  def load_bin
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do
        glob(@sct_file) do |_p|
          unless @tasks.empty?
            raise(RuntimeError, 'script tasks remaining in buffer')
          end
          if File.file?(_p)
            load_cache(_p)
            unless @cache.valid?
              load_bin_data(_p)
            end
            Fiber.yield
          end
        end
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume

    _result = true
    unless _fiber&.alive?
      @fibers.delete(__method__)
      _result = false
    end
    
    _result
  end

  # Writes all entries to binary files. To free up memory, all script tasks
  # are automatically removed afterwards.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
  def save_bin
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do
        loop do
          _files = collect_files
          if _files.empty?
            break
          end
          if _files.size > 1
            raise(RuntimeError, 'too many script tasks remaining in buffer')
          end
          
          _filename = _files.first
          _versions = find_versions(_filename)
          if !@cache.valid? || !(@cache.versions & _versions).empty?
            save_bin_data(sct_path(_filename))
            save_cache
          end
          @tasks.clear
          Fiber.yield
        end
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume

    _result = true
    unless _fiber&.alive?
      @fibers.delete(__method__)
      _result = false
    end
    
    _result
  end

  # Reads all entries from CSV files.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
	def load_csv
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do
        if File.exist?(@version_csv_file)
          load_csv_versions(@version_csv_file)
        end

        glob(@task_csv_file) do |_p|
          unless @tasks.empty?
            raise(RuntimeError, 'script tasks remaining in buffer')
          end
          if File.file?(_p)
            load_cache(_p)
            unless @cache.valid?
              load_csv_tasks(_p)
            end
            Fiber.yield
          end
        end
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume

    _result = true
    unless _fiber&.alive?
      @fibers.delete(__method__)
      _result = false
    end
    
    _result
	end

  # Writes all entries to CSV files. To free up memory, all script tasks are 
  # automatically removed afterwards.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
  def save_csv
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do
        loop do
          _files = collect_files
          if _files.empty?
            break
          end
          if _files.size > 1
            raise(RuntimeError, 'too many script tasks remaining in buffer')
          end
          
          unless @cache.valid?
            _filename = File.basename(_files.first, '.*')
            _filename = @task_csv_file.sub('*', _filename)
            _filename = join(_filename)
            save_csv_task(_filename)
            save_cache
          end
          @tasks.clear
          Fiber.yield
        end

        save_csv_version(@version_csv_file)
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume

    _result = true
    unless _fiber&.alive?
      @fibers.delete(__method__)
      _result = false
    end
    
    _result
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :sct_file
  attr_accessor :version_csv_file
  attr_accessor :task_csv_file
  attr_accessor :versions
  attr_accessor :tasks

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Returns the SCT base name of a CSV or SCT path.
  # @param _filename [String] File name
  # @return [String] Base name
  def sct_basename(_filename)
    File.basename(_filename, '.*') + File.extname(@sct_file)
  end

  # Returns the SCT path of a CSV or SCT path.
  # @param _filename [String] File name
  # @return [String] Base name
  def sct_path(_filename)
    join(File.dirname(@sct_file), sct_basename(_filename))
  end
  
  # Returns the CSV base name of a CSV or SCT path.
  # @param _filename [String] File name
  # @return [String] Base name
  def csv_basename(_filename)
    File.basename(_filename, '.*') + File.extname(@task_csv_file)
  end

  # Returns the CSV path of a CSV or SCT path.
  # @param _filename [String] File name
  # @return [String] Base name
  def csv_path(_filename)
    join(File.dirname(@task_csv_file), csv_basename(_filename))
  end

  # Reads all entries from a cache file.
  # @param _filename [String] File name
  def load_cache(_filename)
    _prefix  = ''
    _prefix << create_task.class.name.split('::').last.downcase
    _prefix << '-'
    _prefix << sct_basename(_filename).downcase

    @cache.clear
    @cache.prefix = _prefix
    @cache.add_dummy(create_version)
    @cache.add_dummy(create_task   )
    @cache.add_descriptor(:bin, sct_path(_filename))
    @cache.add_descriptor(:csv, csv_path(_filename))
    @cache.add_storage(:versions, @versions)
    @cache.add_storage(:tasks   , @tasks   )
    @cache.load
    
    if @cache.valid?
      @versions.concat(@cache.versions)
      @tasks = @cache.tasks
    end
  end

  # Writes all entries to a cache file.
  def save_cache
    _descriptor = @cache.descriptors.find do |_dscr|
      _dscr.pool == :bin
    end

    _filename = Root.glob(_descriptor.name)
    @cache.add_storage(:versions, find_versions(_filename))
    @cache.add_storage(:tasks   , find_tasks(_filename)   )
    @cache.save
  end

  # Returns script versions by filename, or +nil+ otherwise.
  # @param _filename [String] File name
  # @return [Array] Script versions
  def find_versions(_filename)
    _basename = sct_basename(_filename)
    @versions.find_all do |_v|
      _v.file == _basename
    end
  end
  
  # Returns script tasks by filename, or +nil+ otherwise.
  # @param _filename [String] File name
  # @return [Array] Script tasks
  def find_tasks(_filename)
    _basename = sct_basename(_filename)
    @tasks.find_all do |_t|
      _t.file == _basename
    end
  end

  # Returns all SCT files by tasks.
  # @return [Array] SCT files
  def collect_files
    _files = []
    @tasks.each do |_task|
      _filename = _task.file
      unless _files.include?(_filename)
        _files << _filename
      end
    end
    _files.sort!
    _files
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    _file = SctFile.new
    _file.load(_filename)
    @versions.concat(_file.versions)
    @tasks.concat(_file.tasks)
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file          = SctFile.new
    _file.versions = @versions
    _file.tasks    = @tasks
    _file.save(_filename)
  end

  # Reads all script versions from a CSV file.
  # @param _filename [String]  File name
  def load_csv_versions(_filename)
    unless @versions.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        _version = create_version
        _version.read_csv(_f)
        @versions << _version
      end
    end
  end

  # Reads all script tasks from a CSV file.
  # @param _filename [String] File name
  def load_csv_tasks(_filename)
    unless @tasks.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        _task      = create_task
        _task.file = sct_basename(_filename)
        _task.read_csv(_f)
        _task.refresh_predecessors(@tasks)
        _task.refresh
        @tasks << _task
      end
    end
  end

  # Writes all script versions to a CSV file.
  # @param _filename [String] File name
  def save_csv_version(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))
  
    _header = create_version.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @versions.each do |_version|
        _version.write_csv(_f)
      end
    end
  end

  # Writes all script tasks to a CSV file.
  # @param _filename [String] File name
  def save_csv_task(_filename)
    if @tasks.empty?
      return
    end
    _tasks = find_tasks(_filename)
    if _tasks.empty?
      return
    end
  
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    _header = create_task.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      _tasks.each do |_task|
        _task.write_csv(_f)
      end
    end
  end

end # class ScriptTaskData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
