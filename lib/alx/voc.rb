#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2020 Marcel Renner
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

# Class to handle translations and vocabulary.
VOC.configure do |_v|
  
#------------------------------------------------------------------------------
# CLI
#------------------------------------------------------------------------------

  _v.build_gcm       = 'Build GCM image: %s'
  _v.build_gdi       = 'Build GDI image: %s'
  _v.check_bnr       = 'Check BNR file: %s'
  _v.check_dir       = 'Check for existing directory: %s'
  _v.check_file      = 'Check for existing file: %s'
  _v.check_hdr       = 'Check HDR file: %s'
  _v.check_platform  = 'Check platform: %s'
  _v.check_ruby      = 'Check Ruby version: %s'
  _v.check_sys_attr  = 'Check SYS attribute: %s'
  _v.close           = 'File "%s" has been closed.'
  _v.country_id      = 'Country ID'
  _v.description     = 'Description'
  _v.done            = 'done'
  _v.exists          = 'exists'
  _v.failed          = 'failed'
  _v.identified      = 'identified'
  _v.incorrect       = 'incorrect'
  _v.maker_id        = 'Maker ID'
  _v.maker_name      = 'Maker name'
  _v.not_found       = 'not found'
  _v.not_matched     = 'not matched'
  _v.open            = 'Opening file "%s" to %s %s.'
  _v.open_data       = 'data'
  _v.open_dscr       = 'descriptions'
  _v.open_name       = 'names'
  _v.open_read       = 'read'
  _v.open_snapshot   = 'snapshot'
  _v.open_write      = 'write'
  _v.product_id      = 'Product ID'
  _v.product_name    = 'Product name'
  _v.product_version = 'Product version'
  _v.product_date    = 'Product date'
  _v.read            = 'Reading entry #%s @ 0x%x'
  _v.region_id       = 'Region ID'
  _v.region_name     = 'Region name'
  _v.search          = 'Searching entry #%s @ 0x%x'
  _v.skip            = 'Skipping file "%s" because of unchanged %s.'
  _v.valid           = 'valid'
  _v.write           = 'Writing entry #%s @ 0x%x'

#------------------------------------------------------------------------------
# Common CSV Headers
#------------------------------------------------------------------------------

  _v.unknown = hdr('Unk. %d')
  _v.padding = hdr('Pad. %d')
  
  _v.id       = 'Entry ID'
  _v.filter   = '[Filter]'
  _v.location = '[Location]'
  _v.rating   = 'Rating'
  
  _v.message_id     = hdr('%s Message ID'        )
  _v.name_opt       = hdr('[%s Entry Name]'      )
  _v.name_pos       = hdr('[%s Entry Name Pos.]' )
  _v.name_size      = hdr('[%s Entry Name Size]' )
  _v.name_str       = hdr('%s Entry Name'        )
  _v.dscr_pos       = hdr('[%s Descr. Pos.]'     )
  _v.dscr_size      = hdr('[%s Descr. Size]'     )
  _v.dscr_str       = hdr('%s Descr. Str.'       )
  _v.ship_dscr_pos  = hdr('[%s Ship Descr. Pos.]')
  _v.ship_dscr_size = hdr('[%s Ship Descr. Size]')
  _v.ship_dscr_str  = hdr('%s Ship Descr. Str.'  )

  _v.age               = 'Age'
  _v.agile             = 'Agile'
  _v.attack            = 'Attack'
  _v.base_agile_incr   = 'Base Agile Incr.'
  _v.base_defense_incr = 'Base Defense Incr.'
  _v.base_hp_incr      = 'Base MAXHP Incr.'
  _v.base_magdef_incr  = 'Base MagDef Incr.'
  _v.base_mp_incr      = 'Base MAXMP Incr.'
  _v.base_power_incr   = 'Base Power Incr.'
  _v.base_quick_incr   = 'Base Quick Incr.'
  _v.base_vigor_incr   = 'Base Vigor Incr.'
  _v.base_will_incr    = 'Base Will Incr.'
  _v.consume           = 'Consume%'
  _v.counter           = 'Counter%'
  _v.defense           = 'Defense'
  _v.depth             = 'Depth'
  _v.dodge             = 'Dodge%'
  _v.gold              = 'Gold'
  _v.hit               = 'Hit%'
  _v.hp                = 'HP'
  _v.level             = 'Level'
  _v.limit             = 'Limit'
  _v.magdef            = 'MagDef'
  _v.maxhp             = 'MAXHP'
  _v.maxmp             = 'MAXMP'
  _v.maxsp             = hdr('MAXSP %d')
  _v.movement_flags    = 'Movement Flags'
  _v.power             = 'Power'
  _v.quick             = 'Quick'
  _v.run               = 'Run%'
  _v.sp                = hdr('SP %d'   )
  _v.value             = 'Value'
  _v.vigor             = 'Vigor'
  _v.width             = 'Width'
  _v.will              = 'Will'

  _v.characters    = Hash.new('???')
  _v.characters[0] = 'Vyse'
  _v.characters[1] = 'Aika'
  _v.characters[2] = 'Fina'
  _v.characters[3] = 'Drachma'
  _v.characters[4] = 'Enrique'
  _v.characters[5] = 'Gilder'
  
  _v.element_id   = 'Element ID'
  _v.element_name = '[Element Name]'
  
  _v.elements     = Hash.new('???')
  _v.elements[-1] = 'None'
  _v.elements[ 0] = 'Green'
  _v.elements[ 1] = 'Red'
  _v.elements[ 2] = 'Purple'
  _v.elements[ 3] = 'Blue'
  _v.elements[ 4] = 'Yellow'
  _v.elements[ 5] = 'Silver'
  _v.elements[ 6] = 'Neutral'

  _v.state_id   = 'State ID'
  _v.state_name = '[State Name]'
  _v.state_miss = 'State Miss%'
  
  _v.states     = Hash.new('???')
  _v.states[-1] = 'None'
  _v.states[ 0] = 'Poison'
  _v.states[ 1] = 'Unconscious'
  _v.states[ 2] = 'Stone'
  _v.states[ 3] = 'Sleep'
  _v.states[ 4] = 'Confusion'
  _v.states[ 5] = 'Silence'
  _v.states[ 6] = 'Fatigue'
  _v.states[ 7] = 'Revival'
  _v.states[ 8] = 'Weak'
  _v.states[ 9] = 'State 10'
  _v.states[10] = 'State 11'
  _v.states[11] = 'State 12'
  _v.states[12] = 'State 13'
  _v.states[13] = 'State 14'
  _v.states[14] = 'State 15'
  _v.states[15] = 'Danger'

#------------------------------------------------------------------------------
# Defined String
#------------------------------------------------------------------------------

  _v.string_pos      = '[Str. Pos.]'
  _v.string_size     = '[Str. Size]'
  _v.string_encoding = '[Str. Encoding]'
  _v.string_value    = 'Str. Value'
  _v.string_data     = '[Str. Data]'
  _v.string_filter   = '[Str. Filter]'

