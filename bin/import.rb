#!/usr/bin/ruby
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

require_relative('../lib/alx/entrytransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to execute all import commands.
class Importer < EntryTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public
  
  def initialize
    super(nil)
    
    @files  = []
    @files << OpenStruct.new(prio: 20, file: 'importaccessory.rb')
    @files << OpenStruct.new(prio: 20, file: 'importarmor.rb')
    @files << OpenStruct.new(prio: 30, file: 'importcharacter.rb')
    @files << OpenStruct.new(prio: 40, file: 'importcharactermagic.rb')
    @files << OpenStruct.new(prio: 40, file: 'importcharactersupermove.rb')
    @files << OpenStruct.new(prio: 20, file: 'importcrewmember.rb')
    @files << OpenStruct.new(prio: 30, file: 'importenemy.rb')
    @files << OpenStruct.new(prio: 40, file: 'importenemymagic.rb')
    @files << OpenStruct.new(prio: 30, file: 'importenemyship.rb')
    @files << OpenStruct.new(prio: 30, file: 'importenemyshiptask.rb')
    @files << OpenStruct.new(prio: 40, file: 'importenemysupermove.rb')
    @files << OpenStruct.new(prio: 40, file: 'importexpcurve.rb')
    @files << OpenStruct.new(prio: 40, file: 'importmagicexpcurve.rb')
    @files << OpenStruct.new(prio: 30, file: 'importplayableship.rb')
    @files << OpenStruct.new(prio: 20, file: 'importshipaccessory.rb')
    @files << OpenStruct.new(prio: 20, file: 'importshipcannon.rb')
    @files << OpenStruct.new(prio: 20, file: 'importshipitem.rb')
    @files << OpenStruct.new(prio: 30, file: 'importshop.rb')
    @files << OpenStruct.new(prio: 20, file: 'importspecialitem.rb')
    @files << OpenStruct.new(prio: 40, file: 'importspiritcurve.rb')
    @files << OpenStruct.new(prio: 20, file: 'importswashbuckler.rb')
    @files << OpenStruct.new(prio: 30, file: 'importtreasurechest.rb')
    @files << OpenStruct.new(prio: 20, file: 'importusableitem.rb')
    @files << OpenStruct.new(prio: 20, file: 'importweapon.rb')
    @files << OpenStruct.new(prio: 10, file: 'importweaponeffect.rb')
    
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
        _result &&= has_file?(File.join(File.dirname(__FILE__), _p))
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

end	# class Importer

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0
  ALX::Main.call do
    _importer = ALX::Importer.new
    _importer.exec
  end
end
