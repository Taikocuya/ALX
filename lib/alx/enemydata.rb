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

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require_relative('accessorydata.rb')
require_relative('armordata.rb')
require_relative('datfile.rb')
require_relative('entrytransform.rb')
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
#                                  CONSTANTS
#==============================================================================

  # Path to DAT files of boss enemies
  EB_DAT_FILE        = 'root/battle/ebinit%s.dat'
  # Path to DAT files of standard enemies
  EC_DAT_FILE        = 'root/battle/ecinit%s.dat'
  # Path to ENP files with +%s+ as wildcard
  ENP_FILE           = 'root/field/%s.enp'
  # Path to EVP file
  EVP_FILE           = 'root/battle/epevent.evp'
  # Path to CSV file of enemy database
  ENEMY_CSV_FILE     = 'csv/enemies.csv'
  # Path to CSV file of enemy events
  EVENT_CSV_FILE     = 'csv/enemyevents.csv'
  # Path to CSV file of enemy encounters
  ENCOUNTER_CSV_FILE = 'csv/enemyencounters.csv'

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a EnemyData.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super(Object, _root)
    @eb_dat_file           = EB_DAT_FILE
    @ec_dat_file           = EC_DAT_FILE
    @enp_file              = sprintf(ENP_FILE, '*_ep')
    @evp_file              = EVP_FILE
    @enemy_csv_file        = ENEMY_CSV_FILE
    @event_csv_file        = EVENT_CSV_FILE
    @encounter_csv_file    = ENCOUNTER_CSV_FILE
    
    @accessory_data        = AccessoryData.new(_root)
    @armor_data            = ArmorData.new(_root)
    @enemy_magic_data      = EnemyMagicData.new(_root)
    @enemy_super_move_data = EnemySuperMoveData.new(_root)
    @ship_cannon_data      = ShipCannonData.new(_root)
    @ship_accessory_data   = ShipAccessoryData.new(_root)
    @ship_item_data        = ShipItemData.new(_root)
    @special_item_data     = SpecialItemData.new(_root)
    @usable_item_data      = UsableItemData.new(_root)
    @weapon_data           = WeaponData.new(_root)
    @items                 = {}

    @enemies               = []
    @events                = []
    @encounters            = []
  end

  # Does nothing.
  def create_entry
    nil
  end

  # Creates an event.
  # @param _id [Integer] Event ID
  # @return [Entry] Event object
  def create_event(_id = -1)
    _event         = Event.new(region)
    _event.id      = _id
    _event.enemies = @enemies
    _event
  end

  # Creates an encounter.
  # @param _id [Integer] Encounter ID
  # @return [Entry] Encounter object
  def create_encounter(_id = -1)
    _encounter         = Encounter.new(region)
    _encounter.id      = _id
    _encounter.enemies = @enemies
    _encounter
  end
  
  # Creates an enemy.
  # @param _id [Integer] Event ID
  # @return [Entry] Enemy object
  def create_enemy(_id = -1)
    _enemy              = Enemy.new(region)
    _enemy.id           = _id
    _enemy.items        = @items
    _enemy.magics       = @magics
    _enemy.super_moves  = @super_moves
    _enemy
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_entries_from_bin(_filename)
    case File.extname(_filename)
    when '.enp'
      _file             = EnpFile.new(region)
      _file.items       = @items
      _file.magics      = @enemy_magic_data.data
      _file.super_moves = @enemy_super_move_data.data
      _file.load(_filename)
      @encounters.concat(_file.encounters)
    when '.evp'
      _file             = EvpFile.new(region)
      _file.items       = @items
      _file.magics      = @enemy_magic_data.data
      _file.super_moves = @enemy_super_move_data.data
      _file.load(_filename)
      @events.concat(_file.events)
    when '.dat'
      _file             = DatFile.new(region)
      _file.items       = @items
      _file.magics      = @enemy_magic_data.data
      _file.super_moves = @enemy_super_move_data.data
      _file.load(_filename)
    else
      return
    end
    
    _file.enemies.each do |_new|
      _old = @enemies.find { |_enemy| _enemy == _new }
      if _old
        _old.files.concat(_new.files)
        _old.files.uniq!
      else
        @enemies << _new
      end
    end
  end

  # Reads all entries from binary files.
  def load_all_from_bin
    @accessory_data.load_all_from_bin
    @armor_data.load_all_from_bin
    @enemy_magic_data.load_all_from_bin
    @enemy_super_move_data.load_all_from_bin
    @ship_cannon_data.load_all_from_bin
    @ship_accessory_data.load_all_from_bin
    @ship_item_data.load_all_from_bin
    @special_item_data.load_all_from_bin
    @usable_item_data.load_all_from_bin
    @weapon_data.load_all_from_bin
    
    @items.merge!(@accessory_data.data)
    @items.merge!(@armor_data.data)
    @items.merge!(@ship_cannon_data.data)
    @items.merge!(@ship_accessory_data.data)
    @items.merge!(@ship_item_data.data)
    @items.merge!(@special_item_data.data)
    @items.merge!(@usable_item_data.data)
    @items.merge!(@weapon_data.data)
    
    load_entries_from_bin(File.join(root.path, @evp_file))
      
    Dir.glob(File.join(root.path, @enp_file)).each do |_p|
      if File.file?(_p)
        load_entries_from_bin(_p)
      end
    end

    _ec_dat_file = sprintf(@ec_dat_file, '[0-9][0-9][0-9]')
    Dir.glob(File.join(root.path, _ec_dat_file)).each do |_p|
      if File.file?(_p)
        load_entries_from_bin(_p)
      end
    end

    _eb_dat_file = sprintf(@eb_dat_file, '[0-9][0-9][0-9]')
    Dir.glob(File.join(root.path, _eb_dat_file)).each do |_p|
      if File.file?(_p)
        load_entries_from_bin(_p)
      end
    end
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_entries_to_bin(_filename)
    case File.extname(_filename)
    when '.enp'
      FileUtils.mkdir_p(File.dirname(_filename))
      _file            = EnpFile.new(region)
      _file.enemies    = @enemies
      _file.encounters = @encounters
      _file.save(_filename)
    when '.evp'
      FileUtils.mkdir_p(File.dirname(_filename))
      _file            = EvpFile.new(region)
      _file.enemies    = @enemies
      _file.events     = @events
      _file.save(_filename)
    when '.dat'
      FileUtils.mkdir_p(File.dirname(_filename))
      _file            = DatFile.new(region)
      _file.enemies    = @enemies
      _file.save(_filename)
    end
  end

  # Writes all entries to binary files.
  def save_all_to_bin
    save_entries_to_bin(File.join(root.path, @evp_file))

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
      save_entries_to_bin(File.join(root.path, _dirname, _filename))
    end

    _ids = []
    @enemies.each do |_enemy|
      _id = _enemy.id
      unless _ids.include?(_id)
        _ids << _id
      end
    end

    _ids.each do |_id|
      if _id < 128
        _filename = sprintf(sprintf(@ec_dat_file, '%03d'), _id)
      else
        _filename = sprintf(sprintf(@eb_dat_file, '%03d'), _id - 128)
      end
      save_entries_to_bin(File.join(root.path, _filename))
    end
  end

  # Reads all enemy entries from a CSV file.
  # @param _filename [String] File name
  def load_enemies_from_csv(_filename)
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_READ, STR_OPEN_DATA))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        puts(sprintf(STR_READ, [0, _f.lineno - 1].max, _f.pos))
        _enemy = create_enemy
        _enemy.read_from_csv(_f)
        @enemies << _enemy
      end
    end

    puts(sprintf(STR_CLOSE, _filename))
  end

  # Reads all event entries from a CSV file.
  # @param _filename [String] File name
  def load_events_from_csv(_filename)
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_READ, STR_OPEN_DATA))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        puts(sprintf(STR_READ, [0, _f.lineno - 1].max, _f.pos))
        _event = create_event
        _event.read_from_csv(_f)
        @events << _event
      end
    end

    puts(sprintf(STR_CLOSE, _filename))
  end

  # Reads all encounter entries from a CSV file.
  # @param _filename [String] File name
  def load_encounters_from_csv(_filename)
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_READ, STR_OPEN_DATA))

    CSV.open(_filename, headers: true) do |_f|
      while !_f.eof?
        puts(sprintf(STR_READ, [0, _f.lineno - 1].max, _f.pos))
        _encounter = create_encounter
        _encounter.read_from_csv(_f)
        @encounters << _encounter
      end
    end

    puts(sprintf(STR_CLOSE, _filename))
  end

  # Reads all entries from CSV files.
	def load_all_from_csv
    load_enemies_from_csv(File.join(root.path, @enemy_csv_file))
    load_events_from_csv(File.join(root.path, @event_csv_file))
    load_encounters_from_csv(File.join(root.path, @encounter_csv_file))
	end

  # Writes all enemy entries to a CSV file.
  # @param _filename [String] File name
  def save_enemies_to_csv(_filename)
    if @enemies.empty?
      return
    end

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

    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_WRITE, STR_OPEN_DATA))

    _header = create_enemy.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @enemies.each do |_enemy|
        puts(sprintf(STR_WRITE, [0, _f.lineno - 1].max, _f.pos))
        _enemy.write_to_csv(_f)
      end
    end
    
    puts(sprintf(STR_CLOSE, _filename))
  end

  # Writes all event entries to a CSV file.
  # @param _filename [String] File name
  def save_events_to_csv(_filename)
    if @events.empty?
      return
    end
    
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_WRITE, STR_OPEN_DATA))

    _header = create_event.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @events.each do |_event|
        puts(sprintf(STR_WRITE, [0, _f.lineno - 1].max, _f.pos))
        _event.write_to_csv(_f)
      end
    end
    
    puts(sprintf(STR_CLOSE, _filename))
  end
      
  # Writes all encounter entries to a CSV file.
  # @param _filename [String] File name
  def save_encounters_to_csv(_filename)
    if @encounters.empty?
      return
    end
    
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_WRITE, STR_OPEN_DATA))

    _header = create_encounter.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @encounters.each do |_encounter|
        puts(sprintf(STR_WRITE, [0, _f.lineno - 1].max, _f.pos))
        _encounter.write_to_csv(_f)
      end
    end
    
    puts(sprintf(STR_CLOSE, _filename))
  end

  # Writes all entries to CSV files.
	def save_all_to_csv
    save_enemies_to_csv(File.join(root.path, @enemy_csv_file))
    save_events_to_csv(File.join(root.path, @event_csv_file))
    save_encounters_to_csv(File.join(root.path, @encounter_csv_file))
	end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :eb_dat_file
  attr_accessor :ec_dat_file
  attr_accessor :enp_file
  attr_accessor :evp_file
  attr_accessor :enemy_csv_file
  attr_accessor :event_csv_file
  attr_accessor :encounter_csv_file
  attr_accessor :enemies
  attr_accessor :events
  attr_accessor :encounters

end # class EnemyData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
