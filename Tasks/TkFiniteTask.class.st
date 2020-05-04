Class {
	#name : #TkFiniteTask,
	#superclass : #TkTask,
	#instVars : [
		'doneState',
		'tearDownState',
		'tearDownBlock'
	],
	#category : #'Tasks-Private-Tasks'
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

{ #category : #accessing }
TkFiniteTask >> isEndConditionMet [
	^self subclassResponsibility 
]

{ #category : #accessing }
TkFiniteTask >> tearDownBlock [
	^ tearDownBlock
]

{ #category : #accessing }
TkFiniteTask >> tearDownBlock: aBlockClosure [ 
	tearDownBlock := aBlockClosure
]
