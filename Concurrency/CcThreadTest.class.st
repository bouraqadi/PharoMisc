Class {
	#name : #CcThreadTest,
	#superclass : #TestCase,
	#traits : 'CcTConcurrencyTest',
	#classTraits : 'CcTConcurrencyTest classTrait',
	#instVars : [
		'activeObject'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcThreadTest >> activeObjProcess [
	activeObject ifNil: [ ^nil ].
	^activeObject process
]

{ #category : #testing }
CcThreadTest >> runCaseManaged [
	self runCase
]

{ #category : #testing }
CcThreadTest >> tearDown [
	super tearDown.
	self activeObjProcess ifNotNil: [ :process | process terminate ]
]
