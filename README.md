ALX - Skies of Arcadia Legends Examiner
=======================================

*ALX* is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from Skies of Arcadia Legends as well as Eternal 
Arcadia Legends. It is written in Ruby and is able to export and import the 
data to and from CSV files.

Features
--------

* Character skills (Super Moves and Magic)
* Character stats (EXP curves, Magic EXP curves and parameters)
* Crew members
* Enemy ship stats
* Enemy skills (Super Moves and Magic)
* Items (accessories, armors, ship cannons, ship accessories, ship items, 
  special items, usable items and weapons)
* Playable ship stats

Prerequisites
-------------

The commands respectively scripts in the `bin` directory require:

* [Ruby](https://www.ruby-lang.org/) 2.1.0+
* At least one extracted image of Skies of Arcadia Legends, or rather, Eternal 
  Arcadia Legends

The shipped and pre-exported CSV files in the subdirectories of `share` 
require:

* Spreadsheet application (e.g. [uniCSVed](http://csved.sjfrancke.nl/))
* Editor for plain text (e.g. [Notepad++](https://notepad-plus-plus.org/))

Download
--------

* You can get the latest official release on the SourceForge project website:
  https://sourceforge.net/projects/aex/files/latest/download
* You can also get the current development version from the GitHub repository:
  https://github.com/Taikocuya/ALX

Installation
------------

Put the files to some directory where you want it. Pre-exported CSV files with 
complete game data can already be found in the subdirectories `share/geaj8p` 
for NTSC-J, `share/geaj8p` for NTSC-U or `share/geae8p` for PAL-E.

The scripts require at least one extracted image of Skies of Arcadia Legends, 
or rather, Eternal Arcadia Legends in a new or existing subdirectory of 
`share`. To obtain these files, you need a corresponding game image (ISO or 
GCM) and [GCRebuilder](http://www.romhacking.net/utilities/619/). Please do not 
ask for download links.

Commands
--------

All commands respectively scripts can be found in the `bin` directory. 

### export.rb

Executes all export commands in `bin`.

### import.rb

Executes all import commands in `bin`.

Links
-----

* [EsoArcadia, the Skies of Arcadia resource](http://www.esoarcadia.org/)
* [EsoArcadia Wiki, a Skies of Arcadia wiki](http://www.esoarcadia.org/wiki)
* [EsoArcadia Forum, a Skies of Arcadia forum](http://www.esoarcadia.org/forum)

License
-------

Copyright (C) 2015 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