#------------------------------------------------------------------------------
# Effects
#------------------------------------------------------------------------------

  _v.category_id   = 'Category ID'
  _v.category_name = '[Category Name]'
  
  _v.character_skill_categories    = Hash.new('???')
  _v.character_skill_categories[0] = _v.characters[0]
  _v.character_skill_categories[1] = _v.characters[1]
  _v.character_skill_categories[2] = _v.characters[2]
  _v.character_skill_categories[3] = _v.characters[3]
  _v.character_skill_categories[4] = _v.characters[4]
  _v.character_skill_categories[5] = _v.characters[5]
  _v.character_skill_categories[6] = 'Magic'
  
  _v.enemy_skill_categories    = Hash.new('???')
  _v.enemy_skill_categories[0] = 'S-Move'
  _v.enemy_skill_categories[1] = 'Magic'

  _v.type_id   = 'Type ID'
  _v.type_name = '[Type Name]'
  
  _v.types     = Hash.new('???')
  _v.types[-1] = 'None'
  _v.types[ 0] = 'Physical'
  _v.types[ 1] = 'Magical'

  _v.ship_occasion_id   = 'Ship Occ. ID'
  _v.ship_occasion_name = '[Ship Occ. Name]'
  
  _v.ship_occasions     = Hash.new('???')
  _v.ship_occasions[-1] = 'Never'
  _v.ship_occasions[ 0] = 'Magic Cannon'
  _v.ship_occasions[ 1] = 'Always'

  _v.scope_id   = 'Scope ID'
  _v.scope_name = '[Scope Name]'

  _v.scopes      = Hash.new('???')
  _v.scopes[  0] = 'None'
  _v.scopes[  1] = 'Single PC'
  _v.scopes[  2] = 'All PCs'
  _v.scopes[  3] = 'Single EC'
  _v.scopes[  4] = 'All ECs'
  _v.scopes[  5] = 'Self'
  _v.scopes[  6] = 'All PCs and ECs'
  _v.scopes[ 32] = 'EC Square S3'
  _v.scopes[ 33] = 'EC Square S5'
  _v.scopes[ 34] = 'EC Square S7'
  _v.scopes[ 36] = 'EC Ray S1'
  _v.scopes[ 37] = 'EC Ray S3'
  _v.scopes[ 38] = 'EC Ray S5'
  _v.scopes[ 39] = 'EC Ray S3'
  _v.scopes[ 43] = 'EC Triangle 60°'
  _v.scopes[ 96] = 'PC Square S3'
  _v.scopes[ 97] = 'PC Square S5'
  _v.scopes[ 98] = 'PC Square S7'
  _v.scopes[100] = 'PC Ray S1'
  _v.scopes[101] = 'PC Ray S3'
  _v.scopes[102] = 'PC Ray S5'
  _v.scopes[103] = 'PC Triangle 60°'
  _v.scopes[107] = 'PC Triangle 60°'
  _v.scopes[200] = 'PCs Nearby S1'
  _v.scopes[201] = 'PCs Nearby S1'
    
  _v.effect_id       = 'Effect ID'
  _v.effect_name     = '[Effect Name]'
  _v.effect_spirit   = 'Effect SP'
  _v.effect_value    = hdr('Effect Value %d')
  _v.effect_priority = 'Effect Prio.'

  _v.ship_effect_id     = 'Ship Effect ID'
  _v.ship_effect_name   = '[Ship Effect Name]'
  _v.ship_effect_spirit = 'Ship Effect SP'
  _v.ship_effect_turns  = 'Ship Effect Turns'
  _v.ship_effect_value  = 'Ship Effect Amount'

  _v.effects      = Hash.new('???')
  _v.effects[ -1] = 'None'
  _v.effects[  0] = 'Damage'
  _v.effects[  1] = 'Guard'
  _v.effects[  4] = 'Damage, Poison'
  _v.effects[  5] = 'Unconscious'
  _v.effects[  6] = 'Damage, Unconscious 1'
  _v.effects[  7] = 'Stone'
  _v.effects[  8] = 'Damage, Stone'
  _v.effects[  9] = 'Sleep'
  _v.effects[ 11] = 'Confusion'
  _v.effects[ 12] = 'Silence'
  _v.effects[ 16] = 'Rem. Pos. States'
  _v.effects[ 17] = 'Damage, Rem. Pos. States'
  _v.effects[ 20] = 'Quickened'
  _v.effects[ 21] = 'Strengthen'
  _v.effects[ 26] = 'Weak'
  _v.effects[ 27] = 'Revive, Recover HP 50%'
  _v.effects[ 28] = 'Revive, Recover HP 100%'
  _v.effects[ 30] = 'Rem. Neg. States'
  _v.effects[ 31] = 'Recover HP'
  _v.effects[ 32] = 'Recover HP 100%'
  _v.effects[ 33] = 'Regenerate'
  _v.effects[ 35] = 'Recover SP'
  _v.effects[ 38] = 'Guard, Counter Attack'
  _v.effects[ 39] = 'Block Magic'
  _v.effects[ 41] = 'Guard, Incr. SP Restor. 200%'
  _v.effects[ 42] = 'Block Neg. States'
  _v.effects[ 43] = 'Call EC'
  _v.effects[ 44] = 'Absorb HP'
  _v.effects[ 46] = 'Counter Attack, Block Attack'
  _v.effects[ 47] = 'Recover HP & MP, Rem. Neg. States'
  _v.effects[ 48] = 'Recover MP'
  _v.effects[ 49] = 'Recover MP 100%'
  _v.effects[ 51] = 'Recover HP & MP'
  _v.effects[ 52] = 'Moonberry'
  _v.effects[ 53] = 'Cham'
  _v.effects[ 54] = 'Incr. Power'
  _v.effects[ 55] = 'Incr. Will'
  _v.effects[ 56] = 'Incr. Vigor'
  _v.effects[ 57] = 'Incr. Agile'
  _v.effects[ 58] = 'Incr. Quick'
  _v.effects[ 59] = 'Incr. MAXHP'
  _v.effects[ 60] = 'Incr. MAXMP'
  _v.effects[ 62] = 'Damage, Defeat User'
  _v.effects[ 63] = 'Regenerate, Sleep'
  _v.effects[ 64] = 'Call EC, Defeat All ECs'
  _v.effects[ 65] = 'Prophecy'
  _v.effects[ 66] = 'Blue Rogues'
  _v.effects[ 67] = 'Invulnerable'
  _v.effects[ 68] = 'Damage, Unconscious 2'
  _v.effects[ 69] = 'Damage, Sleep'
  _v.effects[ 70] = 'Damage, Confusion'
  _v.effects[ 71] = 'Damage, Silence'
  _v.effects[ 72] = 'Damage, Fatigue'
  _v.effects[ 73] = 'Damage, Weak'
  _v.effects[ 74] = 'Control PC'
  _v.effects[ 75] = 'Abirik Cham'
  _v.effects[ 76] = 'Reset Cupil'
  _v.effects[ 77] = 'Recover MP, Invulnerable'
  _v.effects[ 78] = 'Quickened, Regenerate, Strengthen'
  _v.effects[100] = 'Recover HP'
  _v.effects[101] = 'Recover HP 100%'
  _v.effects[102] = 'Recover SP'
  _v.effects[103] = 'Recover SP 100%'
  _v.effects[104] = 'Quickened'
  _v.effects[105] = 'Strengthen'
  _v.effects[106] = 'Weak'
  _v.effects[107] = 'Damage'
  _v.effects[108] = 'Impr. Parameters'
  _v.effects[109] = 'Block Artillery'
  _v.effects[110] = 'Block Magic'
  _v.effects[111] = 'Impr. First Strike%'
  _v.effects[112] = 'Impr. Critical%'
  _v.effects[113] = 'Decr. SP Consum. 50%'
  _v.effects[114] = 'Incr. SP Restor. 200%'
  _v.effects[115] = 'Captain\'s Stripe'
  _v.effects[116] = 'Silence'
  _v.effects[117] = 'Recover MP'
  _v.effects[255] = 'None'

