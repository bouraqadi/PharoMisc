Class {
	#name : #TkTheradTest,
	#superclass : #TestCase,
	#traits : 'TkTWaitPolling',
	#classTraits : 'TkTWaitPolling classTrait',
	#instVars : [
		'thread',
		'bench'
	],
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #tests }
TkTheradTest >> setUp [
	super setUp.
	bench := TkThreadTestBench new.
]

{ #category : #tests }
TkTheradTest >> testKillStartedProcess [
	thread := bench threadRepeatingForever.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	thread kill.
	self assert: thread isKilled.
	self assert: thread process isTerminated.	
	
	
	
	
]

{ #category : #tests }
TkTheradTest >> testNormalTermination [
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [ bench actionCount = 3 ].
	self assert: thread isDone.
	self deny: thread isStarted.
	self deny: thread isKilled.
	self deny: thread isStopped.

]

{ #category : #tests }
TkTheradTest >> testStartNewThread [
	thread := bench threadRepeatingForever.
	self assert: thread priority equals: 30.
	self assert: thread isStopped.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	self assert: thread process priority equals: 30.
	self deny: thread isDone.
	self deny: thread isKilled.

]

{ #category : #tests }
TkTheradTest >> testStartStoppedThread [
	| previousCount |
	thread := bench threadRepeatingForever.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	thread stop.
	self waitUntil: [thread isStopped].
	previousCount := bench actionCount.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= previousCount].
	
	
	
	
	
]

{ #category : #tests }
TkTheradTest >> testStopStartedProcess [
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [bench actionCount >= 1].
	thread stop.
	self waitUntil: [thread isStopped].
	self deny: thread isStarted.

]
