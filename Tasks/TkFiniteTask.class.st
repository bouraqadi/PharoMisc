Class {
	#name : #TkFiniteTask,
	#superclass : #TkTask,
	#instVars : [
		'endConditionBlock',
		'tearDownBlock',
		'isTearDownDone'
	],
	#category : #Tasks
}

{ #category : #accessing }
TkFiniteTask >> endConditionBlock [
	^ endConditionBlock
]

{ #category : #accessing }
TkFiniteTask >> endConditionBlock: anObject [
	endConditionBlock := anObject
]

{ #category : #accessing }
TkFiniteTask >> isDone [
	^self isEndConditionMet and: [ self isTearDownDone ]
]

{ #category : #accessing }
TkFiniteTask >> isEndConditionMet [
	^self endConditionBlock value
]

{ #category : #accessing }
TkFiniteTask >> isTearDownDone [
	^ isTearDownDone
]

{ #category : #accessing }
TkFiniteTask >> isTearDownDone: anObject [
	isTearDownDone := anObject
]

{ #category : #initialization }
TkFiniteTask >> reset [
	super reset.
	self isTearDownDone: false
]

{ #category : #accessing }
TkFiniteTask >> step [
	self isDone ifTrue: [ ^self].
	self isEndConditionMet ifTrue: [ ^self tearDown ].
	super step.

]

{ #category : #accessing }
TkFiniteTask >> tearDown [
	self isTearDownDone ifTrue: [ ^self ].
	self tearDownBlock value.
	self isTearDownDone: true
]

{ #category : #accessing }
TkFiniteTask >> tearDownBlock [
	^ tearDownBlock
]

{ #category : #accessing }
TkFiniteTask >> tearDownBlock: anObject [
	tearDownBlock := anObject
]
