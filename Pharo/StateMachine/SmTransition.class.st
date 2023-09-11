"
A SmTransition is a connection between two states.

Instance Variables
	sourceState:		<SmState>
	targetState:		<SmState>

sourceState
	- State desactivated when performing the transition

targetState
	- State activated when performing the transition

"
Class {
	#name : #SmTransition,
	#superclass : #Object,
	#instVars : [
		'sourceState',
		'targetState'
	],
	#category : #'StateMachine-Kernel'
}

{ #category : #'instance creation' }
SmTransition class >> from: sourceState to: targetState [
	^self new
		sourceState: sourceState;
		targetState: targetState;
		yourself
]

{ #category : #accessing }
SmTransition >> automaton [
	^self sourceState automaton
]

{ #category : #testing }
SmTransition >> isActionable [
	^true
]

{ #category : #stepping }
SmTransition >> perform [
	self sourceState exit.
	self targetState enter
]

{ #category : #accessing }
SmTransition >> sourceState [
	^ sourceState
]

{ #category : #accessing }
SmTransition >> sourceState: anObject [
	sourceState := anObject
]

{ #category : #accessing }
SmTransition >> targetState [
	^ targetState
]

{ #category : #accessing }
SmTransition >> targetState: aState [
	targetState := aState.

]
