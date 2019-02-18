# PharoExtra
I provide small extension to different Pharo libraries

## Install
```
Metacello new
  baseline: 'PharoExtra';
  repository: 'github://bouraqadi/PharoMisc';
  load
```

## Usage
Send messages implemented in this library. An example is the + (plus) message, that allows adding a duration to a time.

Time now + 3 hours.