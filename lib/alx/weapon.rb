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

require_relative('armor.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a weapon.
class Weapon < Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Size of the binary structure
  STRUCT_SIZE = 32

  # State IDs
  STATES = Hash.new('???')
  STATES.store(-1, 'None'              )
  STATES.store( 0, 'Poison'            )
  STATES.store( 1, 'Sleep (Type 1)'    )
  STATES.store( 2, 'Weak'              )
  STATES.store( 3, 'Confusion (Type 1)')
  STATES.store( 4, 'Sleep (Type 2)'    )
  STATES.store( 5, 'Confusion (Type 2)')
  STATES.store( 6, 'Death (Type 1)'    )
  STATES.store( 7, 'Silence (Type 1)'  )
  STATES.store( 8, 'Stone (Type 1)'    )
  STATES.store( 9, 'Sleep (Type 3)'    )
  STATES.store(10, 'Death (Type 2)'    )
  STATES.store(11, 'Confusion (Type 3)')
  STATES.store(12, 'Silence (Type 2)'  )
  STATES.store(13, 'Stone (Type 2)'    )
  STATES.store(14, 'Confusion (Type 4)')
  STATES.store(15, 'Sleep (Type 4)'    )
  STATES.store(16, 'Death (Type 3)'    )
  STATES.store(17, 'Sleep (Type 5)'    )
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super
    @character_id    = 0
    @sell            = 0
    @unknown1        = -1
    @unknown2        = -1
    @state_id        = -1
    @price           = 0
    @attack          = 0
    @hit             = 0
    @feature_id      = -1
    @feature_padding = 0
    @feature_value   = 0
  end

  # Reads one weapon from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    super
    @character_id    = _f.read_data(1, 'c' )
    @sell            = _f.read_data(1, 'c' )
    @unknown1        = _f.read_data(1, 'c' )
    @unknown2        = _f.read_data(1, 'c' )
    @state_id        = _f.read_data(1, 'c' )
    @price           = _f.read_data(2, 'S>')
    @attack          = _f.read_data(2, 's>')
    @hit             = _f.read_data(2, 's>')
    @feature_id      = _f.read_data(1, 'c' )
    @feature_padding = _f.read_data(1, 'c' )
    @feature_value   = _f.read_data(2, 's>')
  end
  
  # Write one weapon to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    super
    _f.write_data(@character_id   , 'c' )
    _f.write_data(@sell           , 'c' )
    _f.write_data(@unknown1       , 'c' )
    _f.write_data(@unknown2       , 'c' )
    _f.write_data(@state_id       , 'c' )
    _f.write_data(@price          , 'S>')
    _f.write_data(@attack         , 's>')
    _f.write_data(@hit            , 's>')
    _f.write_data(@feature_id     , 'c' )
    _f.write_data(@feature_padding, 'c' )
    _f.write_data(@feature_value  , 's>')
  end

  # Reads one weapon from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    @character_id    = _row['Character ID'    ] || @character_id
    @sell            = _row['Sell price in %' ] || @sell
    @unknown1        = _row['Unknown #1'      ] || @unknown1
    @unknown2        = _row['Unknown #2'      ] || @unknown2
    @state_id        = _row['Inflict state ID'] || @state_id
    @price           = _row['Price'           ] || @price
    @attack          = _row['Attack'          ] || @attack
    @hit             = _row['Hit%'            ] || @hit
    @feature_id      = _row['Feature ID'      ] || @feature_id
    @feature_padding = _row['Feature Padding' ] || @feature_padding
    @feature_value   = _row['Feature Value'   ] || @feature_value
      
    @character_id    = @character_id.to_i
    @sell            = @sell.to_i
    @unknown1        = @unknown1.to_i
    @unknown2        = @unknown2.to_i
    @state_id        = @state_id.to_i
    @price           = @price.to_i
    @attack          = @attack.to_i
    @hit             = @hit.to_i
    @feature_id      = @feature_id.to_i
    @feature_padding = @feature_padding.to_i
    @feature_value   = @feature_value.to_i
  end

  # Writes one weapon to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _row['Character ID'        ] = @character_id
    _row['Character name'      ] = CHARACTERS[@character_id]
    _row['Sell price in %'     ] = @sell
    _row['Unknown #1'          ] = @unknown1
    _row['Unknown #2'          ] = @unknown2
    _row['Inflict state ID'    ] = @state_id
    _row['Inflict state name'  ] = STATES[@state_id]
    _row['Price'               ] = @price
    _row['Attack'              ] = @attack
    _row['Hit%'                ] = @hit
    _row['Feature ID'          ] = @feature_id
    _row['Feature Name'        ] = Armor::FEATURES[@feature_id]
    _row['Feature Padding'     ] = @feature_padding
    _row['Feature Value'       ] = @feature_value
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :character_id
  attr_accessor :sell
  attr_accessor :unknown1
  attr_accessor :unknown2
  attr_accessor :state_id
  attr_accessor :price
  attr_accessor :attack
  attr_accessor :hit
  attr_accessor :feature_id
  attr_accessor :feature_padding
  attr_accessor :feature_value

end	# class Weapon

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
