Class {
	#name : #ActiveObjectTest,
	#superclass : #TestCase,
	#traits : 'TConcurrencyTest',
	#classTraits : 'TConcurrencyTest classTrait',
	#instVars : [
		'activeObject'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
ActiveObjectTest >> activeObjProcess [
	activeObject ifNil: [ ^nil ].
	^activeObject process
]

{ #category : #testing }
ActiveObjectTest >> runCaseManaged [
	self runCase
]

{ #category : #testing }
ActiveObjectTest >> tearDown [
	super tearDown.
	self activeObjProcess ifNotNil: [ :process | process terminate ]
]
