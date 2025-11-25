#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2025 Marcel Renner
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

require_relative('enemyanimation.rb')
require_relative('enemydata.rb')
require_relative('enemymagicdata.rb')
require_relative('enemysupermovedata.rb')
require_relative('mb3stdfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle enemy animations from binary and/or CSV files.
class EnemyAnimationData < EntryData

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an EnemyAnimationData.
  # @param _depend [Boolean] Resolve dependencies
  def initialize(_depend = true)
    super(EnemyAnimation, _depend)
    
    _build              = CFG.build_dir
    @mb_std_file        = cfg(:mb_std_file)
    @mg_std_file        = cfg(:mg_std_file)
    @animation_csv_file = join(CFG.enemy_animation_csv_file)
    @animation_tpl_file = File.join(_build, CFG.enemy_animation_tpl_file)
    @movement_csv_file  = join(CFG.enemy_movement_csv_file)
    @movement_tpl_file  = File.join(_build, CFG.enemy_movement_tpl_file)
    
    if depend
      @enemy_data            = EnemyData.new
      @enemy_magic_data      = EnemyMagicData.new
      @enemy_super_move_data = EnemySuperMoveData.new
    end
    
    @animations = []
    @movements  = []
  end

  # Creates an enemy animation.
  # @param _id [Integer] Enemy animation ID
  # @return [EnemyAnimation] EnemyAnimation object
  def create_animation(_id = -1)
    _entry             = EnemyAnimation.new
    _entry.id          = _id
    _entry.enemies     = @enemy_data&.enemies
    _entry.magics      = @enemy_magic_data&.data
    _entry.super_moves = @enemy_super_move_data&.data
    _entry
  end

  # Creates an enemy movement.
  # @param _id [Integer] Enemy movement ID
  # @return [EnemyMovement] EnemyMovement object
  def create_movement(_id = -1)
    _entry             = EnemyMovement.new
    _entry.id          = _id
    _entry.enemies     = @enemy_data&.enemies
    _entry.magics      = @enemy_magic_data&.data
    _entry.super_moves = @enemy_super_move_data&.data
    _entry
  end
  
  # Reads all entries from binary files.
  # @return [Boolean] +true+ if reading was successful, otherwise +false+.
  def load_bin
    if !@animations.empty? || !@movements.empty?
      return false
    end

    @enemy_data&.load_bin
    @enemy_magic_data&.load_bin
    @enemy_super_move_data&.load_bin
    
    load_cache
    if cache.valid?
      return false
    end

    glob(@mb_std_file.sub('*', '[0-9][0-9][0-9]')) do |_p|
      if File.file?(_p)
        load_bin_data(_p)
      end
    end
    glob(@mg_std_file.sub('*', '[0-9][0-9][0-9]')) do |_p|
      if File.file?(_p)
        load_bin_data(_p)
      end
    end

    true
  end

  # Writes all entries to binary files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_bin
    if @animations.empty? && @movements.empty?
      return false
    end
    if cache.valid?
      return false
    end

    _files = []
    (@animations + @movements).each do |_entry|
      _filename = _entry.file
      unless _files.include?(_filename)
        _files << _filename
      end
    end
    _files.sort!

    _dirname = File.dirname(@mb_std_file)
    _files.each do |_filename|
      save_bin_data(glob(_dirname, _filename))
    end
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

    load_csv_animations(@animation_tpl_file, true)
    load_csv_animations(@animation_csv_file)
    load_csv_movements(@movement_tpl_file, true)
    load_csv_movements(@movement_csv_file)

    true
  end

  # Writes all entries to CSV files.
  # @return [Boolean] +true+ if writing was successful, otherwise +false+.
  def save_csv
    if @animations.empty? && @movements.empty?
      return false
    end
    if cache.valid?
      return false
    end
    
    save_csv_animations(@animation_csv_file)
    save_csv_movements(@movement_csv_file)
    save_cache
    
    true
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :std_file
  attr_accessor :animation_csv_file
  attr_accessor :animation_tpl_file
  attr_accessor :movement_csv_file
  attr_accessor :movement_tpl_file
  attr_accessor :animations
  attr_accessor :movements

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initializes the cache descriptors.
  def init_cache_descriptors
    super

    glob(@mb_std_file) do |_p|
      if File.file?(_p)
        cache.add_descriptor(:bin, _p)
      end
    end
    glob(@mg_std_file) do |_p|
      if File.file?(_p)
        cache.add_descriptor(:bin, _p)
      end
    end

    cache.add_descriptor(:csv, @animation_csv_file)
    cache.add_descriptor(:csv, @animation_tpl_file)
    cache.add_descriptor(:csv, @movement_csv_file)
    cache.add_descriptor(:csv, @movement_tpl_file)
  end

  # Initializes the cache storage.
  def init_cache_storage
    super
    cache.add_storage(:@animations, @animations)
    cache.add_storage(:@movements , @movements )
  end

  # Reads all entries from a binary file.
  # @param _filename [String] File name
  def load_bin_data(_filename)
    _file             = Mb3StdFile.new
    _file.enemies     = @enemy_data&.enemies
    _file.magics      = @enemy_magic_data&.data
    _file.super_moves = @enemy_super_move_data&.data
    _file.load(_filename)
    @animations.concat(_file.animations)
    @movements.concat(_file.movements)
  end

  # Writes all entries to a binary file.
  # @param _filename [String] File name
  def save_bin_data(_filename)
    if !DSCRPTR.enemy_animation_allow_new_files && !File.exist?(_filename)
      return
    end

    FileUtils.mkdir_p(File.dirname(_filename))
    _file            = Mb3StdFile.new
    _file.animations = @animations
    _file.movements  = @movements
    _file.save(_filename)
  end

  # Reads all enemy animations from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_animations(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @animations.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      _cache = cache.animations
      while !_f.eof?
        _entry = create_animation
        _entry.read_csv(_f)

        unless _cache.include?(_entry)
          _entry.modified = true
        end
        
        @animations << _entry
      end
    end
  end

  # Reads all enemy movements from a CSV file.
  # @param _filename [String]  File name
  # @param _force    [Boolean] Skip missing file
  def load_csv_movements(_filename, _force = false)
    if _force && !File.exist?(_filename)
      return
    end
    unless @movements.empty?
      return
    end

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    CSV.open(_filename, headers: true) do |_f|
      _cache = cache.movements
      while !_f.eof?
        _entry = create_movement
        _entry.read_csv(_f)

        unless _cache.include?(_entry)
          _entry.modified = true
        end
        
        @movements << _entry
      end
    end
  end

  # Writes all enemy animations to a CSV file.
  # @param _filename [String] File name
  def save_csv_animations(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    _header = create_animation.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @animations.each do |_entry|
        _entry.write_csv(_f)
      end
    end
  end

  # Writes all enemy movements to a CSV file.
  # @param _filename [String] File name
  def save_csv_movements(_filename)
    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    _header = create_movement.header
    
    FileUtils.mkdir_p(File.dirname(_filename))
    CSV.open(_filename, 'w', headers: _header, write_headers: true) do |_f|
      @movements.each do |_entry|
        _entry.write_csv(_f)
      end
    end
  end

end # class EnemyAnimationData

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
