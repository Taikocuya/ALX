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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Module to handle CSV header strings.
module CsvHdr

#==============================================================================
#                                   PUBLIC
#==============================================================================

  # Creates a dynamic CSV header.
  # @param _format [String] Header format
  # @return [Hash] Dynamic CSV header
  def self.create_hdr(_format)
    if _format =~ /^.*%s\]?$/
      _enum = ' #%d'
      _zero = ''
    else
      _enum = ' #%d '
      _zero = ' '
    end
    
    Hash.new do |_h, _k|
      if _k.is_a?(Integer) && _k > 0
        _str = sprintf(_enum, _k)
      else
        _str = _zero
      end
      
      _h[_k] = sprintf(_format, _str)
    end
  end
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================
  
#------------------------------------------------------------------------------
# Global
#------------------------------------------------------------------------------

  ID                  = 'Entry ID'
  FILTER              = '[Filter]'
  MESSAGE_ID          = 'Message ID'
  UNKNOWN             = create_hdr('Unknown%s')
  PADDING             = create_hdr('Padding%s')
  
  ELEMENT_ID          = 'Element ID'
  ELEMENT_NAME        = '[Element name]'
  TYPE_ID             = 'Type ID'
  TYPE_NAME           = '[Type name]'
  CATEGORY_ID         = 'Category ID'
  CATEGORY_NAME       = '[Category name]'
  STATE_ID            = 'State ID'
  STATE_NAME          = '[State name]'
  STATE_HIT           = 'State hit%'

#------------------------------------------------------------------------------
# Name
#------------------------------------------------------------------------------

  NAME_EU_STR         = 'EU entry name'
  NAME_JP_STR         = 'JP entry name'
  NAME_US_STR         = 'US entry name'
  
  NAME_DE_SIZE        = '[DE entry name size]'
  NAME_DE_POS         = '[DE entry name position]'
  NAME_DE_STR         = 'DE entry name'
  NAME_ES_SIZE        = '[ES entry name size]'
  NAME_ES_POS         = '[ES entry name position]'
  NAME_ES_STR         = 'ES entry name'
  NAME_FR_SIZE        = '[FR entry name size]'
  NAME_FR_POS         = '[FR entry name position]'
  NAME_FR_STR         = 'FR entry name'
  NAME_GB_SIZE        = '[GB entry name size]'
  NAME_GB_POS         = '[GB entry name position]'
  NAME_GB_STR         = 'GB entry name'

#------------------------------------------------------------------------------
# Description
#------------------------------------------------------------------------------

  DSCR_JP_SIZE        = '[JP description size]'
  DSCR_JP_POS         = '[JP description position]'
  DSCR_JP_STR         = 'JP description string'
  DSCR_US_SIZE        = '[US description size]'
  DSCR_US_POS         = '[US description position]'
  DSCR_US_STR         = 'US description string'
  DSCR_DE_SIZE        = '[DE description size]'
  DSCR_DE_POS         = '[DE description position]'
  DSCR_DE_STR         = 'DE description string'
  DSCR_ES_SIZE        = '[ES description size]'
  DSCR_ES_POS         = '[ES description position]'
  DSCR_ES_STR         = 'ES description string'
  DSCR_FR_SIZE        = '[FR description size]'
  DSCR_FR_POS         = '[FR description position]'
  DSCR_FR_STR         = 'FR description string'
  DSCR_GB_SIZE        = '[GB description size]'
  DSCR_GB_POS         = '[GB description position]'
  DSCR_GB_STR         = 'GB description string'

  SHIP_DSCR_JP_SIZE   = '[JP ship description size]'
  SHIP_DSCR_JP_POS    = '[JP ship description position]'
  SHIP_DSCR_JP_STR    = 'JP ship description string'
  SHIP_DSCR_US_SIZE   = '[US ship description size]'
  SHIP_DSCR_US_POS    = '[US ship description position]'
  SHIP_DSCR_US_STR    = 'US ship description string'
  SHIP_DSCR_DE_SIZE   = '[DE ship description size]'
  SHIP_DSCR_DE_POS    = '[DE ship description position]'
  SHIP_DSCR_DE_STR    = 'DE ship description string'
  SHIP_DSCR_ES_SIZE   = '[ES ship description size]'
  SHIP_DSCR_ES_POS    = '[ES ship description position]'
  SHIP_DSCR_ES_STR    = 'ES ship description string'
  SHIP_DSCR_FR_SIZE   = '[FR ship description size]'
  SHIP_DSCR_FR_POS    = '[FR ship description position]'
  SHIP_DSCR_FR_STR    = 'FR ship description string'
  SHIP_DSCR_GB_SIZE   = '[GB ship description size]'
  SHIP_DSCR_GB_POS    = '[GB ship description position]'
  SHIP_DSCR_GB_STR    = 'GB ship description string'

