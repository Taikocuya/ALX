ALX - Skies of Arcadia Legends Examiner
=======================================

ALX is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from the NTSC-U/C version of Skies of Arcadia 
Legends. It is written in Ruby and is able to export and import the data to 
and from CSV files.

Features
--------

Following game data can be exported and imported:
  * All items (e.g. accessories, armors, ship cannons, ship accessories, 
    ship items, special items, usable items and weapons)
  * Crew members

Prerequisites
-------------

This project requires:
  * Ruby 2.1.0+
  * DOL file from the NTSC-U/C version of Skies of Arcadia Legends

Download
--------

* You can get the latest official release from the GitHub releases:
  https://github.com/Tortigar/ALX/releases
* You can also get the current development version from the GitHub repository:
  https://github.com/Tortigar/ALX

Installation
------------

Put the files to some directory where you want it. The scripts require an 
extracted NTSC-U/C image of Skies of Arcadia Legends in the `share/bin` 
directory. To obtain this files, you need an image file (ISO or GCM) and 
[GCRebuilder](http://www.romhacking.net/utilities/619/). Please do not ask for
a download link.

Usage
-----

All commands respectively scripts can be found in the `bin` directory.

| Command                    | Description              |
| -------------------------- | ------------------------ |
| `exportaccessories.rb`     | Exports accessories      |
| `exportarmors.rb`          | Exports armos            |
| `exportcrewmembers.rb`     | Exports crew members     |
| `exportshipcannons.rb`     | Exports ship cannons     |
| `exportshipaccessories.rb` | Exports ship accessories |
| `exportshipitems.rb`       | Exports ship items       |
| `exportspecialitems.rb`    | Exports special items    |
| `exportusableitems.rb`     | Exports usable items     |
| `exportweapons.rb`         | Exports weapons          |
| `importaccessories.rb`     | Imports accessories      |
| `importarmors.rb`          | Imports armors           |
| `importcrewmembers.rb`     | Imports crew members     |
| `importshipcannons.rb`     | Imports ship cannons     |
| `importshipaccessories.rb` | Imports ship accessories |
| `importshipitems.rb`       | Imports ship items       |
| `importspecialitems.rb`    | Imports special items    |
| `importusableitems.rb`     | Imports usable items     |
| `importweapons.rb`         | Imports weapons          |

Links
-----

* [EsoArcadia, the Skies of Arcadia resource](http://www.esoarcadia.org/)
* [EsoArcadia Wiki, a Skies of Arcadia wiki](http://www.esoarcadia.org/wiki)
* [EsoArcadia Forum, a Skies of Arcadia forum](http://www.esoarcadia.org/forum)

License
-------

Copyright (C) 2015 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
