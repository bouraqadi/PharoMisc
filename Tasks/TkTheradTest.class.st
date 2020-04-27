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
TkTheradTest >> testKillDoneProcess [
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [ thread isDone ].
	thread kill.
	self assert: thread isDone.
	
	
	
	
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
TkTheradTest >> testKillStoppedProcess [
	thread := bench threadRepeatingForever.
	thread start.
	self assert: thread isStarted.
	thread stop.
	self waitUntil: [thread isStopped].
	self assert: thread isStopped.
	thread kill.
	self assert: thread isStopped.
	
	
	
	
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
TkTheradTest >> testRestartAfterKill [
	| previousCount |
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [ bench actionCount > 0 ].
	thread kill.
	previousCount := bench actionCount.
	thread restart.
	self assert: thread isStarted.
	self assert: bench resetCount equals: 1.
	self waitUntil: [ bench actionCount > previousCount ].

]

{ #category : #tests }
TkTheradTest >> testRestartAfterNormalTermination [
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [ bench actionCount = 3 ].
	thread restart.
	self assert: thread isStarted.
	self assert: bench resetCount equals: 1.
	self waitUntil: [ thread isDone ].
	self assert: bench actionCount equals: 6.

]

{ #category : #tests }
TkTheradTest >> testRestartAfterStart [
	| previousCount |
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [ bench actionCount > 0 ].
	previousCount := bench actionCount.
	thread restart.
	self assert: thread isStarted.
	self assert: bench resetCount equals: 1.
	self waitUntil: [ bench actionCount > previousCount ].

]

{ #category : #tests }
TkTheradTest >> testRestartStoppedThread [
	thread := bench threadRepeatingForever.
	thread start.
	self assert: thread isStarted.
	thread stop.
	self waitUntil: [ thread isStopped ].
	thread restart.
	self assert: thread isStarted.
	self assert: bench resetCount equals: 1.

]

{ #category : #tests }
TkTheradTest >> testRestartThreadNeverStarted [
	thread := bench threadRepeatingForever.
	thread restart.
	self assert: thread isStarted.
	self assert: bench resetCount equals: 0.

]

{ #category : #tests }
TkTheradTest >> testStartDoneThread [
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [thread isDone].
	thread start.
	self assert: thread isDone.
	
	
	
	
	
]

{ #category : #tests }
TkTheradTest >> testStartKilledThread [
	thread := bench threadRepeatingForever.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	thread kill.
	self assert: thread isKilled.
	thread start.
	self assert: thread isKilled.
	
	
	
	
	
]

{ #category : #tests }
TkTheradTest >> testStartNewThread [
	thread := bench threadRepeatingForever.
	self assert: thread priority equals: 30.
	self deny: thread isStopped.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	self assert: thread process priority equals: 30.
	self deny: thread isDone.
	self deny: thread isKilled.

]

{ #category : #tests }
TkTheradTest >> testStartStartedThread [
	| previousCount |
	thread := bench threadRepeatingForever.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	previousCount := bench actionCount.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= previousCount].
	
	
	
	
	
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
TkTheradTest >> testStopStartedThread [
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [bench actionCount >= 1].
	thread stop.
	self waitUntil: [thread isStopped].
	self deny: thread isStarted.

]
