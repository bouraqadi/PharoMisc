"
A SmAutomaton is a finite state machine. States are connected by transitions. Each time an automaton receives the step message, it checks conditions attached to outgoing transitions from the current state. Whenever a condition of a transition is true, the machine switches to the target state of the transition.

Example
	automaton := SmAutomaton new.
	initialState := SmLoggedState new.
	automaton initialState: initialState.
	newState := SmLoggedState new.
	flag := false.
	initialState transitionTo: newState when: [flag = true].
	flag := true.
	automaton step.
	automaton currentState = newState. ""Should be true""

Instance Variables
	currentState:		<SmState>

currentState
	- the last state to be enabled


"
Class {
	#name : #SmAutomaton,
	#superclass : #Object,
	#instVars : [
		'currentState'
	],
	#category : #'StateMachine-Kernel'
}

{ #category : #accessing }
SmAutomaton >> currentState [
	^ currentState
]

{ #category : #accessing }
SmAutomaton >> currentState: aState [
	currentState := aState

]

{ #category : #'creating states' }
SmAutomaton >> defaultStateClass [
	^ SmState
]

{ #category : #transitions }
SmAutomaton >> forceTransitionTo: targetState [ 
	(SmTransition from: self currentState to: targetState) perform.
	self currentState performMainAction.
]

{ #category : #'initialize-release' }
SmAutomaton >> initialState: aState [
	self currentState: aState.
	aState enter.
	aState performMainAction.
]

{ #category : #'creating states' }
SmAutomaton >> newState [
	^ self newState: self defaultStateClass
]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass [
	^stateClass automaton: self
]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass doing: aBlock [
	^(self newState: stateClass)
		mainActionBlock: aBlock;
		yourself
		
]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass doing: mainActionBlock onEntryDo: entryActionBlock [ 
	^self newState: stateClass doing: mainActionBlock onEntryDo: entryActionBlock onExitDo: nil.
]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass doing: mainActionBlock onEntryDo: entryActionBlock onExitDo: exitActionBlock [
	^(self newState: stateClass doing: mainActionBlock)
		addEntryAction: entryActionBlock;
		addExitAction: exitActionBlock;
		yourself

]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass doing: mainActionBlock onExitDo: exitActionBlock [ 
	^self newState: stateClass doing: mainActionBlock onEntryDo: nil onExitDo: exitActionBlock.
]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass onEntryDo: aBlockClosure [ 
	^self newState: stateClass doing: nil onEntryDo: aBlockClosure
]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass onEntryDo: entryActionBlock onExitDo: exitActionBlock [
	^(self newState: stateClass)
		addEntryAction: entryActionBlock;
		addExitAction: exitActionBlock;
		yourself

]

{ #category : #'creating states' }
SmAutomaton >> newState: stateClass onExitDo: aBlockClosure [ 
	^self newState: stateClass doing: nil onExitDo: aBlockClosure
]

{ #category : #'creating states' }
SmAutomaton >> newStateDoing: aBlock [
	^self newState
		mainActionBlock: aBlock;
		yourself
		
]

{ #category : #'creating states' }
SmAutomaton >> newStateDoing: mainActionBlock onEntryDo: entryActionBlock [ 
	^self newStateDoing: mainActionBlock onEntryDo: entryActionBlock onExitDo: nil.
]

{ #category : #'creating states' }
SmAutomaton >> newStateDoing: mainActionBlock onEntryDo: entryActionBlock onExitDo: exitActionBlock [
	^(self newStateDoing: mainActionBlock)
		addEntryAction: entryActionBlock;
		addExitAction: exitActionBlock;
		yourself

]

{ #category : #'creating states' }
SmAutomaton >> newStateDoing: mainActionBlock onExitDo: exitActionBlock [ 
	^self newStateDoing: mainActionBlock onEntryDo: nil onExitDo: exitActionBlock.
]

{ #category : #'creating states' }
SmAutomaton >> newStateOnEntryDo: aBlockClosure [ 
	^self newStateDoing: nil onEntryDo: aBlockClosure
]

{ #category : #'creating states' }
SmAutomaton >> newStateOnEntryDo: entryActionBlock onExitDo: exitActionBlock [
	^self newState
		addEntryAction: entryActionBlock;
		addExitAction: exitActionBlock;
		yourself

]

{ #category : #'creating states' }
SmAutomaton >> newStateOnExitDo: aBlockClosure [ 
	^self newStateDoing: nil onExitDo: aBlockClosure
]

{ #category : #stepping }
SmAutomaton >> step [
	self currentState step.
	self currentState performMainAction
]