#------------------------------------------------------------------------------
# Menu
#------------------------------------------------------------------------------

  _v.occasion_flags  = 'Occ. Flags'
  _v.occasion_menu   = '[M]'
  _v.occasion_battle = '[B]'
  _v.occasion_ship   = '[S]'

  _v.occasions    = Hash.new('???')
  _v.occasions[0] = _v.occasion_menu
  _v.occasions[1] = _v.occasion_battle
  _v.occasions[2] = _v.occasion_ship

  _v.order_abc  = hdr('%s Order by ABC')
  _v.order_prio = 'Order by Prio.'

  _v.retail_price   = 'Retail Price in %'
  _v.purchase_price = 'Purchase Price'

  _v.feature_id    = hdr('Feat. %d ID'    )
  _v.feature_name  = hdr('[Feat. %d Name]')
  _v.feature_value = hdr('Feat. %d Value' )

  _v.accessory_features     = Hash.new('???')
  _v.accessory_features[-1] = 'None'
  _v.accessory_features[ 1] = 'Will'
  _v.accessory_features[ 4] = 'Quick'
  _v.accessory_features[16] = 'Attack'
  _v.accessory_features[17] = 'Defense'
  _v.accessory_features[18] = 'MagDef'
  _v.accessory_features[19] = 'Hit%'
  _v.accessory_features[20] = 'Dodge%'
  _v.accessory_features[32] = _v.elements[ 0]
  _v.accessory_features[33] = _v.elements[ 1]
  _v.accessory_features[34] = _v.elements[ 2]
  _v.accessory_features[35] = _v.elements[ 3]
  _v.accessory_features[36] = _v.elements[ 4]
  _v.accessory_features[37] = _v.elements[ 5]
  _v.accessory_features[48] = _v.states[ 0]
  _v.accessory_features[49] = _v.states[ 1]
  _v.accessory_features[50] = _v.states[ 2]
  _v.accessory_features[51] = _v.states[ 3]
  _v.accessory_features[52] = _v.states[ 4]
  _v.accessory_features[53] = _v.states[ 5]
  _v.accessory_features[54] = _v.states[ 6]
  _v.accessory_features[55] = _v.states[ 7] 
  _v.accessory_features[56] = _v.states[ 8]
  _v.accessory_features[57] = _v.states[ 9]
  _v.accessory_features[58] = _v.states[10]
  _v.accessory_features[59] = _v.states[11]
  _v.accessory_features[60] = _v.states[12]
  _v.accessory_features[61] = _v.states[13]
  _v.accessory_features[62] = _v.states[14]
  _v.accessory_features[63] = _v.states[15]
  _v.accessory_features[64] = 'Block Magic'
  _v.accessory_features[65] = 'Block Attack'
  _v.accessory_features[68] = 'Reduce SP'
  _v.accessory_features[73] = 'Counter%'
  _v.accessory_features[77] = 'Recover SP'
  _v.accessory_features[78] = 'Add Regenerate'
  _v.accessory_features[79] = 'Block Neg. States'
  _v.accessory_features[80] = 'First Strike%'
  _v.accessory_features[81] = 'PC Run%'
  _v.accessory_features[83] = 'EC Run%'
  _v.accessory_features[84] = 'Random Encounter%'
  
  _v.ship_accessory_features     = Hash.new('???')
  _v.ship_accessory_features[-1] = 'None'
  _v.ship_accessory_features[ 2] = 'Defense'
  _v.ship_accessory_features[ 3] = 'MagDef'
  _v.ship_accessory_features[ 4] = 'Quick'
  _v.ship_accessory_features[ 6] = 'Dodge%'
  _v.ship_accessory_features[ 7] = 'Value'
  _v.ship_accessory_features[48] = 'Main Cannon Atk.'
  _v.ship_accessory_features[64] = 'Sec. Cannon Atk.'
  _v.ship_accessory_features[81] = 'Torpedo Hit%'
  _v.ship_accessory_features[96] = 'Special Attack'

  _v.ship_cannon_types     = Hash.new('???')
  _v.ship_cannon_types[-1] = 'None'
  _v.ship_cannon_types[ 0] = 'Main Cannon'
  _v.ship_cannon_types[ 1] = 'Sec. Cannon'
  _v.ship_cannon_types[ 2] = 'Torpedo'
  _v.ship_cannon_types[ 3] = 'Special'

#------------------------------------------------------------------------------
# Character
#------------------------------------------------------------------------------

  _v.character_id    = hdr('PC%d ID'    )
  _v.character_name  = hdr('[PC%d Name]')
  _v.character_x     = hdr('PC%d X'     )
  _v.character_z     = hdr('PC%d Z'     )
  _v.character_opt   = hdr('[%s]'       )
  _v.character_flags = 'PC Flags'

  _v.gender_id   = 'Gender ID'
  _v.gender_name = '[Gender Name]'
  
  _v.genders     = Hash.new('???')
  _v.genders[-1] = 'None'
  _v.genders[ 0] = 'Male'
  _v.genders[ 1] = 'Female'

  _v.weapon_id      = 'Weapon ID'
  _v.weapon_name    = '[Weapon Name]'
  _v.armor_id       = 'Armor ID'
  _v.armor_name     = '[Armor Name]'
  _v.accessory_id   = hdr('Accessory %d ID')
  _v.accessory_name = hdr('[Accessory %d Name]')

  _v.exp        = hdr('EXP %d'       )
  _v.magic_exp  = 'Magic EXP'
  _v.green_exp  = hdr('Green EXP %d' )
  _v.red_exp    = hdr('Red EXP %d'   )
  _v.purple_exp = hdr('Purple EXP %d')
  _v.blue_exp   = hdr('Blue EXP %d'  )
  _v.yellow_exp = hdr('Yellow EXP %d')
  _v.silver_exp = hdr('Silver EXP %d')

