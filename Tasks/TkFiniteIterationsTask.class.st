Class {
	#name : #TkFiniteIterationsTask,
	#superclass : #TkFiniteTask,
	#instVars : [
		'totalIterations',
		'iterationsCount'
	],
	#category : #Tasks
}

{ #category : #acting }
TkFiniteIterationsTask >> afterStep [
	super afterStep.
	self iterationsCount: self iterationsCount + 1
]

{ #category : #initialization }
TkFiniteIterationsTask >> initialize [
	super initialize.
	self endConditionBlock: [ self iterationsCount = self totalIterations ]
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
TkFiniteIterationsTask >> reset [
	super reset.
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
