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

# Class to handle translations and vocabulary.
VOC.configure do |_v|
  
#------------------------------------------------------------------------------
# CLI
#------------------------------------------------------------------------------

  _v.bnr_devel  = 'Developer'
  _v.bnr_title  = 'Game title'
  _v.check_bnr  = 'Check BNR file: %s'
  _v.check_dir  = 'Check for existing directory: %s'
  _v.check_file = 'Check for existing file: %s'
  _v.check_hdr  = 'Check HDR file: %s'
  _v.close      = 'File "%s" has been closed.'
  _v.exists     = 'exists'
  _v.hdr_game   = 'Game ID'
  _v.hdr_maker  = 'Maker ID'
  _v.hdr_name   = 'Name'
  _v.hdr_region = 'Region ID'
  _v.incorrect  = 'incorrect'
  _v.not_found  = 'not found'
  _v.open       = 'Opening file "%s" to %s %s...'
  _v.open_data  = 'data'
  _v.open_dscr  = 'descriptions'
  _v.open_name  = 'names'
  _v.open_read  = 'read'
  _v.open_write = 'write'
  _v.read       = 'Reading entry #%s @ %#x...'
  _v.valid      = 'valid'
  _v.write      = 'Writing entry #%s @ %#x...'

#------------------------------------------------------------------------------
# Common CSV headers
#------------------------------------------------------------------------------

  _v.unknown = _v.create_hdr('Unknown%d')
  _v.padding = _v.create_hdr('Padding%d')
  
  _v.id             = 'Entry ID'
  _v.filter         = '[Filter]'
  _v.width          = 'Width'
  _v.depth          = 'Depth'
  _v.movement_flags = 'Movement flags'
  
  _v.message_id     = _v.create_hdr('%smessage ID'        )
  _v.name_size      = _v.create_hdr('[%sentry name size]' )
  _v.name_pos       = _v.create_hdr('[%sentry name pos.]' )
  _v.name_str       = _v.create_hdr('%sentry name'        )
  _v.dscr_size      = _v.create_hdr('[%sdescr. size]'     )
  _v.dscr_pos       = _v.create_hdr('[%sdescr. pos.]'     )
  _v.dscr_str       = _v.create_hdr('%sdescr. str.'       )
  _v.ship_dscr_size = _v.create_hdr('[%sship descr. size]')
  _v.ship_dscr_pos  = _v.create_hdr('[%sship descr. pos.]')
  _v.ship_dscr_str  = _v.create_hdr('%sship descr. str.'  )

#------------------------------------------------------------------------------
# Character
#------------------------------------------------------------------------------

  _v.character_id    = _v.create_hdr('Chara.%dID'    )
  _v.character_name  = _v.create_hdr('[Chara.%dname]')
  _v.character_x     = _v.create_hdr('Chara.%dX'     )
  _v.character_y     = _v.create_hdr('Chara.%dY'     )
  _v.character_opt   = _v.create_hdr('[%s]'          )
  _v.character_flags = 'Chara. flags'

  _v.characters    = Hash.new('???')
  _v.characters[0] = 'Vyse'
  _v.characters[1] = 'Aika'
  _v.characters[2] = 'Fina'
  _v.characters[3] = 'Drachma'
  _v.characters[4] = 'Enrique'
  _v.characters[5] = 'Gilder'
  
  _v.weapon_id         = 'Weapon ID'
  _v.weapon_name       = '[Weapon name]'
  _v.armor_id          = 'Armor ID'
  _v.armor_name        = '[Armor name]'
  _v.accessory_id      = 'Accessory ID'
  _v.accessory_name    = '[Accessory name]'

  _v.exp        = _v.create_hdr('EXP%d'       )
  _v.megic_exp  = 'Magic EXP'
  _v.green_exp  = _v.create_hdr('Green EXP%d' )
  _v.red_exp    = _v.create_hdr('Red EXP%d'   )
  _v.purple_exp = _v.create_hdr('Purple EXP%d')
  _v.blue_exp   = _v.create_hdr('Blue EXP%d'  )
  _v.yellow_exp = _v.create_hdr('Yellow EXP%d')
  _v.silver_exp = _v.create_hdr('Silver EXP%d')

