ALX - Skies of Arcadia Legends Examiner
=======================================

*ALX* is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from Skies of Arcadia Legends as well as Eternal 
Arcadia Legends. It is written in Ruby and is able to export and import the 
data to and from CSV files.

Features
--------

* Items (accessories, armors, ship cannons, ship accessories, ship items, 
  special items, usable items and weapons)
* Crew members

Prerequisites
-------------

The commands respectively scripts in the `bin` directory require:

* [Ruby](https://www.ruby-lang.org/) 2.1.0+
* At least one extracted image of Skies of Arcadia Legends, or rather, Eternal 
  Arcadia Legends in a subdirectory of `share`

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
all game data can already be found in the subdirectories `share/geaj8p` for 
NTSC-J, `share/geaj8p` for NTSC-U or `share/geae8p` for PAL-E.

The scripts require at least one extracted image of Skies of Arcadia Legends, 
or rather, Eternal Arcadia Legends in a new or existing subdirectory of 
`share`. To obtain these files, you need a corresponding game image (ISO or 
GCM) and [GCRebuilder](http://www.romhacking.net/utilities/619/). Please do not 
ask for download links.

Commands
--------

All commands respectively scripts can be found in the `bin` directory. 

### exportaccessories.rb

Exports the accessories to `share/.../accessories.csv`.

### exportarmors.rb

Exports the armos to `share/.../armors.csv`.

### exportcrewmembers.rb

Exports the crew members to `share/.../crewmembers.csv`.

### exportshipcannons.rb

Exports the ship cannons to `share/.../shipcannons.csv`.

### exportshipaccessories.rb

Exports the ship accessories to `share/.../shipaccessories.csv`.

### exportshipitems.rb

Exports the ship items to `share/.../shipitems.csv`.

### exportspecialitems.rb

Exports the special items to `share/.../specialitems.csv`.

### exportusableitems.rb

Exports the usable items to `share/.../usableitems.csv`.

### exportweapons.rb

Exports the weapons to `share/.../weapons.csv`.

### importaccessories.rb

Imports the accessories to `share/.../&&systemdata/Start.dol`.

### importarmors.rb

Imports the armors to `share/.../&&systemdata/Start.dol`.

### importcrewmembers.rb

Imports the crew members to `share/.../&&systemdata/Start.dol`.

### importshipcannons.rb

Imports the ship cannons to `share/.../&&systemdata/Start.dol`.

### importshipaccessories.rb

Imports the ship accessories to `share/.../&&systemdata/Start.dol`.

### importshipitems.rb

Imports the ship items to `share/.../&&systemdata/Start.dol`.

### importspecialitems.rb

Imports the special items to `share/.../&&systemdata/Start.dol`.

### importusableitems.rb

Imports the usable items to `share/.../&&systemdata/Start.dol`.

### importweapons.rb

Imports the weapons to `share/.../&&systemdata/Start.dol`.

Links
-----

* [EsoArcadia, the Skies of Arcadia resource](http://www.esoarcadia.org/)
* [EsoArcadia Wiki, a Skies of Arcadia wiki](http://www.esoarcadia.org/wiki)
* [EsoArcadia Forum, a Skies of Arcadia forum](http://www.esoarcadia.org/forum)

License
-------

Copyright (C) 2015 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
