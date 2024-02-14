# PharoMisc
Small utilities and libraries for Pharo. All under MIT Licence.
Each project is in a dedicated folder with a Readme file.

To install any of the projects below evaluate the following expression in a Playground
```Smalltalk
Metacello new
  baseline: 'PROJECT_NAME';
  repository: 'github://bouraqadi/PharoMisc';
  load
 ```

# Table of Contents
## A
### AppMaker
I turn a development image into a ready to use app. I disable development menus and shortcuts. Image is locked so users can only interact via UI kept open.

**Usage:** Simply click on the System/App Maker menu

## B
### BooleanExpressions
This package introduces extensions to collections to make it easy to write usual expressions.
The goal is to avoid writing long sequences of logic messages such as:
```Smalltalk
exp1 or: [ exp2 or: [exp3 or: [exp4]]
exp1 and: [ exp2 and: [exp3 and: [exp4]]
```

Instead, we can write boolean expressions such as :
```Smalltalk
{[exp1]. [exp2]. [exp3]. [exp4]}
  anyTrue;
  allTrue;
  anyFalse;
  allFalse
```

Note that boolean expressions are inside blocks to allow for delayed evaluation.
But, this is of course not mandatory.


### BaselineAnalyzer
Simple tool to analyze a baseline and detect potential loops (i.e. cycles) in the definition of package dependencies. Warning: This is not the actual dependency graph, but just the definition provided in the baseline.
  ```st
  analyzer := BaDependencyAnalyzer analyzeBaselineClass:  BaselineOfPlcWeb.
  analyzer dependencyLoops size.
  analyzer shortestLoop. "Handy because smaller loops might be included into larger ones"
  analyzer internalRoots. "Answers a set with dependency internal roots. Those are packages of the project that depend only on extrnal packages."
  ```

## C
- **CodeMetrics**: Tiny code analyser. Provides with code metrics such as the number of classes and methods.
- **Concurrency**: Simple and easy to use concurrency library. Deprecated. Use [Tasks](/Tasks) instead.
- **CsvToPillarConverter**: Converts CSV to Pillar, ready to display on web page. Used for generating Pillar for ESUG website based on CSV obtained from registration server.

## E
### EasyUI
Small library to quickly make GUI that responds to user interactions. 

### Equals
Defines an equality method `=` that is general to apply to different applications. 
It is also easily customizable, and includes a default definition of `hash`. 
So, objects that are equal have the same hash code, and thus appear only once in hashed collections such as `Set`

**Usage:** Simply add trait `TEquality` to the class which elements need to be equal, as in this example

```Smalltalk
Object subclass: #Fruit
	uses: TEquality
	instanceVariableNames: 'stage'
	classVariableNames: ''
	package: 'Equals-Examples'
```

By default, two objects are equal if all their instance variables (IVs) are equal.
You can override this, by overriding class method `instVarNamesForEqualityComparison` to return the subset of IVs to use for comparison.

## L
- **LightweightObserver**: Lightweight alternative to Announcement. Subclasses of subject automatically generate method wrappers to generate events notifying changes of observed IVs. When IVs reference collections, events can be generated on accessing collection elements. [Read full description](https://nootrix.com/tutorials/lightweight-observer-pharo/)

## N
- **NetworkExtras**: Provides classes that wrap the basic sockets to ease networking

## S
### StateMachine
- Defines automaton, states and transition.  
- Transitions are performed when some condition is valid. 
- Each state has 3 actions :
	-  Entry action: Performed only once upon entring the state
	-  Main action: Performed repeatedly each time checks that it should stay in this state
	-  Exit action: Performed only once upon exiting the state
- State transitions are tested each time the automation receives message `step`.
- It is up to the user to decide when to call this message.

#### Create an automaton and a state
```Smalltalk
automaton := SmAutomaton new.
state1 := automaton newState.
```
Message `newState` returns a state that is already attached to the automaton.

#### Define initial state
```Smalltalk
automaton initialState: state1
```

#### Defining a transition between two states
```Smalltalk
state2 := automaton newState.
flag := false.
state1 transitionTo: newState when: [flag].
```

#### Defining state actions
- Each action can be defined by providing a block as a parameter of the appropriate message:
	- `entryActionBlock:`. The argument is performed only once upon entring the state.
	- `mainActionBlock:`. The argument is performed repeatedly each time checks that it should stay in this state.
	- `exitActionBlock:`. The argument is performed only once upon exiting the state.

### SimpleMiddleware
A basic middleware supporting remote object messages over TCP

## T
### Tasks
Small library to define threads. They makes it easy to express tasks that need to performed at a specific point in time or repeatedly, within a dedicated process. There are 2 main concepts: Tasks and Threads.
##### Tasks
A task is a set of statements that can be performed in a controlled manner. This can be at a specific point in time. 
It can be performed repeatedly at a given frequency. 
It can be repeated forever.
Conversely, it can be repeated for a given amount of iterations, or until some condition or some point in time is reached. 
A task materializes as an instance of class `TkTask`.
##### Threads
A thread (instance of `TkThread`) is a task decorator that ensures the task is run within a dedicated process (instance of `Process`).
Threds are more abstract that tasks and processes. Users new to this library should start with threads.
Examples are provided as class side methods 


