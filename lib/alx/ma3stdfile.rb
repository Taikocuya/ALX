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

require_relative('characteranimation.rb')
require_relative('charactermovement.rb')
require_relative('mx3stdfile.rb')

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to read and write MA000.STD files.
class Ma3StdFile < Mx3StdFile

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Mb3StdFile.
  def initialize
    super(CharacterAnimation, CharacterMovement)
    @characters = {}
    @items      = {}
  end

  # Creates a character animation.
  # @param _id       [Integer] Character animation ID
  # @param _filename [String]  File name
  # @return [Entry] CharacterAnimation object
  def create_animation(_id = -1, _filename = '*')
    _animation            = super
    _animation.characters = @characters
    _animation.items      = @items
    _animation
  end

  # Creates a character movement.
  # @param _id       [Integer] Character movement ID
  # @param _filename [String]  File name
  # @return [Entry] CharacterMovement object
  def create_movement(_id = -1, _filename = '*')
    _movement            = super
    _movement.characters = @characters
    _movement.items      = @items
    _movement
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_accessor :characters
  attr_accessor :items

end # class Ma3StdFile

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
