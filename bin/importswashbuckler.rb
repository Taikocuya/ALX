#!/usr/bin/ruby
#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2023 Marcel Renner
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

require_relative('../lib/alx/swashbucklertransform.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to import swashbuckler ratings from CSV files.
class SwashbucklerImporter < SwashbucklerTransform

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  def valid?
    _result   = super
    _result &&= has_file?(Root.dirname, SYS.weapon_effect_csv_file)
    _result
  end

  def update
    super
    if Worker.child?
      transform_csv_to_bin
    end
  end

end	# class SwashbucklerImporter

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end	# module ALX

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

if __FILE__ == $0 || Object.const_defined?('ALX::Importer')
  ALX::Main.call do
    _importer = ALX::SwashbucklerImporter.new
    _importer.exec
  end
end
