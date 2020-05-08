Class {
	#name : #TkThreadTest,
	#superclass : #TestCase,
	#traits : 'TkTConcurrencyTest',
	#classTraits : 'TkTConcurrencyTest classTrait',
	#instVars : [
		'thread',
		'bench'
	],
	#category : #'Tasks-Tests'
}

{ #category : #tests }
TkThreadTest >> setUp [
	super setUp.
	bench := TkThreadTestBench new.
]

{ #category : #tests }
TkThreadTest >> testFinalization [
	| process |
	thread := bench threadRepeatingForeverPeriod100Milliseconds.
	thread start.
	process := thread process.
	self deny: process isTerminated.
	bench thread: nil.
	thread := nil.
	Smalltalk garbageCollect.
	self waitUntil: [process isTerminated] timeout: 2 seconds.


]

{ #category : #tests }
TkThreadTest >> testFrequency [
	thread := bench threadRepeatingForeverFrequency10Hz.
	self assert: thread frequency equals: 10.
	self assert: thread period equals: 100 milliSeconds.
	thread start.
	self assert: [ bench actionCount >= 3 ] takesMoreThan: 200 milliSeconds 

]

{ #category : #tests }
TkThreadTest >> testKillAfterDone [
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [ thread isDone ].
	thread kill.
	self assert: thread isDone.
	
	
	
	
]

{ #category : #tests }
TkThreadTest >> testKillStartedThread [
	thread := bench threadRepeatingForever.
	thread start.
	self assert: thread isStarted.
	self waitUntil: [bench actionCount >= 1].
	thread kill.
	self assert: thread isKilled.
	self assert: thread process isTerminated.	
	
	
	
	
]

{ #category : #tests }
TkThreadTest >> testKillStoppedThread [
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
TkThreadTest >> testNormalTermination [
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [ bench actionCount = 3 ].
	self assert: thread isDone.
	self deny: thread isStarted.
	self deny: thread isKilled.
	self deny: thread isStopped.

]

{ #category : #tests }
TkThreadTest >> testPeriodFixedDuration [
	thread := bench threadRepeatingFor300MillisecondPeriod100Milliseconds.
	thread start.
	self waitUntil: [thread isDone].
	self assert: bench actionCount < 4
]

{ #category : #tests }
TkThreadTest >> testPeriodFixedIterationsCount [
	thread := bench threadRepeating3TimesPeriod100Milliseconds.
	thread start.
	self assert: [thread isDone] takesMoreThan: 200 milliSeconds 

]

{ #category : #tests }
TkThreadTest >> testPeriodForever [
	thread := bench threadRepeatingForeverPeriod100Milliseconds.
	self assert: thread period equals: 100 milliSeconds.
	self assert: thread frequency equals: 10.
	thread start.
	self assert:  [ bench actionCount >= 3 ] takesMoreThan: 200 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testPeriodUntilCondition [
	thread := bench threadUntilFlagTruePeriod100Milliseconds.
	thread start.
	self assert:  [ bench actionCount >= 3 ] takesMoreThan: 200 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testPeriodWhileCondition [
	thread := bench threadWhileFlagTruePeriod100Milliseconds.
	thread start.
	self assert:  [ bench actionCount >= 3 ] takesMoreThan: 200 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testPersistUntillDone [
	| process |
	thread := bench threadRepeating3TimesPeriod100Milliseconds.
	thread persistUntillDone.
	bench thread: nil.
	thread start.
	process := thread process.
	thread := nil.
	Smalltalk garbageCollect.
	self waitUntil: [process isTerminated].
	self assert: bench actionCount equals: 3.


]

{ #category : #tests }
TkThreadTest >> testPostponedRestartByDuration [
	| startTime endTime |
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [ thread isDone ].
	startTime := DateAndTime now.
	bench restartThreadAfter100Milliseconds.
	self waitUntil: [thread isDone].
	endTime := DateAndTime now.
	self assert:  endTime - startTime > 100 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testPostponedRestartToGivenTime [
	| startTime endTime |
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [ thread isDone ].
	startTime := DateAndTime now.
	bench restartThread100MillisecondsInTheFuture.
	self waitUntil: [thread isDone].
	endTime := DateAndTime now.
	self assert:  endTime - startTime > 100 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testPostponedStartByDuration [
	| startTime endTime |
	thread := bench threadRepeating3Times.
	startTime := DateAndTime now.
	bench startThreadAfter100Milliseconds.
	self waitUntil: [thread isDone].
	endTime := DateAndTime now.
	self assert:  endTime - startTime > 100 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testPostponedStartOfDoneThread [
	thread := bench threadRepeating3TimesPeriod100Milliseconds.
	thread start.
	self waitUntil: [ thread isDone ].
	bench startThreadAfter100Milliseconds.
	self deny: thread isStarted.
	self assert: thread isDone.

]

{ #category : #tests }
TkThreadTest >> testPostponedStartOfStartedThread [
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [ bench actionCount > 1 ].
	bench startThreadAfter100Milliseconds.
	self assert: thread isStarted.
	self assert: bench resetCount equals: 0.

]

{ #category : #tests }
TkThreadTest >> testPostponedStartToGivenTime [
	| startTime endTime |
	thread := bench threadRepeating3Times.
	startTime := DateAndTime now.
	bench startThread100MillisecondsInTheFuture.
	self waitUntil: [thread isDone].
	endTime := DateAndTime now.
	self assert:  endTime - startTime > 100 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testPrintString [
	thread := bench threadUntilFlagTruePeriod100Milliseconds.
	self assert: (thread printString includesSubstring: '30').
	thread priority: 33.
	self assert: (thread printString includesSubstring: '33').
	#('First Name' 'Second Name') do: [: newName |
		thread name: newName.
		self assert: (thread printString includesSubstring: newName).
	].
	self assert: (thread printString includesSubstring: 'New').
	thread start.
	self assert: (thread printString includesSubstring: 'Started').
	thread stop.
	self waitUntil: [ thread isStopped ].
	self assert: (thread printString includesSubstring: 'Stopped').
	thread start.
	bench setFlagTrue.	
	self waitUntil: [ thread isDone ].
	self assert: (thread printString includesSubstring: 'Done').
	bench setFlagFalse.	
	thread restart.
	self waitUntil: [ thread isStarted ].
	thread kill.
	self assert: thread isKilled.
	self assert: (thread printString includesSubstring: 'Killed').
		

	
	
	
	
]

{ #category : #tests }
TkThreadTest >> testProcessName [
	| firstName secondName |
	thread := bench threadRepeatingForever.
	firstName := 'First Name'.
	thread name: firstName.
	thread start.
	self assert: thread process name equals: firstName.
	secondName := 'Second Name'.
	thread name: secondName.
	self assert: thread process name equals: secondName.
		
	
	
	
]

{ #category : #tests }
TkThreadTest >> testProcessPriority [
	| firstPriority secondPriority |
	thread := bench threadRepeatingForeverPeriod100Milliseconds.
	self assert: thread priority equals: 30.
	firstPriority := 33. 
	thread priority: firstPriority.
	thread start.
	self assert: thread process priority equals: firstPriority.
	secondPriority := 35.
	thread priority: secondPriority.
	self assert: thread process priority equals: secondPriority.
		
	
	
	
]

{ #category : #tests }
TkThreadTest >> testRepeatForFixedDuration [
	thread := bench threadRepeatingFor300Milliseconds.
	thread start.
	self waitUntil: [ thread isDone ].
	self assert: bench actionCount > 0.
	
	
	
	
]

{ #category : #tests }
TkThreadTest >> testRestartAfterKill [
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
TkThreadTest >> testRestartAfterNormalTermination [
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
TkThreadTest >> testRestartAfterStart [
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
TkThreadTest >> testRestartOfStartedThreadAfterAGivenDuration [
	| startTime endTime currentCount |
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [ bench actionCount > 1 ].
	startTime := DateAndTime now.
	bench restartThreadAfter100Milliseconds.
	currentCount := bench actionCount.
	self waitUntil: [bench actionCount > currentCount].
	endTime := DateAndTime now.
	self assert:  endTime - startTime > 100 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testRestartOfStartedThreadOnAGivenTime [
	| startTime endTime currentCount |
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [ bench actionCount > 1 ].
	startTime := DateAndTime now.
	bench restartThread100MillisecondsInTheFuture.
	currentCount := bench actionCount.
	self waitUntil: [bench actionCount > currentCount].
	endTime := DateAndTime now.
	self assert:  endTime - startTime > 100 milliSeconds.

]

{ #category : #tests }
TkThreadTest >> testRestartStoppedThread [
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
TkThreadTest >> testRestartThreadNeverStarted [
	thread := bench threadRepeatingForever.
	thread restart.
	self assert: thread isStarted.
	self assert: bench resetCount equals: 0.

]

{ #category : #tests }
TkThreadTest >> testSetUpTearDown [
	thread := bench threadRepeating3Times.
	bench addSetUpTearDownBlocks.
	thread start.
	self waitUntil: [ thread isDone ].
	self assert: bench setUpCount equals: 1.	
	self assert: bench tearDownCount equals: 1.	
	
	
	
]

{ #category : #tests }
TkThreadTest >> testSetUpTearDownActions [
	thread := bench threadRepeating3TimesWithSetUpTearDownActions.
	thread start.
	self assert: bench setUpCount equals: 1.
	self waitUntil: [ thread isDone ].
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 1.

]

{ #category : #tests }
TkThreadTest >> testSingleIterationThread [
	thread := bench threadDoOnce.
	thread start.
	self waitUntil: [ thread isDone ].
	self assert: bench actionCount equals: 1.
	
	
	
	
]

{ #category : #tests }
TkThreadTest >> testStartDoneThread [
	thread := bench threadRepeating3Times.
	thread start.
	self waitUntil: [thread isDone].
	thread start.
	self assert: thread isDone.
	
	
	
	
	
]

{ #category : #tests }
TkThreadTest >> testStartKilledThread [
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
TkThreadTest >> testStartNewThread [
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
TkThreadTest >> testStartStartedThread [
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
TkThreadTest >> testStartStoppedThread [
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
TkThreadTest >> testStopStartedThread [
	thread := bench threadRepeatingForever.
	thread start.
	self waitUntil: [bench actionCount >= 1].
	thread stop.
	self waitUntil: [thread isStopped].
	self deny: thread isStarted.

]

{ #category : #tests }
TkThreadTest >> testWaitTimeout [
	thread := bench threadRepeating3Times.
	self should: [thread waitDoneTimeout: 300 milliSeconds] raise: TkTimeout.

]

{ #category : #tests }
TkThreadTest >> testWaitUntillDone [
	thread := bench threadRepeating3Times.
	thread start.
	thread waitDone.
	self assert: thread isDone.
	self assert: bench actionCount equals: 3.
]
