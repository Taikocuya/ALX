ALX — Skies of Arcadia Legends Examiner
=======================================

ALX is a very simple, fast, cross-platform and object-oriented command line 
tool to extract the game data from Skies of Arcadia, Skies of Arcadia Legends,
Eternal Arcadia (エターナルアルカディア) and Eternal Arcadia Legends 
(エターナルアルカディアレジェンド). It is able to export and import the data to and from 
CSV files.

Features
--------

* Character skills (Super Moves and Magics)
* Character stats (EXP curves, Magic EXP curves, parameters and spirit curves)
* Crew members
* Defined strings (detector for Shift_JIS and Windows-1252 strings)
* Enemy ship stats (action patterns and parameters)
* Enemy skills (Super Moves and Magics)
* Enemy stats (action patterns, encounters, events and parameters)
* Items (accessories, armors, ship cannons, ship accessories, ship items, 
  special items, usable items and weapons)
* Playable ship stats
* Shops
* Treasure chests

Prerequisites
-------------

The commands respectively scripts in the `bin` directory require:

* [Ruby](https://www.ruby-lang.org/) 2.7+
* At least one extracted image of Skies of Arcadia, Skies of Arcadia Legends, 
  Eternal Arcadia (エターナルアルカディア) or Eternal Arcadia Legends 
  (エターナルアルカディアレジェンド)

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
| `share/dc-eu-preview-1` | Dreamcast | PAL-E   | Beta Preview (1/2)        |
| `share/dc-eu-preview-2` | Dreamcast | PAL-E   | Beta Preview (1/2)        |
| `share/dc-eu-retail-1`  | Dreamcast | PAL-E   | Retail (1/2)              |
| `share/dc-eu-retail-2`  | Dreamcast | PAL-E   | Retail (2/2)              |
| `share/dc-jp-barai-1`   | Dreamcast | NTSC-J  | @barai (1/2)              |
| `share/dc-jp-barai-2`   | Dreamcast | NTSC-J  | @barai (2/2)              |
| `share/dc-jp-express`   | Dreamcast | NTSC-J  | Dreamcast Express Vol. 6  |
| `share/dc-jp-kuzokuban` | Dreamcast | NTSC-J  | Kuzokuban (Trial Edition) |
| `share/dc-jp-retail-1`  | Dreamcast | NTSC-J  | Retail (1/2)              |
| `share/dc-jp-retail-2`  | Dreamcast | NTSC-J  | Retail (2/2)              |
| `share/dc-us-magazine`  | Dreamcast | NTSC-U  | Official Magazine Vol. 9  |
| `share/dc-us-retail-1`  | Dreamcast | NTSC-U  | Retail (1/2)              |
| `share/dc-us-retail-2`  | Dreamcast | NTSC-U  | Retail (2/2)              |
| `share/gc-eu-retail`    | Gamecube  | PAL-E   | Retail                    |
| `share/gc-jp-retail`    | Gamecube  | NTSC-J  | Retail                    |
| `share/gc-us-retail`    | Gamecube  | NTSC-U  | Retail                    |

The scripts require at least one extracted image of Skies of Arcadia, Skies of 
Arcadia Legends, Eternal Arcadia (エターナルアルカディア) or Eternal Arcadia Legends 
(エターナルアルカディアレジェンド). The directory structure should look like this:

* `share/*/database` (replace the asterisk with any name you choose) for CSV 
  files
* `share/*/gameroot` (replace the asterisk with any name you choose) for game 
  data

To obtain the game files, you need a corresponding image (ISO, GCM or GDI) and 
the appropriate data extraction tool.

| Platform  | Download                                                     |
|:---------:|:------------------------------------------------------------:|
| Dreamcast | [GDRom Explorer](https://www.romhacking.net/utilities/1459/) |
| Gamecube  | [GCRebuilder](http://www.romhacking.net/utilities/619/)      |

Commands
--------

All commands respectively scripts can be found in the `bin` directory. 

### export.rb

Executes all export commands in `bin` except `exportdefinedstring.rb`.

### import.rb

Executes all import commands in `bin` except `importdefinedstring.rb`.

Links
-----

* [Skies of Arcadia Wiki](https://skiesofarcadia.gamepedia.com/)

License
-------

Copyright (C) 2020 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](LICENSE.md) for the full license text.
