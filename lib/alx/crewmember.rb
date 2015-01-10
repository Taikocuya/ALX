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

require_relative('shipaccessory.rb')
require_relative('shipitem.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a crew member.
class CrewMember < Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Size of the binary structure
  STRUCT_SIZE = 36

  # Position IDs
  POSITIONS = Hash.new('???')
  POSITIONS.store( 0, 'Helmsman')
  POSITIONS.store( 1, 'Engineer')
  POSITIONS.store( 2, 'Gunner'  )
  POSITIONS.store( 3, 'Lookout' )
  POSITIONS.store( 4, 'Merchant')
  POSITIONS.store( 5, 'Builder' )
  POSITIONS.store( 6, 'Cook'    )
  POSITIONS.store( 7, 'Artisan' )
  POSITIONS.store( 8, 'Sailor'  )
  POSITIONS.store( 9, 'Jester'  )
  POSITIONS.store(10, 'Delegate')

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super
    @position_id     = -1
    @feature_id      = -1
    @feature_padding = 0
    @feature_value   = 0
    @effect_id       = -1
    @effect_spirit   = -1
    @effect_turns    = -1
    @unknown1        = 0
    @unknown2        = 0
    @unknown3        = 0
    @effect_amount   = 0
    @unknown4        = 0
    @unknown5        = 0
    @unknown6        = 0
    @unknown7        = 0
    @unknown8        = 0
  end

  # Reads one crew member from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    super
    @position_id     = _f.read_data(1, 'c' )
    @feature_id      = _f.read_data(1, 'c' )
    @feature_padding = _f.read_data(1, 'c' )
    @feature_value   = _f.read_data(2, 's>')
    @effect_id       = _f.read_data(1, 'c' )
    @effect_spirit   = _f.read_data(1, 'c' )
    @effect_turns    = _f.read_data(1, 'c' )
    @unknown1        = _f.read_data(1, 'c' )
    @unknown2        = _f.read_data(1, 'c' )
    @unknown3        = _f.read_data(1, 'c' )
    @effect_amount   = _f.read_data(2, 's>')
    @unknown4        = _f.read_data(2, 's>')
    @unknown5        = _f.read_data(1, 'c' )
    @unknown6        = _f.read_data(1, 'c' )
    @unknown7        = _f.read_data(1, 'c' )
    @unknown8        = _f.read_data(1, 'c' )
  end
  
  # Write one crew member to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    super
    _f.write_data(@position_id    , 'c' )
    _f.write_data(@feature_id     , 'c' )
    _f.write_data(@feature_padding, 'c' )
    _f.write_data(@feature_value  , 's>')
    _f.write_data(@effect_id      , 'c' )
    _f.write_data(@effect_spirit  , 'c' )
    _f.write_data(@effect_turns   , 'c' )
    _f.write_data(@unknown1       , 'c' )
    _f.write_data(@unknown2       , 'c' )
    _f.write_data(@unknown3       , 'c' )
    _f.write_data(@effect_amount  , 's>')
    _f.write_data(@unknown4       , 's>')
    _f.write_data(@unknown5       , 'c' )
    _f.write_data(@unknown6       , 'c' )
    _f.write_data(@unknown7       , 'c' )
    _f.write_data(@unknown8       , 'c' )
  end

  # Reads one crew member from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    @position_id     = _row['Position ID'    ] || @position_id
    @feature_id      = _row['Feature ID'     ] || @feature_id
    @feature_padding = _row['Feature padding'] || @feature_padding
    @feature_value   = _row['Feature value'  ] || @feature_value
    @effect_id       = _row['Effect ID'      ] || @effect_id
    @effect_spirit   = _row['Effect spirit'  ] || @effect_spirit
    @effect_turns    = _row['Effect turns'   ] || @effect_turns
    @unknown1        = _row['Unknown #1'     ] || @unknown1
    @unknown2        = _row['Unknown #2'     ] || @unknown2
    @unknown3        = _row['Unknown #3'     ] || @unknown3
    @effect_amount   = _row['Effect amount'  ] || @effect_amount
    @unknown4        = _row['Unknown #4'     ] || @unknown4
    @unknown5        = _row['Unknown #5'     ] || @unknown5
    @unknown6        = _row['Unknown #6'     ] || @unknown6
    @unknown7        = _row['Unknown #7'     ] || @unknown7
    @unknown8        = _row['Unknown #8'     ] || @unknown8

    @position_id     = @position_id.to_i
    @feature_id      = @feature_id.to_i
    @feature_padding = @feature_padding.to_i
    @feature_value   = @feature_value.to_i
    @effect_id       = @effect_id.to_i
    @effect_spirit   = @effect_spirit.to_i
    @effect_turns    = @effect_turns.to_i
    @unknown1        = @unknown1.to_i
    @unknown2        = @unknown2.to_i
    @unknown3        = @unknown3.to_i
    @effect_amount   = @effect_amount.to_i
    @unknown4        = @unknown4.to_i
    @unknown5        = @unknown5.to_i
    @unknown6        = @unknown6.to_i
    @unknown7        = @unknown7.to_i
    @unknown8        = @unknown8.to_i
  end

  # Writes one crew member to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _row['Position ID'    ] = @position_id
    _row['Position name'  ] = POSITIONS[@position_id]
    _row['Feature ID'     ] = @feature_id
    _row['Feature name'   ] = ShipAccessory::FEATURES[@feature_id]
    _row['Feature padding'] = @feature_padding
    _row['Feature value'  ] = @feature_value
    _row['Effect ID'      ] = @effect_id
    _row['Effect name'    ] = ShipItem::EFFECTS[@effect_id]
    _row['Effect spirit'  ] = @effect_spirit
    _row['Effect turns'   ] = @effect_turns
    _row['Unknown #1'     ] = @unknown1
    _row['Unknown #2'     ] = @unknown2
    _row['Unknown #3'     ] = @unknown3
    _row['Effect amount'  ] = @effect_amount
    _row['Unknown #4'     ] = @unknown4
    _row['Unknown #5'     ] = @unknown5
    _row['Unknown #6'     ] = @unknown6
    _row['Unknown #7'     ] = @unknown7
    _row['Unknown #8'     ] = @unknown8
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :position_id
  attr_accessor :feature_id
  attr_accessor :feature_padding
  attr_accessor :feature_value
  attr_accessor :effect_id
  attr_accessor :effect_spirit
  attr_accessor :effect_turns
  attr_accessor :unknown1
  attr_accessor :unknown2
  attr_accessor :unknown3
  attr_accessor :effect_amount
  attr_accessor :unknown4
  attr_accessor :unknown5
  attr_accessor :unknown6
  attr_accessor :unknown7
  attr_accessor :unknown8
  
end	# class CrewMember

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
