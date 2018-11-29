# AppMaker

AppMaker turns a development image into a ready to use desktop app. 
It disables development menus and shortcuts.
Image is locked so users can only interact via UI kept open. 

## Install

```
Metacello new
  baseline: 'AppMaker';
  repository: 'github://bouraqadi/PharoMisc';
  load.
```

## Usage
Simply evaluate: 
```
AppMaker makeApp
```
