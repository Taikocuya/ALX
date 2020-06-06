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

require_relative('entry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle an enemy.
class Enemy < Entry

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an Enemy.
  # @param _root [GameRoot] Game root
  def initialize(_root)
    super
    @files = []
    @items = {}
    
    members << StrDmy.new(VOC.filter                , ''         )
    members << StrVar.new(VOC.name_str['JP']        , '',      21)

    if us?
      members << StrDmy.new(VOC.enemy_name_us[-1]   , ''         )
    elsif eu?
      members << StrDmy.new(VOC.enemy_name_eu[-1]   , ''         )
    end

    members << IntVar.new(VOC.width                 ,  0, :int8  )
    members << IntVar.new(VOC.depth                 ,  0, :int8  )
    members << IntVar.new(VOC.element_id            ,  0, :int8  )
    members << StrDmy.new(VOC.element_name          , ''         )
    members << IntVar.new(padding_hdr               , -1, :int8  )
    members << IntVar.new(padding_hdr               , -1, :int8  )
    members << PosVar.new(VOC.movement_flags        ,  0, :int16 )
    members << IntVar.new(VOC.counter               ,  0, :int16 )
    members << IntVar.new(VOC.exp[-1]               ,  0, :uint16)
    members << IntVar.new(VOC.gold                  ,  0, :uint16)
    members << IntVar.new(padding_hdr               , -1, :int8  )
    members << IntVar.new(padding_hdr               , -1, :int8  )
    members << IntVar.new(VOC.maxhp                 ,  0, :int32 )
    members << FltVar.new(unknown_hdr               ,  0, :float )

    (0...6).each do |_i|
      members << IntVar.new(VOC.elements[_i]        ,  0, :int16 )
    end

    (0...15).each do |_i|
      members << IntVar.new(VOC.states[_i]          ,  0, :int16 )
    end

    members << IntVar.new(unknown_hdr               ,  0, :int16 )
    members << IntVar.new(VOC.effect_id             , -1, :int8  )
    members << StrDmy.new(VOC.effect_name           , ''         )
    members << IntVar.new(VOC.state_id              ,  0, :int8  )
    members << StrDmy.new(VOC.state_name            , ''         )
    members << IntVar.new(VOC.state_miss            ,  0, :int8  )
    members << IntVar.new(padding_hdr               , -1, :int8  )
    members << IntVar.new(VOC.level                 ,  0, :int16 )
    members << IntVar.new(VOC.will                  ,  0, :int16 )
    members << IntVar.new(VOC.vigor                 ,  0, :int16 )
    members << IntVar.new(VOC.agile                 ,  0, :int16 )
    members << IntVar.new(VOC.quick                 ,  0, :int16 )
    members << IntVar.new(VOC.attack                ,  0, :int16 )
    members << IntVar.new(VOC.defense               ,  0, :int16 )
    members << IntVar.new(VOC.magdef                ,  0, :int16 )
    members << IntVar.new(VOC.hit                   ,  0, :int16 )
    members << IntVar.new(VOC.dodge                 ,  0, :int16 )
    members << IntVar.new(padding_hdr               , -1, :int8  )
    members << IntVar.new(padding_hdr               , -1, :int8  )

    (0...4).each do |_i|
      members << IntVar.new(VOC.item_probability[_i], -1, :int16 )
      members << IntVar.new(VOC.item_amount[_i]     , -1, :int16 )
      members << IntVar.new(VOC.item_id[_i]         , -1, :int16 )
      members << StrDmy.new(VOC.item_name[_i]       , ''         )
    end
  end

  # Checks the entry with a snapshot. Assigns +true+ to #expired if the entry 
  # differs from the snapshot, otherwise nothing happens. Returns +true+ if 
  # the entry matches the snapshot, otherwise +false+.
  # @param _entry [Entry] Entry object
  # @return [Boolean] +true+ if entry matches the snapshot, otherwise +false+.
  def check_expiration(_entry)
    _found   = true
    _found &&= _entry.is_a?(Enemy)
    _found &&= (id     == _entry.id  )
    _found &&= (@files == _entry.files)

    if _found
      super
    end

    _found
  end

  # Reads one entry from a CSV file.
  # @param _csv [CSV] CSV object
  def read_from_csv(_csv)
    super
    @files = find_member(VOC.filter).value.split(';')
  end
  
  # Writes one entry to a CSV file.
  # @param _csv [CSV] CSV object
  def write_to_csv(_csv)
    find_member(VOC.filter).value = @files.join(';')
    
    if us?
      _name = voc(:enemies, id.to_s) || '???'
      find_member(VOC.enemy_name_us[-1]).value = _name
    elsif eu?
      _name = voc(:enemies, id.to_s) || '???'
      find_member(VOC.enemy_name_eu[-1]).value = _name
    end

    _id = find_member(VOC.element_id).value
    find_member(VOC.element_name).value = VOC.elements[_id]

    _id = find_member(VOC.effect_id).value
    find_member(VOC.effect_name).value = VOC.effects[_id]
    
    _id = find_member(VOC.state_id).value
    find_member(VOC.state_name).value = VOC.states[_id]
    
    (0...4).each do |_i|
      _id = find_member(VOC.item_id[_i]).value
      if _id != -1
        _entry = @items[_id]
        _name  = '???'
        if _entry
          if jp? || us?
            _name = _entry.find_member(VOC.name_str[country_id]).value
          elsif eu?
            _name = _entry.find_member(VOC.name_str['GB']).value
          end
        end
      else
        _name = 'None'
      end
      find_member(VOC.item_name[_i]).value = _name
    end

    super
  end

  # Provides marshalling support for use by the Marshal library.
  # @param _hash [Hash] Hash object
  def marshal_load(_hash)
    _hash.each do |_key, _value|
      instance_variable_set(_key, _value)
    end
    @items = {}
  end
  
  # Provides marshalling support for use by the Marshal library.
  # @return [Hash] Hash object
  def marshal_dump
    _hash          = super
    _hash[:@files] = @files
    _hash
  end
  
#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_accessor :files
  attr_accessor :items
  
  def order
    _order    = 0xff
    _enp_file = File.basename(sys(:enp_file))
    _evp_file = File.basename(sys(:evp_file))
    _eb_file  = File.basename(sys(:eb_file ))
    _ec_file  = File.basename(sys(:ec_file ))

    @files.each do |_filename|
      _filename = _filename.sub(EnpFile::MULTI_REGEXP, '\1\3')

      if _filename == '*'
        _order = [_order, 0].min
        break
      elsif File.fnmatch?(_enp_file, _filename, File::FNM_CASEFOLD)
        _order = [_order, 0].min
        break
      elsif File.fnmatch?(_evp_file, _filename, File::FNM_CASEFOLD)
        _order = [_order, 1].min
      elsif File.fnmatch?(_eb_file , _filename, File::FNM_CASEFOLD)
        _order = [_order, 2].min
      elsif File.fnmatch?(_ec_file , _filename, File::FNM_CASEFOLD)
        _order = [_order, 2].min
      end
    end

    _order
  end

end	# class Enemy

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
