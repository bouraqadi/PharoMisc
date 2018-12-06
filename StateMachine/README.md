# StateMachine
Defines automaton, states and transition. 
Transitions are performed when some condition is valid. 
Each state has 3 actions :
- Entry action: Performed only once upon entring the state
- Main action: Performed repeatedly each time checks that it should stay in this state
- Exit action: Performed only once upon exiting the state

# Install
```Smalltalk
Metacello new
  baseline: 'StateMachine';
  repository: 'github://bouraqadi/PharoMisc';
  load
```

# Usage

## Create an automaton and a state
```Smalltalk
automaton := SmAutomaton new.
state1 := automaton newState.
```
Message `newState` returns a state that is already attached to the automaton.

## Define initial state
```Smalltalk
automaton initialState: state1 
```

## Defining a transition between two states
```Smalltalk
state2 := automaton newState.
flag := false.
state1 transitionTo: newState when: [flag].
```

State transitions are tested each time the automation receives message `step`.
It is up to the user to decide when to call this message.

## Defining state actions
Each action can be defined by providing a block as a parameter of the appropriate message:
- `entryActionBlock:`. The argument is performed only once upon entring the state.
- `mainActionBlock:`. The argument is performed repeatedly each time checks that it should stay in this state.
- `exitActionBlock:`. The argument is performed only once upon exiting the state.