#------------------------------------------------------------------------------
# Ship
#------------------------------------------------------------------------------

  _v.ship_flags = 'PS Flags'
  _v.ships      = Hash.new('???')
  _v.ships[0]   = '[L1]'
  _v.ships[1]   = '[L2]'
  _v.ships[2]   = '[D1]'
  _v.ships[3]   = '[D2]'
  _v.ships[4]   = '[D3]'
  
  _v.cannon_id   = hdr('Cannon %d ID'    )
  _v.cannon_name = hdr('[Cannon %d Name]')

  _v.position_id   = 'Pos. ID'
  _v.position_name = '[Pos. Name]'

  _v.positions     = Hash.new('???')
  _v.positions[ 0] = 'Helmsman'
  _v.positions[ 1] = 'Engineer'
  _v.positions[ 2] = 'Gunner'
  _v.positions[ 3] = 'Lookout'
  _v.positions[ 4] = 'Merchant'
  _v.positions[ 5] = 'Builder'
  _v.positions[ 6] = 'Cook'
  _v.positions[ 7] = 'Artisan'
  _v.positions[ 8] = 'Sailor'
  _v.positions[ 9] = 'Jester'
  _v.positions[10] = 'Delegate'

#------------------------------------------------------------------------------
# Enemy
#------------------------------------------------------------------------------

  _v.enemy_id       = hdr('EC%d ID'       )
  _v.enemy_ref      = '[EC ID]'
  _v.enemy_name_jp  = hdr('[JP EC%d Name]')
  _v.enemy_name_us  = hdr('[US EC%d Name]')
  _v.enemy_name_eu  = hdr('[EU EC%d Name]')
  _v.enemy_x        = hdr('EC%d X'        )
  _v.enemy_z        = hdr('EC%d Z'        )

  _v.item_probability = hdr('Item %d Prob.' )
  _v.item_amount      = hdr('Item %d Amount')
  _v.item_id          = hdr('Item %d ID'    )
  _v.item_name        = hdr('[Item %d Name]')

  _v.task_id    = 'Task ID'
  _v.task_name  = '[Task Name]'
  _v.param_id   = 'Param. ID'
  _v.param_name = '[Param. Name]'

  _v.task_types     = Hash.new('???')
  _v.task_types[-1] = 'None'
  _v.task_types[ 0] = 'Branch'
  _v.task_types[ 1] = 'Action'
  
  _v.branches     = Hash.new('???')
  _v.branches[ 0] = 'HP = 100%'
  _v.branches[ 1] = 'HP < 50%'
  _v.branches[ 2] = 'HP < 25%'
  _v.branches[ 3] = 'HP < 10%'
  _v.branches[ 4] = 'Got Hit?'
  _v.branches[ 5] = 'Got Hit by Spell?'
  _v.branches[ 6] = 'Any PC Distance > 2'
  _v.branches[ 7] = 'Any PC Distance > 3'
  _v.branches[ 8] = 'Any PC Distance >= 2'
  _v.branches[ 9] = 'Any PC Distance >= 3'
  _v.branches[10] = _v.branches[7]
  _v.branches[11] = 'Turn 1'
  _v.branches[12] = 'Turn 2'
  _v.branches[13] = 'Turn 3'
  _v.branches[14] = 'Turn 4'
  _v.branches[15] = 'Turn 8'
  _v.branches[16] = "Has Silence?"
  _v.branches[17] = 'ECs Alive = 1'
  _v.branches[18] = 'Party SP = 100%'
  _v.branches[19] = 'Party SP ≤ 50%'
  _v.branches[20] = 'Party SP ≤ 25%'
  _v.branches[21] = 'Rating 10%'
  _v.branches[22] = 'Rating 20%'
  _v.branches[23] = 'Rating 30%'
  _v.branches[24] = 'Rating 40%'
  _v.branches[25] = 'Rating 50%'
  _v.branches[26] = 'Rating 60%'
  _v.branches[27] = 'Rating 70%'
  _v.branches[28] = 'Rating 80%'
  _v.branches[29] = 'Rating 90%'
  _v.branches[30] = 'Always'
  _v.branches[31] = 'Used Sacri Spells ≥ 1'
  _v.branches[32] = 'Used Sacri Spells ≥ 2'
  _v.branches[33] = 'Used Atk. Spells ≥ 1'
  _v.branches[34] = 'Used Atk. Spells ≥ 2'
  _v.branches[35] = 'Used State Spells ≥ 1'
  _v.branches[36] = 'Used State Spells ≥ 2'
  _v.branches[37] = 'Turn ≥ 5'
  _v.branches[38] = 'Any EC HP < 50%'
  _v.branches[39] = 'Any EC HP < 25%'
  _v.branches[40] = 'Used Gather Strength?'
  _v.branches[41] = 'Used Tremble?'
  _v.branches[42] = 'Used Sacri Crystals ≥ 1'
  _v.branches[43] = 'Used Sacri Crystals ≥ 2'
  _v.branches[44] = "1st PC Δ#{_v.level} > 3"
  _v.branches[45] = "1st PC Δ#{_v.level} > 7"
  _v.branches[46] = 'Used HP Absorbs ≥ 1'
  _v.branches[47] = 'Used HP Absorbs ≥ 2'
  _v.branches[48] = 'Used Target Search?'
  _v.branches[49] = 'Used Spell Last Turn?'
  _v.branches[50] = 'Used S-Move Last Turn?'
  _v.branches[51] = 'Used Focus?'
  _v.branches[52] = 'Used Charge'
  _v.branches[53] = 'Used Engage?'
  _v.branches[54] = 'ECs Alive ≤ 3'
  _v.branches[55] = 'Used Digest?'
  _v.branches[56] = "All PCs Have Weak?"
  _v.branches[57] = 'Any PC Has Strengthen?'
  _v.branches[58] = 'Any PC Has Quickened?'
  _v.branches[59] = 'Any PC Has Regenerate?'
  _v.branches[60] = 'Destruction on Recharge?'
  _v.branches[61] = 'Has No Regenerate?'
  _v.branches[62] = 'PCs Alive ≥ 1'
  _v.branches[63] = 'PCs Alive ≥ 2'
  _v.branches[64] = 'PCs Alive ≥ 3'
  _v.branches[65] = 'PCs Alive ≥ 4'
  _v.branches[66] = 'ECs Alive = 3'
  _v.branches[67] = 'Used Legendary Charge?'
  _v.branches[68] = 'Used Target Search?'
  _v.branches[69] = "EC Slots < 8 and #{_v.states[15]} ≤ 3000"

  _v.branch_params = Hash.new do |_h, _k|
    _h[_k] = sprintf('Go to %d', _k)
  end

  _v.actions      = Hash.new('???')
  _v.actions[550] = 'Attack'
  _v.actions[551] = 'Guard'
  _v.actions[552] = 'Run'
  
  _v.action_params     = Hash.new('???')
  _v.action_params[-1] = 'None'
  _v.action_params[ 0] = 'Random PC'
  _v.action_params[ 1] = 'Same PC'
  _v.action_params[ 2] = 'Random PC'
  _v.action_params[ 3] = 'PC w/ Most HP'
  _v.action_params[ 4] = 'PC w/ Least HP'
  _v.action_params[ 5] = 'Random EC'
  _v.action_params[ 6] = 'EC w/ Most HP'
  _v.action_params[ 7] = 'EC w/ Least HP'
  _v.action_params[ 8] = 'EC w/ Highest ID'
  _v.action_params[11] = 'EC w/o Strengthen'
  _v.action_params[12] = 'EC Nearby'
  _v.action_params[13] = "PC w/o Stone"
  _v.action_params[14] = "PC w/o Confusion"
  _v.action_params[15] = "PC w/o Silence"
  _v.action_params[16] = "PC w/o Sleep"
  _v.action_params[17] = "PC w/o Weak"
  _v.action_params[18] = "PC w/o Fatigue"
  _v.action_params[19] = "PC w/o Poison"
  _v.action_params[20] = 'PC w/ Highest Will'
  _v.action_params[21] = 'PC w/ Highest Attack'
  _v.action_params[22] = 'Self'
  _v.action_params[23] = "#{_v.characters[1]}"
  