#------------------------------------------------------------------------------
# Character
#------------------------------------------------------------------------------
  
  CHARACTER_ID        = create_hdr('Character%sID'    )
  CHARACTER_NAME      = create_hdr('[Character%sname]')
  CHARACTER_X         = create_hdr('Character%sX'     )
  CHARACTER_Y         = create_hdr('[Character%sY]'   )
  CHARACTER_FLAGS     = 'Character flags'
  CHARACTER_OPT       = Hash.new { |_h, _k| _h[_k] = sprintf('[%s]', _k) }
  CHARACTER_VYSE      = 'Vyse'
  CHARACTER_AIKA      = 'Aika'
  CHARACTER_FINA      = 'Fina'
  CHARACTER_DRACHMA   = 'Drachma'
  CHARACTER_GILDER    = 'Gilder'
  CHARACTER_ENRIQUE   = 'Enrique'
  
  WEAPON_ID           = 'Weapon ID'
  WEAPON_NAME         = '[Weapon name]'
  ARMOR_ID            = 'Armor ID'
  ARMOR_NAME          = '[Armor name]'
  ACCESSORY_ID        = 'Accessory ID'
  ACCESSORY_NAME      = '[Accessory name]'
  
  EXP                 = create_hdr('EXP%s'       )
  MEGIC_EXP           = 'Magic EXP'
  GREEN_EXP           = create_hdr('Green EXP%s' )
  RED_EXP             = create_hdr('Red EXP%s'   )
  PURPLE_EXP          = create_hdr('Purple EXP%s')
  BLUE_EXP            = create_hdr('Blue EXP%s'  )
  YELLOW_EXP          = create_hdr('Yellow EXP%s')
  SILVER_EXP          = create_hdr('Silver EXP%s')

#------------------------------------------------------------------------------
# Ship
#------------------------------------------------------------------------------
  
  SHIP_FLAGS          = 'Ship flags'
  SHIP_LITTLEJACK     = create_hdr('[Little Jack%s]')
  SHIP_DELPHINUS      = create_hdr('[Delphinus%s]'  )

  SHIP_CANNON_ID      = create_hdr('Ship cannon%sID'       )
  SHIP_CANNON_NAME    = create_hdr('[Ship cannon%sname]'   )
  SHIP_ACCESSORY_ID   = create_hdr('Ship accessory%sID'    )
  SHIP_ACCESSORY_NAME = create_hdr('[Ship accessory%sname]')
  
#------------------------------------------------------------------------------
# Enemy
#------------------------------------------------------------------------------
  
  ENEMY_ID            = create_hdr('Enemy%sID'       )
  ENEMY_NAME_JP       = create_hdr('[JP enemy%sname]')
  ENEMY_NAME_US       = create_hdr('[US enemy%sname]')
  ENEMY_NAME_EU       = create_hdr('[EU enemy%sname]')
  ENEMY_X             = create_hdr('Enemy%sX'        )
  ENEMY_Y             = create_hdr('Enemy%sY'        )
  ENEMY_WIDTH         = 'Width'
  ENEMY_HEIGHT        = 'Height'

  MOVEMENT_FLAGS      = 'Movement flags'

  ITEM_PROBABILITY    = create_hdr('Item%sprobability')
  ITEM_AMOUNT         = create_hdr('Item%samount'     )
  ITEM_ID             = create_hdr('Item%sID'         )
  ITEM_NAME           = create_hdr('[Item%sname]'     )

  INST_TYPE_ID        = create_hdr('Instruction%stype ID'         )
  INST_TYPE_NAME      = create_hdr('[Instruction%stype name]'     )
  INST_ID             = create_hdr('Instruction%sID'              )
  INST_NAME           = create_hdr('[Instruction%sname]'          )
  INST_PARAM_ID       = create_hdr('Instruction%sparameter ID'    )
  INST_PARAM_NAME     = create_hdr('[Instruction%sparameter name]')

