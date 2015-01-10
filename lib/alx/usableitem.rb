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

# Class to handle a usable item.
class UsableItem < Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================
 
  # Size of the binary structure
  STRUCT_SIZE = 36

  # Occasion IDs
  OCCASIONS = Hash.new('???')
  OCCASIONS.store(0, 'Menu'       )
  OCCASIONS.store(1, 'Battle'     )
  OCCASIONS.store(2, 'Ship battle')

  # Effect IDs
  EFFECTS = Hash.new('???')
  EFFECTS.store(-1, 'None')
  EFFECTS.store( 0, 'Damage')
  EFFECTS.store( 6, 'Add state: Unconscious')
  EFFECTS.store( 9, 'Add state: Sleep')
  EFFECTS.store(11, 'Add state: Confusion')
  EFFECTS.store(12, 'Add state: Silence')
  EFFECTS.store(20, 'Add state: Quickened')
  EFFECTS.store(21, 'Add state: Strengthen')
  EFFECTS.store(26, 'Add state: Weak')
  EFFECTS.store(27, 'Revive and recover HP: 50%')
  EFFECTS.store(28, 'Revive and recover HP: 100%')
  EFFECTS.store(30, 'Remove adverse states')
  EFFECTS.store(31, 'Recover HP')
  EFFECTS.store(32, 'Recover HP: 100%')
  EFFECTS.store(33, 'Add state: Regenerate')
  EFFECTS.store(35, 'Recover SP')
  EFFECTS.store(48, 'Recover MP')
  EFFECTS.store(49, 'Recover MP: 100%')
  EFFECTS.store(51, 'Recover HP and MP')
  EFFECTS.store(52, 'Moonberry')
  EFFECTS.store(53, 'Evolve Cupil: Cham')
  EFFECTS.store(54, 'Increase: Power')
  EFFECTS.store(55, 'Increase: Will')
  EFFECTS.store(56, 'Increase: Vigor')
  EFFECTS.store(57, 'Increase: Agile')
  EFFECTS.store(58, 'Increase: Quick')
  EFFECTS.store(59, 'Increase: HP')
  EFFECTS.store(60, 'Increase: MP')
  EFFECTS.store(75, 'Evolve Cupil: Abirik Cham')
  EFFECTS.store(76, 'Reset Cupil')

  # Scope IDs
  SCOPES = Hash.new('???')
  SCOPES.store( 0, 'None'                  )
  SCOPES.store( 1, 'One ally'              )
  SCOPES.store( 2, 'All allies'            )
  SCOPES.store( 3, 'One enemy'             )
  SCOPES.store( 4, 'All enemies'           )
  SCOPES.store( 5, 'User'                  )
  SCOPES.store( 6, 'All allies and enemies')
  SCOPES.store(32, 'Enemy area: Small'     )
  SCOPES.store(33, 'Enemy area: Medium'    )
  SCOPES.store(34, 'Enemy area: Large'     )
  SCOPES.store(36, 'Enemy line: Small'     )
  SCOPES.store(37, 'Enemy line: Medium'    )
  SCOPES.store(38, 'Enemy line: Large'     )
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super
    @occasion_flags = 0
    @effect_id      = -1
    @scope_id       = 0
    @consume        = 0
    @sell           = 0
    @unknown1       = 0
    @unknown2       = -1
    @price          = 0
    @unknown3       = 0
    @unknown4       = 0
    @amount         = 0
    @unknown5       = 0
    @unknown6       = 0
    @unknown7       = 0
    @unknown8       = 0
    @unknown9       = 0
    @hit            = 0
  end

  # Reads one usable item from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    super
    @occasion_flags = _f.read_data(1, 'c' )
    @effect_id      = _f.read_data(1, 'c' )
    @scope_id       = _f.read_data(1, 'c' )
    @consume        = _f.read_data(1, 'c' )
    @sell           = _f.read_data(1, 'c' )
    @unknown1       = _f.read_data(1, 'c' )
    @unknown2       = _f.read_data(1, 'c' )
    @price          = _f.read_data(2, 'S>')
    @unknown3       = _f.read_data(1, 'c' )
    @unknown4       = _f.read_data(1, 'c' )
    @amount         = _f.read_data(2, 's>')
    @unknown5       = _f.read_data(1, 'c' )
    @unknown6       = _f.read_data(1, 'c' )
    @unknown7       = _f.read_data(1, 'c' )
    @unknown8       = _f.read_data(1, 'c' )
    @unknown9       = _f.read_data(1, 'c' )
    @hit            = _f.read_data(1, 'c' )
  end
  
  # Write one usable item to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    super
    _f.write_data(@occasion_flags, 'c' )
    _f.write_data(@effect_id     , 'c' )
    _f.write_data(@scope_id      , 'c' )
    _f.write_data(@consume       , 'c' )
    _f.write_data(@sell          , 'c' )
    _f.write_data(@unknown1      , 'c' )
    _f.write_data(@unknown2      , 'c' )
    _f.write_data(@price         , 'S>')
    _f.write_data(@unknown3      , 'c' )
    _f.write_data(@unknown4      , 'c' )
    _f.write_data(@amount        , 's>')
    _f.write_data(@unknown5      , 'c' )
    _f.write_data(@unknown6      , 'c' )
    _f.write_data(@unknown7      , 'c' )
    _f.write_data(@unknown8      , 'c' )
    _f.write_data(@unknown9      , 'c' )
    _f.write_data(@hit           , 'c' )
  end

  # Reads one usable item from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    @occasion_flags = _row['Occasion flags' ] || @occasion_flags
    @effect_id      = _row['Effect ID'      ] || @effect_id
    @scope_id       = _row['Scope ID'       ] || @scope_id
    @consume        = _row['Consume%'       ] || @consume
    @sell           = _row['Sell price in %'] || @sell
    @unknown1       = _row['Unknown #1'     ] || @unknown1
    @unknown2       = _row['Unknown #2'     ] || @unknown2
    @price          = _row['Price'          ] || @price
    @unknown3       = _row['Unknown #3'     ] || @unknown3
    @unknown4       = _row['Unknown #4'     ] || @unknown4
    @amount         = _row['Effect amount'  ] || @amount
    @unknown5       = _row['Unknown #5'     ] || @unknown5
    @unknown6       = _row['Unknown #6'     ] || @unknown6
    @unknown7       = _row['Unknown #7'     ] || @unknown7
    @unknown8       = _row['Unknown #8'     ] || @unknown8
    @unknown9       = _row['Unknown #9'     ] || @unknown9
    @hit            = _row['Hit%'           ] || @hit

    @occasion_flags = @occasion_flags.to_i
    @effect_id      = @effect_id.to_i
    @scope_id       = @scope_id.to_i
    @consume        = @consume.to_i
    @sell           = @sell.to_i
    @unknown1       = @unknown1.to_i
    @unknown2       = @unknown2.to_i
    @price          = @price.to_i
    @unknown3       = @unknown3.to_i
    @unknown4       = @unknown4.to_i
    @amount         = @amount.to_i
    @unknown5       = @unknown5.to_i
    @unknown6       = @unknown6.to_i
    @unknown7       = @unknown7.to_i
    @unknown8       = @unknown8.to_i
    @unknown9       = @unknown9.to_i
    @hit            = @hit.to_i
  end

  # Writes one usable item to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
  
    _row['Occasion flags' ] = @occasion_flags

    OCCASIONS.each do |_id, _c|
      if @occasion_flags & (0x4 >> _id) != 0
        _row[_c] = 'X'
      end
    end

    _row['Effect ID'      ] = @effect_id
    _row['Effect name'    ] = EFFECTS[@effect_id]
    _row['Scope ID'       ] = @scope_id
    _row['Scope name'     ] = SCOPES[@scope_id]
    _row['Consume%'       ] = @consume
    _row['Sell price in %'] = @sell
    _row['Unknown #1'     ] = @unknown1
    _row['Unknown #2'     ] = @unknown2
    _row['Price'          ] = @price
    _row['Unknown #3'     ] = @unknown3
    _row['Unknown #4'     ] = @unknown4
    _row['Effect amount'  ] = @amount
    _row['Unknown #5'     ] = @unknown5
    _row['Unknown #6'     ] = @unknown6
    _row['Unknown #7'     ] = @unknown7
    _row['Unknown #8'     ] = @unknown8
    _row['Unknown #9'     ] = @unknown9
    _row['Hit%'           ] = @hit
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :occasion_flags
  attr_accessor :effect_id
  attr_accessor :scope_id
  attr_accessor :consume
  attr_accessor :sell
  attr_accessor :unknown1
  attr_accessor :unknown2
  attr_accessor :price
  attr_accessor :unknown3
  attr_accessor :unknown4
  attr_accessor :amount
  attr_accessor :unknown5
  attr_accessor :unknown6
  attr_accessor :unknown7
  attr_accessor :unknown8
  attr_accessor :unknown9
  attr_accessor :hit
  
end	# class UsableItem

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