#------------------------------------------------------------------------------
# Enemy Ship
#------------------------------------------------------------------------------

  _v.enemy_ship_id   = '[ES ID]'
  _v.enemy_ship_name = '[ES Name]'

  _v.arm_name_eu = hdr('EU Arm. %d Name')
  _v.arm_name_jp = hdr('JP Arm. %d Name')
  _v.arm_name_us = hdr('US Arm. %d Name')

  _v.arm_name_de_pos  = hdr('[DE Arm. %d Name Pos.]')
  _v.arm_name_de_size = hdr('[DE Arm. %d Name Size]')
  _v.arm_name_de_str  = hdr('DE Arm. %d Name Str.'  )
  _v.arm_name_es_pos  = hdr('[ES Arm. %d Name Pos.]')
  _v.arm_name_es_size = hdr('[ES Arm. %d Name Size]')
  _v.arm_name_es_str  = hdr('ES Arm. %d Name Str.'  )
  _v.arm_name_fr_pos  = hdr('[FR Arm. %d Name Pos.]')
  _v.arm_name_fr_size = hdr('[FR Arm. %d Name Size]')
  _v.arm_name_fr_str  = hdr('FR Arm. %d Name Str.'  )
  _v.arm_name_gb_pos  = hdr('[GB Arm. %d Name Pos.]')
  _v.arm_name_gb_size = hdr('[GB Arm. %d Name Size]')
  _v.arm_name_gb_str  = hdr('GB Arm. %d Name Str.'  )

  _v.arm_attack       = hdr('Arm. %d Attack'        )
  _v.arm_type_id      = hdr('Arm. %d Type ID'       )
  _v.arm_type_name    = hdr('[Arm. %d Type name]'   )
  _v.arm_hit          = hdr('Arm. %d Hit%%'         )
  _v.arm_range        = hdr('Arm. %d Range'         )
  _v.arm_element_id   = hdr('Arm. %d Element ID'    )
  _v.arm_element_name = hdr('[Arm. %d Element Name]')

  _v.item_drop_id   = hdr('Item Drop %d ID'    )
  _v.item_drop_name = hdr('[Item Drop %d Name]')

  _v.drops     = Hash.new('???')
  _v.drops[-1] = 'None'
  _v.drops[ 0] = '100%'
  _v.drops[ 2] = '10%'
  _v.drops[ 3] = '20%'
  _v.drops[ 4] = '50%'
  _v.drops[ 6] = 'Kalifa'
  _v.drops[ 7] = 'Osman'

  _v.task_cond_id    = 'Cond. ID'
  _v.task_cond_name  = '[Cond. Name]'
  _v.task_type_id    = hdr('T%d Type ID')
  _v.task_type_name  = hdr('[T%d Type Name]')
  _v.task_arm_id     = hdr('T%d Arm. ID')
  _v.task_arm_name   = hdr('[T%d Arm. Name]')
  _v.task_param_id   = hdr('T%d Param. ID')
  _v.task_param_name = hdr('[T%d Param. Name]')
  _v.task_range      = hdr('T%d Arm. Range')

  _v.ship_task_types     = Hash.new('???')
  _v.ship_task_types[-1] = 'None'
  _v.ship_task_types[ 0] = 'Attack'
  _v.ship_task_types[ 1] = 'Magic'
  _v.ship_task_types[ 2] = 'Focus'
  _v.ship_task_types[ 3] = 'Guard'
  _v.ship_task_types[ 4] = 'Nothing'

  _v.focus_ship_tasks     = Hash.new('???')
  _v.focus_ship_tasks[-1] = 'None'
  _v.focus_ship_tasks[ 0] = 'Focus'
  _v.focus_ship_tasks[ 1] = 'Taking Aim'
  _v.focus_ship_tasks[ 2] = 'Preparing Attack'
  _v.focus_ship_tasks[34] = 'Preparing Attack'

  _v.guard_ship_tasks     = Hash.new('???')
  _v.guard_ship_tasks[-1] = 'None'
  _v.guard_ship_tasks[ 0] = 'Evasive Action'

  _v.nothing_ship_tasks     = Hash.new('???')
  _v.nothing_ship_tasks[-1] = 'None'
  _v.nothing_ship_tasks[ 0] = 'Awaiting Orders'
  _v.nothing_ship_tasks[ 1] = 'Target Lost'
  _v.nothing_ship_tasks[ 2] = 'Assessing Damage'
  _v.nothing_ship_tasks[ 3] = 'Hull Ram'
  _v.nothing_ship_tasks[ 4] = 'Red Ray'
  _v.nothing_ship_tasks[ 5] = 'Fist of Grendel'
  _v.nothing_ship_tasks[ 6] = 'Boulder Throw'
  _v.nothing_ship_tasks[ 7] = 'Stomp'
  _v.nothing_ship_tasks[ 8] = 'Flee'
  
