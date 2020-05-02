#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2019 Marcel Renner
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
  _v.dup             = 'Unchanged entry #%s @ 0x%x'
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
# Common CSV headers
#------------------------------------------------------------------------------

  _v.unknown = hdr('Unk.%d')
  _v.padding = hdr('Pad.%d')
  
  _v.id             = 'Entry ID'
  _v.filter         = '[Filter]'
  _v.width          = 'Width'
  _v.depth          = 'Depth'
  _v.movement_flags = 'Movement flags'
  
  _v.message_id     = hdr('%smessage ID'        )
  _v.name_pos       = hdr('[%sentry name pos.]' )
  _v.name_size      = hdr('[%sentry name size]' )
  _v.name_str       = hdr('%sentry name'        )
  _v.dscr_pos       = hdr('[%sdescr. pos.]'     )
  _v.dscr_size      = hdr('[%sdescr. size]'     )
  _v.dscr_str       = hdr('%sdescr. str.'       )
  _v.ship_dscr_pos  = hdr('[%sship descr. pos.]')
  _v.ship_dscr_size = hdr('[%sship descr. size]')
  _v.ship_dscr_str  = hdr('%sship descr. str.'  )

#------------------------------------------------------------------------------
# Defined string
#------------------------------------------------------------------------------

  _v.string_pos      = '[Str. pos.]'
  _v.string_size     = '[Str. size]'
  _v.string_encoding = '[Str. encoding]'
  _v.string_value    = 'Str. value'
  _v.string_data     = '[Str. data]'
  _v.string_filter   = '[Str. filter]'

#------------------------------------------------------------------------------
# Character
#------------------------------------------------------------------------------

  _v.character_id    = hdr('Chara.%dID'    )
  _v.character_name  = hdr('[Chara.%dname]')
  _v.character_x     = hdr('Chara.%dX'     )
  _v.character_z     = hdr('Chara.%dZ'     )
  _v.character_opt   = hdr('[%s]'          )
  _v.character_flags = 'Chara. flags'

  _v.characters    = Hash.new('???')
  _v.characters[0] = 'Vyse'
  _v.characters[1] = 'Aika'
  _v.characters[2] = 'Fina'
  _v.characters[3] = 'Drachma'
  _v.characters[4] = 'Enrique'
  _v.characters[5] = 'Gilder'
  
  _v.weapon_id      = 'Weapon ID'
  _v.weapon_name    = '[Weapon name]'
  _v.armor_id       = 'Armor ID'
  _v.armor_name     = '[Armor name]'
  _v.accessory_id   = 'Accessory ID'
  _v.accessory_name = '[Accessory name]'

  _v.exp        = hdr('EXP%d'       )
  _v.magic_exp  = 'Magic EXP'
  _v.green_exp  = hdr('Green EXP%d' )
  _v.red_exp    = hdr('Red EXP%d'   )
  _v.purple_exp = hdr('Purple EXP%d')
  _v.blue_exp   = hdr('Blue EXP%d'  )
  _v.yellow_exp = hdr('Yellow EXP%d')
  _v.silver_exp = hdr('Silver EXP%d')

