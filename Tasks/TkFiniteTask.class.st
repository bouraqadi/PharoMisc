Class {
	#name : #TkFiniteTask,
	#superclass : #TkTask,
	#instVars : [
		'doneState',
		'tearDownState'
	],
	#category : #Tasks
}

{ #category : #initialization }
TkFiniteTask >> initialize [
	super initialize.
	tearDownState := self newState: TkTearDownTaskState.
	doneState := self newState: TkDoneTaskState.
	actionState transitionTo: tearDownState when: [ 
		self isEndConditionMet and: [self tearDownBlock  notNil] ].
	actionState transitionTo: doneState when: [ 
		self isEndConditionMet and: [self tearDownBlock  isNil] ].
	tearDownState transitionTo: doneState.
]

{ #category : #testing }
TkFiniteTask >> isEndConditionMet [
	^self subclassResponsibility 
]