#------------------------------------------------------------------------------
# Battle
#------------------------------------------------------------------------------

  _v.bgm_id     = 'BGM ID'
  _v.initiative = 'Initiative'
    
  _v.defeat_cond_id   = 'Defeat Cond. ID'
  _v.defeat_cond_name = '[Defeat Cond. Name]'
  _v.escape_cond_id   = 'Escape Cond. ID'
  _v.escape_cond_name = '[Escape Cond. Name]'

  _v.defeats    = Hash.new('???')
  _v.defeats[0] = 'Must Not Lose'
  _v.defeats[1] = 'May Try Again'
  _v.defeats[2] = 'May Lose'
  
  _v.escapes    = Hash.new('???')
  _v.escapes[0] = 'Can Escape'
  _v.escapes[1] = 'Cannot Escape'

#------------------------------------------------------------------------------
# Enemy Names
#------------------------------------------------------------------------------
  
  _v.enemies = {
    '0'              => 'Soldier',
    '1'              => 'Guard',
    '2'              => 'Seeker',
    '3'              => 'Marocca',
    '4'              => 'Grouder',
    '7'              => 'Spell Warden',
    '8'              => 'Flestik',
    '9'              => 'Basallish',
    '10'             => 'Mind Stealer',
    '11'             => 'Walrenk',
    '12'             => 'Varkris',
    '13'             => 'Azbeth',
    '14'             => 'Zivilyn Bane',
    '15'             => 'Ghastling',
    '16'             => 'Florast',
    '17'             => 'Tsirat',
    '18'             => 'Thorkryn',
    '19'             => 'Scorfly',
    '20'             => 'Centralk',
    '21'             => 'Feralisk',
    '22'             => 'Ferlith',
    '23'             => 'Crylhound',
    '24'             => 'Magma Tiki',
    '25'             => 'Salamander',
    '26'             => 'Baroo',
    '27'             => 'Dung Fly',
    '28'             => 'Death\'s Head',
    '29'             => 'Looper',
    '30'             => 'Loopalon',
    '31'             => 'Tsurak',
    '32'             => 'Enforcer',
    '33'             => 'Serpantis',
    '34'             => 'Dralnog',
    '35'             => 'Que\'lak',
    '36'             => 'Pinalisk',
    '37'             => 'Crylbeast',
    '38'             => 'Slothstra',
    '39'             => 'Polraxis',
    '40'             => 'Roseln',
    '41'             => 'Elooper',
    '42'             => 'Grapor',
    '43'             => 'Sphyrus',
    '44'             => 'Iridzu',
    '45'             => 'Flyst',
    '46'             => 'Medulizk',
    '47'             => 'Lucich',
    '48'             => 'Digger',
    '49'             => 'Flat Fiend',
    '50'             => 'Burocca',
    '51'             => 'Drogerp',
    '52'             => 'Nadnarb',
    '53'             => 'Nairad',
    '54'             => 'Kanezl',
    '55'             => 'Mantoid',
    '56'             => 'Sorcerer',
    '57'             => 'Slithar',
    '58'             => 'Golooper',
    '59'             => 'Alusphere',
    '60'             => 'Soldier',
    '61'             => 'Delzool',
    '62'             => 'Defender',
    '63'             => 'Ghrost',
    '64'             => 'Graver',
    '65'             => 'Shrilp',
    '66'             => 'Cerosik',
    '67'             => 'Carnilak',
    '68'             => 'Valgand',
    '69'             => 'Berserker',
    '70'             => 'Lurgel Tank',
    '71'             => 'Tenkou',
    '72'             => 'Patrol Guard',
    '73'             => 'Mine Patrol',
    '74'             => 'Frost Worm',
    '75'             => 'Destroyer',
    '76'             => 'Marauder',
    '77'             => 'Guardian',
    '78'             => 'Telsor',
    '79'             => 'Dorntak',
    '80'             => 'Linark',
    '81'             => 'Dolthstra',
    '82'             => 'Dracolurg',
    '83'             => 'Garagor',
    '84'             => 'Kilite',
    '85'             => 'Imezl',
    '86'             => 'Lurker',
    '87'             => 'Jellikra',
    '88'             => 'Scorpon',
    '89'             => 'Arclooper',
    '90'             => 'Tsorok',
    '91'             => 'Sentry',
    '92'             => 'Langry',
    '93'             => 'Durel Beetle',
    '94'             => 'Totelm',
    '95'             => 'Thryllak',
    '96'             => 'Stonebeak',
    '97'             => 'Razorbeak',
    '98'             => 'Stalk Fiend',
    '99'             => 'Kantor',
    '100'            => 'Shadow',
    '101'            => 'Assassin',
    '102'            => 'Officer',
    '103'            => 'Mage Warden',
    '104'            => 'Shock Troop',
    '105'            => 'Red Guard',
    '106'            => 'Elite Guard',
    '107'            => 'Jynnus',
    '108'            => 'Hydra Elite',
    '109'            => 'Yulooper',
    '110'            => 'Hunter',
    '111'            => 'Zivilyn Bane',
    '112'            => 'Zivilyn Bane',
    '113'            => 'Zivilyn Bane',
    '114'            => 'Zivilyn Bane',
    '115'            => 'Zivilyn Bane',
    '116'            => 'Zivilyn Bane',
    '117'            => 'Zivilyn Bane',
    '118'            => 'Hunter',
    '119'            => 'Delvax',
    '120'            => 'Hopril',
    '121'            => 'Elcian',
    '128'            => 'Antonio',
    '129'            => 'Sentinel',
    '130'            => 'Bleigock',
    '131'            => 'Executioner',
    '132'            => 'Galcian',
    '133'            => 'Royal Guard',
    '134'            => 'Rokwyrm',
    '136'            => 'Antonio 2',
    '137'            => 'Rik\'talish',
    '138'            => 'Sinistra',
    '139'            => 'Destra',
    '140'            => 'Ramirez',
    '141'            => 'Vigoro',
    '142'            => 'Dralkor Tank',
    '144'            => 'Tortigar',
    '145'            => 'Jao',
    '146'            => 'Mao',
    '147'            => 'Muraji',
    '148'            => 'Veltarn',
    '149'            => 'Vigoro',
    '150'            => 'Dracoslyth',
    '151'            => 'Galcian',
    '152'            => 'Ramirez',
    '153'            => 'Ramirez',
    '154'            => 'Eliminator',
    '155'            => 'Gordo',
    '156'            => 'Mad Chef',
    '157'            => 'Ramirez',
    '158'            => 'Piastol',
    '159'            => 'Piastol',
    '160'            => 'Piastol',
    '161'            => 'Piastol',
    '162'            => 'Piastol',
    '163'            => 'Piastol',
    '164'            => 'Piastol',
    '165'            => 'Piastol',
    '166'            => 'Piastol',
    '167'            => 'Piastol',
    '168'            => 'Piastol',
    '169'            => 'Piastol',
    '170'            => 'Piastol',
    '171'            => 'Piastol',
    '172'            => 'Piastol',
    '173'            => 'Piastol',
    '174'            => 'Piastol',
    '175'            => 'Piastol',
    '176'            => 'Piastol',
    '177'            => 'Piastol',
    '178'            => 'Tara',
    '179'            => 'Tara',
    '180'            => 'Tara',
    '181'            => 'Tara',
    '182'            => 'Tara',
    '183'            => 'Lira',
    '184'            => 'Lira',
    '185'            => 'Lira',
    '186'            => 'Lira',
    '187'            => 'Lira',
    '188'            => 'Pera',
    '189'            => 'Pera',
    '190'            => 'Pera',
    '191'            => 'Pera',
    '192'            => 'Pera',
    '193'            => 'Daikokuya',
    '194'            => 'Daikokuya',
    '195'            => 'Daikokuya',
    '196'            => 'Daikokuya',
    '197'            => 'Daikokuya',
    '198'            => 'Rupee',
    '199'            => 'Rupee',
    '200'            => 'Rupee',
    '201'            => 'Rupee',
    '202'            => 'Rupee',
    '203'            => 'Rupee',
    '204'            => 'Rupee',
    '205'            => 'Rupee',
    '206'            => 'Rupee',
    '207'            => 'Rupee',
    '208'            => 'Barta',
    '209'            => 'Barta',
    '210'            => 'Barta',
    '211'            => 'Barta',
    '212'            => 'Barta',
    '213'            => 'Vize',
    '214'            => 'Vize',
    '215'            => 'Vize',
    '216'            => 'Vize',
    '217'            => 'Vize',
    '218'            => 'Anita',
    '219'            => 'Anita',
    '220'            => 'Anita',
    '221'            => 'Anita',
    '222'            => 'Anita',
    '223'            => 'Faina',
    '224'            => 'Faina',
    '225'            => 'Faina',
    '226'            => 'Faina',
    '227'            => 'Faina',
    '228'            => 'Lord Bane',
    '229'            => 'Lord Bane',
    '230'            => 'Lord Bane',
    '231'            => 'Lord Bane',
    '232'            => 'Lord Bane',
    '233'            => 'Gunarm',
    '234'            => 'Gunarm',
    '235'            => 'Gunarm',
    '236'            => 'Gunarm',
    '237'            => 'Gunarm',
    '238'            => 'Vigoro',
    '239'            => 'Vigoro',
    '240'            => 'Vigoro',
    '241'            => 'Vigoro',
    '242'            => 'Vigoro',
    '243'            => 'DeathHound',
    '244'            => 'DeathHound',
    '245'            => 'DeathHound',
    '246'            => 'DeathHound',
    '247'            => 'Youjin',
    '248'            => 'Youjin',
    '249'            => 'Boo',
    '250'            => 'Boo',
    '251'            => 'Zivilyn Bane',
    '252'            => 'Zivilyn Bane',
    '253'            => 'Frock',
    '254'            => 'Frock',
    'DC-EU-0'        => 'Ferratus',
    'DC-EU-1'        => 'Praeses',
    'DC-EU-2'        => 'Latro',
    'DC-EU-7'        => 'Venificus',
    'DC-EU-10'       => 'Dementis',
    'DC-EU-27'       => 'Oestrus',
    'DC-EU-28'       => 'Deatth',
    'DC-EU-32'       => 'Enforca',
    'DC-EU-46'       => 'Medulizk',
    'DC-EU-49'       => 'Fiendo',
    'DC-EU-60'       => 'Mereo',
    'DC-EU-62'       => 'Defensor',
    'DC-EU-72'       => 'Custos',
    'DC-EU-73'       => 'Fossor',
    'DC-EU-74'       => 'Gelu Vermis',
    'DC-EU-75'       => 'Eversor',
    'DC-EU-77'       => 'Susceptor',
    'DC-EU-91'       => 'Sentree',
    'DC-EU-93'       => 'Scarabée',
    'DC-EU-96'       => 'Ballista Rostram',
    'DC-EU-98'       => 'Monstrum',
    'DC-EU-100'      => 'Umbra',
    'DC-EU-101'      => 'Assassinata',
    'DC-EU-102'      => 'Executor',
    'DC-EU-103'      => 'Custodiae',
    'DC-EU-104'      => 'Veles',
    'DC-EU-105'      => 'Red Praeses',
    'DC-EU-106'      => 'Praeses Elite',
    'DC-EU-108'      => 'Hydra',
    'DC-EU-110'      => 'Hunta',
    'DC-EU-118'      => 'Hunta',
    'DC-EU-131'      => 'Carcer',
    'DC-EU-133'      => 'Sceptrum Praeses',
    'DC-EU-142'      => 'Dralkor Lacus',
    'DC-EU-156'      => 'Furiosus',
    'DC-US-IGN9-0'   => 'Battleship Soldier',
    'DC-US-IGN9-1'   => 'Sailor',
    'DC-US-IGN9-2'   => 'Micrastel',
    'DC-US-IGN9-7'   => 'Magic Executor',
    'DC-US-IGN9-15'  => 'Nur',
    'DC-US-IGN9-29'  => 'Elmo',
    'DC-US-IGN9-72'  => 'Guard',
    'DC-US-IGN9-96'  => 'Stonehawk',
    'DC-US-IGN9-99'  => 'Kantor',
    'DC-122'         => 'Soldier',
    'DC-EU-122'      => 'Ferratus',
    'DC-US-IGN9-129' => 'Agathamaus',
    'DC-US-IGN9-130' => 'Imagotalia',
    'DC-US-IGN9-131' => 'Warden',
    'DC-US-IGN9-133' => 'Escort Officer',
    'DC-US-IGN9-134' => 'Laas',
    'DC-158'         => 'Soldier',
    'DC-EU-158'      => 'Ferratus',
    'DC-160'         => 'Soldier',
    'DC-EU-160'      => 'Ferratus',
    'DC-162'         => 'Soldier',
    'DC-EU-162'      => 'Ferratus',
    'DC-164'         => 'Soldier',
    'DC-EU-164'      => 'Ferratus',
    'DC-166'         => 'Soldier',
    'DC-EU-166'      => 'Ferratus',
    'DC-168'         => 'Soldier',
    'DC-EU-168'      => 'Ferratus',
    'DC-170'         => 'Soldier',
    'DC-EU-170'      => 'Ferratus',
    'DC-210'         => 'Soldier',
    'DC-EU-210'      => 'Ferratus',
    'GC-EU-0'        => 'Ferratus',
    'GC-EU-1'        => 'Praeses',
    'GC-EU-2'        => 'Latro',
    'GC-EU-7'        => 'Venificus',
    'GC-EU-10'       => 'Dementis',
    'GC-EU-27'       => 'Oestrus',
    'GC-EU-28'       => 'Deatth',
    'GC-EU-32'       => 'Enforca',
    'GC-EU-46'       => 'Medulizk',
    'GC-EU-49'       => 'Fiendo',
    'GC-EU-60'       => 'Mereo',
    'GC-EU-62'       => 'Defensor',
    'GC-EU-72'       => 'Custos',
    'GC-EU-73'       => 'Fossor',
    'GC-EU-74'       => 'Gelu Vermis',
    'GC-EU-75'       => 'Eversor',
    'GC-EU-77'       => 'Susceptor',
    'GC-EU-91'       => 'Sentree',
    'GC-EU-93'       => 'Scarabée',
    'GC-EU-96'       => 'Ballista Rostram',
    'GC-EU-98'       => 'Monstrum',
    'GC-EU-100'      => 'Umbra',
    'GC-EU-101'      => 'Assassinata',
    'GC-EU-102'      => 'Executor',
    'GC-EU-103'      => 'Custodiae',
    'GC-EU-104'      => 'Veles',
    'GC-EU-105'      => 'Red Praeses',
    'GC-EU-106'      => 'Praeses Elite',
    'GC-EU-108'      => 'Hydra',
    'GC-EU-110'      => 'Hunta',
    'GC-EU-118'      => 'Hunta',
    'GC-EU-131'      => 'Carcer',
    'GC-EU-133'      => 'Sceptrum Praeses',
    'GC-EU-142'      => 'Dralkor Lacus',
    'GC-EU-156'      => 'Furiosus',
  }

