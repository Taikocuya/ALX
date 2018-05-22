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

require_relative('epfile.rb')
require_relative('enemy.rb')
require_relative('enemydata.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write DAT files.
class DatFile < EpFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Reads a DAT file.
  # @param _filename [String] File name
  def load(_filename)
    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_READ, STR_OPEN_DATA))

    _basename   = File.basename(_filename)
    _eb_pattern = sprintf(File.basename(EnemyData::EB_DAT_FILE), '\d{3}')
    _ec_pattern = sprintf(File.basename(EnemyData::EC_DAT_FILE), '\d{3}')
    if Regexp.new(_eb_pattern) =~ _basename
      _boss = true
    elsif Regexp.new(_ec_pattern) =~ _basename
      _boss = false
    end
    
    _id = _basename[/\d{3}/]
    if _id
      _id = _id.to_i
      if _boss
        _id += 128
      end
    else
      return
    end
    
    AklzFile.open(_filename, 'rb') do |_f|
      puts(sprintf(STR_READ, _id, _f.pos))
      _enemy = create_enemy(_id, _filename)
      _enemy.read_from_bin(_f)
      enemies << _enemy
    end
    
    puts(sprintf(STR_CLOSE, _filename))
  end

  # Writes a DAT file.
  # @param _filename [String] File name
  def save(_filename)
    _basename   = File.basename(_filename)
    _eb_pattern = sprintf(File.basename(EnemyData::EB_DAT_FILE), '\d{3}')
    _ec_pattern = sprintf(File.basename(EnemyData::EC_DAT_FILE), '\d{3}')
    if Regexp.new(_eb_pattern) =~ _basename
      _boss = true
    elsif Regexp.new(_ec_pattern) =~ _basename
      _boss = false
    end
    
    _id = _basename[/\d{3}/]
    if _id
      _id = _id.to_i
      if _boss
        _id += 128
      end
      
      _enemy = find_enemy(_id, _filename)
      unless _enemy
        return
      end
    else
      return
    end

    print("\n")
    puts(sprintf(STR_OPEN, _filename, STR_OPEN_WRITE, STR_OPEN_DATA))

    AklzFile.open(_filename, 'wb') do |_f|
      puts(sprintf(STR_WRITE, _id, _f.pos))
      _enemy.write_to_bin(_f)
    end

    puts(sprintf(STR_CLOSE, _filename))
  end

end # class DatFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
