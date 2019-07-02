ALX - Skies of Arcadia Legends Examiner
=======================================

*ALX* is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from Skies of Arcadia, Skies of Arcadia Legends,
Eternal Arcadia, as well as Eternal Arcadia Legends. It is written in Ruby and 
is able to export and import the data to and from CSV files.

Features
--------

* Character skills (Super Moves and Magics)
* Character stats (EXP curves, Magic EXP curves, parameters and spirit curves)
* Crew members
* Enemy ship stats (action patterns and parameters)
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
* At least one extracted image of Skies of Arcadia, Skies of Arcadia Legends, 
  Eternal Arcadia, or Eternal Arcadia Legends

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
complete game data can already be found in the subdirectories.

| Path                    | Platform  | Region  | Notes                     |
|:-----------------------:|:---------:|:-------:|:-------------------------:|
| `share/dc-eu-dreamon`   | Dreamcast | PAL-E   | Dreamon Vol. 20           |
| `share/dc-eu-retail-1`  | Dreamcast | PAL-E   | Retail Disc No. 1         |
| `share/dc-eu-retail-2`  | Dreamcast | PAL-E   | Retail Disc No. 2         |
| `share/dc-jp-barai-1`   | Dreamcast | NTSC-J  | @barai Disc No. 1         |
| `share/dc-jp-barai-2`   | Dreamcast | NTSC-J  | @barai Disc No. 2         |
| `share/dc-jp-express`   | Dreamcast | NTSC-J  | Dreamcast Express Vol. 6  |
| `share/dc-jp-kuzokuban` | Dreamcast | NTSC-J  | Kuzokuban (Trial Edition) |
| `share/dc-jp-retail-1`  | Dreamcast | NTSC-J  | Retail Disc No. 1         |
| `share/dc-jp-retail-2`  | Dreamcast | NTSC-J  | Retail Disc No. 2         |
| `share/dc-us-magazine`  | Dreamcast | NTSC-U  | Official Magazine Vol. 9  |
| `share/dc-us-retail-1`  | Dreamcast | NTSC-U  | Retail Disc No. 1         |
| `share/dc-us-retail-2`  | Dreamcast | NTSC-U  | Retail Disc No. 2         |
| `share/gc-eu-retail`    | Gamecube  | PAL-E   | Retail Disc               |
| `share/gc-jp-retail`    | Gamecube  | NTSC-J  | Retail Disc               |
| `share/gc-us-retail`    | Gamecube  | NTSC-U  | Retail Disc               |

The scripts require at least one extracted image of Skies of Arcadia, Skies of 
Arcadia Legends, Eternal Arcadia, or Eternal Arcadia Legends. The directory 
structure should look like this:

* `share/*/database` (replace the asterisk with any name you choose) for CSV 
  files
* `share/*/gameroot` (replace the asterisk with any name you choose) for game 
  data

To obtain the game files, you need a corresponding image (ISO, GCM or GDI).
Please do not ask for download links.

| Platform  | Download                                                     |
|:---------:|:------------------------------------------------------------:|
| Dreamcast | [GCRebuilder](http://www.romhacking.net/utilities/619/)      |
| Gamecube  | [GDRom Explorer](https://www.romhacking.net/utilities/1459/) |

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

Copyright (C) 2019 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