#------------------------------------------------------------------------------
# Ship
#------------------------------------------------------------------------------

  _v.ship_flags = 'Ship flags'
  _v.ships      = Hash.new('???')
  _v.ships[0]   = '[LJ0]'
  _v.ships[1]   = '[LJ1]'
  _v.ships[2]   = '[D0]'
  _v.ships[3]   = '[D1]'
  _v.ships[4]   = '[D2]'
  
  _v.ship_cannon_id      = hdr('Ship cannon%dID'    )
  _v.ship_cannon_name    = hdr('[Ship cannon%dname]')
  _v.ship_accessory_id   = hdr('Ship acc.%dID'      )
  _v.ship_accessory_name = hdr('[Ship acc.%dname]'  )

  _v.position_id   = 'Pos. ID'
  _v.position_name = '[Pos. name]'

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

  _v.enemy_id       = hdr('Enemy%dID'       )
  _v.enemy_name_jp  = hdr('[JP enemy%dname]')
  _v.enemy_name_us  = hdr('[US enemy%dname]')
  _v.enemy_name_eu  = hdr('[EU enemy%dname]')
  _v.enemy_x        = hdr('Enemy%dX'        )
  _v.enemy_z        = hdr('Enemy%dZ'        )

  _v.item_probability = hdr('Item%dprob.' )
  _v.item_amount      = hdr('Item%damount')
  _v.item_id          = hdr('Item%dID'    )
  _v.item_name        = hdr('[Item%dname]')

  _v.instr_enemy_id   = '[Enemy ID]'
  _v.instr_type_id    = 'Instr. type ID'
  _v.instr_type_name  = '[Instr. type name]'
  _v.instr_id         = 'Instr. ID'
  _v.instr_name       = '[Instr. name]'
  _v.instr_param_id   = 'Instr. param. ID'
  _v.instr_param_name = '[Instr. param. name]'

  _v.instr_types     = Hash.new('???')
  _v.instr_types[-1] = 'None'
  _v.instr_types[ 0] = 'Strategy'
  _v.instr_types[ 1] = 'Action'
  
  _v.basic_actions      = Hash.new('???')
  _v.basic_actions[550] = 'Attack'
  _v.basic_actions[551] = 'Guard'
  _v.basic_actions[552] = 'Run'
  
  _v.action_targets     = Hash.new('???')
  _v.action_targets[-1] = 'None'
  _v.action_targets[ 1] = 'Common character'
  _v.action_targets[ 2] = 'Random character'
  _v.action_targets[ 3] = 'Character with most HP'
  _v.action_targets[ 4] = 'Character with least HP'
  _v.action_targets[ 5] = 'Random enemy'
  _v.action_targets[ 6] = 'Common enemy'
  _v.action_targets[ 7] = 'Injured enemy'
  _v.action_targets[ 8] = 'Enemy with highest ID'
  _v.action_targets[11] = 'Enemy without Strengthen'
  _v.action_targets[12] = 'Injured enemy but not self'
  _v.action_targets[13] = 'Character without Stone'
  _v.action_targets[14] = 'Character without Confusion'
  _v.action_targets[15] = 'Character without Silence'
  _v.action_targets[16] = 'Character without Sleep'
  _v.action_targets[17] = 'Character without Weak'
  _v.action_targets[18] = 'Character without Fatigue'
  _v.action_targets[19] = 'Character without Poison'
  _v.action_targets[20] = 'Character with highest Will'
  _v.action_targets[21] = 'Character with highest Attack'
  _v.action_targets[22] = 'Self as target'
  _v.action_targets[23] = "#{_v.characters[1]} as target"
  
