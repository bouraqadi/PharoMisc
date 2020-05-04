"
A SmTransition is a connection between two states.

Instance Variables
	conditionBlock:		<BlockClosure>
	sourceState:		<SmState>
	targetState:		<SmState>

conditionBlock
	- A block which value is a boolean. When it's value is true, the transition can be peformed, so the target state can be activated, and the source state can be desactivated.

sourceState
	- State desactivated when performing the transition

targetState
	- State activated when performing the transition

"
Class {
	#name : #SmTransition,
	#superclass : #Object,
	#instVars : [
		'conditionBlock',
		'sourceState',
		'targetState'
	],
	#category : #'StateMachine-Kernel'
}

{ #category : #'instance creation' }
SmTransition class >> from: sourceState to: targetState when: conditionBlock [ 
	^self new
		sourceState: sourceState;
		targetState: targetState;
		conditionBlock: conditionBlock;
		yourself
]

{ #category : #accessing }
SmTransition >> automaton [
	^self sourceState automaton
]

{ #category : #accessing }
SmTransition >> conditionBlock [
	^ conditionBlock
]

{ #category : #accessing }
SmTransition >> conditionBlock: anObject [
	conditionBlock := anObject
]

{ #category : #stepping }
SmTransition >> isActionable [
	^conditionBlock value
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
