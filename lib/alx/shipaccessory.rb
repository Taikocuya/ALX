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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a ship accessory.
class ShipAccessory < Entry
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Size of the binary structure
  STRUCT_SIZE = 40
  
  # Feature IDs
  FEATURES = Hash.new('???')
  FEATURES.store(-1, 'None')
  FEATURES.store( 2, 'Defense')
  FEATURES.store( 3, 'MagDef')
  FEATURES.store( 4, 'Quick')
  FEATURES.store( 6, 'Dodge%')
  FEATURES.store( 7, 'Value')
  FEATURES.store(48, 'Attack: Main cannon')
  FEATURES.store(64, 'Attack: Secondary cannon')
  FEATURES.store(81, 'Hit%: Torpedo')
  FEATURES.store(96, 'Attack: S-Cannon')
  
#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def initialize
    super
    @ship_flags       = 0
    @feature1_id      = -1
    @feature1_padding = 0
    @feature1_value   = 0
    @feature2_id      = -1
    @feature2_padding = 0
    @feature2_value   = 0
    @feature3_id      = -1
    @feature3_padding = 0
    @feature3_value   = 0
    @feature4_id      = -1
    @feature4_padding = 0
    @feature4_value   = 0
    @price            = 0
    @sell             = 0
    @unknown1         = 0
    @unknown2         = 0
    @padding          = 0
  end

  # Reads one ship accessory from a binary file.
  # @param _f [File] Binary file
  def read_from_bin(_f)
    super
    @ship_flags       = _f.read_data(1, 'c' )
    @feature1_id      = _f.read_data(1, 'c' )
    @feature1_padding = _f.read_data(1, 'c' )
    @feature1_value   = _f.read_data(2, 's>')
    @feature2_id      = _f.read_data(1, 'c' )
    @feature2_padding = _f.read_data(1, 'c' )
    @feature2_value   = _f.read_data(2, 's>')
    @feature3_id      = _f.read_data(1, 'c' )
    @feature3_padding = _f.read_data(1, 'c' )
    @feature3_value   = _f.read_data(2, 's>')
    @feature4_id      = _f.read_data(1, 'c' )
    @feature4_padding = _f.read_data(1, 'c' )
    @feature4_value   = _f.read_data(2, 's>')
    @price            = _f.read_data(2, 'S>')
    @sell             = _f.read_data(1, 'c' )
    @unknown1         = _f.read_data(1, 'c' )
    @unknown2         = _f.read_data(1, 'c' )
    @padding          = _f.read_data(1, 'c' )
  end
  
  # Write one ship accessory to a binary file.
  # @param _f [File] Binary file
  def write_to_bin(_f)
    super
    _f.write_data(@ship_flags      , 'c' )
    _f.write_data(@feature1_id     , 'c' )
    _f.write_data(@feature1_padding, 'c' )
    _f.write_data(@feature1_value  , 's>')
    _f.write_data(@feature2_id     , 'c' )
    _f.write_data(@feature2_padding, 'c' )
    _f.write_data(@feature2_value  , 's>')
    _f.write_data(@feature3_id     , 'c' )
    _f.write_data(@feature3_padding, 'c' )
    _f.write_data(@feature3_value  , 's>')
    _f.write_data(@feature4_id     , 'c' )
    _f.write_data(@feature4_padding, 'c' )
    _f.write_data(@feature4_value  , 's>')
    _f.write_data(@price           , 'S>')
    _f.write_data(@sell            , 'c' )
    _f.write_data(@unknown1        , 'c' )
    _f.write_data(@unknown2        , 'c' )
    _f.write_data(@padding         , 'c' )
  end

  # Reads one ship accessory from a CSV row.
  # @param _row [CSV::Row] CSV row
  def read_from_csv_row(_row)
    super
    @ship_flags       = _row['Ship flags'        ] || @ship_flags
    @feature1_id      = _row['Feature #1 ID'     ] || @feature1_id
    @feature1_padding = _row['Feature #1 padding'] || @feature1_padding
    @feature1_value   = _row['Feature #1 value'  ] || @feature1_value
    @feature2_id      = _row['Feature #2 ID'     ] || @feature2_id
    @feature2_padding = _row['Feature #2 padding'] || @feature2_padding
    @feature2_value   = _row['Feature #2 value'  ] || @feature2_value
    @feature3_id      = _row['Feature #3 ID'     ] || @feature3_id
    @feature3_padding = _row['Feature #3 padding'] || @feature3_padding
    @feature3_value   = _row['Feature #3 value'  ] || @feature3_value
    @feature4_id      = _row['Feature #4 ID'     ] || @feature4_id
    @feature4_padding = _row['Feature #4 padding'] || @feature4_padding
    @feature4_value   = _row['Feature #4 value'  ] || @feature4_value
    @price            = _row['Price'             ] || @price
    @sell             = _row['Sell price in %'   ] || @sell
    @unknown1         = _row['Unknown #1'        ] || @unknown1
    @unknown2         = _row['Unknown #2'        ] || @unknown2
    @padding          = _row['Padding'           ] || @padding
    
    @ship_flags       = @ship_flags.to_i
    @feature1_id      = @feature1_id.to_i
    @feature1_padding = @feature1_padding.to_i
    @feature1_value   = @feature1_value.to_i
    @feature2_id      = @feature2_id.to_i
    @feature2_padding = @feature2_padding.to_i
    @feature2_value   = @feature2_value.to_i
    @feature3_id      = @feature3_id.to_i
    @feature3_padding = @feature3_padding.to_i
    @feature3_value   = @feature3_value.to_i
    @feature4_id      = @feature4_id.to_i
    @feature4_padding = @feature4_padding.to_i
    @feature4_value   = @feature4_value.to_i
    @price            = @price.to_i
    @sell             = @sell.to_i
    @unknown1         = @unknown1.to_i
    @unknown2         = @unknown2.to_i
    @padding          = @padding.to_i
  end

  # Writes one ship accessory to a CSV row.
  # @param _row [CSV::Row] CSV row
  def write_to_csv_row(_row)
    super
    _row['Ship flags'       ] = @ship_flags
      
    ShipCannon::SHIPS.each do |_id, _s|
      if @ship_flags & (0x20 >> _id) != 0
        _row[_s] = 'X'
      end
    end

    _row['Feature #1 ID'     ] = @feature1_id
    _row['Feature #1 name'   ] = FEATURES[@feature1_id]
    _row['Feature #1 padding'] = @feature1_padding
    _row['Feature #1 value'  ] = @feature1_value
    _row['Feature #2 ID'     ] = @feature2_id
    _row['Feature #2 name'   ] = FEATURES[@feature2_id]
    _row['Feature #2 padding'] = @feature2_padding
    _row['Feature #2 value'  ] = @feature2_value
    _row['Feature #3 ID'     ] = @feature3_id
    _row['Feature #3 name'   ] = FEATURES[@feature3_id]
    _row['Feature #3 padding'] = @feature3_padding
    _row['Feature #3 value'  ] = @feature3_value
    _row['Feature #4 ID'     ] = @feature4_id
    _row['Feature #4 name'   ] = FEATURES[@feature4_id]
    _row['Feature #4 padding'] = @feature4_padding
    _row['Feature #4 value'  ] = @feature4_value
    _row['Price'             ] = @price
    _row['Sell price in %'   ] = @sell
    _row['Unknown #1'        ] = @unknown1
    _row['Unknown #2'        ] = @unknown2
    _row['Padding'           ] = @padding
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :ship_flags
  attr_accessor :feature1_id
  attr_accessor :feature1_padding
  attr_accessor :feature1_value
  attr_accessor :feature2_id
  attr_accessor :feature2_padding
  attr_accessor :feature2_value
  attr_accessor :feature3_id
  attr_accessor :feature3_padding
  attr_accessor :feature3_value
  attr_accessor :feature4_id
  attr_accessor :feature4_padding
  attr_accessor :feature4_value
  attr_accessor :price
  attr_accessor :sell
  attr_accessor :unknown1
  attr_accessor :unknown2
  attr_accessor :padding
  
end	# class ShipAccessory

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
