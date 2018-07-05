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
      if _k.is_a?(Integer) && _k > -1
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
  NAME_DE_POS         = '[DE entry name pos.]'
  NAME_DE_STR         = 'DE entry name'
  NAME_ES_SIZE        = '[ES entry name size]'
  NAME_ES_POS         = '[ES entry name pos.]'
  NAME_ES_STR         = 'ES entry name'
  NAME_FR_SIZE        = '[FR entry name size]'
  NAME_FR_POS         = '[FR entry name pos.]'
  NAME_FR_STR         = 'FR entry name'
  NAME_GB_SIZE        = '[GB entry name size]'
  NAME_GB_POS         = '[GB entry name pos.]'
  NAME_GB_STR         = 'GB entry name'

#------------------------------------------------------------------------------
# Description
#------------------------------------------------------------------------------

  DSCR_JP_SIZE        = '[JP descr. size]'
  DSCR_JP_POS         = '[JP descr. pos.]'
  DSCR_JP_STR         = 'JP descr. str.'
  DSCR_US_SIZE        = '[US descr. size]'
  DSCR_US_POS         = '[US descr. pos.]'
  DSCR_US_STR         = 'US descr. str.'
  DSCR_DE_SIZE        = '[DE descr. size]'
  DSCR_DE_POS         = '[DE descr. pos.]'
  DSCR_DE_STR         = 'DE descr. str.'
  DSCR_ES_SIZE        = '[ES descr. size]'
  DSCR_ES_POS         = '[ES descr. pos.]'
  DSCR_ES_STR         = 'ES descr. str.'
  DSCR_FR_SIZE        = '[FR descr. size]'
  DSCR_FR_POS         = '[FR descr. pos.]'
  DSCR_FR_STR         = 'FR descr. str.'
  DSCR_GB_SIZE        = '[GB descr. size]'
  DSCR_GB_POS         = '[GB descr. pos.]'
  DSCR_GB_STR         = 'GB descr. str.'

  SHIP_DSCR_JP_SIZE   = '[JP ship descr. size]'
  SHIP_DSCR_JP_POS    = '[JP ship descr. pos.]'
  SHIP_DSCR_JP_STR    = 'JP ship descr. str.'
  SHIP_DSCR_US_SIZE   = '[US ship descr. size]'
  SHIP_DSCR_US_POS    = '[US ship descr. pos.]'
  SHIP_DSCR_US_STR    = 'US ship descr. str.'
  SHIP_DSCR_DE_SIZE   = '[DE ship descr. size]'
  SHIP_DSCR_DE_POS    = '[DE ship descr. pos.]'
  SHIP_DSCR_DE_STR    = 'DE ship descr. str.'
  SHIP_DSCR_ES_SIZE   = '[ES ship descr. size]'
  SHIP_DSCR_ES_POS    = '[ES ship descr. pos.]'
  SHIP_DSCR_ES_STR    = 'ES ship descr. str.'
  SHIP_DSCR_FR_SIZE   = '[FR ship descr. size]'
  SHIP_DSCR_FR_POS    = '[FR ship descr. pos.]'
  SHIP_DSCR_FR_STR    = 'FR ship descr. str.'
  SHIP_DSCR_GB_SIZE   = '[GB ship descr. size]'
  SHIP_DSCR_GB_POS    = '[GB ship descr. pos.]'
  SHIP_DSCR_GB_STR    = 'GB ship descr. str.'

#------------------------------------------------------------------------------
# Character
#------------------------------------------------------------------------------
  
  CHARACTER_ID        = create_hdr('Chara.%sID'    )
  CHARACTER_NAME      = create_hdr('[Chara.%sname]')
  CHARACTER_X         = create_hdr('Chara.%sX'     )
  CHARACTER_Y         = create_hdr('Chara.%sY'     )
  CHARACTER_FLAGS     = 'Chara. flags'
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

  SHIP_CANNON_ID      = create_hdr('Ship cannon%sID'    )
  SHIP_CANNON_NAME    = create_hdr('[Ship cannon%sname]')
  SHIP_ACCESSORY_ID   = create_hdr('Ship acc.%sID'      )
  SHIP_ACCESSORY_NAME = create_hdr('[Ship acc.%sname]'  )
  
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

  ITEM_PROBABILITY    = create_hdr('Item%sprob.'      )
  ITEM_AMOUNT         = create_hdr('Item%samount'     )
  ITEM_ID             = create_hdr('Item%sID'         )
  ITEM_NAME           = create_hdr('[Item%sname]'     )

  INSTR_TYPE_ID       = create_hdr('Instr.%stype ID'      )
  INSTR_TYPE_NAME     = create_hdr('[Instr.%stype name]'  )
  INSTR_ID            = create_hdr('Instr.%sID'           )
  INSTR_NAME          = create_hdr('[Instr.%sname]'       )
  INSTR_PARAM_ID      = create_hdr('Instr.%sparam. ID'    )
  INSTR_PARAM_NAME    = create_hdr('[Instr.%sparam. name]')