#------------------------------------------------------------------------------
# Enemy ship
#------------------------------------------------------------------------------

  _v.enemy_ship_id   = '[Enemy ship ID]'
  _v.enemy_ship_name = '[Enemy ship name]'

  _v.arm_name_eu = hdr('EU arm.%dname')
  _v.arm_name_jp = hdr('JP arm.%dname')
  _v.arm_name_us = hdr('US arm.%dname')

  _v.arm_name_de_pos  = hdr('[DE arm.%dname pos.]')
  _v.arm_name_de_size = hdr('[DE arm.%dname size]')
  _v.arm_name_de_str  = hdr('DE arm.%dname str.'  )
  _v.arm_name_es_pos  = hdr('[ES arm.%dname pos.]')
  _v.arm_name_es_size = hdr('[ES arm.%dname size]')
  _v.arm_name_es_str  = hdr('ES arm.%dname str.'  )
  _v.arm_name_fr_pos  = hdr('[FR arm.%dname pos.]')
  _v.arm_name_fr_size = hdr('[FR arm.%dname size]')
  _v.arm_name_fr_str  = hdr('FR arm.%dname str.'  )
  _v.arm_name_gb_pos  = hdr('[GB arm.%dname pos.]')
  _v.arm_name_gb_size = hdr('[GB arm.%dname size]')
  _v.arm_name_gb_str  = hdr('GB arm.%dname str.'  )

  _v.arm_attack       = hdr('Arm.%dattack'        )
  _v.arm_type_id      = hdr('Arm.%dtype ID'       )
  _v.arm_type_name    = hdr('[Arm.%dtype name]'   )
  _v.arm_hit          = hdr('Arm.%dhit%%'         )
  _v.arm_range        = hdr('Arm.%drange'         )
  _v.arm_element_id   = hdr('Arm.%delement ID'    )
  _v.arm_element_name = hdr('[Arm.%delement name]')

  _v.item_drop_id   = hdr('Item drop%dID'    )
  _v.item_drop_name = hdr('[Item drop%dname]')

  _v.drops     = Hash.new('???')
  _v.drops[-1] = 'None'
  _v.drops[ 0] = '100%'
  _v.drops[ 2] = '10%'
  _v.drops[ 3] = '20%'
  _v.drops[ 4] = '50%'
  _v.drops[ 6] = 'Osman'
  _v.drops[ 7] = 'Kalifa'

  _v.task_cond_id      = 'Task cond. ID'
  _v.task_cond_name    = 'Task cond. name'
  _v.task_rating       = 'Task rating'
  _v.task_a_type_id    = 'Task A type ID'
  _v.task_a_type_name  = '[Task A type name]'
  _v.task_a_arm_id     = 'Task A arm. ID'
  _v.task_a_arm_name   = '[Task A arm. name]'
  _v.task_a_param_id   = 'Task A param. ID'
  _v.task_a_param_name = '[Task A param. name]'
  _v.task_a_range      = 'Task A arm. range'
  _v.task_b_type_id    = 'Task B type ID'
  _v.task_b_type_name  = '[Task B type name]'
  _v.task_b_arm_id     = 'Task B arm. ID'
  _v.task_b_arm_name   = '[Task B arm. name]'
  _v.task_b_param_id   = 'Task B param. ID'
  _v.task_b_param_name = '[Task B param. name]'
  _v.task_b_range      = 'Task B arm. range'
  
  _v.task_types     = Hash.new('???')
  _v.task_types[-1] = 'None'
  _v.task_types[ 0] = 'Attack'
  _v.task_types[ 1] = 'Magic'
  _v.task_types[ 2] = 'Focus'
  _v.task_types[ 3] = 'Guard'
  _v.task_types[ 4] = 'Nothing'

  _v.focus_tasks     = Hash.new('???')
  _v.focus_tasks[-1] = 'None'
  _v.focus_tasks[ 0] = 'Focus'
  _v.focus_tasks[ 1] = 'Taking Aim'
  _v.focus_tasks[ 2] = 'Preparing Attack'
  _v.focus_tasks[34] = 'Preparing Attack'

  _v.guard_tasks     = Hash.new('???')
  _v.guard_tasks[-1] = 'None'
  _v.guard_tasks[ 0] = 'Evasive Action'

  _v.nothing_tasks     = Hash.new('???')
  _v.nothing_tasks[-1] = 'None'
  _v.nothing_tasks[ 0] = 'Awaiting Orders'
  _v.nothing_tasks[ 1] = 'Target Lost'
  _v.nothing_tasks[ 2] = 'Assessing Damage'
  _v.nothing_tasks[ 3] = 'Hull Ram'
  _v.nothing_tasks[ 4] = 'Red Ray'
  _v.nothing_tasks[ 5] = 'Fist of Grendel'
  _v.nothing_tasks[ 6] = 'Boulder Throw'
  _v.nothing_tasks[ 7] = 'Stomp'
  _v.nothing_tasks[ 8] = 'Flee'
  
#------------------------------------------------------------------------------
# Battle
#------------------------------------------------------------------------------

  _v.party_vigor = 'Party vigor'
  _v.bgm_id      = 'BGM ID'
    
  _v.defeat_cond_id   = 'Defeat cond. ID'
  _v.defeat_cond_name = '[Defeat cond. name]'
  _v.escape_cond_id   = 'Escape cond. ID'
  _v.escape_cond_name = '[Escape cond. name]'

  _v.defeats    = Hash.new('???')
  _v.defeats[0] = 'Must not lose'
  _v.defeats[1] = 'May try again'
  _v.defeats[2] = 'May lose'
  
  _v.escapes    = Hash.new('???')
  _v.escapes[0] = 'Can escape'
  _v.escapes[1] = 'Cannot escape'

