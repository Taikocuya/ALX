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
#                                  CONSTANTS
#==============================================================================
  
#------------------------------------------------------------------------------
# Global
#------------------------------------------------------------------------------

  ID                 = 'Entry ID'
  
  MESSAGE_ID         = 'Message ID'

  NAME_EU_STR        = 'EU entry name'
  NAME_JP_STR        = 'JP entry name'
  NAME_US_STR        = 'US entry name'
  NAME_GB_SIZE       = '[GB entry name size]'
  NAME_GB_POS        = '[GB entry name position]'
  NAME_GB_STR        = 'GB entry name'
  NAME_DE_SIZE       = '[DE entry name size]'
  NAME_DE_POS        = '[DE entry name position]'
  NAME_DE_STR        = 'DE entry name'
  NAME_FR_SIZE       = '[FR entry name size]'
  NAME_FR_POS        = '[FR entry name position]'
  NAME_FR_STR        = 'FR entry name'
  NAME_ES_SIZE       = '[ES entry name size]'
  NAME_ES_POS        = '[ES entry name position]'
  NAME_ES_STR        = 'ES entry name'

  DSCR_JP_SIZE       = '[JP description size]'
  DSCR_JP_POS        = '[JP description position]'
  DSCR_JP_STR        = 'JP description string'
  DSCR_US_SIZE       = '[US description size]'
  DSCR_US_POS        = '[US description position]'
  DSCR_US_STR        = 'US description string'
  DSCR_GB_SIZE       = '[GB description size]'
  DSCR_GB_POS        = '[GB description position]'
  DSCR_GB_STR        = 'GB description string'
  DSCR_DE_SIZE       = '[DE description size]'
  DSCR_DE_POS        = '[DE description position]'
  DSCR_DE_STR        = 'DE description string'
  DSCR_FR_SIZE       = '[FR description size]'
  DSCR_FR_POS        = '[FR description position]'
  DSCR_FR_STR        = 'FR description string'
  DSCR_ES_SIZE       = '[ES description size]'
  DSCR_ES_POS        = '[ES description position]'
  DSCR_ES_STR        = 'ES description string'

  SHIP_DSCR_JP_SIZE  = '[JP ship description size]'
  SHIP_DSCR_JP_POS   = '[JP ship description position]'
  SHIP_DSCR_JP_STR   = 'JP ship description string'
  SHIP_DSCR_US_SIZE  = '[US ship description size]'
  SHIP_DSCR_US_POS   = '[US ship description position]'
  SHIP_DSCR_US_STR   = 'US ship description string'
  SHIP_DSCR_GB_SIZE  = '[GB ship description size]'
  SHIP_DSCR_GB_POS   = '[GB ship description position]'
  SHIP_DSCR_GB_STR   = 'GB ship description string'
  SHIP_DSCR_DE_SIZE  = '[DE ship description size]'
  SHIP_DSCR_DE_POS   = '[DE ship description position]'
  SHIP_DSCR_DE_STR   = 'DE ship description string'
  SHIP_DSCR_FR_SIZE  = '[FR ship description size]'
  SHIP_DSCR_FR_POS   = '[FR ship description position]'
  SHIP_DSCR_FR_STR   = 'FR ship description string'
  SHIP_DSCR_ES_SIZE  = '[ES ship description size]'
  SHIP_DSCR_ES_POS   = '[ES ship description position]'
  SHIP_DSCR_ES_STR   = 'ES ship description string'

  CHARACTER_ID       = 'Character ID'
  CHARACTER_NAME     = 'Character name'
  CHARACTER_FLAGS    = 'Character flags'
  CHARACTER_OPT      = Hash.new { |_h, _k| _h[_k] = sprintf('[%s]', _k) }
  CHARACTER_VYSE     = 'Vyse'
  CHARACTER_AIKA     = 'Aika'
  CHARACTER_FINA     = 'Fina'
  CHARACTER_DRACHMA  = 'Drachma'
  CHARACTER_GILDER   = 'Gilder'
  CHARACTER_ENRIQUE  = 'Enrique'

  SHIP_FLAGS         = 'Ship flags'
  SHIP_MODEL1        = '[Little Jack #1]'
  SHIP_MODEL2        = '[Little Jack #2]'
  SHIP_MODEL3        = '[Delphinus #1]'
  SHIP_MODEL4        = '[Delphinus #2]'
  SHIP_MODEL5        = '[Delphinus #3]'

  OCCASION_FLAGS     = 'Occasion flags'
  OCCASION_MENU      = '[Menu]'
  OCCASION_BATTLE    = '[Battle]'
  OCCASION_SHIP      = '[Ship battle]'
  
  SHIP_OCCASION_ID   = 'Ship occasion ID'
  SHIP_OCCASION_NAME = 'Ship occasion name'

  ORDER_ALPHABET     = 'Order by alphabet'
  ORDER_IMPORTANCE   = 'Order by importance'

  RETAIL_PRICE       = 'Retail price in %'
  PURCHASE_PRICE     = 'Purchase price'

  FEATURE_ID         = Hash.new do |_h, _k|
    _h[_k] = sprintf('Feature%sID'     , _k && _k != 0 ? " ##{_k} " : ' ')
  end
  FEATURE_NAME       = Hash.new do |_h, _k|
    _h[_k] = sprintf('[Feature%sname]' , _k && _k != 0 ? " ##{_k} " : ' ')
  end
  FEATURE_VALUE      = Hash.new do |_h, _k|
    _h[_k] = sprintf('Feature%svalue'  , _k && _k != 0 ? " ##{_k} " : ' ')
  end

  EFFECT_ID          = 'Effect ID'
  EFFECT_NAME        = '[Effect name]'
  EFFECT_SPIRIT      = 'Effect spirit'
  EFFECT_VALUE       = Hash.new do |_h, _k|
    _h[_k] = sprintf('Effect value%s', _k && _k != 0 ? " ##{_k} " : '')
  end
  EFFECT_PRIORITY    = 'Effect priority'

  SHIP_EFFECT_ID     = 'Ship effect ID'
  SHIP_EFFECT_NAME   = '[Ship effect name]'
  SHIP_EFFECT_SPIRIT = 'Ship effect spirit'
  SHIP_EFFECT_TURNS  = 'Ship effect turns'
  SHIP_EFFECT_VALUE  = 'Ship effect amount'

  SCOPE_ID           = 'Scope ID'
  SCOPE_NAME         = '[Scope name]'
  
  ELEMENT_ID         = 'Element ID'
  ELEMENT_NAME       = '[Element name]'

  TYPE_ID            = 'Type ID'
  TYPE_NAME          = '[Type name]'

  CATEGORY_ID        = 'Category ID'
  CATEGORY_NAME      = '[Category name]'
  
  STATE_ID           = 'Inflict state ID'
  STATE_NAME         = '[Inflict state name]'

  AGILE              = 'Agile'
  ATTACK             = 'Attack'
  BASE_HP_INCREASE   = 'Base MAXHP increase'
  CONSUME            = 'Consume%'
  COUNTER            = 'Counter%'
  EXP                = Hash.new do |_h, _k|
    _h[_k] = sprintf('EXP%s', _k && _k != 0 ? " ##{_k} " : '')
  end
  HIT                = 'Hit%'
  HP                 = 'HP'
  LIMIT              = 'Limit'
  GREEN_EXP          = Hash.new do |_h, _k|
    _h[_k] = sprintf('Green EXP%s' , _k && _k != 0 ? " ##{_k} " : '')
  end
  RED_EXP            = Hash.new do |_h, _k|
    _h[_k] = sprintf('Red EXP%s'   , _k && _k != 0 ? " ##{_k} " : '')
  end
  PURPLE_EXP         = Hash.new do |_h, _k|
    _h[_k] = sprintf('Purple EXP%s', _k && _k != 0 ? " ##{_k} " : '')
  end
  BLUE_EXP           = Hash.new do |_h, _k|
    _h[_k] = sprintf('Blue EXP%s'  , _k && _k != 0 ? " ##{_k} " : '')
  end
  YELLOW_EXP         = Hash.new do |_h, _k|
    _h[_k] = sprintf('Yellow EXP%s', _k && _k != 0 ? " ##{_k} " : '')
  end
  SILVER_EXP         = Hash.new do |_h, _k|
    _h[_k] = sprintf('Silver EXP%s', _k && _k != 0 ? " ##{_k} " : '')
  end
  MAXHP              = 'MAXHP'
  MAXMP              = 'MAXMP'
  MAXSPIRIT          = 'MAXSpirit'
  POWER              = 'Power'
  QUICK              = 'Quick'
  SPIRIT             = 'Spirit'
  VIGOR              = 'Vigor'
  WILL               = 'Will'

  STATE              = Hash.new do |_h, _k|
    _h[_k] = sprintf('State%s', _k && _k != 0 ? " ##{_k} " : '')
  end

  POISON             = 'Poison'
  UNCONSCIOUS        = 'Unconscious'
  STONE              = 'Stone'
  SLEEP              = 'Sleep'
  CONFUSION          = 'Confusion'
  SILENCE            = 'Silence'
  WEAK               = 'Weak'

  WEAPON_ID          = 'Weapon ID'
  WEAPON_NAME        = 'Weapon name'
  ARMOR_ID           = 'Armor ID'
  ARMOR_NAME         = 'Armor name'
  ACCESSORY_ID       = 'Accessory ID'
  ACCESSORY_NAME     = 'Accessory name'
  
  POSITION_ID        = 'Position ID'
  POSITION_NAME      = '[Position name]'
  
  UNKNOWN            = Hash.new do |_h, _k|
    _h[_k] = sprintf('Unknown%s', _k && _k != 0 ? " ##{_k}" : '')
  end
  PADDING            = Hash.new do |_h, _k|
    _h[_k] = sprintf('Padding%s', _k && _k != 0 ? " ##{_k}" : '')
  end

end # class CsvHdr

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