#------------------------------------------------------------------------------
# Treasure Chest Locations
#------------------------------------------------------------------------------
  
  _v.treasure_chests = {
    '0'                  => 'Pirate Isle Village',
    '1'                  => 'Pirate Isle Village',
    '2'                  => 'Pirate Isle Village',
    '3'                  => 'Pirate Isle Underground',
    '4'                  => 'Pirate Isle Underground',
    '5'                  => 'Sailors‘ Island',
    '6'                  => 'Sailors‘ Island',
    '7'                  => 'Lower City',
    '8'                  => 'Lower City',
    '9'                  => 'Maramba',
    '10'                 => 'Maramba',
    '11'                 => 'Maramba',
    '12'                 => 'Maramba',
    '13'                 => 'Maramba',
    '14'                 => 'Maramba',
    '15'                 => 'Maramba',
    '16'                 => 'Horteka',
    '17'                 => 'Horteka',
    '18'                 => 'Horteka',
    '19'                 => 'Horteka',
    '20'                 => 'Nasrad',
    '21'                 => 'Deserted Island',
    '22'                 => 'Deserted Island',
    '23'                 => 'Nasrad',
    '24'                 => 'Esparanza',
    '25'                 => 'Esparanza',
    '26'                 => 'Esparanza',
    '27'                 => 'Yafutoma',
    '28'                 => 'Yafutoma',
    '29'                 => 'Great Silver Shrine',
    '30'                 => 'Great Silver Shrine',
    '31'                 => 'Great Silver Shrine',
    '32'                 => 'Great Silver Shrine',
    '33'                 => 'Delphinus',
    '34'                 => 'Valuan Battle Ship',
    '35'                 => 'Valuan Battle Ship',
    '36'                 => 'Valuan Battle Ship',
    '37'                 => 'Valuan Battle Ship',
    '38'                 => 'Shrine Island',
    '39'                 => 'Shrine Island',
    '40'                 => 'Shrine Island',
    '41'                 => 'Catacombs',
    '42'                 => 'Catacombs',
    '43'                 => 'Catacombs',
    '44'                 => 'Catacombs',
    '45'                 => 'Temple of Pyrynn',
    '46'                 => 'Temple of Pyrynn',
    '47'                 => 'Temple of Pyrynn',
    '48'                 => 'Temple of Pyrynn',
    '49'                 => 'Temple of Pyrynn',
    '50'                 => 'Temple of Pyrynn',
    '51'                 => 'Temple of Pyrynn',
    '52'                 => 'Temple of Pyrynn',
    '53'                 => 'Moonstone Mountain',
    '54'                 => 'Moonstone Mountain',
    '55'                 => 'Moonstone Mountain',
    '56'                 => 'Moonstone Mountain',
    '57'                 => 'Moonstone Mountain',
    '58'                 => 'Moonstone Mountain',
    '59'                 => 'Moonstone Mountain',
    '60'                 => 'Moonstone Mountain',
    '61'                 => 'Moonstone Mountain',
    '62'                 => 'Moonstone Mountain',
    '63'                 => 'Rixis',
    '64'                 => 'Rixis',
    '65'                 => 'Rixis',
    '66'                 => 'Rixis',
    '67'                 => 'Rixis',
    '68'                 => 'Rixis',
    '69'                 => 'Rixis',
    '70'                 => 'Rixis',
    '71'                 => 'Rixis',
    '72'                 => 'Daccat\'s Island',
    '73'                 => 'Daccat\'s Island',
    '74'                 => 'Daccat\'s Island',
    '75'                 => 'Daccat\'s Island',
    '76'                 => 'Daccat\'s Island',
    '77'                 => 'Daccat\'s Island',
    '78'                 => 'Daccat\'s Island',
    '79'                 => 'Daccat\'s Island',
    '80'                 => 'Daccat\'s Island',
    '81'                 => 'Daccat\'s Island',
    '82'                 => 'Daccat\'s Island',
    '83'                 => 'Daccat\'s Island',
    '84'                 => 'Daccat\'s Island',
    '85'                 => 'Grand Fortress',
    '86'                 => 'Grand Fortress',
    '87'                 => 'Mount Kazai',
    '88'                 => 'Mount Kazai',
    '89'                 => 'The Dark Rift',
    '90'                 => 'The Dark Rift',
    '91'                 => 'The Dark Rift',
    '92'                 => 'The Dark Rift',
    '93'                 => 'The Dark Rift',
    '94'                 => 'The Dark Rift',
    '95'                 => 'The Dark Rift',
    '96'                 => 'The Dark Rift',
    '97'                 => 'Glacia',
    '98'                 => 'Glacia',
    '99'                 => 'Glacia',
    '100'                => 'Glacia',
    '101'                => 'Glacia',
    '102'                => 'Hydra',
    '103'                => 'Dangral Island',
    '104'                => 'Dangral Island',
    '105'                => 'Dangral Island',
    '106'                => 'Hydra',
    '107'                => 'Dangral Island',
    '108'                => 'Hydra',
    '109'                => 'Hydra',
    '110'                => 'Soltis',
    '111'                => 'Soltis',
    '112'                => 'Soltis',
    '113'                => 'Maw of Tartas',
    '114'                => 'Maw of Tartas',
    '115'                => 'Catacombs',
    '116'                => 'Catacombs',
    '117'                => 'Yafutoma',
    '118'                => 'The Dark Rift',
    'DC-JP-6107110 06-5' => 'Pirate Isle Underground',
    'DC-JP-6107810-5'    => 'Pirate Isle Underground',
    'DC-US-IGN9-5'       => 'Pirate Isle Underground',
  }

end # class VOC

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
