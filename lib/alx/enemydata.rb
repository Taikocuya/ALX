#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2022 Marcel Renner
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
# You should have received a copy of the GNU General Public License along 
# with ALX.  If not, see <http://www.gnu.org/licenses/>.
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
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(Enemy, _depend)

    _build              = SYS.build_dir
    @eb_file            = sys(:eb_file)
    @ec_file            = sys(:ec_file)
    @enp_file           = sys(:enp_file)
    @evp_file           = glob(:evp_file)
    @event_bgm_id_range = sys(:enemy_event_bgm_id_range)
    @event_bgm_file     = sys(:enemy_event_bgm_files)
    @enemy_csv_file     = join(SYS.enemy_csv_file)
    @enemy_tpl_file     = File.join(_build, SYS.enemy_tpl_file)
    @task_csv_file      = join(SYS.enemy_task_csv_file)
    @task_tpl_file      = File.join(_build, SYS.enemy_task_tpl_file)
    @event_csv_file     = join(SYS.enemy_event_csv_file)
    @event_tpl_file     = File.join(_build, SYS.enemy_event_tpl_file)
    @encounter_csv_file = join(SYS.enemy_encounter_csv_file)
    @encounter_tpl_file = File.join(_build, SYS.enemy_encounter_tpl_file)

    if depend
      @accessory_data        = AccessoryData.new
      @armor_data            = ArmorData.new
      @enemy_magic_data      = EnemyMagicData.new(false)
      @enemy_super_move_data = EnemySuperMoveData.new(false)
      @ship_accessory_data   = ShipAccessoryData.new
      @ship_cannon_data      = ShipCannonData.new
      @ship_item_data        = ShipItemData.new
      @special_item_data     = SpecialItemData.new
      @usable_item_data      = UsableItemData.new
      @weapon_data           = WeaponData.new
    end

    @items      = {}
    @enemies    = []
    @tasks      = []
    @events     = []
    @encounters = []
  end

  # Does nothing.
  def create_entry
    nil
  end
  
  # Creates an enemy.
  # @param _id [Integer] Enemy ID
  # @return [Entry] Enemy object
  def create_enemy(_id = -1)
    _enemy       = Enemy.new
    _enemy.id    = _id
    _enemy.items = @items
    _enemy
  end
  
  # Creates an enemy task.
  # @param _id [Integer] Enemy task ID
  # @return [Entry] EnemyTask object
  def create_task(_id = -1)
    _task             = EnemyTask.new
    _task.id          = _id
    _task.enemies     = @enemies
    _task.magics      = @enemy_magic_data&.data
    _task.super_moves = @enemy_super_move_data&.data
    _task
  end

  # Creates an event.
  # @param _id [Integer] Event ID
  # @return [Entry] EnemyEvent object
  def create_event(_id = -1)
    _event         = EnemyEvent.new
    _event.id      = _id
    _event.enemies = @enemies
    _event
  end

  # Creates an encounter.
  # @param _id [Integer] Encounter ID
  # @return [Entry] EnemyEncounter object
  def create_encounter(_id = -1)
    _encounter         = EnemyEncounter.new
    _encounter.id      = _id
    _encounter.enemies = @enemies
    _encounter
  end
  
  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    if !@enemies.empty? || !@tasks.empty?
      return false
    end

    @accessory_data&.load_bin
    @armor_data&.load_bin
    @enemy_magic_data&.load_bin
    @enemy_super_move_data&.load_bin
    @ship_accessory_data&.load_bin
    @ship_cannon_data&.load_bin
    @ship_item_data&.load_bin
    @special_item_data&.load_bin
    @usable_item_data&.load_bin
    @weapon_data&.load_bin
    
    if depend
      @items.merge!(@accessory_data.data)
      @items.merge!(@armor_data.data)
      @items.merge!(@ship_accessory_data.data)
      @items.merge!(@ship_cannon_data.data)
      @items.merge!(@ship_item_data.data)
      @items.merge!(@special_item_data.data)
      @items.merge!(@usable_item_data.data)
      @items.merge!(@weapon_data.data)
    end

    # Cache file
    load_cache
    if cache.valid?
      return false
    end
    
    # BIN and EVP files
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
    
    true
  end
  
  # Writes all entries to binary files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_bin
    if @enemies.empty? || @tasks.empty?
      return false
    end
    if cache.valid?
      return false
    end
  
    # BIN and EVP files
    save_evp_data(@evp_file)
    each_descriptor(@event_bgm_file) do |_d|
      save_bin_bgms(glob(_d.name))
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
    
    # Cache file
    save_cache
    
    true
  end

  # Reads all entries from CSV files (TPL files first, CSV files last).
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_csv
    load_cache
    if cache.valid?
      return false
    end

    load_csv_enemies(@enemy_tpl_file, true)
    load_csv_enemies(@enemy_csv_file      )

    load_csv_tasks(@task_tpl_file, true)
    load_csv_tasks(@task_csv_file      )
    
    load_csv_events(@event_tpl_file, true)
    load_csv_events(@event_csv_file      )
    
    load_csv_encounters(@encounter_tpl_file, true)
    load_csv_encounters(@encounter_csv_file      )

    true
	end
	
  # Writes all entries to CSV files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_csv
    if @enemies.empty? || @tasks.empty?
      return false
    end
    if cache.valid?
      return false
    end
    
    save_csv_enemies(@enemy_csv_file)
    save_csv_tasks(@task_csv_file)
    save_csv_events(@event_csv_file)
    save_csv_encounters(@encounter_csv_file)
    save_cache
    
    true
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :eb_file
  attr_accessor :ec_file
  attr_accessor :enp_file
  attr_accessor :evp_file
  attr_accessor :event_bgm_id_range
  attr_accessor :event_bgm_file
  attr_accessor :enemy_csv_file
  attr_accessor :enemy_tpl_file
  attr_accessor :task_csv_file
  attr_accessor :task_tpl_file
  attr_accessor :event_csv_file
  attr_accessor :event_tpl_file
  attr_accessor :encounter_csv_file
  attr_accessor :encounter_tpl_file
  attr_accessor :enemies
  attr_accessor :events
  attr_accessor :encounters

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache dummies.
  def init_cache_dummies
    super
    cache.add_dummy(create_enemy    )
    cache.add_dummy(create_task     )
    cache.add_dummy(create_event    )
    cache.add_dummy(create_encounter)
  end

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super
    
    glob(@enp_file) do |_p|
      if File.file?(_p)
        cache.add_descriptor(:bin, _p)
      end
    end

    glob(@ec_file) do |_p|
      if File.file?(_p)
        cache.add_descriptor(:bin, _p)
      end
    end
    glob(@eb_file) do |_p|
      if File.file?(_p)
        cache.add_descriptor(:bin, _p)
      end
    end

    cache.add_descriptor(:bin, @evp_file          )
    cache.add_descriptor(:bin, @event_bgm_file    )
    cache.add_descriptor(:csv, @enemy_csv_file    )
    cache.add_descriptor(:csv, @enemy_tpl_file    )
    cache.add_descriptor(:csv, @task_csv_file     )
    cache.add_descriptor(:csv, @task_tpl_file     )
    cache.add_descriptor(:csv, @event_csv_file    )
    cache.add_descriptor(:csv, @event_tpl_file    )
    cache.add_descriptor(:csv, @encounter_csv_file)
    cache.add_descriptor(:csv, @encounter_tpl_file)
  end

  # Initializes the cache storage.
  def init_cache_storage
    super
    cache.add_storage(:@enemies   , @enemies   )
    cache.add_storage(:@tasks     , @tasks     )
    cache.add_storage(:@events    , @events    )
    cache.add_storage(:@encounters, @encounters)
  end

  # Returns an enemy by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Enemy] Enemy object
  def find_enemy(_id, _filename)
    _basename = File.basename(_filename)
    _enemies  = @enemies.find_all { |_enemy| _enemy.id == _id }
    
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?(_basename)
    end
    _enemy ||= _enemies.find do |_entry|
      _entry.files.include?('*')
    end
    
    _enemy
  end
  
  # Returns enemy tasks by ID and filename, or +nil+ otherwise.
  # @param _id       [Integer] Enemy ID
  # @param _filename [String]  File name
  # @return [Array] Enemy tasks
  def find_tasks(_id, _filename)
    _basename = File.basename(_filename)
    _tasks    = @tasks.find_all do |_t|
      _t.enemy_id == _id && _t.files.include?(_basename)
    end
    if _tasks.empty?
      _tasks = @tasks.find_all do |_t|
        _t.enemy_id == _id && _t.files.include?('*')
      end
    end
    
    _tasks
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

  # Concatenates enemy tasks and removes its duplicates.
  # @param _tasks       [Array]   EnemyTask objects
  # @param _stack_level [Integer] Current stack level of method for internal 
  #                               use.
  def concat_tasks(_tasks, _stack_level = 1)
    # ENP files with segments (e.g. 'A099A_EP.BIN' or 'a099a_ep.enp') have 
    # duplicate enemy data under certain circumstances. In order to remove the 
    # duplicates correctly, this method is recursively called per single 
    # segment.
    if _stack_level == 1
      _group_by_files = _tasks.group_by do |_t|
        _t.files
      end
      if _group_by_files.size > 1
        _group_by_files.each_value do |_group|
          concat_tasks(_group, _stack_level + 1)
        end
        return
      end
    end
    
    _new_groups = _tasks.group_by do |_t|
      _t.group_key
    end
    _old_groups = @tasks.group_by do |_t|
      _t.group_key
    end

    _new_groups.each_value do |_new|
      _old = _old_groups.values.find { |_group| _group == _new }
      if _old
        _files = _new[0].files
        _old.each do |_t|
          _t.files.concat(_files)
          _t.files.uniq!
        end
      else
        @tasks.concat(_new)
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
  
  # Sorts enemy tasks.
  def sort_tasks
    @tasks.sort! do |_a, _b|
      _comp = (_a.enemy_id   <=> _b.enemy_id  )
      _comp = (_b.files.size <=> _a.files.size) if _comp == 0
      _comp = (_a.order      <=> _b.order     ) if _comp == 0
      _comp = (_a.files      <=> _b.files     ) if _comp == 0
      _comp = (_a.id         <=> _b.id        ) if _comp == 0
      _comp
    end

    if SYS.enemy_task_id_base > 1 || SYS.enemy_task_summarize_filter
      _last = nil
      _lock = false
      @tasks.each do |_task|
        if SYS.enemy_task_id_base > 1
          _task.id *= SYS.enemy_task_id_base
          if _task.type_id == 0
            _task.param_id *= SYS.enemy_task_id_base
          end
        end
        if SYS.enemy_task_summarize_filter
          if _last && _last.enemy_id != _task.enemy_id
            _last = nil
            _lock = false
          end
          if _last && _last.id >= _task.id
            _lock = true
          end
          if !_lock && _task.order <= 2
            _last       = _task
            _last.files = ['*']
          end
        end
      end
    end
  end

  # Reads all entries from an EVP file.
  # @param _filename [String] File name
  def load_evp_data(_filename)
    _file             = EvpFile.new
    _file.items       = @items
    _file.magics      = @enemy_magic_data&.data
    _file.super_moves = @enemy_super_move_data&.data
    _file.load(_filename)
    @events.concat(_file.events)
    concat_enemies(_file.enemies)
    concat_tasks(_file.tasks)
  end

  # Reads all BGM entries from a binary file.
  # @param _filename [String] File name
  def load_bin_bgms(_filename)
    LOG.info(sprintf(VOC.load, VOC.open_bgms, _filename))

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

          _entry             = @events[_id]
          _entry[VOC.bgm_id] = _f.read_int(:i8)
        end
      end
    end
  end
  
  # Reads all entries from an ENP file.
  # @param _filename [String] File name
  def load_enp_data(_filename)
    _file             = EnpFile.new
    _file.items       = @items
    _file.magics      = @enemy_magic_data&.data
    _file.super_moves = @enemy_super_move_data&.data
    _file.load(_filename)
    @encounters.concat(_file.encounters)
    concat_enemies(_file.enemies)
    concat_tasks(_file.tasks)
  end
  
  # Reads all entries from a DAT file.
  # @param _filename [String] File name
  def load_dat_data(_filename)
    _file             = DatFile.new
    _file.items       = @items
    _file.magics      = @enemy_magic_data&.data
    _file.super_moves = @enemy_super_move_data&.data
    _file.load(_filename)
    concat_enemies(_file.enemies)
    concat_tasks(_file.tasks)
  end
  
  # Writes all entries to an EVP file.
  # @param _filename [String] File name
  def save_evp_data(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file         = EvpFile.new
    _file.enemies = @enemies
    _file.tasks   = @tasks
    _file.events  = @events
    _file.save(_filename)
  end

  # Writes all BGM entries to a binary file.
  # @param _filename [String] File name
  def save_bin_bgms(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_bgms, _filename))

    FileUtils.mkdir_p(File.dirname(_filename))
    BinaryFile.open(_filename, 'r+b', endianness: endianness) do |_f|
      _descriptor = find_descriptor(@event_bgm_file, _filename)
      @events.each_with_index do |_entry, _id|
        unless id_valid?(_id, @event_bgm_id_range, _descriptor)
          next
        end
        
        _f.pos = _descriptor.convert(_id - @event_bgm_id_range.begin)
        if !_descriptor.include?(_f.pos)
          next
        end
        
        _bgmid = _entry[VOC.bgm_id]
        if _bgmid < 1
          next
        end

        _f.write_int(_bgmid, :i8)
      end
    end
  end
  
  # Writes all entries to an ENP file.
  # @param _filename [String] File name
  def save_enp_data(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file            = EnpFile.new
    _file.enemies    = @enemies
    _file.tasks      = @tasks
    _file.encounters = @encounters
    _file.save(_filename)
  end
  
  # Writes all entries to a DAT file.
  # @param _filename [String] File name
  def save_dat_data(_filename)
    FileUtils.mkdir_p(File.dirname(_filename))
    _file         = DatFile.new
    _file.enemies = @enemies
    _file.tasks   = @tasks
    _file.save(_filename)
  end

  # Reads all enemy entries from a CSV file. This method must be called before 
  # #load_csv_tasks.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_enemies(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @enemies.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      _cache = cache.enemies
      while !_f.eof?
        _enemy = create_enemy
        _enemy.read_csv(_f)
        
        unless _cache.include?(_enemy)
          _enemy.modified = true
        end
        
        @enemies << _enemy
      end
    end
  end

  # Reads all enemy tasks from a CSV file. Forwards the expiration to the 
  # corresponding enemy object if an enemy task differs from the snapshot. 
  # This method must be called after #load_csv_enemies.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_tasks(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @tasks.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      _cache = cache.tasks
      while !_f.eof?
        _task = create_task
        _task.read_csv(_f)
        
        unless _cache.include?(_task)
          _enemy = find_enemy(_task.enemy_id, _filename)
          _enemy&.modified = true
        end

        @tasks << _task
      end
    end
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

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      _cache = cache.events
      while !_f.eof?
        _event = create_event
        _event.read_csv(_f)
        
        unless _cache.include?(_event)
          _event.modified = true
        end

        @events << _event
      end
    end
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

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      _cache = cache.encounters
      while !_f.eof?
        _encounter = create_encounter
        _encounter.read_csv(_f)
        
        unless _cache.include?(_encounter)
          _encounter.modified = true
        end

        @encounters << _encounter
      end
    end
  end

  # Writes all enemy entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_enemies(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    sort_enemies
    _header = create_enemy.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @enemies.each do |_enemy|
        _enemy.write_csv(_f)
      end
    end
  end

  # Writes all enemy task entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_tasks(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))
  
    sort_tasks
    _header = create_task.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @tasks.each do |_task|
        _task.write_csv(_f)
      end
    end
  end

  # Writes all event entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_events(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    _header = create_event.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @events.each do |_event|
        _event.write_csv(_f)
      end
    end
  end
      
  # Writes all encounter entries to a CSV file.
  # @param _filename [String] File name
  def save_csv_encounters(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    _header = create_encounter.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @encounters.each do |_encounter|
        _encounter.write_csv(_f)
      end
    end
  end

end # class EnemyData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
