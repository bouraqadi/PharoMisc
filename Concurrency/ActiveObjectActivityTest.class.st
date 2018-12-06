Class {
	#name : #ActiveObjectActivityTest,
	#superclass : #ActiveObjectTest,
	#instVars : [
		'counter',
		'activityTerminatedSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
ActiveObjectActivityTest >> assertEnsureBlockRunUponFinalizationForPriority: activeObjPriority [
	| activityStartedSemaphore process |
	activityStartedSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [ 
			activityStartedSemaphore signal.
			[50 milliSeconds wait] repeat]
		ensure: [ activityTerminatedSemaphore signal ].
	activeObject 
		priority: activeObjPriority;
		start.
	self assertSemaphore: activityStartedSemaphore  signaledWithinSeconds:  2.
	process := self activeObjProcess.
	activeObject := nil.
	Smalltalk garbageCollect.
	self assertSemaphore: activityTerminatedSemaphore  signaledWithinSeconds:  2.
	self assert: process isTerminated 

]

{ #category : #testing }
ActiveObjectActivityTest >> assertEnsureBlockRunUponStopForPriority: activeObjPriority [
	| activityStartedSemaphore |
	activityStartedSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [ 
			activityStartedSemaphore signal.
			[50 milliSeconds wait] repeat]
		ensure: [ activityTerminatedSemaphore signal ].
	activeObject 
		priority: activeObjPriority;
		start.
	self assertSemaphore: activityStartedSemaphore signaledWithinSeconds:  2.
	activeObject stop.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinSeconds:  2.
	self assert: self activeObjProcess isTerminated 

]

{ #category : #testing }
ActiveObjectActivityTest >> setUp [
	super setUp.
	counter := 0.
	activityTerminatedSemaphore := Semaphore new.

]

{ #category : #testing }
ActiveObjectActivityTest >> testDoesActivity [
	activeObject := ActiveObject do: [
			counter := 1.
			activityTerminatedSemaphore signal
	].
	activeObject start.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 1.
	
]

{ #category : #testing }
ActiveObjectActivityTest >> testDoesEnsureBlock [
	activeObject := ActiveObject 
		do: [counter := 1]
		ensure:	 [activityTerminatedSemaphore signal].
	activeObject start.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 1.
	
]

{ #category : #testing }
ActiveObjectActivityTest >> testDoesEnsureBlockUponFinalizationForHighestPriority [
	self assertEnsureBlockRunUponFinalizationForPriority: Processor highestPriority
]

{ #category : #testing }
ActiveObjectActivityTest >> testDoesEnsureBlockUponFinalizationForLowestPriority [
	self assertEnsureBlockRunUponFinalizationForPriority: Processor lowestPriority
]

{ #category : #testing }
ActiveObjectActivityTest >> testDoesEnsureBlockUponStopForHighestPriority [
	self assertEnsureBlockRunUponStopForPriority: Processor highestPriority
]

{ #category : #testing }
ActiveObjectActivityTest >> testDoesEnsureBlockUponStopForLowestPriority [
	self assertEnsureBlockRunUponStopForPriority: Processor lowestPriority
]

{ #category : #testing }
ActiveObjectActivityTest >> testRestartUponForcedStop [
	| previousCounter |
	activeObject := ActiveObject repeat: [counter := counter + 1] every: 50 milliSeconds ensure: [ activityTerminatedSemaphore signal].
	activeObject start.
	self denySemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	activeObject stop.
	self assertSemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter >  0.
	previousCounter := counter.
	activeObject start.
	self denySemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter > previousCounter
	
	
]

{ #category : #testing }
ActiveObjectActivityTest >> testRestartUponNormalTermination [
	activeObject := ActiveObject 
		do: [counter := counter + 1] 
		ensure: [activityTerminatedSemaphore signal].
	activeObject priority: Processor userSchedulingPriority.
	activeObject start.
	self assertSemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter = 1.
	activeObject start.
	self assertSemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter = 2
	
	
]

{ #category : #testing }
ActiveObjectActivityTest >> testRunUntilCompletness [
	activeObject := ActiveObject 
		repeat: [counter := counter + 1]
		every: 10 milliSeconds
		while: [ counter < 10 ]
		ensure: [ activityTerminatedSemaphore signal].
	activeObject runTillDone.
	activeObject := nil. "Unreference the active object"
	Smalltalk garbageCollectMost.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 10.
	
]