#------------------------------------------------------------------------------
# Enemy ship
#------------------------------------------------------------------------------

  ENEMY_SHIP_ID       = '[Enemy ship ID]'
  ENEMY_SHIP_NAME     = '[Enemy ship name]'

  ARM_NAME_EU         = create_hdr('EU arm.%sname')
  ARM_NAME_JP         = create_hdr('JP arm.%sname')
  ARM_NAME_US         = create_hdr('US arm.%sname')

  ARM_NAME_DE_POS     = create_hdr('[DE arm.%sname pos.]')
  ARM_NAME_DE_SIZE    = create_hdr('[DE arm.%sname size]')
  ARM_NAME_DE_STR     = create_hdr('DE arm.%sname str.'  )
  ARM_NAME_ES_POS     = create_hdr('[ES arm.%sname pos.]')
  ARM_NAME_ES_SIZE    = create_hdr('[ES arm.%sname size]')
  ARM_NAME_ES_STR     = create_hdr('ES arm.%sname str.'  )
  ARM_NAME_FR_POS     = create_hdr('[FR arm.%sname pos.]')
  ARM_NAME_FR_SIZE    = create_hdr('[FR arm.%sname size]')
  ARM_NAME_FR_STR     = create_hdr('FR arm.%sname str.'  )
  ARM_NAME_GB_POS     = create_hdr('[GB arm.%sname pos.]')
  ARM_NAME_GB_SIZE    = create_hdr('[GB arm.%sname size]')
  ARM_NAME_GB_STR     = create_hdr('GB arm.%sname str.'  )

  ARM_ATTACK          = create_hdr('Arm.%sattack'        )
  ARM_TYPE_ID         = create_hdr('Arm.%stype ID'       )
  ARM_TYPE_NAME       = create_hdr('[Arm.%stype name]'   )
  ARM_HIT             = create_hdr('Arm.%shit%'          )
  ARM_RANGE           = create_hdr('Arm.%srange'         )
  ARM_ELEMENT_ID      = create_hdr('Arm.%selement ID'    )
  ARM_ELEMENT_NAME    = create_hdr('[Arm.%selement name]')
  
  ITEM_DROP_ID        = create_hdr('Item drop%sID'    )
  ITEM_DROP_NAME      = create_hdr('[Item drop%sname]')

  # TASK_COND_ID        = 'Task cond. ID'
  # TASK_COND_NAME      = 'Task cond. name'
  TASK_RATING         = 'Task rating'
  TASK_A_TYPE_ID      = 'Task A type ID'
  TASK_A_TYPE_NAME    = '[Task A type name]'
  TASK_A_ARM_ID       = 'Task A arm. ID'
  TASK_A_ARM_NAME     = '[Task A arm. name]'
  TASK_A_PARAM_ID     = 'Task A param. ID'
  TASK_A_PARAM_NAME   = '[Task A param. name]'
  TASK_A_RANGE        = 'Task A arm. range'
  TASK_B_TYPE_ID      = 'Task B type ID'
  TASK_B_TYPE_NAME    = '[Task B type name]'
  TASK_B_ARM_ID       = 'Task B arm. ID'
  TASK_B_ARM_NAME     = '[Task B arm. name]'
  TASK_B_PARAM_ID     = 'Task B param. ID'
  TASK_B_PARAM_NAME   = '[Task B param. name]'
  TASK_B_RANGE        = 'Task B arm. range'

#------------------------------------------------------------------------------
# Battle
#------------------------------------------------------------------------------
  
  DEFEAT_COND_ID      = 'Defeat cond. ID'
  DEFEAT_COND_NAME    = '[Defeat cond. name]'
  ESCAPE_COND_ID      = 'Escape cond. ID'
  ESCAPE_COND_NAME    = '[Escape cond. name]'
  
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

  OCCASION_FLAGS      = 'Occ. flags'
  OCCASION_MENU       = '[Menu]'
  OCCASION_BATTLE     = '[Battle]'
  OCCASION_SHIP       = '[Ship battle]'
  
  SHIP_OCCASION_ID    = 'Ship occ. ID'
  SHIP_OCCASION_NAME  = '[Ship occ. name]'

  ORDER_ALPHABET      = 'O. by alphabet'
  ORDER_IMPORTANCE    = 'O. by importance'

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

  POSITION_ID         = 'Pos. ID'
  POSITION_NAME       = '[Pos. name]'

end # class CsvHdr

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
