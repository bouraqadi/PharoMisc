# TimedAction

A timed action expresses when to value a given block. This can be at a specific point in time. 
The block can be performed repeatedly at a given frequency. It can be repeated forever.
Conversely, it can be repeated for a given amount of iterations, or until some point in time.

`TaAction` is the entry point class. See its comment and class methods.

## Install
```
Metacello new
  baseline: 'TimedAction';
  repository: 'github://bouraqadi/PharoMisc';
  load
```
