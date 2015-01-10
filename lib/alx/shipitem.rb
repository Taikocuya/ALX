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

require_relative('shipcannon.rb')
require_relative('usableitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a ship item.
class ShipItem < Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================
 
  # Size of the binary structure
  STRUCT_SIZE = 36

  # Effect IDs
  EFFECTS = Hash.new('???')
  EFFECTS.store( -1, 'None')
  EFFECTS.store(100, 'Recover HP')
  EFFECTS.store(101, 'Recover HP: 100%')
  EFFECTS.store(102, 'Recover Spirit')
  EFFECTS.store(103, 'Recover Spirit: 100%')
  EFFECTS.store(104, 'Add state: Quickened')
  EFFECTS.store(105, 'Add state: Strengthen')
  EFFECTS.store(106, 'Add state: Weak')
  EFFECTS.store(107, 'Damage')
  EFFECTS.store(108, 'Improve: Parameters')
  EFFECTS.store(109, 'Invulnerable: Artillery')
  EFFECTS.store(110, 'Invulnerable: Magic')
  EFFECTS.store(111, 'Improve: First strike%')
  EFFECTS.store(112, 'Improve: Critical%')
  EFFECTS.store(113, 'Spirit consumption: 50%')
  EFFECTS.store(114, 'Spirit restoration: 200%')
  EFFECTS.store(115, 'Increase: Parameters')
  EFFECTS.store(116, 'Add state: Silence')
  EFFECTS.store(117, 'Recover MP')
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super
    @occasion_flags = 0
    @effect_id      = 0
    @turns          = 0
    @consume        = 0
    @padding1       = 0
    @price          = 0
    @sell           = 0
    @unknown1       = 0
    @unknown2       = 0
    @padding2       = 0
    @amount         = 0
    @element_id     = 0
    @unknown3       = 0
    @unknown4       = 0
    @hit            = 0
  end

  # Reads one ship item from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    super
    @occasion_flags = _f.read_data(1, 'c' )
    @effect_id      = _f.read_data(1, 'c' )
    @turns          = _f.read_data(1, 'c' )
    @consume        = _f.read_data(1, 'c' )
    @padding1       = _f.read_data(1, 'c' )
    @price          = _f.read_data(2, 'S>')
    @sell           = _f.read_data(1, 'c' )
    @unknown1       = _f.read_data(1, 'c' )
    @unknown2       = _f.read_data(1, 'c' )
    @padding2       = _f.read_data(1, 'c' )
    @amount         = _f.read_data(2, 's>')
    @element_id     = _f.read_data(1, 'c' )
    @unknown3       = _f.read_data(1, 'c' )
    @unknown4       = _f.read_data(2, 's>')
    @hit            = _f.read_data(2, 's>')
  end
  
  # Write one ship item to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    super
    _f.write_data(@occasion_flags, 'c' )
    _f.write_data(@effect_id     , 'c' )
    _f.write_data(@turns         , 'c' )
    _f.write_data(@consume       , 'c' )
    _f.write_data(@padding1      , 'c' )
    _f.write_data(@price         , 'S>')
    _f.write_data(@sell          , 'c' )
    _f.write_data(@unknown1      , 'c' )
    _f.write_data(@unknown2      , 'c' )
    _f.write_data(@padding2      , 'c' )
    _f.write_data(@amount        , 's>')
    _f.write_data(@element_id    , 'c' )
    _f.write_data(@unknown3      , 'c' )
    _f.write_data(@unknown4      , 's>')
    _f.write_data(@hit           , 's>')
  end

  # Reads one ship item from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    @occasion_flags = _row['Occasion flags' ] || @occasion_flags
    @effect_id      = _row['Effect ID'      ] || @effect_id
    @turns          = _row['Turns'          ] || @turns
    @consume        = _row['Consume%'       ] || @consume
    @padding1       = _row['Padding #1'     ] || @padding1
    @price          = _row['Price'          ] || @price
    @sell           = _row['Sell price in %'] || @sell
    @unknown1       = _row['Unknown #1'     ] || @unknown1
    @unknown2       = _row['Unknown #2'     ] || @unknown2
    @padding2       = _row['Padding #2'     ] || @padding2
    @amount         = _row['Effect amount'  ] || @amount
    @element_id     = _row['Element ID'     ] || @element_id
    @unknown3       = _row['Unknown #3'     ] || @unknown3
    @unknown4       = _row['Unknown #4'     ] || @unknown4
    @hit            = _row['Hit%'           ] || @hit
    
    @occasion_flags = @occasion_flags.to_i
    @effect_id      = @effect_id.to_i
    @turns          = @turns.to_i
    @consume        = @consume.to_i
    @padding1       = @padding1.to_i
    @price          = @price.to_i
    @sell           = @sell.to_i
    @unknown1       = @unknown1.to_i
    @unknown2       = @unknown2.to_i
    @padding2       = @padding2.to_i
    @amount         = @amount.to_i
    @element_id     = @element_id.to_i
    @unknown3       = @unknown3.to_i
    @unknown4       = @unknown4.to_i
    @hit            = @hit.to_i
  end

  # Writes one ship item to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super

    _row['Occasion flags' ] = @occasion_flags

    UsableItem::OCCASIONS.each do |_id, _c|
      if @occasion_flags & (0x4 >> _id) != 0
        _row[_c] = 'X'
      end
    end

    _row['Effect ID'      ] = @effect_id
    _row['Effect name'    ] = EFFECTS[@effect_id]
    _row['Turns'          ] = @turns
    _row['Consume%'       ] = @consume
    _row['Padding #1'     ] = @padding1
    _row['Price'          ] = @price
    _row['Sell price in %'] = @sell
    _row['Unknown #1'     ] = @unknown1
    _row['Unknown #2'     ] = @unknown2
    _row['Padding #2'     ] = @padding2
    _row['Effect amount'  ] = @amount
    _row['Element ID'     ] = @element_id
    _row['Element name'   ] = ShipCannon::ELEMENTS[@element_id]
    _row['Unknown #3'     ] = @unknown3
    _row['Unknown #4'     ] = @unknown4
    _row['Hit%'           ] = @hit
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :occasion_flags
  attr_accessor :effect_id
  attr_accessor :turns
  attr_accessor :consume
  attr_accessor :padding1
  attr_accessor :price
  attr_accessor :sell
  attr_accessor :unknown1
  attr_accessor :unknown2
  attr_accessor :padding2
  attr_accessor :amount
  attr_accessor :element_id
  attr_accessor :unknown3
  attr_accessor :unknown4
  attr_accessor :hit
  
end	# class ShipItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
