#!/usr/bin/ruby
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

require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================
  
# Class to compare two files.
class FileComparator < EntryTransform

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Path to first file
  FILE_1 = File.join(CFG.build_dir, '')
  # Path to second file
  FILE_2 = File.join(CFG.build_dir, '')
  # Filter for bytes to be ignored.
  FILTER = [0x55]

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an FileComparator.
  def initialize
    super(nil)
  end

  # This method is called before #update respectively as first in #exec.
  # @see #exec
  def startup
  end
  
  # This method is called after #startup and before #shutdown in #exec. It 
  # will be re-executed as long as #repeat is true.
  # @see #exec
  def update
    super
  
    LOG.info(sprintf(VOC.load, VOC.open_file, FILE_1))
    LOG.info(sprintf(VOC.load, VOC.open_file, FILE_2))
    
    _total   = 0
    _ignored = 0
    _diffs   = 0
    _matches = 0
    BinaryFile.open(FILE_1, 'rb') do |_f1|
      BinaryFile.open(FILE_2, 'rb') do |_f2|
        while !_f1.eof? && !_f2.eof?
          _byte1 = !_f1.eof? ? _f1.read_int(:u8) : nil
          _byte2 = !_f2.eof? ? _f2.read_int(:u8) : nil
          
          _total += 1
          if FILTER.include?(_byte1) || FILTER.include?(_byte2)
            _ignored += 1
          elsif _byte1 != _byte2
            _diffs   += 1
          else
            _matches += 1
          end
        end
      end
    end
    _ratio = (_matches + _ignored) * 100 / _total.to_f

    LOG.info(sprintf('Total:     %d'  , _total  ))
    LOG.info(sprintf('Ignored:   %d'  , _ignored))
    LOG.info(sprintf('Different: %d'  , _diffs  ))
    LOG.info(sprintf('Matched:   %d'  , _matches))
    LOG.info(sprintf('Ratio:     %f%%', _ratio  ))
  end

end # class FileComparator

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _fc = ALX::FileComparator.new
    _fc.exec
  end
end
