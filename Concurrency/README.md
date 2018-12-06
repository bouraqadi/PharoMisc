# Concurrency
I introduce simple and easy to use concurrency library

# Install
```Smalltalk
Metacello new
  baseline: 'Concurrency';
  repository: 'github://bouraqadi/PharoMisc';
  load
```

# Usage
1. Create an instance of `ActiveObject`
1. Fire the thread  using message `start`
1. Stop the thread using message `stop`

When garbage collected, instances of `ActiveObject` terminate the atteched thread. In case you want the thread to continue, use message `runTillDone`.

There exist many facility methods to make it easy to create threads for different purpose. Check out class side methods of `ActiveObject`.

# Example

```Smalltalk
|runner|
runner := ActiveObject 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 300 milliSeconds
		while: [ counter < 100 ].
runner start.
1 second wait.
runner stop
```
More examples are provided as class side methods of `ActiveObjectExamples`.
