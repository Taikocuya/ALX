ALX - Skies of Arcadia Legends Examiner
=======================================

*ALX* is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from Skies of Arcadia Legends as well as Eternal 
Arcadia Legends. It is written in Ruby and is able to export and import the 
data to and from CSV files.

Features
--------

* Character skills (Super Moves and Magics)
* Character stats (EXP curves, Magic EXP curves and parameters)
* Crew members
* Enemy ship stats
* Enemy skills (Super Moves and Magics)
* Enemy stats (action patterns, encounters, events and parameters)
* Items (accessories, armors, ship cannons, ship accessories, ship items, 
  special items, usable items and weapons)
* Playable ship stats
* Shops

Prerequisites
-------------

The commands respectively scripts in the `bin` directory require:

* [Ruby](https://www.ruby-lang.org/) 2.4.0+
* At least one extracted image of Skies of Arcadia Legends, or rather, Eternal 
  Arcadia Legends

The shipped and pre-exported CSV files in the subdirectories of `share` 
require:

* Spreadsheet application with UTF-8 support (e.g. 
  [LibreOffice Calc](https://www.libreoffice.org/) or 
  [uniCSVed](http://csved.sjfrancke.nl/))
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
complete game data can already be found in the subdirectories:

* `share/geaj8p/csv` for NTSC-J
* `share/geaj8p/csv` for NTSC-U
* `share/geae8p/csv` for PAL-E

The scripts require at least one extracted image of Skies of Arcadia Legends, 
or rather, Eternal Arcadia Legends. The directory structure should look like 
this:

* `share/*/csv` (replace the asterisk with any name you choose, i.e. 
  `share/geae8p/csv` or similar) for CSV files
* `share/*/root` (replace the asterisk with any name you choose, i.e. 
  `share/geae8p/root` or similar) for game data

To obtain the game files, you need a corresponding image (ISO or GCM) and 
[GCRebuilder](http://www.romhacking.net/utilities/619/). Please do not ask for 
download links.

Commands
--------

All commands respectively scripts can be found in the `bin` directory. 

### export.rb

Executes all export commands in `bin`.

### import.rb

Executes all import commands in `bin`.

Links
-----

* [Skies of Arcadia Wiki](https://skiesofarcadia.gamepedia.com/)

License
-------

Copyright (C) 2018 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
