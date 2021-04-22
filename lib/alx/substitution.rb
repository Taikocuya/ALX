#******************************************************************************
# ALX - Skies of Arcadia Legends Examiner
# Copyright (C) 2021 Marcel Renner
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

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

module ALX

#==============================================================================
#                                    CLASS
#==============================================================================

# Class to handle a string substitution.
class Substitution

#==============================================================================
#                                  CONSTANTS
#==============================================================================

  # Regular expression for template names
  TEMPLATE_REGEXP = /({(?<name>[a-z]+)(?<quant>\d+)?})/

#==============================================================================
#                                   PUBLIC
#==============================================================================

  public

  # Constructs a Substitution
  # @param _pattern     [Regexp,String] Pattern
  # @param _replacement [String]        Replacement
  # @param platform     [String]        Platform
  # @param country      [String]        Country
  # @param verify       [Boolean]       Check string for consistency
  # @param stop         [Boolean]       Stop processing more substitutions
  # @see ::String#gsub
  def initialize(
    _pattern,
    _replacement = ''  ,
    platform:      ''  ,
    country:       ''  ,
    stop:          true,
    verify:        true
  )
    if !_pattern.is_a?(Regexp) && !_pattern.is_a?(String)
      _msg = '%s is not a regexp nor string'
      raise(TypeError, sprintf(_msg, _pattern.inspect))
    end
    unless _replacement.is_a?(String)
      raise(TypeError, sprintf('%s is not a string', _replacement.inspect))
    end
    unless platform.is_a?(String)
      raise(TypeError, sprintf('%s is not a string', platform.inspect))
    end
    unless country.is_a?(String)
      raise(TypeError, sprintf('%s is not a string', country.inspect))
    end

    @source      = _pattern
    @replacement = _replacement
    @platform    = platform
    @country     = country
    @stop        = !!stop
    @verify      = !!verify
    if _pattern.is_a?(Regexp)
      _options = _pattern.options
      _pattern = _pattern.source
    end

    @exact = (
      _replacement.empty?      &&
      /\A\\A/.match?(_pattern) &&
      /\\z\z/.match?(_pattern)
    )

    _pattern = _pattern.gsub(TEMPLATE_REGEXP) do
      _name  = Regexp.last_match(:name).to_sym
      _quant = Regexp.last_match(:quant)
      _templ = nil
      
      if respond_to?(_name)
        _templ = send(_name)
      end
      unless _templ.is_a?(Regexp)
        _msg = sprintf('regexp template invalid - %s', _name.to_s)
        raise(RegexpError, _msg)
      end
      _templ = _templ.to_s
      if _quant
        _quant = sprintf('{1,%s}', _quant)
      end

      sprintf('(?>%s%s)', _templ, _quant)
    end
    if _options
      _pattern = Regexp.new(_pattern, _options)
    end

    @pattern = _pattern
  end

  # Returns regular expression for a single-byte character (Windows-1252 only).
  # @return [Regexp] Regular expression for single-byte character.
  def singlew
    /[ \n\r\t\x21-\x7e\x85\xa1-\xff]/n
  end
  alias sngw singlew
  alias sng  singlew

  # Returns regular expression for a extension character (Windows-1252 only).
  # @return [Regexp] Regular expression for extension character.
  def extensionw
    /[\xa1-\xff]/n
  end
  alias extw extensionw
  alias ext  extensionw
  
  # Returns regular expression for a double-byte character (Shift_JIS only).
  # @return [Regexp] Regular expression for double-byte character.
  def doublej
    /(?>[ \n\r\t]|[\x81-\x9f\xe0-\xea][\x40-\xfc])/n
  end
  alias dblj doublej
  alias dbl  doublej
  
  # Returns regular expression for a double-byte character (Shift_JIS only).
  # @return [Regexp] Regular expression for double-byte character.
  def prefixj
    /[\x81-\x9f\xe0-\xea]/n
  end
  alias pfxj prefixj
  alias pfx  prefixj

  # Returns regular expression for a space character (Windows-1252 only).
  # @return [Regexp] Regular expression for space character.
  def blankw
    / /n
  end
  alias blkw blankw
  
  # Returns regular expression for a space character (Shift_JIS only).
  # @return [Regexp] Regular expression for space character.
  def blankj
    /(?> |\x81\x40)/n
  end
  alias blkj blankj

  # Returns regular expression for a space character.
  # @return [Regexp] Regular expression for space character.
  def blankx
    /(?> |\x81\x40)/n
  end
  alias blkx  blankx
  alias blk   blankx
  alias blank blankx

  # Returns regular expression for a whitespace character (Windows-1252 only).
  # @return [Regexp] Regular expression for whitespace character.
  def spacew
    /(?>[\n\r\t]|#{blankw})/n
  end
  alias spcw spacew

  # Returns regular expression for a whitespace character (Shift_JIS only).
  # @return [Regexp] Regular expression for whitespace character.
  def spacej
    /(?>[\n\r\t]|#{blankj})/n
  end
  alias spcj spacej

  # Returns regular expression for a whitespace character.
  # @return [Regexp] Regular expression for whitespace character.
  def spacex
    /(?>[\n\r\t]|#{blankx})/n
  end
  alias spcx  spacex
  alias spc   spacex
  alias space spacex

  # Returns regular expression for a punctuation or symbol (Windows-1252 only).
  # @return [Regexp] Regular expression for punctuation or symbol.
  def punctw
    /(?>
      [!"\#$%&'()*+,\-.\/:;<=>?@\[\\\]^_\x60{|}~]|
      [\x85\xa1-\xac\xae-\xbf\xd7\xf7]
    )/nx
  end
  alias pctw punctw
  
  # Returns regular expression for a punctuation or symbol (Shift_JIS only).
  # @return [Regexp] Regular expression for punctuation or symbol.
  def punctj
    /(?>
      [!"\#$%&'()*+,\-.\/:;<=>?@\[\\\]^_\x60{|}~]|
      [\xa1-\xa5\xdf]|\x81[\x41-\x51\x5c-\xfc]|\x84[\x9f-\xbe]
    )/nx
  end
  alias pctj punctj
  
  # Returns regular expression for a punctuation or symbol.
  # @return [Regexp] Regular expression for punctuation or symbol.
  def punctx
    /(?>
      [!"\#$%&'()*+,\-.\/:;<=>?@\[\\\]^_\x60{|}~]|
      [\x85\xa1-\xac\xae-\xbf\xd7\xf7]|
      [\xa1-\xa5\xdf]|\x81[\x41-\x51\x5c-\xfc]|\x84[\x9f-\xbe]
    )/nx
  end
  alias pctx  punctx
  alias pct   punctx
  alias punct punctx
  
  # Returns regular expression for a sprintf format.
  # @return [Regexp] Regular expression for sprintf format.
  def sprntf
    /
      (?<!%)(?>%%)*%
      (?>[\-\+0\ \#])?
      (?>\d+|\*)?
      (?>\.\*|\.\d+)?
      (?>[hjLltz]|[hl]{1,2})?
      (?>[AacdEeFfGginopsuXx])
    /nx
  end

  # Returns regular expression for a punctuation or symbol (Windows-1252 only) 
  # without sprintf formats.
  # @return [Regexp] Regular expression for punctuation or symbol.
  def fpunctw
    /(?>(?!#{sprntf})#{punctw})/n
  end
  alias fpctw fpunctw

  # Returns regular expression for a punctuation or symbol (Shift_JIS only) 
  # without sprintf formats.
  # @return [Regexp] Regular expression for punctuation or symbol.
  def fpunctj
    /(?>(?!#{sprntf})#{punctj})/n
  end
  alias fpctj fpunctj

  # Returns regular expression for a punctuation or symbol without sprintf 
  # formats.
  # @return [Regexp] Regular expression for punctuation or symbol.
  def fpunctx
    /(?>(?!#{sprntf})#{punctx})/n
  end
  alias fpctx  fpunctx
  alias fpct   fpunctx
  alias fpunct fpunctx
  
  # Returns regular expression for an end punctuation (Windows-1252 only).
  # @return [Regexp] Regular expression for end punctuation.
  def finalw
    /(?>[!.?\x85\xa1\xbf])/n
  end
  alias finw finalw
  
  # Returns regular expression for an end punctuation (Shift_JIS only).
  # @return [Regexp] Regular expression for end punctuation.
  def finalj
    /(?>[!.?\xa1]|\x81[\x42\x48\x49\x63])/n
  end
  alias finj finalj
  
  # Returns regular expression for an end punctuation.
  # @return [Regexp] Regular expression for end punctuation.
  def finalx
    /(?>[!.?\x85\xa1\xbf]|\x81[\x42\x48\x49\x63])/n
  end
  alias finx  finalx
  alias fin   finalx
  alias final finalx

  # Returns regular expression for a space character, punctuation or symbol 
  # without sprintf formats (Windows-1252 only).
  # @return [Regexp] Regular expression for space character, punctuation or 
  #                  symbol.
  def fblankw
    /(?>#{blankw}|#{fpunctw})/n
  end
  alias fblkw fblankw

  # Returns regular expression for a space character, punctuation or symbol 
  # without sprintf formats (Shift_JIS only).
  # @return [Regexp] Regular expression for space character, punctuation or 
  #                  symbol.
  def fblankj
    /(?>#{blankj}|#{fpunctj})/n
  end
  alias fblkj fblankj

  # Returns regular expression for a space character, punctuation or symbol 
  # without sprintf formats.
  # @return [Regexp] Regular expression for space character, punctuation or 
  #                  symbol.
  def fblankx
    /(?>#{blankx}|#{fpunctx})/n
  end
  alias fblkx  fblankx
  alias fblk   fblankx
  alias fblank fblankx

  # Returns regular expression for a whitespace character, punctuation or 
  # symbol without sprintf formats (Windows-1252 only).
  # @return [Regexp] Regular expression for whitespace character, punctuation 
  #                  or symbol.
  def fspacew
    /(?>#{spacew}|#{fpunctw})/n
  end
  alias fspcw fspacew

  # Returns regular expression for a whitespace character, punctuation or 
  # symbol without sprintf formats (Shift_JIS only).
  # @return [Regexp] Regular expression for whitespace character, punctuation 
  #                  or symbol.
  def fspacej
    /(?>#{spacej}|#{fpunctj})/n
  end
  alias fspcj fspacej

  # Returns regular expression for a whitespace character, punctuation or 
  # symbol without sprintf formats.
  # @return [Regexp] Regular expression for whitespace character, punctuation 
  #                  or symbol.
  def fspacex
    /(?>#{fspacew}|#{fspacej})/n
  end
  alias fspcx  fspacex
  alias fspc   fspacex
  alias fspace fspacex

  # Returns regular expression for a digit (Windows-1252 only).
  # @return [Regexp] Regular expression for 1-byte digit.
  def digitw
    /[0-9]/n
  end
  alias dgtw digitw
  
  # Returns regular expression for a digit (Shift_JIS only).
  # @return [Regexp] Regular expression for digit.
  def digitj
    /(?>[0-9]|\x82[\x4f-\x58])/n
  end
  alias dgtj digitj

  # Returns regular expression for a digit.
  # @return [Regexp] Regular expression for digit.
  def digitx
    /(?>[0-9]|\x82[\x4f-\x58])/n
  end
  alias dgtx  digitx
  alias dgt   digitx
  alias digit digitx
  
  # Returns regular expression for a uppercase letter (Windows-1252 only).
  # @return [Regexp] Regular expression for uppercase letter.
  def upperw
    /[A-Z]/n
  end
  alias uprw upperw
  
  # Returns regular expression for a uppercase letter (Shift_JIS only).
  # @return [Regexp] Regular expression for uppercase letter.
  def upperj
    /(?>[A-Z]|\x82[\x60-\x79])/n
  end
  alias uprj upperj
  
  # Returns regular expression for a uppercase letter.
  # @return [Regexp] Regular expression for uppercase letter.
  def upperx
    /(?>[A-Z]|\x82[\x60-\x79])/n
  end
  alias uprx  upperx
  alias upr   upperx
  alias upper upperx
  
  # Returns regular expression for a lowercase letter (Windows-1252 only).
  # @return [Regexp] Regular expression for lowercase letter.
  def lowerw
    /[a-z]/n
  end
  alias lwrw lowerw
  
  # Returns regular expression for a lowercase letter (Shift_JIS only).
  # @return [Regexp] Regular expression for lowercase letter.
  def lowerj
    /(?>[a-z]|\x82[\x81-\x9a])/n
  end
  alias jlwrj lowerj
  
  # Returns regular expression for a lowercase letter.
  # @return [Regexp] Regular expression for lowercase letter.
  def lowerx
    /(?>[a-z]|\x82[\x81-\x9a])/n
  end
  alias lwrx  lowerx
  alias lwr   lowerx
  alias lower lowerx
  
  # Returns regular expression for a alphabetic character (Windows-1252 only).
  # @return [Regexp] Regular expression for alphabetic character.
  def alphaw
    /(?>#{upperw}|#{lowerw})/n
  end
  alias alpw alphaw
  
  # Returns regular expression for a alphabetic character (Shift_JIS only).
  # @return [Regexp] Regular expression for alphabetic character.
  def alphaj
    /(?>#{upperj}|#{lowerj})/n
  end
  alias alpj alphaj
  
  # Returns regular expression for a alphabetic character.
  # @return [Regexp] Regular expression for alphabetic character.
  def alphax
    /(?>#{upperx}|#{lowerx})/n
  end
  alias alpx  alphax
  alias alp   alphax
  alias alpha alphax

  # Returns regular expression for a uppercase diacritic (Windows-1252 only).
  # @return [Regexp] Regular expression for uppercase diacritic.
  def udiacw
    /[\xc0-\xd6\xd8-\xde]/n
  end
  alias udia udiacw

  # Returns regular expression for a lowercase diacritic (Windows-1252 only).
  # @return [Regexp] Regular expression for lowercase diacritic.
  def ldiacw
    /[\xdf-\xf6\xf8-\xff]/n
  end
  alias ldia ldiacw
  
  # Returns regular expression for a diacritic (Windows-1252 only).
  # @return [Regexp] Regular expression for diacritic.
  def adiacw
    /(?>#{udiacw}|#{ldiacw})/n
  end
  alias adiac adiacw
  alias dia   adiacw
  
  # Returns regular expression for a alphanumeric character (Windows-1252
  # only).
  # @return [Regexp] Regular expression for alphanumeric character.
  def alnumw
    /(?>#{digitw}|#{alphaw})/n
  end
  
  # Returns regular expression for a alphanumeric character (Shift_JIS only).
  # @return [Regexp] Regular expression for alphanumeric character.
  def alnumj
    /(?>#{digitj}|#{alphaj})/n
  end
  
  # Returns regular expression for a alphanumeric character (Windows-1252 
  # only).
  # @return [Regexp] Regular expression for alphanumeric character.
  def alnumx
    /(?>#{digitx}|#{alphax})/n
  end
  alias alnum alnumx
  
  # Returns regular expression a for a Japanese character (Shift_JIS only).
  # @return [Regexp] Regular expression for Japanese character.
  def japanj
    /(?>
      [\xa6-\xde]|
      \x81[\x52-\x5b]|
      \x82[\x9f-\xf1]|
      [\x83-\x9f\xe0-\xea][\x40-\xfc]
    )/nx
  end
  alias japj  japanj
  alias jap   japanj
  alias japan japanj

  # Returns regular expression for a digit or a Japanese character (Shift_JIS 
  # only).
  # @return [Regexp] Regular expression for digit or Japanese character.
  def japnumj
    /(?>#{digitj}|#{japanj})/n
  end
  alias japnum japnumj

  # Returns regular expression for a Latin or Japanese character (Shift_JIS 
  # only).
  # @return [Regexp] Regular expression for Latin or Japanese character.
  def aljapj
    /(?>#{alphaj}|#{japanj})/n
  end
  alias aljap aljapj

  # Returns regular expression for a digit, Latin or Japanese character 
  # (Shift_JIS only).
  # @return [Regexp] Regular expression for digit, Latin or Japanese
  #                  character.
  def aljapnumj
    /(?>#{alnumj}|#{japnumj})/n
  end
  alias aljapnum aljapnumj

  # Returns regular expression for any character (Windows-1252).
  # @return [Regexp] Regular expression for any character.
  def anyw
    /(?>#{spacew}|#{punctw}|#{alnumw}|#{adiacw})/n
  end

  # Returns regular expression for any character (Shift_JIS only).
  # @return [Regexp] Regular expression for any character.
  def anyj
    /(?>#{spacej}|#{punctj}|#{aljapnumj})/n
  end

  # Returns regular expression for any character.
  # @return [Regexp] Regular expression for any character.
  def anyx
    /(?>#{anyw}|#{anyj})/n
  end
  alias any anyx

  # Returns regular expression for a word (Windows-1252 only).
  # @return [Regexp] Regular expression for word.
  def wordw
    /(?>#{digitw}+|#{upperw}?#{lowerw}+(?>[\-']#{lowerw}+)?|#{upperw}+)/n
  end
  alias wrdw wordw
  
  # Returns regular expression for a word (Shift_JIS only).
  # @return [Regexp] Regular expression for word.
  def wordj
    /(?>#{digitj}+|#{upperj}?#{lowerj}+(?>[\-']#{lowerj}+)?|#{upperj}+)/n
  end
  alias wrdj wordj
  
  # Returns regular expression for a word.
  # @return [Regexp] Regular expression for word.
  def wordx
    /(?>#{digitx}+|#{upperx}?#{lowerx}+(?>[\-']#{lowerx}+)?|#{upperx}+)/n
  end
  alias wrdx wordx
  alias wrd  wordx
  alias word wordx

  # Returns regular expression for a word group (Windows-1252 only).
  # @return [Regexp] Regular expression for word group.
  def wordgroupw
    /(?>#{wordw}(?>#{spacew}#{wordw})+)/n
  end
  alias wrdgrpw wordgroupw
  
  # Returns regular expression for a word group (Shift_JIS only).
  # @return [Regexp] Regular expression for word group.
  def wordgroupj
    /(?>#{wordj}(?>#{spacej}#{wordj})+)/n
  end
  alias wrdgrpj wordgroupj
  
  # Returns regular expression for a word group.
  # @return [Regexp] Regular expression for word group.
  def wordgroupx
    /(?>#{wordx}(?>#{spacex}#{wordx})+)/n
  end
  alias wrdgrpx   wordgroupx
  alias wrdgrp    wordgroupx
  alias wordgroup wordgroupx

  # Returns regular expression for a clause (Windows-1252 only).
  # @return [Regexp] Regular expression for clause.
  def clausew
    /(?>#{wordgroupw}(?>(?>[,:;]#{spacew}|--)#{wordgroupw})*)/n
  end
  alias clsw clausew
  
  # Returns regular expression for a clause (Shift_JIS only).
  # @return [Regexp] Regular expression for clause.
  def clausej
    /(?>#{wordgroupj}(?>(?>[,:;]#{spacej}|--)#{wordgroupj})*)/n
  end
  alias clsj clausej
  
  # Returns regular expression for a clause.
  # @return [Regexp] Regular expression for clause.
  def clausex
    /(?>#{wordgroupx}(?>(?>[,:;]#{spacex}|--)#{wordgroupx})*)/n
  end
  alias clsx   clausex
  alias cls    clausex
  alias clause clausex

  # Returns regular expression for a sentence (Windows-1252 only).
  # @return [Regexp] Regular expression for sentence.
  def sentencew
    /(?>
      (?>#{clausew}#{finalw})|
      (?>#{clausew}#{spacew}\(#{clausew}\)#{finalw})|
      (?>#{clausew}#{spacew}\[#{clausew}\]#{finalw})|
      (?>#{clausew}#{spacew}\[#{clausew}#{finalw}\])
    )/nx
  end
  alias stcw sentencew

  # Returns regular expression for a sentence (Shift_JIS only).
  # @return [Regexp] Regular expression for sentence.
  def sentencej
    /(?>
      (?>#{clausej}#{finalj})|
      (?>#{clausej}#{spacej}\(#{clausej}\)#{finalj})|
      (?>#{clausej}#{spacej}\[#{clausej}\]#{finalj})|
      (?>#{clausej}#{spacej}\[#{clausej}#{finalj}\])
    )/nx
  end
  alias stcj sentencej
  
  # Returns regular expression for a sentence.
  # @return [Regexp] Regular expression for sentence.
  def sentencex
    /(?>
      (?>#{clausex}#{finalx})|
      (?>#{clausex}#{spacex}\(#{clausex}\)#{finalx})|
      (?>#{clausex}#{spacex}\[#{clausex}\]#{finalx})|
      (?>#{clausex}#{spacex}\[#{clausex}#{finalx}\])
    )/nx
  end
  alias stcx  sentencex
  alias stc   sentencex
  alias sntnc sentencex

  # Returns regular expression for a paragraph (Windows-1252 only).
  # @return [Regexp] Regular expression for paragraph.
  def paragraphw
    /(?>#{sentencew}(?>#{spacew}#{sentencew})*)/n
  end
  alias prgw paragraphw
  
  # Returns regular expression for a paragraph (Shift_JIS only).
  # @return [Regexp] Regular expression for paragraph.
  def paragraphj
    /(?>#{sentencej}(?>#{spacej}#{sentencej})*)/n
  end
  alias prgj paragraphj
  
  # Returns regular expression for a paragraph.
  # @return [Regexp] Regular expression for paragraph.
  def paragraphx
    /(?>#{sentencex}(?>#{spacex}#{sentencex})*)/n
  end
  alias prgx      paragraphx
  alias prg       paragraphx
  alias paragraph paragraphx

  # Returns regular expression for a directory name (Windows-1252 only).
  # @return [Regexp] Regular expression for directory name.
  def dir
    /(?>(?>#{alnumw}|&)+)/n
  end
  
  # Returns regular expression for a filename (Windows-1252 only).
  # @return [Regexp] Regular expression for filename.
  def file
    /(?>(?>#{alnumw}|_|#{sprntf})+(?>\.#{alphaw}(?>#{alnumw}){2,4}))/n
  end

  # Returns regular expression for a file path (Windows-1252 only).
  # @return [Regexp] Regular expression for file path.
  def path
    /(?>
      (?>(?>#{alphaw}:|\.\.?)?(?>\/|\\))?(?>#{dir}(?>\/|\\))*(?<=\/|\\)#{file}
    )/nx
  end

  # Returns regular expression for a function name (Windows-1252 only).
  # @return [Regexp] Regular expression for function name.
  def funct
    /(?>
      (?>#{upperw}?#{lowerw}+|#{upperw}+)
      (?>_?(?>#{digitw}+|#{upperw}?#{lowerw}+|#{upperw}+))*
    )/nx
  end

#------------------------------------------------------------------------------
# Public Member Variables
#------------------------------------------------------------------------------

  attr_reader :pattern
  attr_reader :source
  attr_reader :replacement
  attr_reader :platform
  attr_reader :country
  attr_reader :stop
  attr_reader :verify
  
  def exact?
    @exact
  end
  
  def partial?
    !@exact
  end

end # class Substitution

# -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

end # module ALX
