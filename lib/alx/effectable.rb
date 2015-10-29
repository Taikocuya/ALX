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
#                                 REQUIREMENTS
#==============================================================================

require_relative('csvhdr.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Mixin for entries with effects.
module Effectable
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

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

  # Occasion IDs
  OCCASIONS = Hash.new('???')
  OCCASIONS.store(0, CsvHdr::OCCASION_MENU  )
  OCCASIONS.store(1, CsvHdr::OCCASION_BATTLE)
  OCCASIONS.store(2, CsvHdr::OCCASION_SHIP  )

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

  # Effect IDs
  EFFECTS = Hash.new('???')
  EFFECTS.store( -1, 'None'                       )
  EFFECTS.store(  0, 'Damage'                     )
  EFFECTS.store(  6, 'Add state: Unconscious'     )
  EFFECTS.store(  9, 'Add state: Sleep'           )
  EFFECTS.store( 11, 'Add state: Confusion'       )
  EFFECTS.store( 12, 'Add state: Silence'         )
  EFFECTS.store( 20, 'Add state: Quickened'       )
  EFFECTS.store( 21, 'Add state: Strengthen'      )
  EFFECTS.store( 26, 'Add state: Weak'            )
  EFFECTS.store( 27, 'Revive and recover HP: 50%' )
  EFFECTS.store( 28, 'Revive and recover HP: 100%')
  EFFECTS.store( 30, 'Remove adverse states'      )
  EFFECTS.store( 31, 'Recover HP'                 )
  EFFECTS.store( 32, 'Recover HP: 100%'           )
  EFFECTS.store( 33, 'Add state: Regenerate'      )
  EFFECTS.store( 35, 'Recover SP'                 )
  EFFECTS.store( 48, 'Recover MP'                 )
  EFFECTS.store( 49, 'Recover MP: 100%'           )
  EFFECTS.store( 51, 'Recover HP and MP'          )
  EFFECTS.store( 52, 'Moonberry'                  )
  EFFECTS.store( 53, 'Evolve Cupil: Cham'         )
  EFFECTS.store( 54, 'Increase: Power'            )
  EFFECTS.store( 55, 'Increase: Will'             )
  EFFECTS.store( 56, 'Increase: Vigor'            )
  EFFECTS.store( 57, 'Increase: Agile'            )
  EFFECTS.store( 58, 'Increase: Quick'            )
  EFFECTS.store( 59, 'Increase: HP'               )
  EFFECTS.store( 60, 'Increase: MP'               )
  EFFECTS.store( 75, 'Evolve Cupil: Abirik Cham'  )
  EFFECTS.store( 76, 'Reset Cupil'                )
  EFFECTS.store(100, 'Recover HP'                 )
  EFFECTS.store(101, 'Recover HP: 100%'           )
  EFFECTS.store(102, 'Recover Spirit'             )
  EFFECTS.store(103, 'Recover Spirit: 100%'       )
  EFFECTS.store(104, 'Add state: Quickened'       )
  EFFECTS.store(105, 'Add state: Strengthen'      )
  EFFECTS.store(106, 'Add state: Weak'            )
  EFFECTS.store(107, 'Damage'                     )
  EFFECTS.store(108, 'Improve: Parameters'        )
  EFFECTS.store(109, 'Invulnerable: Artillery'    )
  EFFECTS.store(110, 'Invulnerable: Magic'        )
  EFFECTS.store(111, 'Improve: First strike%'     )
  EFFECTS.store(112, 'Improve: Critical%'         )
  EFFECTS.store(113, 'Spirit consumption: 50%'    )
  EFFECTS.store(114, 'Spirit restoration: 200%'   )
  EFFECTS.store(115, 'Increase: Parameters'       )
  EFFECTS.store(116, 'Add state: Silence'         )
  EFFECTS.store(117, 'Recover MP'                 )
  
end # class Effectable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