#------------------------------------------------------------------------------
# Menu
#------------------------------------------------------------------------------

  _v.occasion_flags  = 'Occ. flags'
  _v.occasion_menu   = '[Menu]'
  _v.occasion_battle = '[Battle]'
  _v.occasion_ship   = '[Ship battle]'

  _v.occasions    = Hash.new('???')
  _v.occasions[0] = _v.occasion_menu
  _v.occasions[1] = _v.occasion_battle
  _v.occasions[2] = _v.occasion_ship

  _v.order_alphabet    = hdr('%sorder by ABC')
  _v.order_priority    = 'Order by prio.'

  _v.retail_price   = 'Retail price in %'
  _v.purchase_price = 'Purchase price'

  _v.age                 = 'Age'
  _v.agile               = 'Agile'
  _v.attack              = 'Attack'
  _v.base_hp_increase    = 'Base MAXHP increase'
  _v.base_mp_increase    = 'Base MAXMP increase'
  _v.base_quick_increase = 'Base quick increase'
  _v.base_power_increase = 'Base power increase'
  _v.base_vigor_increase = 'Base vigor increase'
  _v.base_will_increase  = 'Base will increase'
  _v.consume             = 'Consume%'
  _v.counter             = 'Counter%'
  _v.defense             = 'Defense'
  _v.dodge               = 'Dodge%'
  _v.gold                = 'Gold'
  _v.hit                 = 'Hit%'
  _v.hp                  = 'HP'
  _v.level               = 'Level'
  _v.limit               = 'Limit'
  _v.magdef              = 'MagDef'
  _v.maxhp               = 'MAXHP'
  _v.maxmp               = 'MAXMP'
  _v.maxspirit           = hdr('MAXSpirit%d')
  _v.power               = 'Power'
  _v.quick               = 'Quick'
  _v.spirit              = hdr('Spirit%d'   )
  _v.value               = 'Value'
  _v.vigor               = 'Vigor'
  _v.will                = 'Will'

  _v.feature_id    = hdr('Feat.%dID'    )
  _v.feature_name  = hdr('[Feat.%dname]')
  _v.feature_value = hdr('Feat.%dvalue' )

  _v.accessory_features     = Hash.new('???')
  _v.accessory_features[-1] = 'None'
  _v.accessory_features[ 1] = 'Will'
  _v.accessory_features[ 4] = 'Quick'
  _v.accessory_features[16] = 'Attack'
  _v.accessory_features[17] = 'Defense'
  _v.accessory_features[18] = 'MagDef'
  _v.accessory_features[19] = 'Hit%'
  _v.accessory_features[20] = 'Dodge%'
  _v.accessory_features[32] = 'Green'
  _v.accessory_features[33] = 'Red'
  _v.accessory_features[34] = 'Purple'
  _v.accessory_features[35] = 'Blue'
  _v.accessory_features[36] = 'Yellow'
  _v.accessory_features[37] = 'Silver'
  _v.accessory_features[48] = 'Poison'
  _v.accessory_features[49] = 'Unconscious'
  _v.accessory_features[50] = 'Stone'
  _v.accessory_features[51] = 'Sleep'
  _v.accessory_features[52] = 'Confuse'
  _v.accessory_features[53] = 'Silence'
  _v.accessory_features[54] = 'Fatigue'
  _v.accessory_features[55] = 'Revival'
  _v.accessory_features[56] = 'Weak'
  _v.accessory_features[57] = 'State #9'
  _v.accessory_features[58] = 'State #10'
  _v.accessory_features[59] = 'State #11'
  _v.accessory_features[60] = 'State #12'
  _v.accessory_features[61] = 'State #13'
  _v.accessory_features[62] = 'State #14'
  _v.accessory_features[63] = 'State #15'
  _v.accessory_features[64] = 'Block magic'
  _v.accessory_features[65] = 'Block attack'
  _v.accessory_features[68] = 'Reduce spirit'
  _v.accessory_features[73] = 'Counter%'
  _v.accessory_features[77] = 'Recover spirit'
  _v.accessory_features[78] = 'Add Regenerate'
  _v.accessory_features[79] = 'Block negative states'
  _v.accessory_features[80] = 'First strike%'
  _v.accessory_features[81] = 'Run%'
  _v.accessory_features[83] = 'Enemy run%'
  _v.accessory_features[84] = 'Random encounter%'
  
  _v.ship_accessory_features     = Hash.new('???')
  _v.ship_accessory_features[-1] = 'None'
  _v.ship_accessory_features[ 2] = 'Defense'
  _v.ship_accessory_features[ 3] = 'MagDef'
  _v.ship_accessory_features[ 4] = 'Quick'
  _v.ship_accessory_features[ 6] = 'Dodge%'
  _v.ship_accessory_features[ 7] = 'Value'
  _v.ship_accessory_features[48] = 'Main cannon attack'
  _v.ship_accessory_features[64] = 'Secondary cannon attack'
  _v.ship_accessory_features[81] = 'Torpedo hit%'
  _v.ship_accessory_features[96] = 'Special attack'

  _v.ship_cannon_types     = Hash.new('???')
  _v.ship_cannon_types[-1] = 'None'
  _v.ship_cannon_types[ 0] = 'Main cannon'
  _v.ship_cannon_types[ 1] = 'Secondary cannon'
  _v.ship_cannon_types[ 2] = 'Torpedo'
  _v.ship_cannon_types[ 3] = 'Special'

