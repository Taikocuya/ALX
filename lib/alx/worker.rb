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

require('fileutils')
require('logger')
require('optparse')
require('timeout')
require_relative('etc.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle the worker process.
class Worker

#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Enumerable)

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Name format of PID file
  PID_FILE   = '%s#%s.pid'
  # Regular expression for PID file
  PID_REGEXP = /(?<name>.+)#(?<pid>\d+)\.pid$/
  # Path to MemFs directory 
  MEMFS_DIR  = '/__enclose_io_memfs__'
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Worker.
  def initialize
    ObjectSpace.define_finalizer(self, finalize)
    self.limit   = 0xffffffff
    self.timeout = CFG.worker_timeout
    init_worker
    init_ruby
    init_pid
  end

  # Initializes the Worker.
  def self.init
    @@initialized ||= false
    if @@initialized
      return @@initialized
    end

    ALX.send(:remove_const, self.name.split('::').last)
    ALX.send(:const_set   , self.name.split('::').last, self.new)
    
    @@initialized = true
  end
  
  # Returns +true+ if the worker is a parent process, otherwise +false+.
  # @return [Boolean] +true+ if worker is a parent process, otherwise +false+.
  def parent?
    @key.empty?
  end
  
  # Returns +true+ if the worker is a child process, otherwise +false+.
  # @return [Boolean] +true+ if worker is a child process, otherwise +false+.
  def child?
    !@key.empty?
  end
  
  # Returns +true+ if a process ID is running, otherwise +false+.
  # @param _pid [Integer] Process ID
  # @return [Boolean] +true+ if process ID is running, otherwise +false+.
  def running?(_pid)
    begin
      _int = Process.kill(0, _pid)
      true
    rescue Errno::ESRCH
      false
    end
  end
  
  # Calls the given block once for each worker process ID and process file, 
  # passing these elements as a parameter.
  def each
    Dir.glob(@pid_glob).each do |_pid_file|
      _match = _pid_file.match(PID_REGEXP)
      yield _match&.[](:pid)&.to_i, _pid_file
    end
  end

  # Waits for a worker process to exit if the maximum of worker processes has 
  # been reached. If +_max+ is given, it cannot be greater than #limit. If 
  # +_max+ is not specified, the method waits for all worker processes. If the 
  # time to wait is longer than #timeout seconds, the error is caught with a 
  # timeout exception.
  # 
  # @param _max [Integer] Maximum of worker processes
  def wait(_max = nil)
    _max  = [[2, _max || 2].max, @limit].min
    _last = Process.clock_gettime(Process::CLOCK_MONOTONIC).to_i
    Timeout::timeout(@timeout) do 
      while size >= _max
        sleep(0)
        if Process.clock_gettime(Process::CLOCK_MONOTONIC).to_i != _last
          _last = Process.clock_gettime(Process::CLOCK_MONOTONIC).to_i
          purge_pid
        end
      end
    end
  end

  # Spawns a new worker process of itself.
  # @param _worker [String] Worker key
  def spawn(_worker)
    _worker   = _worker.to_s
    _pid      = Process.spawn(@ruby_exe, @script_file, '--worker', _worker)
    _pid_file = File.join(CFG.temp_dir, sprintf(PID_FILE, @pid_base, _pid))
    save_pid(_pid_file, _pid)
  end

  # Sends the +SIGKILL+ signal to all other worker processes except for 
  # itself.
  # 
  # @param _wait [Boolean] Wait for exit
  def kill(_wait = true)
    each do |_pid, _pid_file|
      if _pid != pid && running?(_pid)
        Process.kill('KILL', _pid)
        delete_pid(_pid_file)
      end
    end
    if _wait
      wait
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :key
  attr_reader :limit
  attr_reader :timeout
  attr_reader :ruby_exe
  attr_reader :script_file
  attr_reader :script_base
  attr_reader :pid
  attr_reader :pid_base
  attr_reader :pid_file
  attr_reader :pid_glob

  def limit=(_limit)
    @limit = [0, _limit].max
  end
  
  def timeout=(_sec)
    @timeout = [0, _sec].max
  end
  
  def size
    Dir.glob(@pid_glob).size
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Destructs a Worker.
  def finalize
    Proc.new do
      delete_pid
    end
  end

  # Initializes the worker process.
  def init_worker
    _params = {}
    _parser = OptionParser.new do |_opts|
      _opts.on('--worker KEY', String)
    end
    _parser.parse!(into: _params)
    @key = _params[:worker] || ''
  end
  
  # Initializes the Ruby environment.
  def init_ruby
    if Dir.exist?(MEMFS_DIR)
      @ruby_exe = CFG.ruby_exe
    else
      @ruby_exe = RbConfig.ruby
    end
    @script_file = Process.argv0
    @script_base = File.basename(@script_file)
  end

  # Initializes the PID management.
  def init_pid
    @pid      = Process.pid
    @pid_base = File.basename(@script_file, '.*')
    @pid_file = File.join(CFG.temp_dir, sprintf(PID_FILE, @pid_base, @pid))
    @pid_glob = File.join(CFG.temp_dir, sprintf(PID_FILE, @pid_base, '*' ))
    purge_pid(true)
    
    _pid = Dir.glob(@pid_glob).first
    if parent? && _pid
      _msg = '%s is already running: "%s"'
      raise(RuntimeError, sprintf(_msg, File.basename(@script_file), _pid))
    end

    save_pid
  end

  # Cleans up the PID management.
  # @param _eval [Boolean] Evaluate file contents
  def purge_pid(_eval = false)
    each do |_pid, _pid_file|
      if !_pid || (_eval && load_pid(_pid_file) != _pid) || !running?(_pid)
        FileUtils.rm(_pid_file, force: true)
      end
    end
  end

  # Reads a PID file.
  # @param _filename [String] File name
  def load_pid(_filename = nil)
    _filename ||= @pid_file
    File.open(_filename, 'r') do |_f|
      begin
        return Integer(_f.read)
      rescue ArgumentError
        return nil
      end
    end
  end
  
  # Writes a PID file.
  # @param _filename [String]  File name
  # @param _pid      [Integer] Process ID
  def save_pid(_filename = nil, _pid = nil)
    _filename ||= @pid_file
    _pid      ||= @pid
    FileUtils.mkdir_p(CFG.temp_dir)
    File.open(_filename, 'w') do |_f|
      _f << _pid
    end
  end
  
  # Removes a PID file.
  # @param _filename [String] File name
  def delete_pid(_filename = nil)
    _filename ||= @pid_file
    FileUtils.rm(_filename, force: true)
  end
  
end # class Worker

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

ALX::Main.call do
  ALX::Worker.init
end
