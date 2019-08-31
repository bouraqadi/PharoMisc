Class {
	#name : #CcServiceTest,
	#superclass : #TestCase,
	#traits : 'CcTConcurrencyTest',
	#classTraits : 'CcTConcurrencyTest classTrait',
	#instVars : [
		'service',
		'runner'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcServiceTest >> runCaseManaged [
	self runCase
]

{ #category : #testing }
CcServiceTest >> serviceProcess [
	runner ifNil: [ ^nil ].
	^runner process
]

{ #category : #testing }
CcServiceTest >> startService [
	runner := service runner.
	service start
]

{ #category : #testing }
CcServiceTest >> tearDown [
	super tearDown.
	self serviceProcess ifNotNil: [ :process | process terminate ]
]
