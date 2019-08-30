Class {
	#name : #CcServiceStateTest,
	#superclass : #CcServiceTest,
	#instVars : [
		'startSemaphore',
		'stopSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #'test state requests' }
CcServiceStateTest >> setUp [
	super setUp.
	startSemaphore := Semaphore new.
	stopSemaphore := Semaphore new.
	service := CcService
		do: [startSemaphore signal]
		thenRepeat: [ ]
		every: 50 milliSeconds
		ensure: [ stopSemaphore signal ]
]

{ #category : #'test state requests' }
CcServiceStateTest >> testNewActiveObjectShouldBeStopped [
	self deny: service isStarted.
	self assert: service isStopped.

]

{ #category : #'test state requests' }
CcServiceStateTest >> testStartedObjectShouldBeStarted [
	service start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds:  100.
	self assert: service isStarted.
	self deny: service isStopped.

]

{ #category : #'test state requests' }
CcServiceStateTest >> testStartedThenStoppedObjectShouldBeStopped [
	service start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds:  100.
	service stop.
	self assertSemaphore: stopSemaphore signaledWithinMilliseconds: 100.
	self deny: service isStarted.
	self assert: service isStopped
]

{ #category : #'test state requests' }
CcServiceStateTest >> testStartedThenStoppedThenStartedObjectShouldBeStarted [
	service start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds: 100.
	service stop.
	self assertSemaphore: stopSemaphore signaledWithinMilliseconds: 100.
	service start.
	self assertSemaphore: startSemaphore signaledWithinMilliseconds: 100.
	self assert: service isStarted.
	self deny: service isStopped.
	
]
