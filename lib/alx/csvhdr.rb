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
  
  MESSAGE_ID          = 'Message ID'

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

  CHARACTER_ID        = 'Character ID'
  CHARACTER_NAME      = '[Character name]'
  CHARACTER_FLAGS     = 'Character flags'
  CHARACTER_OPT       = Hash.new { |_h, _k| _h[_k] = sprintf('[%s]', _k) }
  CHARACTER_VYSE      = 'Vyse'
  CHARACTER_AIKA      = 'Aika'
  CHARACTER_FINA      = 'Fina'
  CHARACTER_DRACHMA   = 'Drachma'
  CHARACTER_GILDER    = 'Gilder'
  CHARACTER_ENRIQUE   = 'Enrique'

  SHIP_FLAGS          = 'Ship flags'
  SHIP_MODEL1         = '[Little Jack #1]'
  SHIP_MODEL2         = '[Little Jack #2]'
  SHIP_MODEL3         = '[Delphinus #1]'
  SHIP_MODEL4         = '[Delphinus #2]'
  SHIP_MODEL5         = '[Delphinus #3]'

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
  
  ELEMENT_ID          = 'Element ID'
  ELEMENT_NAME        = '[Element name]'

  TYPE_ID             = 'Type ID'
  TYPE_NAME           = '[Type name]'

  CATEGORY_ID         = 'Category ID'
  CATEGORY_NAME       = '[Category name]'
  
  STATE_ID            = 'Inflict state ID'
  STATE_NAME          = '[Inflict state name]'

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

  EXP                 = create_hdr('EXP%s'       )
  GREEN_EXP           = create_hdr('Green EXP%s' )
  RED_EXP             = create_hdr('Red EXP%s'   )
  PURPLE_EXP          = create_hdr('Purple EXP%s')
  BLUE_EXP            = create_hdr('Blue EXP%s'  )
  YELLOW_EXP          = create_hdr('Yellow EXP%s')
  SILVER_EXP          = create_hdr('Silver EXP%s')
  STATE               = create_hdr('State%s'     )

  POISON              = 'Poison'
  UNCONSCIOUS         = 'Unconscious'
  STONE               = 'Stone'
  SLEEP               = 'Sleep'
  CONFUSION           = 'Confusion'
  SILENCE             = 'Silence'
  WEAK                = 'Weak'

  ITEM_ID             = create_hdr('Item ID%s'         )
  ITEM_NAME           = create_hdr('[Item name%s]'     )
  ITEM_DROP_ID        = create_hdr('Item drop ID%s'    )
  ITEM_DROP_NAME      = create_hdr('[Item drop name%s]')
  
  WEAPON_ID           = 'Weapon ID'
  WEAPON_NAME         = '[Weapon name]'
  ARMOR_ID            = 'Armor ID'
  ARMOR_NAME          = '[Armor name]'
  ACCESSORY_ID        = 'Accessory ID'
  ACCESSORY_NAME      = '[Accessory name]'
  
  SHIP_CANNON_ID      = create_hdr('Ship cannon ID%s'       )
  SHIP_CANNON_NAME    = create_hdr('[Ship cannon name%s]'   )
  SHIP_ACCESSORY_ID   = create_hdr('Ship accessory ID%s'    )
  SHIP_ACCESSORY_NAME = create_hdr('[Ship accessory name%s]')

  POSITION_ID         = 'Position ID'
  POSITION_NAME       = '[Position name]'

  ARM_ATTACK          = create_hdr('Armament%sattack'        )
  ARM_TYPE_ID         = create_hdr('Armament%stype ID'       )
  ARM_TYPE_NAME       = create_hdr('[Armament%stype name]'   )
  ARM_HIT             = create_hdr('Armament%shit%'          )
  ARM_RANGE           = create_hdr('Armament%srange'         )
  ARM_ELEMENT_ID      = create_hdr('Armament%selement ID'    )
  ARM_ELEMENT_NAME    = create_hdr('[Armament%selement name]')

  UNKNOWN             = create_hdr('Unknown%s')
  PADDING             = create_hdr('Padding%s')

end # class CsvHdr

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