#------------------------------------------------------------------------------
# Effects
#------------------------------------------------------------------------------

  _v.category_id   = 'Category ID'
  _v.category_name = '[Category name]'
  
  _v.character_skill_categories    = Hash.new('???')
  _v.character_skill_categories[0] = _v.characters[0]
  _v.character_skill_categories[1] = _v.characters[1]
  _v.character_skill_categories[2] = _v.characters[2]
  _v.character_skill_categories[3] = _v.characters[3]
  _v.character_skill_categories[4] = _v.characters[4]
  _v.character_skill_categories[5] = _v.characters[5]
  _v.character_skill_categories[6] = 'Magic'
  
  _v.enemy_skill_categories    = Hash.new('???')
  _v.enemy_skill_categories[0] = 'Super Move'
  _v.enemy_skill_categories[1] = 'Magic'

  _v.element_id   = 'Element ID'
  _v.element_name = '[Element name]'
  
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
  _v.state_name = '[State name]'
  _v.state_miss = 'State miss%'
  
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
  _v.states[ 9] = 'State #9'
  _v.states[10] = 'State #10'
  _v.states[11] = 'State #11'
  _v.states[12] = 'State #12'
  _v.states[13] = 'State #13'
  _v.states[14] = 'State #14'
  _v.states[15] = 'State #15'

  _v.type_id   = 'Type ID'
  _v.type_name = '[Type name]'
  
  _v.types     = Hash.new('???')
  _v.types[-1] = 'None'
  _v.types[ 0] = 'Physical'
  _v.types[ 1] = 'Magical'

  _v.ship_occasion_id   = 'Ship occ. ID'
  _v.ship_occasion_name = '[Ship occ. name]'
  
  _v.ship_occasions     = Hash.new('???')
  _v.ship_occasions[-1] = 'Never'
  _v.ship_occasions[ 0] = 'Magic Cannon'
  _v.ship_occasions[ 1] = 'Always'

  _v.scope_id   = 'Scope ID'
  _v.scope_name = '[Scope name]'

  _v.scopes      = Hash.new('???')
  _v.scopes[  0] = 'None'
  _v.scopes[  1] = 'One character'
  _v.scopes[  2] = 'All characters'
  _v.scopes[  3] = 'One enemy'
  _v.scopes[  4] = 'All enemies'
  _v.scopes[  5] = 'User'
  _v.scopes[  6] = 'All characters and enemies'
  _v.scopes[ 32] = 'Enemy area #0'
  _v.scopes[ 33] = 'Enemy area #1'
  _v.scopes[ 34] = 'Enemy area #2'
  _v.scopes[ 35] = 'Enemy area #3'
  _v.scopes[ 36] = 'Enemy line #0'
  _v.scopes[ 37] = 'Enemy line #1'
  _v.scopes[ 38] = 'Enemy line #2'
  _v.scopes[ 39] = 'Enemy line #3'
  _v.scopes[ 43] = 'Enemy line #4'
  _v.scopes[ 96] = 'Character area #0'
  _v.scopes[ 97] = 'Character area #1'
  _v.scopes[ 98] = 'Character area #2'
  _v.scopes[100] = 'Character line #0'
  _v.scopes[101] = 'Character line #1'
  _v.scopes[102] = 'Character line #2'
  _v.scopes[103] = 'Character line #3'
  _v.scopes[107] = 'Character line #4'
  _v.scopes[200] = 'Characters nearby #0'
  _v.scopes[201] = 'Characters nearby #1'
    
  _v.effect_id       = 'Effect ID'
  _v.effect_name     = '[Effect name]'
  _v.effect_spirit   = 'Effect spirit'
  _v.effect_value    = hdr('Effect value%d')
  _v.effect_priority = 'Effect priority'

  _v.ship_effect_id     = 'Ship effect ID'
  _v.ship_effect_name   = '[Ship effect name]'
  _v.ship_effect_spirit = 'Ship effect spirit'
  _v.ship_effect_turns  = 'Ship effect turns'
  _v.ship_effect_value  = 'Ship effect amount'

  _v.effects      = Hash.new('???')
  _v.effects[ -1] = 'None'
  _v.effects[  0] = 'Damage'
  _v.effects[  1] = 'Guard'
  _v.effects[  4] = 'Add Poison + Damage'
  _v.effects[  5] = 'Add Unconscious'
  _v.effects[  6] = 'Add Unconscious + Damage #1'
  _v.effects[  7] = 'Add Stone'
  _v.effects[  8] = 'Add Stone + Damage'
  _v.effects[  9] = 'Add Sleep'
  _v.effects[ 11] = 'Add Confusion'
  _v.effects[ 12] = 'Add Silence'
  _v.effects[ 16] = 'Add Weak'
  _v.effects[ 17] = 'Remove positive states'
  _v.effects[ 20] = 'Add Quickened'
  _v.effects[ 21] = 'Add Strengthen'
  _v.effects[ 26] = 'Add Weak'
  _v.effects[ 27] = 'Revive with 50% of HP'
  _v.effects[ 28] = 'Revive with 100% of HP'
  _v.effects[ 30] = 'Remove negative states'
  _v.effects[ 31] = 'Recover HP'
  _v.effects[ 32] = 'Recover HP to 100%'
  _v.effects[ 33] = 'Add Regenerate'
  _v.effects[ 35] = 'Recover SP'
  _v.effects[ 38] = 'Counter attack + Guard'
  _v.effects[ 39] = 'Block magic'
  _v.effects[ 41] = 'Guard + Increase Spirit restoration to 200%'
  _v.effects[ 42] = 'Block negative states'
  _v.effects[ 43] = 'Call enemy'
  _v.effects[ 44] = 'Absorb HP'
  _v.effects[ 46] = 'Block attack + Counter attack'
  _v.effects[ 47] = 'Recover HP and MP + Remove negative states'
  _v.effects[ 48] = 'Recover MP'
  _v.effects[ 49] = 'Recover MP to 100%'
  _v.effects[ 51] = 'Recover HP and MP'
  _v.effects[ 52] = 'Moonberry'
  _v.effects[ 53] = 'Evolve Cupil with Cham'
  _v.effects[ 54] = 'Increase Power'
  _v.effects[ 55] = 'Increase Will'
  _v.effects[ 56] = 'Increase Vigor'
  _v.effects[ 57] = 'Increase Agile'
  _v.effects[ 58] = 'Increase Quick'
  _v.effects[ 59] = 'Increase MAXHP'
  _v.effects[ 60] = 'Increase MAXMP'
  _v.effects[ 62] = 'Damage + Defeat user'
  _v.effects[ 63] = 'Add Regenerate + Add Sleep'
  _v.effects[ 64] = 'Call enemy + Defeat all enemies'
  _v.effects[ 65] = 'Prophecy'
  _v.effects[ 66] = 'Blue Rogues'
  _v.effects[ 67] = 'Invulnerable'
  _v.effects[ 68] = 'Add Unconscious + Damage #2'
  _v.effects[ 69] = 'Add Sleep + Damage'
  _v.effects[ 70] = 'Add Confusion + Damage'
  _v.effects[ 71] = 'Add Silence + Damage'
  _v.effects[ 72] = 'Add Fatigue + Damage'
  _v.effects[ 73] = 'Add Weak + Damage'
  _v.effects[ 74] = 'Control ally'
  _v.effects[ 75] = 'Evolve Cupil with Abirik Cham'
  _v.effects[ 76] = 'Reset Cupil'
  _v.effects[ 77] = 'Invulnerable + Recover MP'
  _v.effects[ 78] = 'Add Quickened + Add Regenerate + Add Strengthen'
  _v.effects[100] = 'Recover HP (Ship)'
  _v.effects[101] = 'Recover HP to 100% (Ship)'
  _v.effects[102] = 'Recover Spirit (Ship)'
  _v.effects[103] = 'Recover Spirit to 100% (Ship)'
  _v.effects[104] = 'Add Quickened (Ship)'
  _v.effects[105] = 'Add Strengthen (Ship)'
  _v.effects[106] = 'Add Weak (Ship)'
  _v.effects[107] = 'Damage (Ship)'
  _v.effects[108] = 'Improve parameters (Ship)'
  _v.effects[109] = 'Block artillery (Ship)'
  _v.effects[110] = 'Block magic (Ship)'
  _v.effects[111] = 'Improve First strike% (Ship)'
  _v.effects[112] = 'Improve Critical% (Ship)'
  _v.effects[113] = 'Decrease Spirit consumption to 50% (Ship)'
  _v.effects[114] = 'Increase Spirit restoration to 200% (Ship)'
  _v.effects[115] = 'Captain\'s Stripe'
  _v.effects[116] = 'Add Silence (Ship)'
  _v.effects[117] = 'Recover MP (Ship)'
  _v.effects[255] = 'None'

  _v.weapon_effects     = Hash.new('???')
  _v.weapon_effects[-1] = 'None'
  _v.weapon_effects[ 0] = 'Add Poison'
  _v.weapon_effects[ 1] = 'Add Sleep #1'
  _v.weapon_effects[ 2] = 'Add Weak'
  _v.weapon_effects[ 3] = 'Add Confusion #1'
  _v.weapon_effects[ 4] = 'Add Sleep #2'
  _v.weapon_effects[ 5] = 'Add Confusion #2'
  _v.weapon_effects[ 6] = 'Add Death #1'
  _v.weapon_effects[ 7] = 'Add Silence #1'
  _v.weapon_effects[ 8] = 'Add Stone #1'
  _v.weapon_effects[ 9] = 'Add Sleep #3'
  _v.weapon_effects[10] = 'Add Death #2'
  _v.weapon_effects[11] = 'Add Confusion #3'
  _v.weapon_effects[12] = 'Add Silence #2'
  _v.weapon_effects[13] = 'Add Stone #2'
  _v.weapon_effects[14] = 'Add Confusion #4'
  _v.weapon_effects[15] = 'Add Sleep #4'
  _v.weapon_effects[16] = 'Add Death #3'
  _v.weapon_effects[17] = 'Add Sleep #5'
  
