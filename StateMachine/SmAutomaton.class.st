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
	#category : #StateMachine
}

{ #category : #accessing }
SmAutomaton >> currentState [
	^ currentState
]

{ #category : #accessing }
SmAutomaton >> currentState: aState [
	currentState := aState

]

{ #category : #'initialize-release' }
SmAutomaton >> initialState: aState [
	self currentState: aState.
	aState enable.
	aState performMainAction.
]

{ #category : #'creating states' }
SmAutomaton >> newState [
	^SmState automaton: self
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
		entryActionBlock: entryActionBlock;
		exitActionBlock: exitActionBlock;
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
SmAutomaton >> newStateOnExitDo: aBlockClosure [ 
	^self newStateDoing: nil onExitDo: aBlockClosure
]

{ #category : #stepping }
SmAutomaton >> step [
	self currentState step.
	self currentState performMainAction
]
