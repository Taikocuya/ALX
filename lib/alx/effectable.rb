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
  SCOPES.store(32, 'Enemy area #1'         )
  SCOPES.store(33, 'Enemy area #2'         )
  SCOPES.store(34, 'Enemy area #3'         )
  SCOPES.store(36, 'Enemy line #1'         )
  SCOPES.store(37, 'Enemy line #2'         )
  SCOPES.store(38, 'Enemy line #3'         )
  SCOPES.store(39, 'Enemy line #4'         )
  SCOPES.store(43, 'Enemy line #5'         )

  # Effect IDs
  EFFECTS = Hash.new('???')
  EFFECTS.store( -1, 'None'                                       )
  EFFECTS.store(  0, 'Damage'                                     )
  EFFECTS.store(  1, 'Guard'                                      )
  EFFECTS.store(  4, 'Add Poison + Damage'                        )
  EFFECTS.store(  5, 'Add Unconscious'                            )
  EFFECTS.store(  6, 'Add Unconscious + Damage'                   )
  EFFECTS.store(  8, 'Add Stone + Damage'                         )
  EFFECTS.store(  9, 'Add Sleep'                                  )
  EFFECTS.store( 11, 'Add Confusion'                              )
  EFFECTS.store( 12, 'Add Silence'                                )
  EFFECTS.store( 17, 'Remove positive states'                     )
  EFFECTS.store( 20, 'Add Quickened'                              )
  EFFECTS.store( 21, 'Add Strengthen'                             )
  EFFECTS.store( 26, 'Add Weak'                                   )
  EFFECTS.store( 27, 'Revive with 50% of HP'                      )
  EFFECTS.store( 28, 'Revive with 100% of HP'                     )
  EFFECTS.store( 30, 'Remove negative states'                     )
  EFFECTS.store( 31, 'Recover HP'                                 )
  EFFECTS.store( 32, 'Recover HP to 100%'                         )
  EFFECTS.store( 33, 'Add Regenerate'                             )
  EFFECTS.store( 35, 'Recover SP'                                 )
  EFFECTS.store( 38, 'Counter attack + Guard'                     )
  EFFECTS.store( 39, 'Block magic'                                )
  EFFECTS.store( 41, 'Increase Spirit restoration to 200% + Guard')
  EFFECTS.store( 42, 'Block negative states'                      )
  EFFECTS.store( 46, 'Counter attack + Block attacks'             )
  EFFECTS.store( 47, 'Recover HP and MP + Remove negative states' )
  EFFECTS.store( 48, 'Recover MP'                                 )
  EFFECTS.store( 49, 'Recover MP to 100%'                         )
  EFFECTS.store( 51, 'Recover HP and MP'                          )
  EFFECTS.store( 52, 'Moonberry'                                  )
  EFFECTS.store( 53, 'Evolve Cupil with Cham'                     )
  EFFECTS.store( 54, 'Increase Power'                             )
  EFFECTS.store( 55, 'Increase Will'                              )
  EFFECTS.store( 56, 'Increase Vigor'                             )
  EFFECTS.store( 57, 'Increase Agile'                             )
  EFFECTS.store( 58, 'Increase Quick'                             )
  EFFECTS.store( 59, 'Increase HP'                                )
  EFFECTS.store( 60, 'Increase MP'                                )
  EFFECTS.store( 65, 'Prophecy'                                   )
  EFFECTS.store( 66, 'Blue Rogues'                                )
  EFFECTS.store( 75, 'Evolve Cupil with Abirik Cham'              )
  EFFECTS.store( 76, 'Reset Cupil'                                )
  EFFECTS.store( 77, 'Recover MP + Invulnerable'                  )
  EFFECTS.store(100, 'Recover HP (Ship)'                          )
  EFFECTS.store(101, 'Recover HP to 100% (Ship)'                  )
  EFFECTS.store(102, 'Recover Spirit (Ship)'                      )
  EFFECTS.store(103, 'Recover Spirit to 100% (Ship)'              )
  EFFECTS.store(104, 'Add Quickened (Ship)'                       )
  EFFECTS.store(105, 'Add Strengthen (Ship)'                      )
  EFFECTS.store(106, 'Add Weak (Ship)'                            )
  EFFECTS.store(107, 'Damage (Ship)'                              )
  EFFECTS.store(108, 'Improve parameters (Ship)'                  )
  EFFECTS.store(109, 'Block artillery (Ship)'                     )
  EFFECTS.store(110, 'Block magic (Ship)'                         )
  EFFECTS.store(111, 'Improve First strike% (Ship)'               )
  EFFECTS.store(112, 'Improve Critical% (Ship)'                   )
  EFFECTS.store(113, 'Decrease Spirit consumption to 50% (Ship)'  )
  EFFECTS.store(114, 'Increase Spirit restoration to 200% (Ship)' )
  EFFECTS.store(115, 'Captain\'s Stripe'                          )
  EFFECTS.store(116, 'Add Silence (Ship)'                         )
  EFFECTS.store(117, 'Recover MP (Ship)'                          )
  
end # class Effectable

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
