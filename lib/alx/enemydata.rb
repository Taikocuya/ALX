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

  # Constructs an EnemyData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Object, _root)
    @eb_file              = sys(:eb_file)
    @ec_file              = sys(:ec_file)
    @enp_file             = sys(:enp_file)
    @evp_file             = glob(:evp_file)
    @event_bgm_id_range   = sys(:enemy_event_bgm_id_range)
    @event_bgm_file       = sys(:enemy_event_bgm_files)
    @enemy_csv_file       = SYS.enemy_csv_file
    @enemy_tpl_file       = SYS.enemy_tpl_file
    @instruction_csv_file = SYS.enemy_instruction_csv_file
    @instruction_tpl_file = SYS.enemy_instruction_tpl_file
    @event_csv_file       = SYS.enemy_event_csv_file
    @event_tpl_file       = SYS.enemy_event_tpl_file
    @encounter_csv_file   = SYS.enemy_encounter_csv_file
    @encounter_tpl_file   = SYS.enemy_encounter_tpl_file
    
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
    _instr.magics       = @enemy_magic_data.data
    _instr.super_moves  = @enemy_super_move_data.data
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
  
  # Returns an enemy by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Enemy] Enemy object
  def find_enemy(_id, _filename)
    _enemies = @enemies.find_all { |_enemy| _enemy.id == _id }
    
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?(File.basename(_filename))
    end
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?('*')
    end
    
    _enemy
  end
  
  # Returns an enemy instructions by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Array] Enemy instructions
  def find_instructions(_id, _filename)
    _instructions = @instructions.find_all do |_instr|
      _instr.enemy_id == _id && _instr.files.include?(File.basename(_filename))
    end
    if _instructions.empty?
      _instructions = @instructions.find_all do |_instr|
        _instr.enemy_id == _id && _instr.files.include?('*')
      end
    end
    
    _instructions
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
  # @param _stack_level  [Integer] Current stack level of method for internal 
  #                                use.
  def concat_instructions(_instructions, _stack_level = 1)
    # ENP files with segments (e.g. 'A099A_EP.BIN' or 'a099a_ep.enp') have 
    # duplicate enemy data under certain circumstances. In order to remove the 
    # duplicates correctly, this method is recursively called per single 
    # segment.
    if _stack_level == 1
      _group_by_files = _instructions.group_by do |_instr|
        _instr.files
      end
      if _group_by_files.size > 1
        _group_by_files.each_value do |_group|
          concat_instructions(_group, _stack_level + 1)
        end
        return
      end
    end
    
    _new_groups = _instructions.group_by do |_instr|
      _instr.group_key
    end
    _old_groups = @instructions.group_by do |_instr|
      _instr.group_key
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
  
    if SYS.enemy_summarize_filter
      _last = nil
      _lock = false
      @enemies.each do |_enemy|
        if _last && _last.id != _enemy.id
          if _last.order <= 2
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
      if _last && _last.order <= 2
        _last.files = ['*']
      end
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

    if SYS.enemy_instruction_summarize_filter
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
        if !_lock && _instr.order <= 2
          _last       = _instr
          _last.files = ['*']
        end
      end
    end
  end

  # Reads all snaphots (instance variables) from SHT files.
  def load_sht
    super
    load_sht_data(:enemies     )
    load_sht_data(:instructions)
    load_sht_data(:events      )
    load_sht_data(:encounters  )
  end
  
  # Writes all snaphots (instance variables) to SHT files.
  def save_sht
    super
    save_sht_data(:enemies,      @enemies     )
    save_sht_data(:instructions, @instructions)
    save_sht_data(:events,       @events      )
    save_sht_data(:encounters,   @encounters  )
  end
    
  # Reads all entries from an EVP file.
  # @param _filename [String] File name
  def load_evp_data(_filename)
    meta.check_mtime(_filename)
    _file             = EvpFile.new(root)
    _file.items       = @items
    _file.magics      = @enemy_magic_data.data
    _file.super_moves = @enemy_super_move_data.data
    _file.load(_filename)
    @events.concat(_file.events)
    concat_enemies(_file.enemies)
    concat_instructions(_file.instructions)
  end

  # Reads all BGM entries from a binary file.
  # @param _filename [String] File name
  def load_bin_bgms(_filename)
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.check_mtime(_filename)
    BinaryFile.open(_filename, 'rb', endianness: endianness) do |_f|
      _last_id    = @event_bgm_id_range.begin
      _descriptor = find_descriptor(@event_bgm_file, _filename)
      
      _descriptor.each do |_range|
        _f.pos = _range.begin

        (_last_id...@event_bgm_id_range.end).each do |_id|
          if _f.eof? || !_descriptor.include?(_f.pos)
            _last_id = _id
            break
          end
          unless id_valid?(_id, @event_bgm_id_range, _descriptor)
            next
          end

          _entry  = @events[_id]

          LOG.info(sprintf(VOC.read, _id - @event_bgm_id_range.begin, _f.pos))
          _entry[VOC.bgm_id] = _f.read_int(:i8)
        end
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end
  
  # Reads all entries from an ENP file.
  # @param _filename [String] File name
  def load_enp_data(_filename)
    meta.check_mtime(_filename)
    _file             = EnpFile.new(root)
    _file.items       = @items
    _file.magics      = @enemy_magic_data.data
    _file.super_moves = @enemy_super_move_data.data
    _file.load(_filename)
    @encounters.concat(_file.encounters)
    concat_enemies(_file.enemies)
    concat_instructions(_file.instructions)
  end
  
  # Reads all entries from a DAT file.
  # @param _filename [String] File name
  def load_dat_data(_filename)
    meta.check_mtime(_filename)
    _file             = DatFile.new(root)
    _file.items       = @items
    _file.magics      = @enemy_magic_data.data
    _file.super_moves = @enemy_super_move_data.data
    _file.load(_filename)
    concat_enemies(_file.enemies)
    concat_instructions(_file.instructions)
  end
  
  # Reads all entries from binary files.
  def load_bin
    @accessory_data.load_bin
    @armor_data.load_bin
    @enemy_magic_data.load_bin
    @enemy_super_move_data.load_bin
    @ship_accessory_data.load_bin
    @ship_cannon_data.load_bin
    @ship_item_data.load_bin
    @special_item_data.load_bin
    @usable_item_data.load_bin
    @weapon_data.load_bin
    
    @items.merge!(@accessory_data.data)
    @items.merge!(@armor_data.data)
    @items.merge!(@ship_accessory_data.data)
    @items.merge!(@ship_cannon_data.data)
    @items.merge!(@ship_item_data.data)
    @items.merge!(@special_item_data.data)
    @items.merge!(@usable_item_data.data)
    @items.merge!(@weapon_data.data)

    # DOL and EVP files
    load_evp_data(@evp_file)
    each_descriptor(@event_bgm_file) do |_d|
      load_bin_bgms(glob(_d.name))
    end

    # ENP files
    glob(@enp_file) do |_p|
      if File.file?(_p)
        load_enp_data(_p)
      end
    end

    # DAT files
    glob(@ec_file) do |_p|
      if File.file?(_p)
        load_dat_data(_p)
      end
    end
    glob(@eb_file) do |_p|
      if File.file?(_p)
        load_dat_data(_p)
      end
    end
  end
  
  # Writes all entries to an EVP file.
  # @param _filename [String] File name
  def save_evp_data(_filename)
    unless meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
    
    FileUtils.mkdir_p(File.dirname(_filename))
    _file              = EvpFile.new(root)
    _file.enemies      = @enemies
    _file.instructions = @instructions
    _file.events       = @events
    _file.save(_filename)
  end

  # Writes all BGM entries to a binary file.
  # @param _filename [String] File name
  def save_bin_bgm(_filename)
    if @events.empty?
      return
    end
    unless meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@event_bgm_file, _filename)
      @events.each_with_index do |_entry, _id|
        unless id_valid?(_id, @event_bgm_id_range, _descriptor)
          next
        end
        
        _f.pos = _descriptor.convert(_id - @event_bgm_id_range.begin)
        unless _descriptor.include?(_f.pos)
          next
        end
        unless _entry.expired
          LOG.info(sprintf(VOC.dup, _id - @event_bgm_id_range.begin, _f.pos))
          next
        end
        
        _bgmid = _entry[VOC.bgm_id]
        if _bgmid < 1
          next
        end
        
        LOG.info(sprintf(VOC.write, _id - @event_bgm_id_range.begin, _f.pos))
        
        _f.write_int(_bgmid, :i8)
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end
  
  # Writes all entries to an ENP file.
  # @param _filename [String] File name
  def save_enp_data(_filename)
    unless meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
    
    FileUtils.mkdir_p(File.dirname(_filename))
    _file              = EnpFile.new(root)
    _file.enemies      = @enemies
    _file.instructions = @instructions
    _file.encounters   = @encounters
    _file.save(_filename)
  end
  
  # Writes all entries to a DAT file.
  # @param _filename [String] File name
  def save_dat_data(_filename)
    unless meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
    
    FileUtils.mkdir_p(File.dirname(_filename))
    _file              = DatFile.new(root)
    _file.enemies      = @enemies
    _file.instructions = @instructions
    _file.save(_filename)
  end

  # Writes all entries to binary files.
  def save_bin
    # DOL and EVP files
    save_evp_data(@evp_file)
    each_descriptor(@event_bgm_file) do |_d|
      save_bin_bgm(glob(_d.name))
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
      save_enp_data(glob(_dirname, _filename))
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
      save_dat_data(glob(_filename))
    end
  end

  # Reads all enemy entries from a CSV file. This method must be called before 
  # #load_csv_instructions.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_enemies(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @enemies.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.check_mtime(_filename)
    CSV.open(_filename, headers: true) do |_f|
      # If the methods #load_csv_enemies and #load_csv_instructions are called 
      # in the wrong order, each enemy is forced to be saved. Snapshots are 
      # not loaded and differences will not be detected, which enormously 
      # increases the total runtime.
      if @instructions.empty?
        _snapshot = snaps[:enemies].dup
      end
      
      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _enemy = create_enemy
        _enemy.read_csv(_f)
        
        if _snapshot
          _result = false
          _snapshot.reject! do |_sht|
            if _result
              break
            end
            _result = _enemy.check_expiration(_sht)
          end
        else
          _enemy.expired = true
        end
        
        @enemies << _enemy
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all enemy instructions from a CSV file. Forwards the expiration to 
  # the corresponding enemy object if an enemy instruction differs from the
  # snapshot. This method must be called after #load_csv_enemies.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_instructions(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @instructions.empty?
      return
    end

    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.check_mtime(_filename)
    CSV.open(_filename, headers: true) do |_f|
      # If the methods #load_csv_enemies and #load_csv_instructions are called 
      # in the wrong order, each enemy is forced to be saved. Snapshots are 
      # not loaded and differences will not be detected, which enormously 
      # increases the total runtime.
      unless @enemies.empty?
        _snapshot = snaps[:instructions]
        if _snapshot
          _snapshot = _snapshot.group_by do |_instr|
            _instr.group_key
          end
        end
      end

      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _instr = create_instruction
        _instr.read_csv(_f)
        
        if _snapshot
          _key   = _instr.group_key
          _group = _snapshot[_key]
          if _group
            if _group.any? { |_sht| _instr.check_expiration(_sht) }
              _enemy = find_enemy(_instr.enemy_id, _filename)
              if _enemy && _instr.expired
                _enemy.expired = true
                _snapshot.delete(_key)
              end
            end
            if _group.last.id == _instr.id
              _snapshot.delete(_key)
            end
          end
        else
          _enemy = find_enemy(_instr.enemy_id, _filename)
          _enemy&.expired = true
        end
        
        @instructions << _instr
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all event entries from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_events(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @events.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.check_mtime(_filename)
    CSV.open(_filename, headers: true) do |_f|
      _snapshot = snaps[:events].dup
      
      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _event = create_event
        _event.read_csv(_f)
        
        if _snapshot
          _result = false
          _snapshot.reject! do |_sht|
            if _result
              break
            end
            _result = _event.check_expiration(_sht)
          end
        else
          _event.expired = true
        end
        
        @events << _event
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all encounter entries from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_encounters(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @encounters.empty?
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_read, VOC.open_data))

    meta.check_mtime(_filename)
    CSV.open(_filename, headers: true) do |_f|
      _snapshot = snaps[:encounters].dup
      
      while !_f.eof?
        LOG.info(sprintf(VOC.read, [0, _f.lineno - 1].max, _f.pos))
        _encounter = create_encounter
        _encounter.read_csv(_f)
        
        if _snapshot
          _result = false
          _snapshot.reject! do |_sht|
            if _result
              break
            end
            _result = _encounter.check_expiration(_sht)
          end
        else
          _encounter.expired = true
        end
        
        @encounters << _encounter
      end
    end

    LOG.info(sprintf(VOC.close, _filename))
  end

  # Reads all entries from CSV files (TPL files first, CSV files last).
	def load_csv
	  _share = SYS.share_dir
    _root  = root.dirname
	  
    load_csv_enemies(File.join(_share, @enemy_tpl_file), true)
    load_csv_enemies(File.join(_root , @enemy_csv_file)      )

    load_csv_instructions(File.join(_share, @instruction_tpl_file), true)
    load_csv_instructions(File.join(_root , @instruction_csv_file)      )
    
    load_csv_events(File.join(_share, @event_tpl_file), true)
    load_csv_events(File.join(_root , @event_csv_file)      )
    
    load_csv_encounters(File.join(_share, @encounter_tpl_file), true)
    load_csv_encounters(File.join(_root , @encounter_csv_file)      )
	end
	
  # Writes all enemy entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_enemy(_filename)
    if @enemies.empty?
      return
    end
    if File.exist?(_filename) && !meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end

    sort_enemies

    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    _header = create_enemy.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @enemies.each do |_enemy|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _enemy.write_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all enemy instruction entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_instruction(_filename)
    if @instructions.empty?
      return
    end
    if File.exist?(_filename) && !meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
  
    sort_instructions
  
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))
  
    _header = create_instruction.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @instructions.each do |_instr|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _instr.write_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all event entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_event(_filename)
    if @events.empty?
      return
    end
    if File.exist?(_filename) && !meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    _header = create_event.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @events.each do |_event|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _event.write_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end
      
  # Writes all encounter entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_encounter(_filename)
    if @encounters.empty?
      return
    end
    if File.exist?(_filename) && !meta.updated?
      LOG.info(sprintf(VOC.skip, _filename, VOC.open_data))
      return
    end
    
    LOG.info(sprintf(VOC.open, _filename, VOC.open_write, VOC.open_data))

    _header = create_encounter.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @encounters.each do |_encounter|
        LOG.info(sprintf(VOC.write, [0, _f.lineno - 1].max, _f.pos))
        _encounter.write_csv(_f)
      end
    end
    
    LOG.info(sprintf(VOC.close, _filename))
  end

  # Writes all entries to CSV files.
	def save_csv
    save_csv_enemy(glob(@enemy_csv_file))
    save_csv_instruction(glob(@instruction_csv_file))
    save_csv_event(glob(@event_csv_file))
    save_csv_encounter(glob(@encounter_csv_file))
	end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :eb_file
  attr_accessor :ec_file
  attr_accessor :enp_file
  attr_accessor :evp_file
  attr_accessor :event_bgm_id_range
  attr_accessor :event_bgm_file
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
