#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2015 Marcel Renner
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
#                                   REQUIRES
#==============================================================================

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a ship cannon.
class ShipCannon < Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Size of the binary structure
  STRUCT_SIZE = 36

  # Ship IDs
  SHIPS = Hash.new('???')
  SHIPS.store(0, 'Little Jack: Harpoon Cannon')
  SHIPS.store(1, 'Little Jack: Standard'      )
  SHIPS.store(2, 'Delphinus: Prototype'       )
  SHIPS.store(3, 'Delphinus: Standard'        )
  SHIPS.store(4, 'Delphinus: Upgraded'        )
  
  # Type IDs
  TYPES = Hash.new('???')
  TYPES.store(0, 'Main cannon'     )
  TYPES.store(1, 'Secondary cannon')
  TYPES.store(2, 'Torpedo'         )
  TYPES.store(3, 'Special'         )

  # Element IDs
  ELEMENTS = Hash.new('???')
  ELEMENTS.store(-1, 'None'  )
  ELEMENTS.store( 0, 'Green' )
  ELEMENTS.store( 1, 'Red'   )
  ELEMENTS.store( 2, 'Purple')
  ELEMENTS.store( 3, 'Blue'  )
  ELEMENTS.store( 4, 'Yellow')
  ELEMENTS.store( 5, 'Silver')
  ELEMENTS.store( 6, 'Normal')
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super
    @ship_flags = 0
    @type_id    = 0
    @element_id = 0
    @attack     = 0
    @hit        = 0
    @limit      = 0
    @spirit     = 0
    @unknown1   = 0
    @unknown2   = 0
    @unknown3   = 0
    @unknown4   = 0
    @price      = 0
    @sell       = 0
    @unknown5   = 0
    @unknown6   = 0
    @padding    = 0
  end

  # Reads one ship cannon from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    super
    @ship_flags = _f.read_data(1, 'c' )
    @type_id    = _f.read_data(1, 'c' )
    @element_id = _f.read_data(1, 'c' )
    @attack     = _f.read_data(2, 's>')
    @hit        = _f.read_data(2, 'S>')
    @limit      = _f.read_data(1, 'c' )
    @spirit     = _f.read_data(1, 'c' )
    @unknown1   = _f.read_data(1, 'c' )
    @unknown2   = _f.read_data(1, 'c' )
    @unknown3   = _f.read_data(1, 'c' )
    @unknown4   = _f.read_data(1, 'c' )
    @price      = _f.read_data(2, 'S>')
    @sell       = _f.read_data(1, 'c' )
    @unknown5   = _f.read_data(1, 'c' )
    @unknown6   = _f.read_data(1, 'c' )
    @padding    = _f.read_data(1, 'c' )
  end
  
  # Write one ship cannon to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    super
    _f.write_data(@ship_flags, 'c' )
    _f.write_data(@type_id   , 'c' )
    _f.write_data(@element_id, 'c' )
    _f.write_data(@attack    , 's>')
    _f.write_data(@hit       , 'S>')
    _f.write_data(@limit     , 'c' )
    _f.write_data(@spirit    , 'c' )
    _f.write_data(@unknown1  , 'c' )
    _f.write_data(@unknown2  , 'c' )
    _f.write_data(@unknown3  , 'c' )
    _f.write_data(@unknown4  , 'c' )
    _f.write_data(@price     , 'S>')
    _f.write_data(@sell      , 'c' )
    _f.write_data(@unknown5  , 'c' )
    _f.write_data(@unknown6  , 'c' )
    _f.write_data(@padding   , 'c' )
  end

  # Reads one ship cannon from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    @ship_flags = _row['Ship flags'     ] || @ship_flags
    @type_id    = _row['Type ID'        ] || @type_id
    @element_id = _row['Element ID'     ] || @element_id
    @attack     = _row['Attack'         ] || @attack
    @hit        = _row['Hit%'           ] || @hit
    @limit      = _row['Limit'          ] || @limit
    @spirit     = _row['Spirit'         ] || @spirit
    @unknown1   = _row['Unknown #1'     ] || @unknown1
    @unknown2   = _row['Unknown #2'     ] || @unknown2
    @unknown3   = _row['Unknown #3'     ] || @unknown3
    @unknown4   = _row['Unknown #4'     ] || @unknown4
    @price      = _row['Price'          ] || @price
    @sell       = _row['Sell price in %'] || @sell
    @unknown5   = _row['Unknown #5'     ] || @unknown5
    @unknown6   = _row['Unknown #6'     ] || @unknown6
    @padding    = _row['Padding'        ] || @padding
    
    @ship_flags = @ship_flags.to_i
    @type_id    = @type_id.to_i
    @element_id = @element_id.to_i
    @attack     = @attack.to_i
    @hit        = @hit.to_i
    @limit      = @limit.to_i
    @spirit     = @spirit.to_i
    @unknown1   = @unknown1.to_i
    @unknown2   = @unknown2.to_i
    @unknown3   = @unknown3.to_i
    @unknown4   = @unknown4.to_i
    @price      = @price.to_i
    @sell       = @sell.to_i
    @unknown5   = @unknown5.to_i
    @unknown6   = @unknown6.to_i
    @padding    = @padding.to_i
  end

  # Writes one ship cannon to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _row['Ship flags'     ] = @ship_flags
      
    SHIPS.each do |_id, _s|
      if @ship_flags & (0x20 >> _id) != 0
        _row[_s] = 'X'
      end
    end
      
    _row['Type ID'        ] = @type_id
    _row['Type name'      ] = TYPES[@type_id]
    _row['Element ID'     ] = @element_id
    _row['Element name'   ] = ELEMENTS[@element_id]
    _row['Attack'         ] = @attack
    _row['Hit%'           ] = @hit
    _row['Limit'          ] = @limit
    _row['Spirit'         ] = @spirit
    _row['Unknown #1'     ] = @unknown1
    _row['Unknown #2'     ] = @unknown2
    _row['Unknown #3'     ] = @unknown3
    _row['Unknown #4'     ] = @unknown4
    _row['Price'          ] = @price
    _row['Sell price in %'] = @sell
    _row['Unknown #5'     ] = @unknown5
    _row['Unknown #6'     ] = @unknown6
    _row['Padding'        ] = @padding
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :ship_flags
  attr_accessor :type_id
  attr_accessor :element_id
  attr_accessor :attack
  attr_accessor :hit
  attr_accessor :limit
  attr_accessor :spirit
  attr_accessor :unknown1
  attr_accessor :unknown2
  attr_accessor :unknown3
  attr_accessor :unknown4
  attr_accessor :price
  attr_accessor :sell
  attr_accessor :unknown5
  attr_accessor :unknown6
  attr_accessor :padding
  
end	# class ShipCannon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
