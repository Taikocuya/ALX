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

require_relative('executable.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write SHT files.
class ShtFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  # Constructs a ShtFile.
  def initialize
    @meta = nil
    @data = nil
  end

  # Compares own metadata with given metadata. Returns +true+ if metadata 
  # objects are equal or +false+ otherwise.
  # @param _meta [MetaData] MetaData object
  # @return [Boolean] +true+ if metadata objects are equal, otherwise +false+.
  def valid?(_meta)
    _result   = true
    _result &&= _meta.is_a?(MetaData)
    _result &&= @meta.is_a?(MetaData)
    _result &&= (@meta.version   == _meta.version  )
    _result &&= (@meta.uuid      == _meta.uuid     )
    _result &&= (@meta.luid      == _meta.luid     )
    _result &&= (@meta.checksums == _meta.checksums)
    _result &&= (@meta.created   == _meta.created  )
    _result
  end

  # Reads a SHT file.
  # @param _filename [String] File name
  def load(_filename)
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_snapshot))
      
    File.open(_filename, 'rb') do |_f|
      LOG.info(sprintf(VOC.read, 0, _f.pos))
      @meta = Marshal.load(_f)
      LOG.info(sprintf(VOC.read, 1, _f.pos))
      @data = Marshal.load(_f)
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes a SHT file.
  # @param _filename [String] File name
  def save(_filename)
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_snapshot))

    File.open(_filename, 'wb') do |_f|
      LOG.info(sprintf(VOC.write, 0, _f.pos))
      Marshal.dump(@meta, _f)
      LOG.info(sprintf(VOC.write, 1, _f.pos))
      Marshal.dump(@data, _f)
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :meta
  attr_accessor :data

end # class ShtFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
