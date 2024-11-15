#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2024 Marcel Renner
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
  def initialize
    super
    init_attrs
    init_props
    init_procs
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :items

  def items=(_items)
    @items = _items || {}
    
    (1..4).each do |_i|
      fetch(VOC.item_id(_i))&.call_proc
    end
  end

  def files
    self[VOC.filter]
  end
  
  def files=(_files)
    self[VOC.filter] = _files
  end

  def order
    _order    = 0xff
    _enp_file = File.basename(cfg(:enp_file))
    _evp_file = File.basename(cfg(:evp_file))
    _eb_file  = File.basename(cfg(:eb_file ))
    _ec_file  = File.basename(cfg(:ec_file ))

    self[VOC.filter].each do |_filename|
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

#==============================================================================
#                                  PROTECTED
#==============================================================================

  protected

  # Initialize the entry attributes.
  def init_attrs
    super
    @items ||= {}
  end
  
  # Initialize the entry properties.
  def init_props
    self[VOC.filter      ] = AryProp.new(    [], dmy: true)
    self[VOC.name_str(jp)] = StrProp.new(21, ''           )

    if us? || eu?
      self[VOC.name_opt(cid)] = StrProp.new(nil, '', dmy: true)
    end

    self[VOC.width         ] = IntProp.new( :i8,   0                    )
    self[VOC.depth         ] = IntProp.new( :i8,   0                    )
    self[VOC.element_id    ] = IntProp.new( :i8,   0                    )
    self[VOC.element_name  ] = StrProp.new( nil,  '', dmy: true         )
    self[padding_hdr       ] = IntProp.new( :i8,  -1                    )
    self[padding_hdr       ] = IntProp.new( :i8,  -1                    )
    self[VOC.movement_flags] = IntProp.new(:i16,   0, base: 2, width: 14)
    
    VOC.movements.each do |_id, _movement|
      self[_movement] = StrProp.new(nil, '', dmy: true)
    end

    self[VOC.counter ] = IntProp.new(:i16,   0         )
    self[VOC.exp(nil)] = IntProp.new(:u16,   0         )
    self[VOC.gold    ] = IntProp.new(:u16,   0         )
    self[padding_hdr ] = IntProp.new( :i8,  -1         )
    self[padding_hdr ] = IntProp.new( :i8,  -1         )
    self[VOC.maxhp   ] = IntProp.new(:i32,   0         )
    self[unknown_hdr ] = FltProp.new(:f32, 0.0, prec: 1)

    (0...6).each do |_i|
      self[VOC.elements(_i)] = IntProp.new(:i16, 0)
    end
    (0...15).each do |_i|
      self[VOC.states(_i)  ] = IntProp.new(:i16, 0)
    end

    self[VOC.danger     ] = IntProp.new(:i16,  0           )
    self[VOC.effect_id  ] = IntProp.new( :i8, -1           )
    self[VOC.effect_name] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_id   ] = IntProp.new( :i8,  0           )
    self[VOC.state_name ] = StrProp.new( nil, '', dmy: true)
    self[VOC.state_miss ] = IntProp.new( :i8,  0           )
    self[padding_hdr    ] = IntProp.new( :i8, -1           )
    self[VOC.level      ] = IntProp.new(:i16,  0           )
    self[VOC.will       ] = IntProp.new(:i16,  0           )
    self[VOC.vigor      ] = IntProp.new(:i16,  0           )
    self[VOC.agile      ] = IntProp.new(:i16,  0           )
    self[VOC.quick      ] = IntProp.new(:i16,  0           )
    self[VOC.attack     ] = IntProp.new(:i16,  0           )
    self[VOC.defense    ] = IntProp.new(:i16,  0           )
    self[VOC.magdef     ] = IntProp.new(:i16,  0           )
    self[VOC.hit        ] = IntProp.new(:i16,  0           )
    self[VOC.dodge      ] = IntProp.new(:i16,  0           )
    self[padding_hdr    ] = IntProp.new( :i8, -1           )
    self[padding_hdr    ] = IntProp.new( :i8, -1           )

    (1..4).each do |_i|
      self[VOC.item_probability(_i)] = IntProp.new(:i16, -1           )
      self[VOC.item_amount(_i)     ] = IntProp.new(:i16, -1           )
      self[VOC.item_id(_i)         ] = IntProp.new(:i16, -1           )
      self[VOC.item_name(_i)       ] = StrProp.new( nil, '', dmy: true)
    end
  end
  
  # Initialize the entry procs.
  def init_procs
    if us? || eu?
      fetch(VOC.id).proc = Proc.new do |_id|
        _name = voc(:enemies, id.to_s) || '???'
        self[VOC.name_opt(cid)] = _name
      end
    end

    fetch(VOC.movement_flags).proc = Proc.new do |_flags|
      VOC.movements.each do |_id, _movement|
        self[_movement] = (_flags & (0x800 >> _id) != 0) ? 'X' : ''
      end
    end

    fetch(VOC.element_id).proc = Proc.new do |_id|
      self[VOC.element_name] = VOC.elements(_id)
    end
    
    fetch(VOC.effect_id).proc = Proc.new do |_id|
      self[VOC.effect_name] = VOC.effects(_id)
    end

    fetch(VOC.state_id).proc = Proc.new do |_id|
      self[VOC.state_name] = VOC.states(_id)
    end

    (1..4).each do |_i|
      fetch(VOC.item_id(_i)).proc = Proc.new do |_id|
        if _id != -1
          _entry = @items[_id]
          _name  = '???'
          if _entry
            if jp? || us?
              _name = _entry[VOC.name_str(cid)]
            elsif eu?
              _name = _entry[VOC.name_str('GB')]
            end
          end
        else
          _name = 'None'
        end
        self[VOC.item_name(_i)] = _name
      end
    end
  end

end	# class Enemy

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX
