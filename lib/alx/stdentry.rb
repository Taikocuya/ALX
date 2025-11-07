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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Base class to handle a standard entry.
class StdEntry < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Add name properties.
  # @param _size [Integer] Size of name properties
  def add_name_props(_size = 17)
    if jp? || us?
      self[VOC.name_str(cid)] = StrProp.new(_size, '')
    elsif eu?
      self[VOC.sot_pos(cid)] = IntProp.new(:u32,  0, base: 16 )
      self[VOC.name_opt(gb)] = StrProp.new( nil, '', dmy: true)
    end
  end

  # Add description properties.
  def add_dscr_props
    if jp? || us?
      self[VOC.dscr_pos(cid) ] = IntProp.new(:u32,  0, base: 16, ext: true)
      self[VOC.dscr_size(cid)] = IntProp.new(:u32,  0,           ext: true)
      self[VOC.dscr_str(cid) ] = StrProp.new( nil, '',           ext: true)
    elsif eu?
      self[VOC.dscr_opt(gb)] = StrProp.new( nil, '', dmy: true)
    end
  end

  # Add ship description properties.
  def add_ship_dscr_props
    if jp? || us?
      _pos  = VOC.ship_dscr_pos
      _size = VOC.ship_dscr_size
      _str  = VOC.ship_dscr_str
      self[_pos[cid] ] = IntProp.new(:u32,  0, base: 16, ext: true)
      self[_size[cid]] = IntProp.new(:u32,  0,           ext: true)
      self[_str[cid] ] = StrProp.new( nil, '',           ext: true)
    elsif eu?
      self[VOC.ship_dscr_opt(gb)] = StrProp.new( nil, '', dmy: true)
    end
  end

  # Add ID proc.
  # @param _id_offset     [Integer] ID offset
  # @param name_table     [String]  Name string table
  # @param dscr_table     [String]  Description string table
  # @param shipdscr_table [String]  Ship description string table
  def add_id_proc(
    _id_offset, name_table: nil, dscr_table: nil, ship_dscr_table: nil
  )
    if eu?
      fetch(VOC.id).proc = Proc.new do |_id|
        if name_table && fetch(VOC.name_opt(gb))
          _table = @string_table_entries&.[](name_table) || []
          _entry = _table[_id + _id_offset]
          _name  = '???'
          if _entry
            if dc?
              _name = _entry['ENGLISH.SOT']
            else
              _name = _entry['english.sot']
            end
          end
          self[VOC.name_opt(gb)] = _name
        end

        if dscr_table && fetch(VOC.dscr_opt(gb))
          _table = @string_table_entries&.[](dscr_table) || []
          _entry = _table[_id + _id_offset]
          _name  = '???'
          if _entry
            if dc?
              _name = _entry['ENGLISH.SOT']
            else
              _name = _entry['english.sot']
            end
          end
          self[VOC.dscr_opt(gb)] = _name
        end

        if ship_dscr_table && fetch(VOC.ship_dscr_opt(gb))
          _table = @string_table_entries&.[](ship_dscr_table) || []
          _entry = _table[_id + _id_offset]
          _name  = '???'
          if _entry
            if dc?
              _name = _entry['ENGLISH.SOT']
            else
              _name = _entry['english.sot']
            end
          end
          self[VOC.ship_dscr_opt(gb)] = _name
        end
      end
    end
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------
  
  attr_reader :string_table_entries

  def string_table_entries=(_string_table_entries)
    @string_table_entries = _string_table_entries || {}
    fetch(VOC.id)&.call_proc
  end
  
  def sot_pos
    self[VOC.sot_pos(cid)] || nil
  end

  def sot_pos=(_sot_pos)
    self[VOC.sot_pos(cid)] = _sot_pos
  end

end # class StdEntry

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
