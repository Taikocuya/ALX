#!/usr/bin/ruby
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
# with ALX.  If not, see <httprio://www.gnu.org/licenses/>.
#******************************************************************************

#==============================================================================
#                                 REQUIREMENTS
#==============================================================================

require('ostruct')
require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to execute all export commands.
class Exporter < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  def initialize
    super(nil)

    @files  = []
    @files << OpenStruct.new(prio: 20, file: 'exportaccessory.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportarmor.rb')
    @files << OpenStruct.new(prio: 30, file: 'exportcharacter.rb')
    @files << OpenStruct.new(prio: 50, file: 'exportcharacteranimation.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportcharactermagic.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportcharactersupermove.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportcrewmember.rb')
    @files << OpenStruct.new(prio: 30, file: 'exportenemy.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportenemyanimation.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportenemymagic.rb')
    @files << OpenStruct.new(prio: 30, file: 'exportenemyship.rb')
    @files << OpenStruct.new(prio: 30, file: 'exportenemyshiptask.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportenemysupermove.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportexpcurve.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportmagicexpcurve.rb')
    @files << OpenStruct.new(prio: 30, file: 'exportplayableship.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportshipaccessory.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportshipcannon.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportshipitem.rb')
    @files << OpenStruct.new(prio: 30, file: 'exportshop.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportspecialitem.rb')
    @files << OpenStruct.new(prio: 40, file: 'exportspiritcurve.rb')
    @files << OpenStruct.new(prio:  5, file: 'exportstringtableentry.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportswashbuckler.rb')
    @files << OpenStruct.new(prio: 30, file: 'exporttreasurechest.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportusableitem.rb')
    @files << OpenStruct.new(prio: 20, file: 'exportweapon.rb')
    @files << OpenStruct.new(prio: 10, file: 'exportweaponeffect.rb')
    
    @files.sort! do |_a, _b|
      _comp = (_a.prio <=> _b.prio)
      _comp = (_a.file <=> _b.file) if _comp == 0
      _comp
    end
    @files.collect! do |_f|
      File.join(File.dirname(__FILE__), _f.file)
    end
  end

  def valid?
    _result = super
    
    if Worker.parent?
      @files.each do |_p|
        _result &&= has_file?(_p)
      end
    end
    
    _result
  end

  def update
    super
    
    if Worker.child?
      @files.each do |_p|
        require(_p)
      end
    end
  end

end	# class Exporter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _exporter = ALX::Exporter.new
    _exporter.exec
  end
end
