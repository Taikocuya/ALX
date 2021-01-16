# How To Import and Export the Game Data

## Introduction

Please note that pre-exported CSV files with complete game data can already be 
found in the `dist` directory. If you want to import and export the game data 
by yourself, you need in the `build` directory at least one extracted image of 
Skies of Arcadia, Skies of Arcadia Legends, Eternal Arcadia (エターナルアルカディア) 
or Eternal Arcadia Legends (エターナルアルカディアレジェンド). Depending on the platform 
the directory structure should look like this.

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

All commands and utilities can be found in the `bin` directory. In 
![Linux](/doc/linux16.png) Linux and ![macOS](/doc/mac16.png) macOS, you have 
to install Ruby first in order to be able to run the RB scripts. 
![Windows](/doc/win16.png) Windows users can optionally do this as well or 
simply run the CMD scripts which use the included Ruby.

### export.cmd & export.rb

Executes all export commands in `bin` except `exportdefinedstring.cmd`, 
`exportdefinedstring.rb`, `exportscripttask.cmd` and `exportscripttask.rb`. 
Exports everything from the `root` to the `data` directory. The destination 
directory is created automatically if required.

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

### import.cmd & import.rb

Executes all import commands in `bin` except `importdefinedstring.cmd`, 
`importdefinedstring.rb`, `importscripttask.cmd` and `importscripttask.rb`. 
Imports everything from the `data` to the `root` directory. The destination 
directory must exist.

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
