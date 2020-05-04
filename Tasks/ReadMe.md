# Tasks

A task is a set of statements that can be performed in a controlled manner. This can be at a specific point in time. 
It can be performed repeatedly at a given frequency. 
It can be repeated forever.
Conversely, it can be repeated for a given amount of iterations, or until some condition or some point in time is reached. 
A task materializes as an instance of class `TkTask`.

# Threads

A thread (instance of `TkThread`) is a task decorator that ensures the task is run within a dedicated process (instance of `Process`).
Threads are more abstract that tasks and processes. Users new to this library should start with threads.
Examples are provided as class side methods 

## Install
```
Metacello new
  baseline: 'Tasks';
  repository: 'github://bouraqadi/PharoMisc';
  load
```
