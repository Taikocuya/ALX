# How To Import and Export the Game Data

## Introduction

Please note that pre-exported CSV files with complete game data can already be 
found in the `dist` directory. If you want to import and export the game data 
by yourself, you need in the `build` directory at least one extracted image of 
Skies of Arcadia, Skies of Arcadia Legends, Eternal Arcadia (エターナルアルカディア) 
or Eternal Arcadia Legends (エターナルアルカディアレジェンド). The directory structure 
should look like this. 

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

| Platform  | Download                                                     |
|:----------|:-------------------------------------------------------------|
| Dreamcast | [GDRom Explorer](https://www.romhacking.net/utilities/1459/) |
| Gamecube  | [GCRebuilder](http://www.romhacking.net/utilities/619/)      |

## Commands

All commands can be found in the `bin` directory.

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
