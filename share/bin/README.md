ALX - Skies of Arcadia Legends Examiner
=======================================

ALX is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from the NTSC-U/C version of Skies of Arcadia 
Legends. It is written in Ruby and is able to export and import the data to 
and from CSV files.

Features
--------

* Items:
  * Accessories
  * Armors
  * Ship cannons
  * Ship accessories
  * Ship items
  * Special items
  * Usable items
  * Weapons
* Crew members

Prerequisites
-------------

This project requires:
  * Ruby 2.1.0+
  * DOL file from the NTSC-U/C version of Skies of Arcadia Legends

Download
--------

* You can get the latest official release from the GitHub releases: http://
* You can also get the current development version from the GitHub repository: http://

Installation
------------

Put the files to some directory where you want it. The scripts require the 
`Start.dol` file from the NTSC-U/C version of Skies of Arcadia Legends in the 
`share/bin/&&systemdata` directory. To obtain this file, you need a NTSC-U/C 
image (please do not ask for a download link) and [GCRebuilder](http://www.romhacking.net/utilities/619/).

Usage
-----

All commands respectively scripts can be found in the `bin` directory.

| Command                   | Description              |
| ------------------------- | ------------------------ |
| `exportaccessories.rb`  | Exports accessories      |
| `exportarmors.rb`       | Exports armos            |
| `exportcrewmembers`     | Exports crew members     |
| `exportshipcannons`     | Exports ship cannons     |
| `exportshipaccessories` | Exports ship accessories |
| `exportshipitems`       | Exports ship items       |
| `exportspecialitems`    | Exports special items    |
| `exportusableitems`     | Exports usable items     |
| `exportweapons`         | Exports weapons          |
| `importaccessories`     | Imports accessories      |
| `importarmors`          | Imports armors           |
| `importcrewmembers`     | Imports crew members     |
| `importshipcannons`     | Imports ship cannons     |
| `importshipaccessories` | Imports ship accessories |
| `importshipitems`       | Imports ship items       |
| `importspecialitems`    | Imports special items    |
| `importusableitems`     | Imports usable items     |
| `importweapons`         | Imports weapons          |

Links
-----

* [EsoArcadia, the Skies of Arcadia resource](http://www.esoarcadia.org/)
* [EsoArcadia Wiki, a Skies of Arcadia wiki](http://www.esoarcadia.org/wiki)
* [EsoArcadia Forum, a Skies of Arcadia forum]((http://www.esoarcadia.org/forum)

License
-------

Copyright (C) 2015 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
