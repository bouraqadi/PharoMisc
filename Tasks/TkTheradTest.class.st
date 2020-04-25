Class {
	#name : #TkTheradTest,
	#superclass : #TestCase,
	#traits : 'TkTWaitPolling',
	#classTraits : 'TkTWaitPolling classTrait',
	#instVars : [
		'thread',
		'bench'
	],
	#category : #'Tasks-Tests'
}

{ #category : #tests }
TkTheradTest >> setUp [
	super setUp.
	bench := TkThreadTestBench new.
]

{ #category : #tests }
TkTheradTest >> tearDown [
	super tearDown.
	thread ifNotNil: [ thread kill ]
	
	
	
	
	
]

{ #category : #tests }
TkTheradTest >> testNormalTermination [
self fail: 'todo: test isDone in different states'.
	self deny: thread isDone.
	self assert: thread isDone.

]

{ #category : #tests }
TkTheradTest >> testPriority [
self fail: 'todo: test priority change in different states'.
	self assert: thread priority equals: 30.

]

{ #category : #tests }
TkTheradTest >> testStartStop [
	| previousCount |
	thread := bench threadRepeatingForever.
	self assert: thread isStopped.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	thread stop.
	self assert: thread isStopping.
	self deny: thread isStarted.
	self waitUntil: [thread isStopped].
	previousCount := bench actionCount.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= previousCount].
	
	
	
	
	
]
