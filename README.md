ALX - Skies of Arcadia Legends Examiner
=======================================

ALX is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from the NTSC-U/C version of Skies of Arcadia 
Legends. It is written in Ruby and is able to export and import the data to 
and from CSV files.

Features
--------

* Items (accessories, armors, ship cannons, ship accessories, ship items, 
special items, usable items and weapons)
* Crew members

Prerequisites
-------------

The shipped and pre-exported CSV files in the `share/csv` directory require:

* Spreadsheet application
* Еditor for plain text

The commands respectively scripts in the `bin` directory require:

* Ruby 2.1.0+
* Extracted NTSC-U/C image of Skies of Arcadia Legends

Download
--------

* You can get the latest official release from the GitHub releases:
  https://github.com/Taikocuya/ALX/releases
* You can also get the current development version from the GitHub repository:
  https://github.com/Taikocuya/ALX

Installation
------------

Put the files to some directory where you want it. Sample CSV files with all 
exported data can already be found in the `share/csv` directory. The scripts 
require an extracted NTSC-U/C image of Skies of Arcadia Legends in the 
`share/root` directory. To obtain this files, you need an image file (ISO or 
GCM) and [GCRebuilder](http://www.romhacking.net/utilities/619/). Please do 
not ask for a download link.

Commands
--------

All commands respectively scripts can be found in the `bin` directory. 

### exportaccessories.rb

Exports the accessories to `share/csv/accessories.csv`.

### exportarmors.rb

Exports the armos to `share/csv/armors.csv`.

### exportcrewmembers.rb

Exports the crew members to `share/csv/crewmembers.csv`.

### exportshipcannons.rb

Exports the ship cannons to `share/csv/shipcannons.csv`.

### exportshipaccessories.rb

Exports the ship accessories to `share/csv/shipaccessories.csv`.

### exportshipitems.rb

Exports the ship items to `share/csv/shipitems.csv`.

### exportspecialitems.rb

Exports the special items to `share/csv/specialitems.csv`.

### exportusableitems.rb

Exports the usable items to `share/csv/usableitems.csv`.

### exportweapons.rb

Exports the weapons to `share/csv/weapons.csv`.

### importaccessories.rb

Imports the accessories to `share/root/&&systemdata/Start.dol`.

### importarmors.rb

Imports the armors to `share/root/&&systemdata/Start.dol`.

### importcrewmembers.rb

Imports the crew members to `share/root/&&systemdata/Start.dol`.

### importshipcannons.rb

Imports the ship cannons to `share/root/&&systemdata/Start.dol`.

### importshipaccessories.rb

Imports the ship accessories to `share/root/&&systemdata/Start.dol`.

### importshipitems.rb

Imports the ship items to `share/root/&&systemdata/Start.dol`.

### importspecialitems.rb

Imports the special items to `share/root/&&systemdata/Start.dol`.

### importusableitems.rb

Imports the usable items to `share/root/&&systemdata/Start.dol`.

### importweapons.rb

Imports the weapons to `share/root/&&systemdata/Start.dol`.

Links
-----

* [EsoArcadia, the Skies of Arcadia resource](http://www.esoarcadia.org/)
* [EsoArcadia Wiki, a Skies of Arcadia wiki](http://www.esoarcadia.org/wiki)
* [EsoArcadia Forum, a Skies of Arcadia forum](http://www.esoarcadia.org/forum)

License
-------

Copyright (C) 2015 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
