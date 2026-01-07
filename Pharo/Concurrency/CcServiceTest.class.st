Class {
	#name : 'CcServiceTest',
	#superclass : 'TestCase',
	#traits : 'CcTConcurrencyTest + CcTWaitPolling',
	#classTraits : 'CcTConcurrencyTest classTrait + CcTWaitPolling classTrait',
	#instVars : [
		'service',
		'runner'
	],
	#category : 'Concurrency-Test',
	#package : 'Concurrency',
	#tag : 'Test'
}

{ #category : 'testing' }
CcServiceTest class >> isAbstract [ 
	^self == CcServiceTest
]

{ #category : 'testing' }
CcServiceTest >> runCaseManaged [
	self runCase
]

{ #category : 'testing' }
CcServiceTest >> serviceProcess [
	runner ifNil: [ ^nil ].
	^runner process
]

{ #category : 'testing' }
CcServiceTest >> startService [
	runner := service runner.
	service start
]

{ #category : 'testing' }
CcServiceTest >> tearDown [
	self serviceProcess ifNotNil: [ :process | process terminate ].
	super tearDown.

]
