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
  # @param _root   [GameRoot] Game root
  # @param _depend [Boolean]  Resolve dependencies
  def initialize(_root, _depend = true)
    super(Object, _root, _depend)

    @sct_file         = sys(:sct_file)
    @version_csv_file = SYS.script_version_csv_file
    @task_csv_file    = SYS.script_task_csv_file

    @fibers   = {}
    @mtimes   = {}
    @versions = fetch_cache(:versions, [])
    @tasks    = []
  end

  # Does nothing.
  def create_entry
    nil
  end

  # Creates a script version.
  # @param _id [Integer] Script version ID
  # @return [Entry] ScriptVersion object
  def create_version(_id = -1)
    _version    = ScriptVersion.new(root)
    _version.id = _id
    _version
  end

  # Creates a script task.
  # @param _id [Integer] Script task ID
  # @return [Entry] ScriptTask object
  def create_task(_id = -1)
    _task    = ScriptTask.new(root)
    _task.id = _id
    _task
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
  
  # Reads all snaphots (instance variables) from SHT files.
  def load_sht
    super
    load_sht_data(:mtimes  )
    load_sht_data(:versions)
  end
  
  # Writes all snaphots (instance variables) to SHT files.
  def save_sht
    super
    save_sht_data(:mtimes  , @mtimes  )
    save_sht_data(:versions, @versions)
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    meta.store_mtime(_filename)
    store_mtime(_filename)
    _file = SctFile.new(root)
    _file.load(_filename)
    @versions.concat(_file.versions)
    @tasks.concat(_file.tasks)
  end

  # Reads all entries from binary files.
  # 
  # @param _suspend [Boolean] Process next and only one binary file and wait 
  #                           for next execution.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
  def load_bin(_suspend = false)
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do |_yield|
        glob(@sct_file) do |_p|
          if File.file?(_p)
            load_bin_data(_p)
            if _yield
              Fiber.yield
            end
          end
        end
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume(_suspend)

    _result = true
    unless _fiber&.alive?
      @fibers.delete(__method__)
      _result = false
    end
    
    _result
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    if !mtime_updated?(_filename)
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
    
    FileUtils.mkdir_p(File.dirname(_filename))
    _file          = SctFile.new(root)
    _file.versions = @versions
    _file.tasks    = @tasks
    _file.save(_filename)
    
    store_mtime(_filename)
  end

  # Writes all entries to binary files. To free up memory, all script tasks
  # are automatically removed afterwards.
  # 
  # @param _suspend [Boolean] Process next binary files and wait for next 
  #                           execution.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
  def save_bin(_suspend = false)
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do |_yield|
        _dirname = File.dirname(@sct_file)
        _files   = collect_files
        until _files.empty?
          _files.each do |_filename|
            save_bin_data(glob(_dirname, _filename))
          end
          @tasks.clear
          if _yield
            Fiber.yield
          end
          
          _files = collect_files
        end
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume(_suspend)

    _result = true
    unless _fiber&.alive?
      @fibers.delete(__method__)
      _result = false
    end
    
    _result
  end

  # Reads all script versions from a CSV file.
  # @param _filename [String]  File name
  def load_csv_versions(_filename)
    unless @versions.empty?
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.store_mtime(_filename)
    CSV.open(_filename, headers: true) do |_f|
      _snapshot = snaps[:versions].dup

      while !_f.eof?
        LOG.debug(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _version = create_version
        _version.read_csv(_f)

        if _snapshot
          _result = false
          _snapshot.reject! do |_sht|
            if _result
              break
            end
            _result = _version.check_expiration(_sht)
          end
        else
          _version.expired = true
        end
        
        @versions << _version
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all script tasks from a CSV file.
  # @param _filename [String] File name
  def load_csv_tasks(_filename)
    unless @tasks.empty?
      return
    end

    _sct_name = sct_name(_filename)

    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.store_mtime(_filename)
    store_mtime(_filename)
    CSV.open(_filename, headers: true) do |_f|
      _snapshot = snaps[:tasks].dup

      while !_f.eof?
        LOG.debug(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _task      = create_task
        _task.file = _sct_name
        _task.read_csv(_f)
        _task.refresh_predecessors(@tasks)
        _task.refresh

        if _snapshot
          _result = false
          _snapshot.reject! do |_sht|
            if _result
              break
            end
            _result = _task.check_expiration(_sht)
          end
        else
          _task.expired = true
        end
        
        @tasks << _task
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all entries from CSV files.
  # 
  # @param _suspend [Boolean] Process next and only one CSV file and wait for 
  #                           next execution.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
	def load_csv(_suspend = false)
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do |_yield|
        _path = File.join(root.dirname, @version_csv_file)
        if File.exist?(_path)
          load_csv_versions(_path)
          if _yield
            Fiber.yield
          end
        end
      
        glob(@task_csv_file) do |_p|
          if File.file?(_p)
            load_csv_tasks(_p)
            if _yield
              Fiber.yield
            end
          end
        end
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume(_suspend)

    _result = true
    unless _fiber&.alive?
      @fibers.delete(__method__)
      _result = false
    end
    
    _result
	end

  # Writes all script versions to a CSV file.
  # @param _filename [String] File name
  def save_csv_version(_filename)
    if @versions.empty?
      return
    end
    if File.exist?(_filename) && !meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))
  
    _header = create_version.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @versions.each do |_version|
        LOG.debug(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _version.write_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all script tasks to a CSV file.
  # @param _filename [String] File name
  def save_csv_task(_filename)
    if @tasks.empty?
      return
    end

    _sct_name = sct_name(_filename)
    _tasks    = @tasks.find_all do |_task|
      _task.file == _sct_name
    end
    if _tasks.empty?
      return
    end

    if !mtime_updated?(_filename)
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      store_mtime(_filename)
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    _header = create_task.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      _tasks.each do |_task|
        LOG.debug(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _task.write_csv(_f)
      end
    end
    store_mtime(_filename)
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all entries to CSV files. To free up memory, all script tasks are 
  # automatically removed afterwards.
  # 
  # @param _suspend [Boolean] Process next CSV files and wait for next 
  #                           execution.
  # 
  # @return [Boolean] +true+ if method waits for next execution, +false+ 
  #                   otherwise.
	def save_csv(_suspend = false)
    _fiber = @fibers[__method__]
    if !_fiber
      _fiber = Fiber.new do |_yield|
        _files = collect_files
        until _files.empty?
          _files.each do |_filename|
            _path = File.basename(_filename, '.*')
            _path = @task_csv_file.sub('*', _path)
            save_csv_task(glob(_path))
          end
          @tasks.clear
          if _yield
            Fiber.yield
          end
          
          _files = collect_files
        end

        save_csv_version(glob(@version_csv_file))
      end
      
      @fibers[__method__] = _fiber
    end
    _fiber.resume(_suspend)

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
  def sct_name(_filename)
    File.basename(_filename, '.*') + File.extname(@sct_file)
  end

  # Returns +true+ if the SCT file has been modified, otherwise +false+.
  # @return [Boolean] +true+ if SCT file has been modified, otherwise +false+.
  def mtime_updated?(_filename)
    _sct_name = sct_name(_filename)

    _snapshot = snaps[:mtimes]
    unless _snapshot
      return true
    end

    _created  = _snapshot[_sct_name]
    _modified = @mtimes[_sct_name]
    if !_created || !_modified
      return true
    end
    if _modified > _created
      return true
    end

    _version = @versions.find { |_v| _v.file == _sct_name }
    if _version&.expired
      return true
    end
    
    false
  end

  # Stores the modification time of the given file.
  # @param _filename [String] File name
  def store_mtime(_filename)
    unless File.exist?(_filename)
      return
    end
  
    _sct_name = sct_name(_filename)
    _mtime    = File.mtime(_filename)

    if _mtime > (@mtimes[_sct_name] || Time.new(0))
      @mtimes[_sct_name] = _mtime
    end
  end
  
end # class ScriptTaskData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