#------------------------------------------------------------------------------
# Ship
#------------------------------------------------------------------------------

  _v.ship_flags      = 'Ship flags'
  _v.ship_littlejack = _v.create_hdr('[Little Jack%d]')
  _v.ship_delphinus  = _v.create_hdr('[Delphinus%d]'  )

  _v.ships    = Hash.new('???')
  _v.ships[0] = _v.ship_littlejack[1]
  _v.ships[1] = _v.ship_littlejack[2]
  _v.ships[2] = _v.ship_delphinus[1]
  _v.ships[3] = _v.ship_delphinus[2]
  _v.ships[4] = _v.ship_delphinus[3]
  
  _v.ship_cannon_id      = _v.create_hdr('Ship cannon%dID'    )
  _v.ship_cannon_name    = _v.create_hdr('[Ship cannon%dname]')
  _v.ship_accessory_id   = _v.create_hdr('Ship acc.%dID'      )
  _v.ship_accessory_name = _v.create_hdr('[Ship acc.%dname]'  )

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

  _v.enemy_id       = _v.create_hdr('Enemy%dID'       )
  _v.enemy_name_jp  = _v.create_hdr('[JP enemy%dname]')
  _v.enemy_name_us  = _v.create_hdr('[US enemy%dname]')
  _v.enemy_name_eu  = _v.create_hdr('[EU enemy%dname]')
  _v.enemy_x        = _v.create_hdr('Enemy%dX'        )
  _v.enemy_y        = _v.create_hdr('Enemy%dY'        )

  _v.item_probability = _v.create_hdr('Item%dprob.' )
  _v.item_amount      = _v.create_hdr('Item%damount')
  _v.item_id          = _v.create_hdr('Item%dID'    )
  _v.item_name        = _v.create_hdr('[Item%dname]')

  _v.instr_type_id    = _v.create_hdr('Instr.%dtype ID'      )
  _v.instr_type_name  = _v.create_hdr('[Instr.%dtype name]'  )
  _v.instr_id         = _v.create_hdr('Instr.%dID'           )
  _v.instr_name       = _v.create_hdr('[Instr.%dname]'       )
  _v.instr_param_id   = _v.create_hdr('Instr.%dparam. ID'    )
  _v.instr_param_name = _v.create_hdr('[Instr.%dparam. name]')

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

  _v.arm_name_eu = _v.create_hdr('EU arm.%dname')
  _v.arm_name_jp = _v.create_hdr('JP arm.%dname')
  _v.arm_name_us = _v.create_hdr('US arm.%dname')

  _v.arm_name_de_pos  = _v.create_hdr('[DE arm.%dname pos.]')
  _v.arm_name_de_size = _v.create_hdr('[DE arm.%dname size]')
  _v.arm_name_de_str  = _v.create_hdr('DE arm.%dname str.'  )
  _v.arm_name_es_pos  = _v.create_hdr('[ES arm.%dname pos.]')
  _v.arm_name_es_size = _v.create_hdr('[ES arm.%dname size]')
  _v.arm_name_es_str  = _v.create_hdr('ES arm.%dname str.'  )
  _v.arm_name_fr_pos  = _v.create_hdr('[FR arm.%dname pos.]')
  _v.arm_name_fr_size = _v.create_hdr('[FR arm.%dname size]')
  _v.arm_name_fr_str  = _v.create_hdr('FR arm.%dname str.'  )
  _v.arm_name_gb_pos  = _v.create_hdr('[GB arm.%dname pos.]')
  _v.arm_name_gb_size = _v.create_hdr('[GB arm.%dname size]')
  _v.arm_name_gb_str  = _v.create_hdr('GB arm.%dname str.'  )

  _v.arm_attack       = _v.create_hdr('Arm.%dattack'        )
  _v.arm_type_id      = _v.create_hdr('Arm.%dtype ID'       )
  _v.arm_type_name    = _v.create_hdr('[Arm.%dtype name]'   )
  _v.arm_hit          = _v.create_hdr('Arm.%dhit%'          )
  _v.arm_range        = _v.create_hdr('Arm.%drange'         )
  _v.arm_element_id   = _v.create_hdr('Arm.%delement ID'    )
  _v.arm_element_name = _v.create_hdr('[Arm.%delement name]')

  _v.item_drop_id   = _v.create_hdr('Item drop%dID'    )
  _v.item_drop_name = _v.create_hdr('[Item drop%dname]')

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

  _v.order_alphabet    = _v.create_hdr('%sorder by ABC')
  _v.order_priority    = 'Order by prio.'

  _v.retail_price   = 'Retail price in %'
  _v.purchase_price = 'Purchase price'

  _v.age              = 'Age'
  _v.agile            = 'Agile'
  _v.attack           = 'Attack'
  _v.base_hp_increase = 'Base MAXHP increase'
  _v.consume          = 'Consume%'
  _v.counter          = 'Counter%'
  _v.defense          = 'Defense'
  _v.dodge            = 'Dodge%'
  _v.gold             = 'Gold'
  _v.hit              = 'Hit%'
  _v.hp               = 'HP'
  _v.level            = 'Level'
  _v.limit            = 'Limit'
  _v.magdef           = 'MagDef'
  _v.maxhp            = 'MAXHP'
  _v.maxmp            = 'MAXMP'
  _v.maxspirit        = _v.create_hdr('MAXSpirit%d')
  _v.power            = 'Power'
  _v.quick            = 'Quick'
  _v.spirit           = _v.create_hdr('Spirit%d'   )
  _v.value            = 'Value'
  _v.vigor            = 'Vigor'
  _v.will             = 'Will'

  _v.feature_id    = _v.create_hdr('Feature%dID'    )
  _v.feature_name  = _v.create_hdr('[Feature%dname]')
  _v.feature_value = _v.create_hdr('Feature%dvalue' )

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
  _v.accessory_features[49] = 'Death'
  _v.accessory_features[50] = 'Stone'
  _v.accessory_features[51] = 'Sleep'
  _v.accessory_features[52] = 'Confuse'
  _v.accessory_features[53] = 'Silence'
  _v.accessory_features[54] = 'Fatigue'
  _v.accessory_features[56] = 'Weak'
  _v.accessory_features[65] = 'Block attacks'
  _v.accessory_features[68] = 'Reduce spirit'
  _v.accessory_features[73] = 'Counter%'
  _v.accessory_features[77] = 'Recover spirit'
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
  _v.ship_accessory_features[48] = 'Attack: Main cannon'
  _v.ship_accessory_features[64] = 'Attack: Secondary cannon'
  _v.ship_accessory_features[81] = 'Hit%: Torpedo'
  _v.ship_accessory_features[96] = 'Attack: S-Cannon'

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
  _v.state_hit  = 'State hit%'
  
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
  _v.scopes[ 32] = 'Enemy area #1'
  _v.scopes[ 33] = 'Enemy area #2'
  _v.scopes[ 34] = 'Enemy area #3'
  _v.scopes[ 36] = 'Enemy line #1'
  _v.scopes[ 37] = 'Enemy line #2'
  _v.scopes[ 38] = 'Enemy line #3'
  _v.scopes[ 39] = 'Enemy line #4'
  _v.scopes[ 43] = 'Enemy line #5'
  _v.scopes[ 96] = 'Character area #1'
  _v.scopes[ 97] = 'Character area #2'
  _v.scopes[ 98] = 'Character area #3'
  _v.scopes[100] = 'Character line #1'
  _v.scopes[101] = 'Character line #2'
  _v.scopes[102] = 'Character line #3'
  _v.scopes[103] = 'Character line #4'
  _v.scopes[107] = 'Character line #5'
  _v.scopes[200] = 'Characters nearby #1'
  _v.scopes[201] = 'Characters nearby #2'
    
  _v.effect_id       = 'Effect ID'
  _v.effect_name     = '[Effect name]'
  _v.effect_spirit   = 'Effect spirit'
  _v.effect_value    = _v.create_hdr('Effect value%d')
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
# Enemy EU names
#------------------------------------------------------------------------------

  _v.enemies_eu      = Hash.new('???')
  _v.enemies_eu[  0] = 'Ferratus'
  _v.enemies_eu[  1] = 'Praeses'
  _v.enemies_eu[  2] = 'Latro'
  _v.enemies_eu[  3] = 'Marocca'
  _v.enemies_eu[  4] = 'Grouder'
  _v.enemies_eu[  7] = 'Venificus'
  _v.enemies_eu[  8] = 'Flestik'
  _v.enemies_eu[  9] = 'Basallish'
  _v.enemies_eu[ 10] = 'Dementis'
  _v.enemies_eu[ 11] = 'Walrenk'
  _v.enemies_eu[ 12] = 'Varkris'
  _v.enemies_eu[ 13] = 'Azbeth'
  _v.enemies_eu[ 14] = 'Zivilyn Bane'
  _v.enemies_eu[ 15] = 'Ghastling'
  _v.enemies_eu[ 16] = 'Florast'
  _v.enemies_eu[ 17] = 'Tsirat'
  _v.enemies_eu[ 18] = 'Thorkyn'
  _v.enemies_eu[ 19] = 'Scorfly'
  _v.enemies_eu[ 20] = 'Centralk'
  _v.enemies_eu[ 21] = 'Feralisk'
  _v.enemies_eu[ 22] = 'Ferlith'
  _v.enemies_eu[ 23] = 'Crylhound'
  _v.enemies_eu[ 24] = 'Magma Tiki'
  _v.enemies_eu[ 25] = 'Salamander'
  _v.enemies_eu[ 26] = 'Baroo'
  _v.enemies_eu[ 27] = 'Oestrus'
  _v.enemies_eu[ 28] = 'Deatth'
  _v.enemies_eu[ 29] = 'Looper'
  _v.enemies_eu[ 30] = 'Loopalon'
  _v.enemies_eu[ 31] = 'Tsurak'
  _v.enemies_eu[ 32] = 'Enforca'
  _v.enemies_eu[ 33] = 'Serpantis'
  _v.enemies_eu[ 34] = 'Dralnog'
  _v.enemies_eu[ 35] = 'Que\'lak'
  _v.enemies_eu[ 36] = 'Pinalisk'
  _v.enemies_eu[ 37] = 'Crylbeast'
  _v.enemies_eu[ 38] = 'Slothstra'
  _v.enemies_eu[ 39] = 'Polraxis'
  _v.enemies_eu[ 40] = 'Roseln'
  _v.enemies_eu[ 41] = 'Elooper'
  _v.enemies_eu[ 42] = 'Grapor'
  _v.enemies_eu[ 43] = 'Sphyrus'
  _v.enemies_eu[ 44] = 'Iridzu'
  _v.enemies_eu[ 45] = 'Flyst'
  _v.enemies_eu[ 46] = 'Medullizk'
  _v.enemies_eu[ 47] = 'Lucich'
  _v.enemies_eu[ 48] = 'Digger'
  _v.enemies_eu[ 49] = 'Fiendo'
  _v.enemies_eu[ 50] = 'Burocca'
  _v.enemies_eu[ 51] = 'Drogerp'
  _v.enemies_eu[ 52] = 'Nadnarb'
  _v.enemies_eu[ 53] = 'Nairad'
  _v.enemies_eu[ 54] = 'Kanezl'
  _v.enemies_eu[ 55] = 'Mantoid'
  _v.enemies_eu[ 56] = 'Sorcerer'
  _v.enemies_eu[ 57] = 'Slithar'
  _v.enemies_eu[ 58] = 'Golooper'
  _v.enemies_eu[ 59] = 'Alusphere'
  _v.enemies_eu[ 60] = 'Mereo'
  _v.enemies_eu[ 61] = 'Delzool'
  _v.enemies_eu[ 62] = 'Defensor'
  _v.enemies_eu[ 63] = 'Ghrost'
  _v.enemies_eu[ 64] = 'Graver'
  _v.enemies_eu[ 65] = 'Shrilp'
  _v.enemies_eu[ 66] = 'Cerosik'
  _v.enemies_eu[ 67] = 'Carnilak'
  _v.enemies_eu[ 68] = 'Valgand'
  _v.enemies_eu[ 69] = 'Berserker'
  _v.enemies_eu[ 70] = 'Lurgel Tank'
  _v.enemies_eu[ 71] = 'Tenkou'
  _v.enemies_eu[ 72] = 'Custos'
  _v.enemies_eu[ 73] = 'Fossor'
  _v.enemies_eu[ 74] = 'Gelu Vermis'
  _v.enemies_eu[ 75] = 'Eversor'
  _v.enemies_eu[ 76] = 'Marauder'
  _v.enemies_eu[ 77] = 'Susceptor'
  _v.enemies_eu[ 78] = 'Telsor'
  _v.enemies_eu[ 79] = 'Dorntak'
  _v.enemies_eu[ 80] = 'Linark'
  _v.enemies_eu[ 81] = 'Dolthstra'
  _v.enemies_eu[ 82] = 'Dracolurg'
  _v.enemies_eu[ 83] = 'Garagor'
  _v.enemies_eu[ 84] = 'Kilite'
  _v.enemies_eu[ 85] = 'Imezl'
  _v.enemies_eu[ 86] = 'Lurker'
  _v.enemies_eu[ 87] = 'Jellikra'
  _v.enemies_eu[ 88] = 'Scorpon'
  _v.enemies_eu[ 89] = 'Arclooper'
  _v.enemies_eu[ 90] = 'Tsorok'
  _v.enemies_eu[ 91] = 'Sentree'
  _v.enemies_eu[ 92] = 'Langry'
  _v.enemies_eu[ 93] = 'Scarabée'
  _v.enemies_eu[ 94] = 'Totelm'
  _v.enemies_eu[ 95] = 'Thryllak'
  _v.enemies_eu[ 96] = 'Stonebeak'
  _v.enemies_eu[ 97] = 'Razorbeak'
  _v.enemies_eu[ 98] = 'Monstrum'
  _v.enemies_eu[ 99] = 'Kantor'
  _v.enemies_eu[100] = 'Umbra'
  _v.enemies_eu[101] = 'Assassinata'
  _v.enemies_eu[102] = 'Executor'
  _v.enemies_eu[103] = 'Custodiae'
  _v.enemies_eu[104] = 'Veles'
  _v.enemies_eu[105] = 'Red Praeses'
  _v.enemies_eu[106] = 'Praeses Elite'
  _v.enemies_eu[107] = 'Jynnus'
  _v.enemies_eu[108] = 'Hydra'
  _v.enemies_eu[109] = 'Yulooper'
  _v.enemies_eu[110] = 'Hunta'
  _v.enemies_eu[111] = 'Zivilyn Bane'
  _v.enemies_eu[112] = 'Zivilyn Bane'
  _v.enemies_eu[113] = 'Zivilyn Bane'
  _v.enemies_eu[114] = 'Zivilyn Bane'
  _v.enemies_eu[115] = 'Zivilyn Bane'
  _v.enemies_eu[116] = 'Zivilyn Bane'
  _v.enemies_eu[117] = 'Zivilyn Bane'
  _v.enemies_eu[118] = 'Hunta'
  _v.enemies_eu[119] = 'Delvax'
  _v.enemies_eu[120] = 'Hopril'
  _v.enemies_eu[121] = 'Elcian'
  _v.enemies_eu[128] = 'Antonio'
  _v.enemies_eu[129] = 'Sentinel'
  _v.enemies_eu[130] = 'Bleigock'
  _v.enemies_eu[131] = 'Carcer'
  _v.enemies_eu[132] = 'Galcian'
  _v.enemies_eu[133] = 'Sceptrum Praeses'
  _v.enemies_eu[134] = 'Rockwyrm'
  _v.enemies_eu[136] = 'Antonio 2'
  _v.enemies_eu[137] = 'Rik\'talish'
  _v.enemies_eu[138] = 'Sinistra'
  _v.enemies_eu[139] = 'Destra'
  _v.enemies_eu[140] = 'Ramirez'
  _v.enemies_eu[141] = 'Vigoro'
  _v.enemies_eu[142] = 'Dralkor Lacus'
  _v.enemies_eu[144] = 'Tortigar'
  _v.enemies_eu[145] = 'Jao'
  _v.enemies_eu[146] = 'Mao'
  _v.enemies_eu[147] = 'Muraji'
  _v.enemies_eu[148] = 'Veltarn'
  _v.enemies_eu[149] = 'Vigoro'
  _v.enemies_eu[150] = 'Dracoslyth'
  _v.enemies_eu[151] = 'Galcian'
  _v.enemies_eu[152] = 'Ramirez'
  _v.enemies_eu[153] = 'Ramirez'
  _v.enemies_eu[154] = 'Eliminator'
  _v.enemies_eu[155] = 'Gordo'
  _v.enemies_eu[156] = 'Furiosus'
  _v.enemies_eu[157] = 'Ramirez'
  _v.enemies_eu[158] = 'Piastol'
  _v.enemies_eu[159] = 'Piastol'
  _v.enemies_eu[160] = 'Piastol'
  _v.enemies_eu[161] = 'Piastol'
  _v.enemies_eu[162] = 'Piastol'
  _v.enemies_eu[163] = 'Piastol'
  _v.enemies_eu[164] = 'Piastol'
  _v.enemies_eu[165] = 'Piastol'
  _v.enemies_eu[166] = 'Piastol'
  _v.enemies_eu[167] = 'Piastol'
  _v.enemies_eu[168] = 'Piastol'
  _v.enemies_eu[169] = 'Piastol'
  _v.enemies_eu[170] = 'Piastol'
  _v.enemies_eu[171] = 'Piastol'
  _v.enemies_eu[172] = 'Piastol'
  _v.enemies_eu[173] = 'Piastol'
  _v.enemies_eu[174] = 'Piastol'
  _v.enemies_eu[175] = 'Piastol'
  _v.enemies_eu[176] = 'Piastol'
  _v.enemies_eu[177] = 'Piastol'
  _v.enemies_eu[178] = 'Tara'
  _v.enemies_eu[179] = 'Tara'
  _v.enemies_eu[180] = 'Tara'
  _v.enemies_eu[181] = 'Tara'
  _v.enemies_eu[182] = 'Tara'
  _v.enemies_eu[183] = 'Lira'
  _v.enemies_eu[184] = 'Lira'
  _v.enemies_eu[185] = 'Lira'
  _v.enemies_eu[186] = 'Lira'
  _v.enemies_eu[187] = 'Lira'
  _v.enemies_eu[188] = 'Pera'
  _v.enemies_eu[189] = 'Pera'
  _v.enemies_eu[190] = 'Pera'
  _v.enemies_eu[191] = 'Pera'
  _v.enemies_eu[192] = 'Pera'
  _v.enemies_eu[193] = 'Daikokuya'
  _v.enemies_eu[194] = 'Daikokuya'
  _v.enemies_eu[195] = 'Daikokuya'
  _v.enemies_eu[196] = 'Daikokuya'
  _v.enemies_eu[197] = 'Daikokuya'
  _v.enemies_eu[198] = 'Rupee'
  _v.enemies_eu[199] = 'Rupee'
  _v.enemies_eu[200] = 'Rupee'
  _v.enemies_eu[201] = 'Rupee'
  _v.enemies_eu[202] = 'Rupee'
  _v.enemies_eu[203] = 'Rupee'
  _v.enemies_eu[204] = 'Rupee'
  _v.enemies_eu[205] = 'Rupee'
  _v.enemies_eu[206] = 'Rupee'
  _v.enemies_eu[207] = 'Rupee'
  _v.enemies_eu[208] = 'Barta'
  _v.enemies_eu[209] = 'Barta'
  _v.enemies_eu[210] = 'Barta'
  _v.enemies_eu[211] = 'Barta'
  _v.enemies_eu[212] = 'Barta'
  _v.enemies_eu[213] = 'Vize'
  _v.enemies_eu[214] = 'Vize'
  _v.enemies_eu[215] = 'Vize'
  _v.enemies_eu[216] = 'Vize'
  _v.enemies_eu[217] = 'Vize'
  _v.enemies_eu[218] = 'Anita'
  _v.enemies_eu[219] = 'Anita'
  _v.enemies_eu[220] = 'Anita'
  _v.enemies_eu[221] = 'Anita'
  _v.enemies_eu[222] = 'Anita'
  _v.enemies_eu[223] = 'Faina'
  _v.enemies_eu[224] = 'Faina'
  _v.enemies_eu[225] = 'Faina'
  _v.enemies_eu[226] = 'Faina'
  _v.enemies_eu[227] = 'Faina'
  _v.enemies_eu[228] = 'Lord Bane'
  _v.enemies_eu[229] = 'Lord Bane'
  _v.enemies_eu[230] = 'Lord Bane'
  _v.enemies_eu[231] = 'Lord Bane'
  _v.enemies_eu[232] = 'Lord Bane'
  _v.enemies_eu[233] = 'Gunarm'
  _v.enemies_eu[234] = 'Gunarm'
  _v.enemies_eu[235] = 'Gunarm'
  _v.enemies_eu[236] = 'Gunarm'
  _v.enemies_eu[237] = 'Gunarm'
  _v.enemies_eu[238] = 'Vigoro'
  _v.enemies_eu[239] = 'Vigoro'
  _v.enemies_eu[240] = 'Vigoro'
  _v.enemies_eu[241] = 'Vigoro'
  _v.enemies_eu[242] = 'Vigoro'
  _v.enemies_eu[243] = 'DeathHound'
  _v.enemies_eu[244] = 'DeathHound'
  _v.enemies_eu[245] = 'DeathHound'
  _v.enemies_eu[246] = 'DeathHound'
  _v.enemies_eu[247] = 'Youjin'
  _v.enemies_eu[248] = 'Youjin'
  _v.enemies_eu[249] = 'Boo'
  _v.enemies_eu[250] = 'Boo'
  _v.enemies_eu[251] = 'Zivilyn Bane'
  _v.enemies_eu[252] = 'Zivilyn Bane'
  _v.enemies_eu[253] = 'Frock'
  _v.enemies_eu[254] = 'Frock'

