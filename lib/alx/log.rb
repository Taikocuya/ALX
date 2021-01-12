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

require('fileutils')
require('logger')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle the logging.
module LOG

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Initializes the logging.
  # @see ::Logger::new
  def self.init
    @@initialized ||= false
    if @@initialized
      return @@initialized
    end

    _prog_name = File.basename($0)
    if $0 && Object.const_defined?('ALX::SYS') && SYS.log
      _log_file = File.basename($0, '.*') + '.log'
      _log_file = File.join(SYS.log_dir, _log_file)
    else
      _log_file = nil
    end

    @@std_out = Logger.new(STDOUT, level: SYS.log_level, progname: _prog_name)
    @@std_out.formatter = Proc.new do |_severity, _, _, _msg|
      sprintf("%s -- %s\r\n", _severity[0], _msg)
    end
    @@log_out = nil

    if _log_file
      FileUtils.mkdir_p(File.dirname(_log_file))
      if File.exist?(_log_file)
        _mdate    = File.mtime(_log_file)
        _basename = File.basename(_log_file, '.*')
        _rdate    = _mdate.strftime('-%Y-%m-%dT%H-%M-%S')
        _filename = _basename + _rdate + '.log'
        _filename = File.join(File.dirname(_log_file), _filename)
        FileUtils.mv(_log_file, _filename)

        _glob  = File.join(
          SYS.log_dir, _basename + '-[0-9]*[0-9]T[0-9]*[0-9].log'
        )
        _files = Dir.glob(_glob).sort.reverse
        while _files.size > SYS.log_keep
          FileUtils.rm(_files.pop)
        end
      end
      @@log_out = Logger.new(
        _log_file, level: SYS.log_level, progname: _prog_name
      )
    end

    @@initialized = true
  end

  # @see ::Logger#level=
  def self.level=(_severity)
    @@std_out&.level = _severity
    @@log_out&.level = _severity
  end

  # @see ::Logger#unknown
  def self.unknown(*_args, &_block)
    @@std_out&.unknown(*_args, &_block)
    @@log_out&.unknown(*_args, &_block)
  end

  # @see ::Logger#debug
  def self.debug(*_args, &_block)
    @@std_out&.debug(*_args, &_block)
    @@log_out&.debug(*_args, &_block)
  end

  # @see ::Logger#info
  def self.info(*_args, &_block)
    @@std_out&.info(*_args, &_block)
    @@log_out&.info(*_args, &_block)
  end

  # @see ::Logger#warn
  def self.warn(*_args, &_block)
    @@std_out&.warn(*_args, &_block)
    @@log_out&.warn(*_args, &_block)
  end

  # @see ::Logger#error
  def self.error(*_args, &_block)
    @@std_out&.error(*_args, &_block)
    @@log_out&.error(*_args, &_block)
  end

  # @see ::Logger#fatal
  def self.fatal(*_args, &_block)
    @@std_out&.fatal(*_args, &_block)
    @@log_out&.fatal(*_args, &_block)
  end

end # module LOG

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

begin
  ALX::LOG.init
rescue => _e
  print(_e.message, "\n", _e.backtrace.join("\n"), "\n")
  exit(1)
end
