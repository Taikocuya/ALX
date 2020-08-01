# ALX — Skies of Arcadia Legends Examiner

ALX is a simple, fast and cross-platform command line tool to extract the 
game data from Skies of Arcadia, Skies of Arcadia Legends, Eternal Arcadia 
(エターナルアルカディア) and Eternal Arcadia Legends (エターナルアルカディアレジェンド). It 
is able to export and import the data to and from CSV files.

![ALX — Skies of Arcadia Legends Examiner](/doc/cli.png)

## Features

* Character Skills (Super Moves and Magic)
* Character Stats (Exp Curves, Magic Exp Curves, Parameters and Spirit Curves)
* Crew Members
* Defined Strings (Detector for Shift_JIS and Windows-1252 Strings)
* Enemy Ship Stats (Action Patterns and Parameters)
* Enemy Skills (Super Moves and Magic)
* Enemy Stats (Action Patterns, Encounters, Events and Parameters)
* Items (Accessories, Armors, Ship Cannons, Ship Accessories, Ship Items, 
  Special Items, Usable Items and Weapons)
* Playable Ship Stats
* Shops
* Treasure Chests

## Requirements

The commands in the `bin` directory require:

* [Ruby](https://www.ruby-lang.org/) 2.7+
* Extracted image of Skies of Arcadia, Skies of Arcadia Legends, Eternal 
  Arcadia (エターナルアルカディア) or Eternal Arcadia Legends (エターナルアルカディアレジェンド)

The CSV files in the `build` and `dist` directories require:

* Spreadsheet application with UTF-8 support (e.g. 
  [LibreOffice Calc](https://www.libreoffice.org/) or 
  [uniCSVed](http://csved.sjfrancke.nl/))
* Editor for plain text (e.g. [Notepad++](https://notepad-plus-plus.org/))

## Download

* You can get the latest official release on the SourceForge project website:
  https://sourceforge.net/projects/aex/files/latest/download
* You can also get the current development version from the GitHub repository:
  https://github.com/Taikocuya/ALX

## Installation

Pre-exported CSV files with complete game data can already be found in the 
`dist` directory.

| Folder            | Platform  | Region  | Notes                     |
|:------------------|:----------|:--------|:--------------------------|
| `dc-eu-dreamon`   | Dreamcast | PAL-E   | Dreamon Vol. 20           |
| `dc-eu-preview-1` | Dreamcast | PAL-E   | Beta Preview (1/2)        |
| `dc-eu-preview-2` | Dreamcast | PAL-E   | Beta Preview (1/2)        |
| `dc-eu-retail-1`  | Dreamcast | PAL-E   | Retail (1/2)              |
| `dc-eu-retail-2`  | Dreamcast | PAL-E   | Retail (2/2)              |
| `dc-jp-barai-1`   | Dreamcast | NTSC-J  | @barai (1/2)              |
| `dc-jp-barai-2`   | Dreamcast | NTSC-J  | @barai (2/2)              |
| `dc-jp-express`   | Dreamcast | NTSC-J  | Dreamcast Express Vol. 6  |
| `dc-jp-kuzokuban` | Dreamcast | NTSC-J  | Kuzokuban (Trial Edition) |
| `dc-jp-retail-1`  | Dreamcast | NTSC-J  | Retail (1/2)              |
| `dc-jp-retail-2`  | Dreamcast | NTSC-J  | Retail (2/2)              |
| `dc-us-magazine`  | Dreamcast | NTSC-U  | Official Magazine Vol. 9  |
| `dc-us-retail-1`  | Dreamcast | NTSC-U  | Retail (1/2)              |
| `dc-us-retail-2`  | Dreamcast | NTSC-U  | Retail (2/2)              |
| `gc-eu-retail`    | Gamecube  | PAL-E   | Retail                    |
| `gc-jp-retail`    | Gamecube  | NTSC-J  | Retail                    |
| `gc-us-retail`    | Gamecube  | NTSC-U  | Retail                    |

If you want to import and export the game data by yourself, you need in the 
`build` directory at least one extracted image of Skies of Arcadia, Skies of 
Arcadia Legends, Eternal Arcadia (エターナルアルカディア) or Eternal Arcadia Legends 
(エターナルアルカディアレジェンド). The directory structure should look like this. 

```bash
build
└── custom-name-1
│   └── root  #=> Data of Game 1
└── custom-name-2
│   └── root  #=> Data of Game 2
└── custom-name-3
│   └── root  #=> Data of Game 3
└── custom-name-n
    └── root  #=> Data of Game N
```

To obtain the game data for the `root` directory, you need a corresponding 
image (ISO, GCM or GDI) and the appropriate data extraction tool.

* ![](/doc/dc.png) [GD-ROM Explorer](/vendor/GDROM-Explorer)
* ![](/doc/dc.png) [GDIbuilder](/vendor/GDIbuilder)
* ![](/doc/gc.png) [GCRebuilder](/vendor/GCRebuilder)

## Commands

All commands can be found in the `bin` directory.

### createbackup.rb

Creates a backup of the `root` directory and stores it in the `backup` 
directory. The destination directory is created automatically if required. 
This command only considers files that can actually be examined by ALX. It is 
not recommended for a complete backup of all files.

```bash
build
└── custom-name-1
│   ├── backup  #=> Backup Files
│   └── root    #=> Game Data
└── custom-name-2
│   ├── backup  #=> Backup Files
│   └── root    #=> Game Data
└── custom-name-3
│   ├── backup  #=> Backup Files
│   └── root    #=> Game Data
└── custom-name-n
    ├── backup  #=> Backup Files
    └── root    #=> Game Data
```

### export.rb

Executes all export commands in `bin` except `exportdefinedstring.rb`. Exports 
everything from the `root` to the `data` directory. The destination directory 
is created automatically if required.

```bash
build
└── custom-name-1
│   ├── data  #=> CSV Files
│   └── root  #=> Game Data
└── custom-name-2
│   ├── data  #=> CSV Files
│   └── root  #=> Game Data
└── custom-name-3
│   ├── data  #=> CSV Files
│   └── root  #=> Game Data
└── custom-name-n
    ├── data  #=> CSV Files
    └── root  #=> Game Data
```

### import.rb

Executes all import commands in `bin` except `importdefinedstring.rb`. Imports 
everything from the `data` to the `root` directory. The destination directory 
must exist.

```bash
build
└── custom-name-1
│   ├── data  #=> CSV Files
│   └── root  #=> Game Data
└── custom-name-2
│   ├── data  #=> CSV Files
│   └── root  #=> Game Data
└── custom-name-3
│   ├── data  #=> CSV Files
│   └── root  #=> Game Data
└── custom-name-n
    ├── data  #=> CSV Files
    └── root  #=> Game Data
```

### restorebackup.rb

Restores the backup from the `backup` directory and overwrites existing files 
in the `root` directory. The destination directory must exist. This command 
only considers files that can actually be examined by ALX.

```bash
build
└── custom-name-1
│   ├── backup  #=> Backup Files
│   └── root    #=> Game Data
└── custom-name-2
│   ├── backup  #=> Backup Files
│   └── root    #=> Game Data
└── custom-name-3
│   ├── backup  #=> Backup Files
│   └── root    #=> Game Data
└── custom-name-n
    ├── backup  #=> Backup Files
    └── root    #=> Game Data
```

### rebuildimage.rb

Rebuilds a bootable GameCube image in the `image` directory. The destination 
directory is created automatically if required. Unfortunately, this command is 
only supported on Windows. Other platforms or Dreamcast images are not 
supported. This command is only for testing anyway and you probably won't need 
it.

```bash
build
└── custom-name-1
│   ├── image  #=> Image Folder
│   └── root   #=> Game Data
└── custom-name-2
│   ├── image  #=> Image Folder
│   └── root   #=> Game Data
└── custom-name-3
│   ├── image  #=> Image Folder
│   └── root   #=> Game Data
└── custom-name-n
    ├── image  #=> Image Folder
    └── root   #=> Game Data
```

### clearcache.rb

Clears the cache storage in the `cache` directory. If you clear the cache 
storage, snapshots will not be loaded and differences will not be detected, 
which enormously increases the next runtime. Normally, you will not need this 
command, however, it can be used to force a recompilation of all files.

```bash
build
└── custom-name-1
│   ├── cache  #=> Cache Storage
│   └── root   #=> Game Data
└── custom-name-2
│   ├── cache  #=> Cache Storage
│   └── root   #=> Game Data
└── custom-name-3
│   ├── cache  #=> Cache Storage
│   └── root   #=> Game Data
└── custom-name-n
    ├── cache  #=> Cache Storage
    └── root   #=> Game Data
```

## Resources

![Enemy Stats](/doc/enemy.png)
![Enemy Action Patterns](/doc/enemytask.png)
![Enemy Super Moves](/doc/enemysupermove.png)
![Usable Items](/doc/usableitem.png)
![Shops](/doc/shop.png)
![Defined Strings](/doc/definedstring.png)

## Acknowledgments

See [CREDITS.md](/CREDITS.md) for a full list of the awesome people, groups and 
software that made this project possible.

## License

Copyright (C) 2020 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](/LICENSE.md) for the full license text.
