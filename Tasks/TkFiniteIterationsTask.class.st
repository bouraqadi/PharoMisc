Class {
	#name : #TkFiniteIterationsTask,
	#superclass : #TkFiniteTask,
	#instVars : [
		'totalIterations',
		'iterationsCount'
	],
	#category : #Tasks
}

{ #category : #initialization }
TkFiniteIterationsTask >> initialize [
	super initialize.
	self resetIterationsCount
]

{ #category : #testing }
TkFiniteIterationsTask >> isEndConditionMet [
	^self iterationsCount = self totalIterations
]

{ #category : #accessing }
TkFiniteIterationsTask >> iterationsCount [
	^ iterationsCount
]

{ #category : #accessing }
TkFiniteIterationsTask >> iterationsCount: anObject [
	iterationsCount := anObject
]

{ #category : #initialization }
TkFiniteIterationsTask >> resetIterationsCount [
	self iterationsCount: 0
]

{ #category : #accessing }
TkFiniteIterationsTask >> totalIterations [
	^totalIterations
]

{ #category : #accessing }
TkFiniteIterationsTask >> totalIterations: anInteger [ 
	totalIterations := anInteger.

]

{ #category : #acting }
TkFiniteIterationsTask >> valueActionBlock [
	self iterationsCount: self iterationsCount + 1.
	super valueActionBlock.
	
]
