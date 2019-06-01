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

require_relative('bnrfile.rb')
require_relative('fileable.rb')
require_relative('hdrfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a game root.
class GameRoot

#==============================================================================
#                                   INCLUDES
#==============================================================================

  include(Fileable)
  
#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Platforms for validation
  PLATFORMS = {
    # 'DC' => 'Dreamcast',
    'GC' => 'Gamecube',
  }
  # Countries for validation
  COUNTRIES = ['EU', 'JP', 'US']

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a GameRoot.
  def initialize(_dir = '')
    clear
  end

  # Clear all values to their default values.
  def clear
    @dirname         = ''
    @platform_id     = ''
    @platform_name   = ''
    @product_id      = ''
    @product_name    = ''
    @product_version = ''
    @product_date    = ''
    @region_id       = ''
    @region_name     = ''
    @country_id      = ''
    @maker_id        = ''
    @maker_name      = ''
    @description     = ''
    @sys_attr_rslvr  = []
    @valid           = false
    @cache           = {}
  end
  
  # Reads the game root directory. Returns +true+ if everything is valid, 
  # otherwise +false+.
  # @param _dirname [String] Directory name
  # @return [Boolean] Returns +true+ if everything is valid, otherwise +false+.
  def load(_dirname)
    clear

    _result   = true
    _result &&= init_dir(_dirname)
    _result &&= init_config
    _result &&= init_platform
    
    case @platform_id
    when 'DC'
      _result &&= init_ip
    when 'GC'
      _result &&= init_bnr
      _result &&= init_hdr
    end

    @valid    = _result
  end
  
  # Returns +true+ if the game root directory is valid, otherwise +false+.
  # @return [Boolean] +true+ if game root directory is valid, otherwise 
  #                   +false+.
  def valid?
    @valid
  end

  # Returns +true+ if the platform is a Dreamcast, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Dreamcast, otherwise +false+.
  def is_dc?
    @platform_id == 'DC'
  end

  # Returns +true+ if the platform is a Gamecube, otherwise +false+.
  # @return [Boolean] +true+ if platform is a Gamecube, otherwise +false+.
  def is_gc?
    @platform_id == 'GC'
  end

  # Returns +true+ if the country is 'EU', otherwise +false+.
  # @return [Boolean] +true+ if country is 'EU', otherwise +false+.
  def is_eu?
    @country_id == 'EU'
  end

  # Returns +true+ if the country is 'JP', otherwise +false+.
  # @return [Boolean] +true+ if country is 'JP', otherwise +false+.
  def is_jp?
    @country_id == 'JP'
  end

  # Returns +true+ if the country is 'US', otherwise +false+.
  # @return [Boolean] +true+ if country is 'US', otherwise +false+.
  def is_us?
    @country_id == 'US'
  end

  # Returns the value of a SYS attribute. If the value is a Hash, the 
  # instance variables are considered during key selection.
  # @param _sym [Symbol] SYS attribute symbol
  # @return [Object] SYS attribute object
  def sys(_sym)
    _attr = SYS.send(_sym)
    if _attr.is_a?(Hash)
      _key   = @cache[_sym]
      _value = _key ? _attr[_key] : nil
      
      unless _value
        (0...[1, @sys_attr_rslvr.size].max).to_a.reverse.each do |_index|
          @sys_attr_rslvr.permutation(_index) do |_permutation|
            _key   = (_permutation.unshift(@platform_id)).join('-')
            _value = _attr[_key]
            if _value
              @cache[_sym] = _key
              break
            end
          end
          if _value
            break
          end
        end
      end
      
      _attr = _value
    end
    
    _attr
  end
  
  # Returns a new path formed by joining the strings using '/' relative to 
  # #dir. SYS symbols are resolved as well. If they contain a Hash, the game 
  # root attributes are considered during key selection.
  # 
  # @param _args [String,Symbol] Paths or SYS symbols
  # @return [String] Path
  # @see ::File::join
  def join(*_args)
    _paths = _args.collect do |_p|
      _p.is_a?(Symbol) ? sys(_p) : _p
    end
    File.join(@dirname, *_paths)
  end
  
  # Expands glob pattern and returns a path of the first matching file or 
  # directory relative to #dir. SYS symbols are resolved as well. If they 
  # contain a Hash, the game root attributes are considered during key 
  # selection.
  # 
  # If a block is given, calls the block once for each matching file or 
  # directory, passing the path as a parameter to the block. 
  # 
  # @param _args [String,Symbol] Glob patterns or SYS attributes
  # @return [String] First matching path
  # @see ::Dir::glob
  def glob(*_args)
    _path  = join(*_args)
    _files = Dir.glob(_path)

    if block_given?
      _files.each do |_p|
        yield(_p)
      end
    else
      if _files.empty?
        _path
      else
        _files.first
      end
    end
  end

#------------------------------------------------------------------------------
# Public member variables
#------------------------------------------------------------------------------

  attr_reader :dirname
  attr_reader :platform_id
  attr_reader :platform_name
  attr_reader :product_id
  attr_reader :product_name
  attr_reader :product_version
  attr_reader :product_date
  attr_reader :region_id
  attr_reader :region_name
  attr_reader :country_id
  attr_reader :maker_id
  attr_reader :maker_name
  attr_reader :description

#==============================================================================
#                                   PRIVATE
#==============================================================================

  private

  # Initializes the directory. Returns +true+ if directory is valid, otherwise 
  # +false+.
  # @param _dirname [String] Directory name
  # @return [Boolean] +true+ if directory is valid, otherwise +false+.
  def init_dir(_dirname)
    @dirname  = _dirname
    _result   = true
    _result &&= has_dir?(@dirname)
    _result &&= has_dir?(@dirname, SYS.root_dir)
    _result
  end

  # Initializes the configuration. Returns +true+ if configuration is valid, 
  # otherwise +false+.
  # @return [Boolean] +true+ if configuration is valid, otherwise +false+.
  def init_config
    _result   = true
    _result &&= check_sys_attr(:platform_files)
    _result &&= check_sys_attr(:region_ids    )
    _result &&= check_sys_attr(:country_ids   )
    _result &&= check_sys_attr(:maker_ids     )
    _result &&= check_sys_attr(:maker_names   )
    _result &&= check_sys_attr(:product_ids   )
    _result &&= check_sys_attr(:product_names )
    _result
  end

  # Initializes the platform. Returns +true+ if platform has been detected, 
  # otherwise +false+.
  # @return [Boolean] +true+ if platform has been detected, otherwise +false+.
  def init_platform
    _result = false
    SYS.platform_files.find do |_id, _files|
      _result = _files.all? do |_path|
        !Dir.glob(join(_path)).empty?
      end
      
      @platform_id   = _id
      @platform_name = PLATFORMS[@platform_id] || ''
      refresh_sys_attr_resolver

      _result
    end

    if _result
      _msg  = sprintf(VOC.check_platform, @platform_id)
      _msg += sprintf(' - %s (%s)', VOC.detected, @platform_name)
      ALX::LOG.info(_msg)
    else
      _msg  = sprintf(VOC.check_platform, PLATFORMS.keys.sort.join(', '))
      _msg += sprintf(' - %s', VOC.not_matched)
      ALX::LOG.error(_msg)
    end

    _result
  end

  # Initializes the BNR file. Returns +true+ if BNR file is valid, otherwise 
  # +false+.
  # @return [Boolean] +true+ if BNR file is valid, otherwise +false+.
  def init_bnr
    _path = join(SYS.bnr_file)
    unless has_file?(_path)
      return false
    end
    
    _bnr = BnrFile.new
    _bnr.load(_path)
    
    @product_name = _bnr.product_name
    @maker_name   = _bnr.maker_name
    @description  = _bnr.description
    _result       = false
    refresh_sys_attr_resolver

    _msg = sprintf(VOC.check_bnr, VOC.product_name)
    if @product_name =~ sys(:product_names)
      _result  = true
      _msg    += sprintf(' - %s (%s)', VOC.valid    , @product_name)
      ALX::LOG.info(_msg)
    else
      _msg    += sprintf(' - %s (%s)', VOC.incorrect, @product_name)
      ALX::LOG.error(_msg)
    end
    
    if _result
      _msg = sprintf(VOC.check_bnr, VOC.maker_name)
      if @maker_name =~ sys(:maker_names)
        _result  = true
        _msg    += sprintf(' - %s (%s)', VOC.valid    , @maker_name)
        ALX::LOG.info(_msg)
      else
        _msg    += sprintf(' - %s (%s)', VOC.incorrect, @maker_name)
        ALX::LOG.error(_msg)
      end
    end
    
    _result
  end

  # Initializes the HDR file. Returns +true+ if HDR file is valid, otherwise 
  # +false+.
  # @return [Boolean] +true+ if HDR file is valid, otherwise +false+.
  def init_hdr
    _path = join(SYS.hdr_file)
    unless has_file?(_path)
      return false
    end
    
    _hdr = HdrFile.new
    _hdr.load(_path)

    @product_id  = _hdr.product_id
    @region_id   = _hdr.region_id
    refresh_sys_attr_resolver

    @region_name = sys(:region_ids)  || ''
    @country_id  = sys(:country_ids) || ''
    @maker_id    = _hdr.maker_id
    _result      = false
    refresh_sys_attr_resolver

    _msg = sprintf(VOC.check_hdr, VOC.product_id)
    if @product_id =~ sys(:product_ids)
      _result  = true
      _msg    += sprintf(' - %s (%s)', VOC.valid    , @product_id)
      ALX::LOG.info(_msg)
    else
      _msg    += sprintf(' - %s (%s)', VOC.incorrect, @product_id)
      ALX::LOG.error(_msg)
    end
    
    if _result
      _msg = sprintf(VOC.check_hdr, VOC.region_id)
      unless @region_name.empty?
        _result  = true
        _msg    += sprintf(' - %s (%s)', VOC.valid    , @region_id)
        ALX::LOG.info(_msg)
      else
        _msg    += sprintf(' - %s (%s)', VOC.incorrect, @region_id)
        ALX::LOG.error(_msg)
      end
    end
    
    if _result
      _msg  = sprintf(VOC.check_hdr, VOC.region_name)
      _msg += sprintf(' - %s (%s)', VOC.valid, @region_name)
      ALX::LOG.info(_msg)
    end

    if _result
      _msg = sprintf(VOC.check_hdr, VOC.country_id)
      if COUNTRIES.include?(@country_id)
        _result  = true
        _msg    += sprintf(' - %s (%s)', VOC.valid    , @country_id)
        ALX::LOG.info(_msg)
      else
        _msg    += sprintf(' - %s (%s)', VOC.incorrect, @country_id)
        ALX::LOG.error(_msg)
      end
    end

    if _result
      _msg = sprintf(VOC.check_hdr, VOC.maker_id)
      if @maker_id =~ sys(:maker_ids)
        _result  = true
        _msg    += sprintf(' - %s (%s)', VOC.valid    , @maker_id)
        ALX::LOG.info(_msg)
      else
        _msg    += sprintf(' - %s (%s)', VOC.incorrect, @maker_id)
        ALX::LOG.error(_msg)
      end
    end

    if _result
      _msg = sprintf(VOC.check_hdr, VOC.product_name)
      if _hdr.product_name =~ sys(:product_names)
        _result  = true
        _msg    += sprintf(' - %s (%s)', VOC.valid    , _hdr.product_name)
        ALX::LOG.info(_msg)
      else
        _msg    += sprintf(' - %s (%s)', VOC.incorrect, _hdr.product_name)
        ALX::LOG.error(_msg)
      end
    end
    
    _result
  end

  # Initializes the IP.BIN file. Returns +true+ if IP.BIN file is valid, 
  # otherwise +false+.
  # @return [Boolean] +true+ if IP.BIN file is valid, otherwise +false+.
  def init_ip
    false
  end

  # Refreshes the SYS attribute resolver.
  def refresh_sys_attr_resolver
    @sys_attr_rslvr.clear
    @sys_attr_rslvr << @product_id      unless @product_id.empty?
    @sys_attr_rslvr << @product_version unless @product_version.empty?
    @sys_attr_rslvr << @product_date    unless @product_date.empty?
    @sys_attr_rslvr << @region_id       unless @region_id.empty?
    @sys_attr_rslvr << @country_id      unless @country_id.empty?
  end

  # Returns +true+ if the SYS attribute is valid, otherwise +false+.
  # @param _sym [Symbol] Method symbol
  # @return [Boolean] +true+ if SYS attribute is valid, otherwise +false+.
  def check_sys_attr(_sym)
    _attr = SYS.send(_sym)
    _ids  = PLATFORMS.select do |_platform, _| 
      _attr.find(_platform) do |_key, _|
        _key.split('-').first == _platform
      end
    end
    _result = !_ids.empty?
    
    _msg = sprintf(VOC.check_sys_attr, "SYS.#{_sym}")
    if _result
      _msg += sprintf(' - %s (%s)', VOC.valid,     _ids.keys.join(', '))
      ALX::LOG.info(_msg)
    else
      _msg += sprintf(' - %s (%s)', VOC.incorrect, _ids.keys.join(', '))
      ALX::LOG.error(_msg)
    end
    
    _result
  end
  
end # class GameRoot

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
