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

require_relative('stringtableentry.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write SOT files.
class SotFile

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Size of node name
  NODE_NAME_SIZE  = 32

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs an SotFile.
  def initialize
    super
    @data = {}
  end

  # Creates a header node.
  # @param _name  [String]  Name
  # @param _count [Integer] Count
  # @param _pos   [Integer] Position
  # @param _size  [Integer] Size
  # @return [OpenStruct] OpenStruct object
  def create_node(_name, _count = 0, _pos = 0x0, _size = 0x0)
    OpenStruct.new(name: _name, count: _count, pos: _pos, size: _size)
  end

  # Creates a string table entry.
  # @param _id [Integer] String table entry ID
  # @return [StringTableEntry] StringTableEntry object
  def create_entry(_id = -1)
    _entry    = StringTableEntry.new
    _entry.id = _id
    _entry
  end
  
  # Reads an SOT file.
  # @param _filename [String] File name
  def load(_filename)
    _basename = File.basename(_filename)

    LOG.info(sprintf(VOC.load, VOC.open_file, _filename))

    BinaryFile.open(_filename, 'rb', endianness: :le) do |_f|
      # Header
      _node_count = _f.read_int(:u32)
      _file_size  = _f.read_int(:u32)
      if _file_size != _f.size
        _msg = 'file size invalid (given %#x, expected %#x)'
        raise(IOError, sprintf(_msg, _f.size, _file_size))
      end

      _reserved1 = _f.read_int(:u32)
      _reserved2 = _f.read_int(:u32)
      if _reserved1 != 0 || _reserved2 != 0
        raise(IOError, 'header corrupted')
      end

      # Nodes
      _nodes = []
      (0..._node_count).each do
        _name      = _f.read_str(length: NODE_NAME_SIZE)
        _pos       = _f.read_int(:u32)
        _reserved1 = _f.read_int(:i32)
        _count     = _f.read_int(:u16)
        _reserved2 = _f.read_int(:i16)
        _size      = _f.read_int(:u32)
        if _reserved1 != -1 || _reserved2 != -1
          raise(IOError, 'nodes corrupted')
        end

        _nodes << create_node(_name, _count, _pos, _size)
      end
      
      # Entries
      _nodes.each do |_node|
        _f.pos = _node.pos
        
        (0..._node.count).each do |_id|
          _table = @data[_node.name] ||= []
          _entry = _table[_id]
          unless _entry
            _entry            = create_entry(_id)
            _entry.table_name = _node.name
            
            if _id != _table.size
              _msg = 'entry ID invalid (given %s, expected %s)'
              raise(IOError, sprintf(_msg, _id, _table.size))
            end
            
            _table << _entry
          end

          _entry.fetch(_basename).read_bin(_f)

          if _f.eof? || _f.pos >= _node.pos + _node.size
            break
          end
        end

        if _f.pos != _node.pos + _node.size
          _msg = 'entry EOF invalid - %s (given %#x, expected %#x)'
          _msg = sprintf(_msg, _node.name, _f.pos, _node.pos + _node.size)
          raise(IOError, _msg)
        end
      end
    end
  end

  # Writes an SOT file.
  # @param _filename [String] File name
  def save(_filename)
    if @data.empty?
      return
    end

    _basename = File.basename(_filename)
    _nodes    = []
    @data.each do |_table_name, _table|
      unless _table.empty?
        _nodes << create_node(_table_name)
      end
    end

    LOG.info(sprintf(VOC.save, VOC.open_file, _filename))

    BinaryFile.open(_filename, 'wb', endianness: :le) do |_f|
      # Header (pre-processing)
      _f.pos += 0x10

      # Nodes (pre-processing)
      _f.pos += (NODE_NAME_SIZE + 0x10) * @data.size

      # Entries
      _nodes.each do |_node|
        _table = @data[_node.name]
      
        _props = []
        _table.reverse_each.with_index do |_entry, _i|
          _id = _table.size - 1 - _i
          if _entry.id != _id
            _msg = 'entry ID invalid (given %s, expected %s)'
            raise(IOError, sprintf(_msg, _entry.id, _id))
          end
          
          _p = _entry.fetch(_basename)
          if _props.empty? && _p.value == ''
            next
          elsif _p.value == ''
            _p.value = '-'
          end
          _props.insert(0, _p)
        end

        _node.pos   = _f.pos
        _node.count = _props.size

        _props.each do |_p|
          _p.write_bin(_f)
        end

        _node.size = _f.pos - _node.pos
      end
      _file_size = _f.pos
      
      # Header (post-processing)
      _f.pos = 0
      _f.write_int(_nodes.size, :u32)
      _f.write_int(_file_size , :u32)
      _f.write_int(0          , :u32)
      _f.write_int(0          , :u32)

      # Nodes (post-processing)
      _nodes.each do |_node|
        _f.write_str(_node.name , length: NODE_NAME_SIZE)
        _f.write_int(_node.pos  , :u32                  )
        _f.write_int(-1         , :i32                  )
        _f.write_int(_node.count, :u16                  )
        _f.write_int(-1         , :i16                  )
        _f.write_int(_node.size , :u32                  )
      end
    end
  end
  
#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :data

end # class SotFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