#------------------------------------------------------------------------------
# Ship enemy
#------------------------------------------------------------------------------

  ARM_NAME_DE_POS     = create_hdr('[DE armament%sname position]')
  ARM_NAME_DE_SIZE    = create_hdr('[DE armament%sname size]'    )
  ARM_NAME_DE_STR     = create_hdr('DE armament%sname string'    )
  ARM_NAME_ES_POS     = create_hdr('[ES armament%sname position]')
  ARM_NAME_ES_SIZE    = create_hdr('[ES armament%sname size]'    )
  ARM_NAME_ES_STR     = create_hdr('ES armament%sname string'    )
  ARM_NAME_FR_POS     = create_hdr('[FR armament%sname position]')
  ARM_NAME_FR_SIZE    = create_hdr('[FR armament%sname size]'    )
  ARM_NAME_FR_STR     = create_hdr('FR armament%sname string'    )
  ARM_NAME_GB_POS     = create_hdr('[GB armament%sname position]')
  ARM_NAME_GB_SIZE    = create_hdr('[GB armament%sname size]'    )
  ARM_NAME_GB_STR     = create_hdr('GB armament%sname string'    )

  ARM_ATTACK          = create_hdr('Armament%sattack'        )
  ARM_TYPE_ID         = create_hdr('Armament%stype ID'       )
  ARM_TYPE_NAME       = create_hdr('[Armament%stype name]'   )
  ARM_HIT             = create_hdr('Armament%shit%'          )
  ARM_RANGE           = create_hdr('Armament%srange'         )
  ARM_ELEMENT_ID      = create_hdr('Armament%selement ID'    )
  ARM_ELEMENT_NAME    = create_hdr('[Armament%selement name]')
  
  ITEM_DROP_ID        = create_hdr('Item drop%sID'    )
  ITEM_DROP_NAME      = create_hdr('[Item drop%sname]')

#------------------------------------------------------------------------------
# Battle
#------------------------------------------------------------------------------
  
  DEFEAT_COND_ID      = 'Defeat condition ID'
  DEFEAT_COND_NAME    = '[Defeat condition name]'
  ESCAPE_COND_ID      = 'Escape condition ID'
  ESCAPE_COND_NAME    = '[Escape condition name]'
  
  EFFECT_ID           = 'Effect ID'
  EFFECT_NAME         = '[Effect name]'
  EFFECT_SPIRIT       = 'Effect spirit'
  EFFECT_VALUE        = create_hdr('Effect value%s')
  EFFECT_PRIORITY     = 'Effect priority'
  
  SHIP_EFFECT_ID      = 'Ship effect ID'
  SHIP_EFFECT_NAME    = '[Ship effect name]'
  SHIP_EFFECT_SPIRIT  = 'Ship effect spirit'
  SHIP_EFFECT_TURNS   = 'Ship effect turns'
  SHIP_EFFECT_VALUE   = 'Ship effect amount'
  
  SCOPE_ID            = 'Scope ID'
  SCOPE_NAME          = '[Scope name]'

#------------------------------------------------------------------------------
# Menu
#------------------------------------------------------------------------------

  OCCASION_FLAGS      = 'Occasion flags'
  OCCASION_MENU       = '[Menu]'
  OCCASION_BATTLE     = '[Battle]'
  OCCASION_SHIP       = '[Ship battle]'
  
  SHIP_OCCASION_ID    = 'Ship occasion ID'
  SHIP_OCCASION_NAME  = '[Ship occasion name]'

  ORDER_ALPHABET      = 'Order by alphabet'
  ORDER_IMPORTANCE    = 'Order by importance'

  RETAIL_PRICE        = 'Retail price in %'
  PURCHASE_PRICE      = 'Purchase price'

  FEATURE_ID          = create_hdr('Feature%sID'    )
  FEATURE_NAME        = create_hdr('[Feature%sname]')
  FEATURE_VALUE       = create_hdr('Feature%svalue' )

  AGE                 = 'Age'
  AGILE               = 'Agile'
  ATTACK              = 'Attack'
  BASE_HP_INCREASE    = 'Base MAXHP increase'
  CONSUME             = 'Consume%'
  COUNTER             = 'Counter%'
  DEFENSE             = 'Defense'
  DODGE               = 'Dodge%'
  GOLD                = 'Gold'
  HIT                 = 'Hit%'
  HP                  = 'HP'
  LEVEL               = 'Level'
  LIMIT               = 'Limit'
  MAGDEF              = 'MagDef'
  MAXHP               = 'MAXHP'
  MAXMP               = 'MAXMP'
  MAXSPIRIT           = 'MAXSpirit'
  POWER               = 'Power'
  QUICK               = 'Quick'
  SPIRIT              = 'Spirit'
  VALUE               = 'Value'
  VIGOR               = 'Vigor'
  WILL                = 'Will'

#------------------------------------------------------------------------------
# Crew
#------------------------------------------------------------------------------

  POSITION_ID         = 'Position ID'
  POSITION_NAME       = '[Position name]'

end # class CsvHdr

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
