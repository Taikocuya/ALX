#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
require_relative('main.rb')
require_relative('worker.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle the logging.
class LOG

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a LOG.
  def initialize
    ObjectSpace.define_finalizer(self, finalize)

    @std = Logger.new(STDOUT, level: CFG.log_level)
    @std.formatter = Proc.new do |_severity, _, _, _msg|
      sprintf("%s [#%d] -- %s\r\n", _severity[0], Worker.pid, _msg)
    end
    
    if Object.const_defined?('ALX::CFG') && CFG.log
      _filename = File.join(CFG.log_dir, Worker.pid_base + '.log')
      
      FileUtils.mkdir_p(File.dirname(CFG.log_dir))
      if Worker.parent? && File.exist?(_filename)
        _mdate = File.mtime(_filename)
        _rdate = _mdate.strftime('-%Y-%m-%dT%H-%M-%S')
        _rname = File.join(CFG.log_dir, Worker.pid_base + _rdate + '.log')
        FileUtils.mv(_filename, _rname)

        _glob  = File.join(
          CFG.log_dir, Worker.pid_base + '-[0-9]*[0-9]T[0-9]*[0-9].log'
        )
        _files = Dir.glob(_glob).sort.reverse
        while _files.size > CFG.log_keep
          FileUtils.rm(_files.pop)
        end
      end

      _file      = File.open(_filename, 'a+')
      _file.sync = true
      
      @log = Logger.new(_file, level: CFG.log_level, progname: Worker.pid_base)
    else
      @log = nil
    end
  end

  # Initializes the LOG.
  def self.init
    @@initialized ||= false
    if @@initialized
      return @@initialized
    end

    ALX.send(:remove_const, self.name.split('::').last)
    ALX.send(:const_set   , self.name.split('::').last, self.new)
    
    @@initialized = true
  end
  
  # @see ::Logger#level=
  def level=(_severity)
    @std&.level = _severity
    @log&.level = _severity
  end

  # @see ::Logger#unknown
  def unknown(_std_msg, _log_msg = nil)
    @std&.unknown(_std_msg            )
    @log&.unknown(_log_msg || _std_msg)
  end

  # @see ::Logger#debug
  def debug(_std_msg, _log_msg = nil)
    @std&.debug(_std_msg            )
    @log&.debug(_log_msg || _std_msg)
  end

  # @see ::Logger#info
  def info(_std_msg, _log_msg = nil)
    @std&.info(_std_msg            )
    @log&.info(_log_msg || _std_msg)
  end

  # @see ::Logger#warn
  def warn(_std_msg, _log_msg = nil)
    @std&.warn(_std_msg            )
    @log&.warn(_log_msg || _std_msg)
  end

  # @see ::Logger#error
  def error(_std_msg, _log_msg = nil)
    @std&.error(_std_msg            )
    @log&.error(_log_msg || _std_msg)
  end

  # @see ::Logger#fatal
  def fatal(_std_msg, _log_msg = nil)
    @std&.fatal(_std_msg            )
    @log&.fatal(_log_msg || _std_msg)
  end

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Destructs a Worker.
  def finalize
    Proc.new do
      @log&.close
    end
  end

end # class LOG

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

ALX::Main.call do
  ALX::LOG.init
end
