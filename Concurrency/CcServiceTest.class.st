Class {
	#name : #CcServiceTest,
	#superclass : #TestCase,
	#traits : 'CcTConcurrencyTest',
	#classTraits : 'CcTConcurrencyTest classTrait',
	#instVars : [
		'service'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcServiceTest >> activeObjProcess [
	service ifNil: [ ^nil ].
	^service process
]

{ #category : #testing }
CcServiceTest >> runCaseManaged [
	self runCase
]

{ #category : #testing }
CcServiceTest >> tearDown [
	super tearDown.
	self activeObjProcess ifNotNil: [ :process | process terminate ]
]