#------------------------------------------------------------------------------
# Enemy names
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
    '18'             => 'Thorkyn',
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
    '33'             => 'Serpentis',
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
    '74'             => 'Forst Worm',
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
    '134'            => 'Rockwyrm',
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
    'EU-0'           => 'Ferratus',
    'EU-1'           => 'Praeses',
    'EU-2'           => 'Latro',
    'EU-7'           => 'Venificus',
    'EU-10'          => 'Dementis',
    'EU-27'          => 'Oestrus',
    'EU-28'          => 'Deatth',
    'EU-32'          => 'Enforca',
    'EU-33'          => 'Serpantis',
    'EU-46'          => 'Medullizk',
    'EU-49'          => 'Fiendo',
    'EU-60'          => 'Mereo',
    'EU-62'          => 'Defensor',
    'EU-72'          => 'Custos',
    'EU-73'          => 'Fossor',
    'EU-74'          => 'Gelu Vermis',
    'EU-75'          => 'Eversor',
    'EU-77'          => 'Susceptor',
    'EU-91'          => 'Sentree',
    'EU-93'          => 'Scarabée',
    'EU-98'          => 'Monstrum',
    'EU-100'         => 'Umbra',
    'EU-101'         => 'Assassinata',
    'EU-102'         => 'Executor',
    'EU-103'         => 'Custodiae',
    'EU-104'         => 'Veles',
    'EU-105'         => 'Red Praeses',
    'EU-106'         => 'Praeses Elite',
    'EU-108'         => 'Hydra',
    'EU-110'         => 'Hunta',
    'EU-118'         => 'Hunta',
    'EU-131'         => 'Carcer',
    'EU-133'         => 'Sceptrum Praeses',
    'EU-142'         => 'Dralkor Lacus',
    'EU-156'         => 'Furiosus',
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
  }

end # class VOC

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
