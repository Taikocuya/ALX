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

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('accessorydata.rb')
require_relative('armordata.rb')
require_relative('datfile.rb')
require_relative('enemymagicdata.rb')
require_relative('enemysupermovedata.rb')
require_relative('enpfile.rb')
require_relative('evpfile.rb')
require_relative('shipaccessorydata.rb')
require_relative('shipcannondata.rb')
require_relative('shipitemdata.rb')
require_relative('specialitemdata.rb')
require_relative('usableitemdata.rb')
require_relative('weapondata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemies from binary and/or CSV files.
class EnemyData < EntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemyData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Object, _root)
    @eb_file              = sys(:eb_file)
    @ec_file              = sys(:ec_file)
    @enp_file             = sys(:enp_file)
    @evp_file             = glob(:evp_file)
    @event_bgm_id_range   = sys(:enemy_event_bgm_id_range)
    @event_bgm_files      = sys(:enemy_event_bgm_files)
    @enemy_csv_file       = sys(:enemy_csv_file)
    @enemy_tpl_file       = sys(:enemy_tpl_file)
    @instruction_csv_file = sys(:enemy_instruction_csv_file)
    @instruction_tpl_file = sys(:enemy_instruction_tpl_file)
    @event_csv_file       = sys(:enemy_event_csv_file)
    @event_tpl_file       = sys(:enemy_event_tpl_file)
    @encounter_csv_file   = sys(:enemy_encounter_csv_file)
    @encounter_tpl_file   = sys(:enemy_encounter_tpl_file)
    
    @accessory_data        = AccessoryData.new(_root)
    @armor_data            = ArmorData.new(_root)
    @enemy_magic_data      = EnemyMagicData.new(_root)
    @enemy_super_move_data = EnemySuperMoveData.new(_root)
    @ship_accessory_data   = ShipAccessoryData.new(_root)
    @ship_cannon_data      = ShipCannonData.new(_root)
    @ship_item_data        = ShipItemData.new(_root)
    @special_item_data     = SpecialItemData.new(_root)
    @usable_item_data      = UsableItemData.new(_root)
    @weapon_data           = WeaponData.new(_root)
    @items                 = {}

    @enemies      = []
    @instructions = []
    @events       = []
    @encounters   = []
  end

  # Does nothing.
  def create_entry
    nil
  end
  
  # Creates an enemy.
  # @param _id [Integer] Enemy ID
  # @return [Entry] Enemy object
  def create_enemy(_id = -1)
    _enemy       = Enemy.new(root)
    _enemy.id    = _id
    _enemy.items = @items
    _enemy
  end
  
  # Creates an enemy instruction.
  # @param _id [Integer] Enemy instruction ID
  # @return [Entry] EnemyInstruction object
  def create_instruction(_id = -1)
    _instr              = EnemyInstruction.new(root)
    _instr.id           = _id
    _instr.enemies      = @enemies
    _instr.magics       = @magics
    _instr.super_moves  = @super_moves
    _instr
  end

  # Creates an event.
  # @param _id [Integer] Event ID
  # @return [Entry] EnemyEvent object
  def create_event(_id = -1)
    _event         = EnemyEvent.new(root)
    _event.id      = _id
    _event.enemies = @enemies
    _event
  end

  # Creates an encounter.
  # @param _id [Integer] Encounter ID
  # @return [Entry] EnemyEncounter object
  def create_encounter(_id = -1)
    _encounter         = EnemyEncounter.new(root)
    _encounter.id      = _id
    _encounter.enemies = @enemies
    _encounter
  end
  
  # Reads all entries from an EVP file.
  # @param _filename [String] File name
  def load_data_from_evp(_filename)
    _file              = EvpFile.new(root)
    _file.items        = @items
    _file.magics       = @enemy_magic_data.data
    _file.super_moves  = @enemy_super_move_data.data
    _file.load(_filename)
    @events.concat(_file.events)
    concat_enemies(_file.enemies)
    concat_instructions(_file.instructions)
  end

  # Concatenates enemies and removes its duplicates.
  # @param _enemies [Array] Enemy objects
  def concat_enemies(_enemies)
    _enemies.each do |_new|
      _old = @enemies.find { |_enemy| _enemy == _new }
      if _old
        _old.files.concat(_new.files)
        _old.files.uniq!
      else
        @enemies << _new
      end
    end
  end

  # Concatenates enemy instructions and removes its duplicates.
  # @param _instructions [Array]   EnemyInstructions objects
  # @param _stack_level  [Integer] Current stack level of method for internal use.
  def concat_instructions(_instructions, _stack_level = 1)
    # ENP files with segments (e.g. 'a099a_ep.enp') have duplicate enemy data 
    # under certain circumstances. In order to remove the duplicates correctly, 
    # this method is recursively called per single segment.
    if _stack_level == 1
      _group_by_files = _instructions.group_by do |_instr|
        _instr.files.join(';').to_s
      end
      if _group_by_files.size > 1
        _group_by_files.each_value do |_group|
          concat_instructions(_group, _stack_level + 1)
        end
        return
      end
    end
    
    _new_groups = _instructions.group_by do |_instr|
      _instr.files.join(';').to_s + _instr.enemy_id.to_s
    end
    _old_groups = @instructions.group_by do |_instr|
      _instr.files.join(';').to_s + _instr.enemy_id.to_s
    end

    _new_groups.each_value do |_new|
      _old = _old_groups.values.find { |_group| _group == _new }
      if _old
        _files = _new[0].files
        _old.each do |_instr|
          _instr.files.concat(_files)
          _instr.files.uniq!
        end
      else
        @instructions.concat(_new)
      end
    end
  end

  # Sorts enemies.
  def sort_enemies
    @enemies.sort! do |_a, _b|
      _comp = (_a.id         <=> _b.id        )
      _comp = (_b.files.size <=> _a.files.size) if _comp == 0
      _comp = (_a.order      <=> _b.order     ) if _comp == 0
      _comp = (_a.files      <=> _b.files     ) if _comp == 0
      _comp
    end
  
    _last = nil
    _lock = false
    @enemies.each do |_enemy|
      if _last && _last.id != _enemy.id
        if _last.order < 2
          _last.files = ['*']
        end
        _last = nil
        _lock = false
      end
      
      if !_lock && (!_last || _last.files.size < _enemy.files.size)
        _last = _enemy
      end
      
      if _enemy.files.include?('*')
        _lock = true
      end
    end
    if _last && _last.order < 2
      _last.files = ['*']
    end
  end
  
  # Sorts enemy instructions.
  def sort_instructions
    @instructions.sort! do |_a, _b|
      _comp = (_a.enemy_id   <=> _b.enemy_id  )
      _comp = (_b.files.size <=> _a.files.size) if _comp == 0
      _comp = (_a.order      <=> _b.order     ) if _comp == 0
      _comp = (_a.files      <=> _b.files     ) if _comp == 0
      _comp = (_a.id         <=> _b.id        ) if _comp == 0
      _comp
    end

    _last = nil
    _lock = false
    @instructions.each do |_instr|
      if _last && _last.enemy_id != _instr.enemy_id
        _last = nil
        _lock = false
      end
      if _last && _last.id >= _instr.id
        _lock = true
      end
      if !_lock && _instr.order < 2
        _last       = _instr
        _last.files = ['*']
      end
    end
  end

  # Reads all BGM entries from a binary file.
  # @param _filename [String] File name
  def load_bgms_from_bin(_filename)
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    BinaryFile.open(_filename, 'rb') do |_f|
      _range = determine_range(@event_bgm_files, _filename)
      _f.pos = _range.begin
      
      @event_bgm_id_range.each do |_id|
        if _range.exclusions.include?(_id)
          next
        end
        if _f.eof? || _f.pos < _range.begin || _f.pos >= _range.end
          next
        end
        
        _event  = @events[_id]
        _bgm_id = _event.find_member(VOC.bgm_id)

        LOG.info(sprintf(VOC.read, _id - @event_bgm_id_range.begin, _f.pos))
        _bgm_id.value  = _f.read_int('c')
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end
  
  # Reads all entries from an ENP file.
  # @param _filename [String] File name
  def load_data_from_enp(_filename)
    _file              = EnpFile.new(root)
    _file.items        = @items
    _file.magics       = @enemy_magic_data.data
    _file.super_moves  = @enemy_super_move_data.data
    _file.load(_filename)
    @encounters.concat(_file.encounters)
    concat_enemies(_file.enemies)
    concat_instructions(_file.instructions)
  end
  
  # Reads all entries from a DAT file.
  # @param _filename [String] File name
  def load_data_from_dat(_filename)
    _file              = DatFile.new(root)
    _file.items        = @items
    _file.magics       = @enemy_magic_data.data
    _file.super_moves  = @enemy_super_move_data.data
    _file.load(_filename)
    concat_enemies(_file.enemies)
    concat_instructions(_file.instructions)
  end
  
  # Reads all entries from binary files.
  def load_all_from_bin
    @accessory_data.load_all_from_bin
    @armor_data.load_all_from_bin
    @enemy_magic_data.load_all_from_bin
    @enemy_super_move_data.load_all_from_bin
    @ship_accessory_data.load_all_from_bin
    @ship_cannon_data.load_all_from_bin
    @ship_item_data.load_all_from_bin
    @special_item_data.load_all_from_bin
    @usable_item_data.load_all_from_bin
    @weapon_data.load_all_from_bin
    
    @items.merge!(@accessory_data.data)
    @items.merge!(@armor_data.data)
    @items.merge!(@ship_accessory_data.data)
    @items.merge!(@ship_cannon_data.data)
    @items.merge!(@ship_item_data.data)
    @items.merge!(@special_item_data.data)
    @items.merge!(@usable_item_data.data)
    @items.merge!(@weapon_data.data)

    # DOL and EVP files
    load_data_from_evp(@evp_file)
    _bgm_ranges = @event_bgm_files
    if _bgm_ranges
      unless _bgm_ranges.is_a?(Array)
        _bgm_ranges = [_bgm_ranges]
      end
      _bgm_ranges.each do |_bgm_range|
        load_bgms_from_bin(glob(_bgm_range.name))
      end
    end

    # ENP files
    glob(@enp_file) do |_p|
      if File.file?(_p)
        load_data_from_enp(_p)
      end
    end

    # DAT files
    glob(@ec_file) do |_p|
      if File.file?(_p)
        load_data_from_dat(_p)
      end
    end
    glob(@eb_file) do |_p|
      if File.file?(_p)
        load_data_from_dat(_p)
      end
    end
  end
  
  # Writes all entries to an EVP file.
  # @param _filename [String] File name
  def save_data_to_evp(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file              = EvpFile.new(root)
    _file.enemies      = @enemies
    _file.instructions = @instructions
    _file.events       = @events
    _file.save(_filename)
  end

  # Writes all BGM entries to a binary file.
  # @param _filename [String] File name
  def save_bgms_to_bin(_filename)
    if @events.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b') do |_f|
      _range = determine_range(@event_bgm_files, _filename) 

      @events.each_with_index do |_entry, _id|
        if _id < @event_bgm_id_range.begin && _id >= @event_bgm_id_range.end
          next
        end
        if _range.exclusions.include?(_id)
          next
        end
        
        _bgm_id = _entry.find_member(VOC.bgm_id).value
        if _bgm_id <= 0
          next
        end
        
        _f.pos = _range.begin + _id
        if _f.eof? || _f.pos < _range.begin || _f.pos + 0x1 > _range.end
          next
        end
        
        LOG.info(sprintf(VOC.write, _id - @event_bgm_id_range.begin, _f.pos))
        _f.write_int(_bgm_id, 'c')
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end
  
  # Writes all entries to an ENP file.
  # @param _filename [String] File name
  def save_data_to_enp(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file              = EnpFile.new(root)
    _file.enemies      = @enemies
    _file.instructions = @instructions
    _file.encounters   = @encounters
    _file.save(_filename)
  end
  
  # Writes all entries to a DAT file.
  # @param _filename [String] File name
  def save_data_to_dat(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file              = DatFile.new(root)
    _file.enemies      = @enemies
    _file.instructions = @instructions
    _file.save(_filename)
  end

  # Writes all entries to binary files.
  def save_all_to_bin
    # DOL and EVP files
    save_data_to_evp(@evp_file)
    _bgm_ranges = @event_bgm_files
    if _bgm_ranges
      unless _bgm_ranges.is_a?(Array)
        _bgm_ranges = [_bgm_ranges]
      end
      _bgm_ranges.each do |_bgm_range|
        save_bgms_to_bin(glob(_bgm_range.name))
      end
    end

    # ENP files
    _files = []
    @encounters.each do |_encounter|
      # Single ENP file
      _single_file = _encounter.file
      unless _files.include?(_single_file)
        _files << _single_file
      end

      # Multi ENP file
      _multi_file = _single_file.sub(EnpFile::MULTI_REGEXP, '\1\3')
      unless _files.include?(_multi_file)
        _files << _multi_file
      end
    end
    _files.sort!

    _dirname = File.dirname(@enp_file)
    _files.each do |_filename|
      save_data_to_enp(glob(_dirname, _filename))
    end

    # DAT files
    _ids = []
    @enemies.each do |_enemy|
      _id = _enemy.id
      unless _ids.include?(_id)
        _ids << _id
      end
    end

    _ids.each do |_id|
      if _id < 0x80
        _filename = sprintf(@ec_file.sub('*', '%03d'), _id)
      else
        _filename = sprintf(@eb_file.sub('*', '%03d'), _id & 0x7f)
      end
      save_data_to_dat(glob(_filename))
    end
  end

  # Reads all enemy entries from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skips missing file
  def load_enemies_from_csv(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @enemies.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _enemy = create_enemy
        _enemy.read_from_csv(_f)
        @enemies << _enemy
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all enemy instructions from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skips missing file
  def load_instructions_from_csv(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @instructions.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))
  
    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _instr = create_instruction
        _instr.read_from_csv(_f)
        @instructions << _instr
      end
    end
  
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all event entries from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skips missing file
  def load_events_from_csv(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @events.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _event = create_event
        _event.read_from_csv(_f)
        @events << _event
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all encounter entries from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skips missing file
  def load_encounters_from_csv(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @encounters.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _encounter = create_encounter
        _encounter.read_from_csv(_f)
        @encounters << _encounter
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all entries from CSV files (TPL files first, CSV files last).
	def load_all_from_csv
	  _share = SYS.share_dir
    _root  = root.dirname
	  
    load_enemies_from_csv(File.join(_share, @enemy_tpl_file), true)
    load_enemies_from_csv(File.join(_root , @enemy_csv_file)      )

    load_instructions_from_csv(File.join(_share, @instruction_tpl_file), true)
    load_instructions_from_csv(File.join(_root , @instruction_csv_file)      )
    
    load_events_from_csv(File.join(_share, @event_tpl_file), true)
    load_events_from_csv(File.join(_root , @event_csv_file)      )
    
    load_encounters_from_csv(File.join(_share, @encounter_tpl_file), true)
    load_encounters_from_csv(File.join(_root , @encounter_csv_file)      )
	end
	
  # Writes all enemy entries to a CSV file.
  # @param _filename [String] File name
  def save_enemies_to_csv(_filename)
    if @enemies.empty?
      return
    end

    sort_enemies

    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    _header = create_enemy.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @enemies.each do |_enemy|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _enemy.write_to_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all enemy instruction entries to a CSV file.
  # @param _filename [String] File name
  def save_instructions_to_csv(_filename)
    if @instructions.empty?
      return
    end
  
    sort_instructions
  
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))
  
    _header = create_instruction.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @instructions.each do |_instr|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _instr.write_to_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all event entries to a CSV file.
  # @param _filename [String] File name
  def save_events_to_csv(_filename)
    if @events.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    _header = create_event.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @events.each do |_event|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _event.write_to_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end
      
  # Writes all encounter entries to a CSV file.
  # @param _filename [String] File name
  def save_encounters_to_csv(_filename)
    if @encounters.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    _header = create_encounter.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @encounters.each do |_encounter|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _encounter.write_to_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all entries to CSV files.
	def save_all_to_csv
    save_enemies_to_csv(glob(@enemy_csv_file))
    save_instructions_to_csv(glob(@instruction_csv_file))
    save_events_to_csv(glob(@event_csv_file))
    save_encounters_to_csv(glob(@encounter_csv_file))
	end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :eb_file
  attr_accessor :ec_file
  attr_accessor :enp_file
  attr_accessor :evp_file
  attr_accessor :event_bgm_id_range
  attr_accessor :event_bgm_files
  attr_accessor :enemy_csv_file
  attr_accessor :enemy_tpl_file
  attr_accessor :instruction_csv_file
  attr_accessor :instruction_tpl_file
  attr_accessor :event_csv_file
  attr_accessor :event_tpl_file
  attr_accessor :encounter_csv_file
  attr_accessor :encounter_tpl_file
  attr_accessor :enemies
  attr_accessor :events
  attr_accessor :encounters

end # class EnemyData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
