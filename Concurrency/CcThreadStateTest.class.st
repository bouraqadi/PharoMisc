Class {
	#name : #CcThreadStateTest,
	#superclass : #CcThreadTest,
	#instVars : [
		'startSemaphore',
		'stopSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #'test state requests' }
CcThreadStateTest >> setUp [
	super setUp.
	startSemaphore := Semaphore new.
	stopSemaphore := Semaphore new.
	activeObject := CcThread
		do: [startSemaphore signal]
		thenRepeat: [ ]
		every: 50 milliSeconds
		ensure: [ stopSemaphore signal ]
]

{ #category : #'test state requests' }
CcThreadStateTest >> testNewActiveObjectShouldBeStopped [
	self deny: activeObject isStarted.
	self assert: activeObject isStopped.

]

{ #category : #'test state requests' }
CcThreadStateTest >> testStartedObjectShouldBeStarted [
	activeObject start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds:  100.
	self assert: activeObject isStarted.
	self deny: activeObject isStopped.

]

{ #category : #'test state requests' }
CcThreadStateTest >> testStartedThenStoppedObjectShouldBeStopped [
	activeObject start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds:  100.
	activeObject stop.
	self assertSemaphore: stopSemaphore signaledWithinMilliseconds: 100.
	self deny: activeObject isStarted.
	self assert: activeObject isStopped
]

{ #category : #'test state requests' }
CcThreadStateTest >> testStartedThenStoppedThenStartedObjectShouldBeStarted [
	activeObject start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds: 100.
	activeObject stop.
	self assertSemaphore: stopSemaphore signaledWithinMilliseconds: 100.
	activeObject start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds: 100.
	self assert: activeObject isStarted.
	self deny: activeObject isStopped.
	
]
