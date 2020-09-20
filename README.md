# ALX — Skies of Arcadia Legends Examiner

ALX is a simple, fast and cross-platform command line tool to extract the 
game data from Skies of Arcadia, Skies of Arcadia Legends, Eternal Arcadia 
(エターナルアルカディア) and Eternal Arcadia Legends (エターナルアルカディアレジェンド). It 
is able to export and import the data to and from CSV files.

![CLI](/doc/cli.gif)

## Features

* Character Skills (Super Moves and Magic)
* Character Stats (EXP Curves, Magic EXP Curves, Parameters and Spirit Curves)
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
| `gc-eu-retail`    | GameCube  | PAL-E   | Retail                    |
| `gc-jp-retail`    | GameCube  | NTSC-J  | Retail                    |
| `gc-us-retail`    | GameCube  | NTSC-U  | Retail                    |

If you want to import and export the game data by yourself, you need in the 
`build` directory at least one extracted image of Skies of Arcadia, Skies of 
Arcadia Legends, Eternal Arcadia (エターナルアルカディア) or Eternal Arcadia Legends 
(エターナルアルカディアレジェンド). Depending on the platform the directory structure 
should look like this.

```
build
├── custom-name-dc
│   ├── meta
│   │   └── IP.BIN
│   └── root
│       ├── BATTLE
│       ├── FIELD
│       ├── 1ST_READ.BIN
│       └── ...
└── custom-name-gc
    └── root
        ├── &&systemdata
        ├── battle
        ├── field
        ├── opening.bnr
        └── ...
```

To obtain the game data for the `root` directory, you need a corresponding 
image (ISO, GCM or GDI) and the appropriate data extraction tool:

* ![GameCube](/doc/ngc16.png)
  [GCRebuilder](http://www.romhacking.net/utilities/619/)
* ![Dreamcast](/doc/sdc16.png)
  [GD-ROM Explorer](https://www.romhacking.net/utilities/1459/)
* ![Dreamcast](/doc/sdc16.png)
  [GDIBuilder](https://github.com/Sappharad/GDIbuilder)
  
## Commands

All commands and utilities can be found in the `bin` directory.

### buildimage.rb

Builds a bootable Dreamcast or GameCube image in the `image` directory. The 
destination directory is created automatically if required. This utility only 
supports Windows.

```
build
├── custom-name-dc
│   ├── image
│   ├── meta
│   └── root
└── custom-name-gc
    ├── image
    └── root
```

### clearcache.rb

Clears the cache storage in the `cache` directory. If you clear the cache 
storage, snapshots will not be loaded and differences will not be detected, 
which enormously increases the next runtime. Normally, you will not need this 
utility, however, it can be used to force a recompilation of all files.

```
build
├── custom-name-dc
│   ├── cache
│   ├── meta
│   └── root
└── custom-name-gc
    ├── cache
    └── root
```

### createbackup.rb

Creates a backup of the `root` directory and stores it in the `backup` 
directory. The destination directory is created automatically if required. 
This utility only considers files that can actually be examined by ALX. It is 
not recommended for a complete backup of all files.

```
build
├── custom-name-dc
│   ├── backup
│   ├── meta
│   └── root
└── custom-name-gc
    ├── backup
    └── root
```

### export.rb

Executes all export commands in `bin` except `exportdefinedstring.rb`. Exports 
everything from the `root` to the `data` directory. The destination directory 
is created automatically if required.

```
build
├── custom-name-dc
│   ├── data
│   ├── meta
│   └── root
└── custom-name-gc
    ├── data
    └── root
```

### import.rb

Executes all import commands in `bin` except `importdefinedstring.rb`. Imports 
everything from the `data` to the `root` directory. The destination directory 
must exist.

```
build
├── custom-name-dc
│   ├── data
│   ├── meta
│   └── root
└── custom-name-gc
    ├── data
    └── root
```

### restorebackup.rb

Restores the backup from the `backup` directory and overwrites existing files 
in the `root` directory. The destination directory must exist. This utility 
only considers files that can actually be examined by ALX.

```
build
├── custom-name-dc
│   ├── backup
│   ├── meta
│   └── root
└── custom-name-gc
    ├── backup
    └── root
```

## Resources

![CSV](/doc/csv.gif)

## Acknowledgments

See [CREDITS.md](/CREDITS.md) for a full list of the awesome people, groups and 
software that made this project possible.

## License

Copyright (C) 2020 Marcel Renner. ALX is licensed under the GNU General Public 
License, Version 3.0. See [LICENSE.md](/LICENSE.md) for the full license text.