#------------------------------------------------------------------------------
# Enemy US names
#------------------------------------------------------------------------------

  _v.enemies_us      = Hash.new('???')
  _v.enemies_us[  0] = 'Soldier'
  _v.enemies_us[  1] = 'Guard'
  _v.enemies_us[  2] = 'Seeker'
  _v.enemies_us[  3] = 'Marocca'
  _v.enemies_us[  4] = 'Grouder'
  _v.enemies_us[  7] = 'Spell Warden'
  _v.enemies_us[  8] = 'Flestik'
  _v.enemies_us[  9] = 'Basallish'
  _v.enemies_us[ 10] = 'Mind Stealer'
  _v.enemies_us[ 11] = 'Walrenk'
  _v.enemies_us[ 12] = 'Varkris'
  _v.enemies_us[ 13] = 'Azbeth'
  _v.enemies_us[ 14] = 'Zivilyn Bane'
  _v.enemies_us[ 15] = 'Ghastling'
  _v.enemies_us[ 16] = 'Florast'
  _v.enemies_us[ 17] = 'Tsirat'
  _v.enemies_us[ 18] = 'Thorkyn'
  _v.enemies_us[ 19] = 'Scorfly'
  _v.enemies_us[ 20] = 'Centralk'
  _v.enemies_us[ 21] = 'Feralisk'
  _v.enemies_us[ 22] = 'Ferlith'
  _v.enemies_us[ 23] = 'Crylhound'
  _v.enemies_us[ 24] = 'Magma Tiki'
  _v.enemies_us[ 25] = 'Salamander'
  _v.enemies_us[ 26] = 'Baroo'
  _v.enemies_us[ 27] = 'Dung Fly'
  _v.enemies_us[ 28] = 'Death\'s Head'
  _v.enemies_us[ 29] = 'Looper'
  _v.enemies_us[ 30] = 'Loopalon'
  _v.enemies_us[ 31] = 'Tsurak'
  _v.enemies_us[ 32] = 'Enforcer'
  _v.enemies_us[ 33] = 'Serpentis'
  _v.enemies_us[ 34] = 'Dralnog'
  _v.enemies_us[ 35] = 'Que\'lak'
  _v.enemies_us[ 36] = 'Pinalisk'
  _v.enemies_us[ 37] = 'Crylbeast'
  _v.enemies_us[ 38] = 'Slothstra'
  _v.enemies_us[ 39] = 'Polraxis'
  _v.enemies_us[ 40] = 'Roseln'
  _v.enemies_us[ 41] = 'Elooper'
  _v.enemies_us[ 42] = 'Grapor'
  _v.enemies_us[ 43] = 'Sphyrus'
  _v.enemies_us[ 44] = 'Iridzu'
  _v.enemies_us[ 45] = 'Flyst'
  _v.enemies_us[ 46] = 'Medulizk'
  _v.enemies_us[ 47] = 'Lucich'
  _v.enemies_us[ 48] = 'Digger'
  _v.enemies_us[ 49] = 'Flat Fiend'
  _v.enemies_us[ 50] = 'Burocca'
  _v.enemies_us[ 51] = 'Drogerp'
  _v.enemies_us[ 52] = 'Nadnarb'
  _v.enemies_us[ 53] = 'Nairad'
  _v.enemies_us[ 54] = 'Kanezl'
  _v.enemies_us[ 55] = 'Mantoid'
  _v.enemies_us[ 56] = 'Sorcerer'
  _v.enemies_us[ 57] = 'Slithar'
  _v.enemies_us[ 58] = 'Golooper'
  _v.enemies_us[ 59] = 'Alusphere'
  _v.enemies_us[ 60] = 'Soldier'
  _v.enemies_us[ 61] = 'Delzool'
  _v.enemies_us[ 62] = 'Defender'
  _v.enemies_us[ 63] = 'Ghrost'
  _v.enemies_us[ 64] = 'Graver'
  _v.enemies_us[ 65] = 'Shrilp'
  _v.enemies_us[ 66] = 'Cerosik'
  _v.enemies_us[ 67] = 'Carnilak'
  _v.enemies_us[ 68] = 'Valgand'
  _v.enemies_us[ 69] = 'Berserker'
  _v.enemies_us[ 70] = 'Lurgel Tank'
  _v.enemies_us[ 71] = 'Tenkou'
  _v.enemies_us[ 72] = 'Patrol Guard'
  _v.enemies_us[ 73] = 'Mine Patrol'
  _v.enemies_us[ 74] = 'Forst Worm'
  _v.enemies_us[ 75] = 'Destroyer'
  _v.enemies_us[ 76] = 'Marauder'
  _v.enemies_us[ 77] = 'Guardian'
  _v.enemies_us[ 78] = 'Telsor'
  _v.enemies_us[ 79] = 'Dorntak'
  _v.enemies_us[ 80] = 'Linark'
  _v.enemies_us[ 81] = 'Dolthstra'
  _v.enemies_us[ 82] = 'Dracolurg'
  _v.enemies_us[ 83] = 'Garagor'
  _v.enemies_us[ 84] = 'Kilite'
  _v.enemies_us[ 85] = 'Imezl'
  _v.enemies_us[ 86] = 'Lurker'
  _v.enemies_us[ 87] = 'Jellikra'
  _v.enemies_us[ 88] = 'Scorpon'
  _v.enemies_us[ 89] = 'Arclooper'
  _v.enemies_us[ 90] = 'Tsorok'
  _v.enemies_us[ 91] = 'Sentry'
  _v.enemies_us[ 92] = 'Langry'
  _v.enemies_us[ 93] = 'Durel Beetle'
  _v.enemies_us[ 94] = 'Totelm'
  _v.enemies_us[ 95] = 'Thryllak'
  _v.enemies_us[ 96] = 'Stonebeak'
  _v.enemies_us[ 97] = 'Razorbeak'
  _v.enemies_us[ 98] = 'Stalk Fiend'
  _v.enemies_us[ 99] = 'Kantor'
  _v.enemies_us[100] = 'Shadow'
  _v.enemies_us[101] = 'Assassin'
  _v.enemies_us[102] = 'Officer'
  _v.enemies_us[103] = 'Mage Warden'
  _v.enemies_us[104] = 'Shock Troop'
  _v.enemies_us[105] = 'Red Guard'
  _v.enemies_us[106] = 'Elite Guard'
  _v.enemies_us[107] = 'Jynnus'
  _v.enemies_us[108] = 'Hydra Elite'
  _v.enemies_us[109] = 'Yulooper'
  _v.enemies_us[110] = 'Hunter'
  _v.enemies_us[111] = 'Zivilyn Bane'
  _v.enemies_us[112] = 'Zivilyn Bane'
  _v.enemies_us[113] = 'Zivilyn Bane'
  _v.enemies_us[114] = 'Zivilyn Bane'
  _v.enemies_us[115] = 'Zivilyn Bane'
  _v.enemies_us[116] = 'Zivilyn Bane'
  _v.enemies_us[117] = 'Zivilyn Bane'
  _v.enemies_us[118] = 'Hunter'
  _v.enemies_us[119] = 'Delvax'
  _v.enemies_us[120] = 'Hopril'
  _v.enemies_us[121] = 'Elcian'
  _v.enemies_us[128] = 'Antonio'
  _v.enemies_us[129] = 'Sentinel'
  _v.enemies_us[130] = 'Bleigock'
  _v.enemies_us[131] = 'Executioner'
  _v.enemies_us[132] = 'Galcian'
  _v.enemies_us[133] = 'Royal Guard'
  _v.enemies_us[134] = 'Rockwyrm'
  _v.enemies_us[136] = 'Antonio 2'
  _v.enemies_us[137] = 'Rik\'talish'
  _v.enemies_us[138] = 'Sinistra'
  _v.enemies_us[139] = 'Destra'
  _v.enemies_us[140] = 'Ramirez'
  _v.enemies_us[141] = 'Vigoro'
  _v.enemies_us[142] = 'Dralkor Tank'
  _v.enemies_us[144] = 'Tortigar'
  _v.enemies_us[145] = 'Jao'
  _v.enemies_us[146] = 'Mao'
  _v.enemies_us[147] = 'Muraji'
  _v.enemies_us[148] = 'Veltarn'
  _v.enemies_us[149] = 'Vigoro'
  _v.enemies_us[150] = 'Dracoslyth'
  _v.enemies_us[151] = 'Galcian'
  _v.enemies_us[152] = 'Ramirez'
  _v.enemies_us[153] = 'Ramirez'
  _v.enemies_us[154] = 'Eliminator'
  _v.enemies_us[155] = 'Gordo'
  _v.enemies_us[156] = 'Mad Chef'
  _v.enemies_us[157] = 'Ramirez'
  _v.enemies_us[158] = 'Piastol'
  _v.enemies_us[159] = 'Piastol'
  _v.enemies_us[160] = 'Piastol'
  _v.enemies_us[161] = 'Piastol'
  _v.enemies_us[162] = 'Piastol'
  _v.enemies_us[163] = 'Piastol'
  _v.enemies_us[164] = 'Piastol'
  _v.enemies_us[165] = 'Piastol'
  _v.enemies_us[166] = 'Piastol'
  _v.enemies_us[167] = 'Piastol'
  _v.enemies_us[168] = 'Piastol'
  _v.enemies_us[169] = 'Piastol'
  _v.enemies_us[170] = 'Piastol'
  _v.enemies_us[171] = 'Piastol'
  _v.enemies_us[172] = 'Piastol'
  _v.enemies_us[173] = 'Piastol'
  _v.enemies_us[174] = 'Piastol'
  _v.enemies_us[175] = 'Piastol'
  _v.enemies_us[176] = 'Piastol'
  _v.enemies_us[177] = 'Piastol'
  _v.enemies_us[178] = 'Tara'
  _v.enemies_us[179] = 'Tara'
  _v.enemies_us[180] = 'Tara'
  _v.enemies_us[181] = 'Tara'
  _v.enemies_us[182] = 'Tara'
  _v.enemies_us[183] = 'Lira'
  _v.enemies_us[184] = 'Lira'
  _v.enemies_us[185] = 'Lira'
  _v.enemies_us[186] = 'Lira'
  _v.enemies_us[187] = 'Lira'
  _v.enemies_us[188] = 'Pera'
  _v.enemies_us[189] = 'Pera'
  _v.enemies_us[190] = 'Pera'
  _v.enemies_us[191] = 'Pera'
  _v.enemies_us[192] = 'Pera'
  _v.enemies_us[193] = 'Daikokuya'
  _v.enemies_us[194] = 'Daikokuya'
  _v.enemies_us[195] = 'Daikokuya'
  _v.enemies_us[196] = 'Daikokuya'
  _v.enemies_us[197] = 'Daikokuya'
  _v.enemies_us[198] = 'Rupee'
  _v.enemies_us[199] = 'Rupee'
  _v.enemies_us[200] = 'Rupee'
  _v.enemies_us[201] = 'Rupee'
  _v.enemies_us[202] = 'Rupee'
  _v.enemies_us[203] = 'Rupee'
  _v.enemies_us[204] = 'Rupee'
  _v.enemies_us[205] = 'Rupee'
  _v.enemies_us[206] = 'Rupee'
  _v.enemies_us[207] = 'Rupee'
  _v.enemies_us[208] = 'Barta'
  _v.enemies_us[209] = 'Barta'
  _v.enemies_us[210] = 'Barta'
  _v.enemies_us[211] = 'Barta'
  _v.enemies_us[212] = 'Barta'
  _v.enemies_us[213] = 'Vize'
  _v.enemies_us[214] = 'Vize'
  _v.enemies_us[215] = 'Vize'
  _v.enemies_us[216] = 'Vize'
  _v.enemies_us[217] = 'Vize'
  _v.enemies_us[218] = 'Anita'
  _v.enemies_us[219] = 'Anita'
  _v.enemies_us[220] = 'Anita'
  _v.enemies_us[221] = 'Anita'
  _v.enemies_us[222] = 'Anita'
  _v.enemies_us[223] = 'Faina'
  _v.enemies_us[224] = 'Faina'
  _v.enemies_us[225] = 'Faina'
  _v.enemies_us[226] = 'Faina'
  _v.enemies_us[227] = 'Faina'
  _v.enemies_us[228] = 'Lord Bane'
  _v.enemies_us[229] = 'Lord Bane'
  _v.enemies_us[230] = 'Lord Bane'
  _v.enemies_us[231] = 'Lord Bane'
  _v.enemies_us[232] = 'Lord Bane'
  _v.enemies_us[233] = 'Gunarm'
  _v.enemies_us[234] = 'Gunarm'
  _v.enemies_us[235] = 'Gunarm'
  _v.enemies_us[236] = 'Gunarm'
  _v.enemies_us[237] = 'Gunarm'
  _v.enemies_us[238] = 'Vigoro'
  _v.enemies_us[239] = 'Vigoro'
  _v.enemies_us[240] = 'Vigoro'
  _v.enemies_us[241] = 'Vigoro'
  _v.enemies_us[242] = 'Vigoro'
  _v.enemies_us[243] = 'DeathHound'
  _v.enemies_us[244] = 'DeathHound'
  _v.enemies_us[245] = 'DeathHound'
  _v.enemies_us[246] = 'DeathHound'
  _v.enemies_us[247] = 'Youjin'
  _v.enemies_us[248] = 'Youjin'
  _v.enemies_us[249] = 'Boo'
  _v.enemies_us[250] = 'Boo'
  _v.enemies_us[251] = 'Zivilyn Bane'
  _v.enemies_us[252] = 'Zivilyn Bane'
  _v.enemies_us[253] = 'Frock'
  _v.enemies_us[254] = 'Frock'

end # class VOC

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
