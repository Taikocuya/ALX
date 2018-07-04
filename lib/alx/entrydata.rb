#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2018 Marcel Renner
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

require_relative('cache.rb')
require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle entries from binary and/or CSV files.
class EntryData
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Path to DOL file relative to game root.
  DOL_FILE       = 'root/&&systemdata/Start.dol'
  # Path to LMT file relative to game root.
  LMT_FILE       = 'root/battle/first.lmt'
  # Path to German SOT file relative to game root (PAL-E only).
  SOT_FILE_DE    = 'root/german.sot'
  # Path to Spanish SOT file relative to game root (PAL-E only).
  SOT_FILE_ES    = 'root/spanish.sot'
  # Path to French SOT file relative to game root (PAL-E only).
  SOT_FILE_FR    = 'root/french.sot'
  # Path to English SOT file relative to game root (PAL-E only).
  SOT_FILE_GB    = 'root/english.sot'
  
  STR_OPEN       = 'Opening file "%s" to %s %s...'
  STR_OPEN_READ  = 'read'
  STR_OPEN_WRITE = 'write'
  STR_OPEN_DATA  = 'data'
  STR_READ       = 'Reading entry #%s @ %#x...'
  STR_WRITE      = 'Writing entry #%s @ %#x...'
  STR_CLOSE      = 'File "%s" has been closed.'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EntryData.
  # @param _class [Entry]    Entry object
  # @param _root  [GameRoot] Game root
  def initialize(_class, _root)
    @class      = _class
    @root       = _root
    _class_name = self.class.name.split('::').last
    @cache_id   = sprintf('%s_%s', region, _class_name).downcase.to_sym
  end
    
  # Creates an entry.
  # @return [Entry] Entry object
  def create_entry
    @class.new(region)
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------
  
  attr_reader :class
  attr_reader :root
  attr_reader :cache_id

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected
    
  # Returns the region ID.
  # @return [String] Region ID
  def region
    @root.hdr.region_id
  end
    
end # class EntryData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
