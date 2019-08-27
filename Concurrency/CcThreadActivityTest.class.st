Class {
	#name : #CcThreadActivityTest,
	#superclass : #CcThreadTest,
	#instVars : [
		'counter',
		'activityTerminatedSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcThreadActivityTest >> assertEnsureBlockRunUponFinalizationForPriority: activeObjPriority [
	| activityStartedSemaphore process |
	activityStartedSemaphore := Semaphore new.
	activeObject := CcThread 
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
CcThreadActivityTest >> assertEnsureBlockRunUponStopForPriority: activeObjPriority [
	| activityStartedSemaphore |
	activityStartedSemaphore := Semaphore new.
	activeObject := CcThread 
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
CcThreadActivityTest >> setUp [
	super setUp.
	counter := 0.
	activityTerminatedSemaphore := Semaphore new.

]

{ #category : #testing }
CcThreadActivityTest >> testDoesActivity [
	activeObject := CcThread do: [
			counter := 1.
			activityTerminatedSemaphore signal
	].
	activeObject start.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 1.
	
]

{ #category : #testing }
CcThreadActivityTest >> testDoesEnsureBlock [
	activeObject := CcThread 
		do: [counter := 1]
		ensure:	 [activityTerminatedSemaphore signal].
	activeObject start.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 1.
	
]

{ #category : #testing }
CcThreadActivityTest >> testDoesEnsureBlockUponFinalizationForHighestPriority [
	self assertEnsureBlockRunUponFinalizationForPriority: Processor highestPriority
]

{ #category : #testing }
CcThreadActivityTest >> testDoesEnsureBlockUponFinalizationForLowestPriority [
	self assertEnsureBlockRunUponFinalizationForPriority: Processor lowestPriority
]

{ #category : #testing }
CcThreadActivityTest >> testDoesEnsureBlockUponStopForHighestPriority [
	self assertEnsureBlockRunUponStopForPriority: Processor highestPriority
]

{ #category : #testing }
CcThreadActivityTest >> testDoesEnsureBlockUponStopForLowestPriority [
	self assertEnsureBlockRunUponStopForPriority: Processor lowestPriority
]

{ #category : #testing }
CcThreadActivityTest >> testRestartUponForcedStop [
	| previousCounter |
	activeObject := CcThread repeat: [counter := counter + 1] every: 50 milliSeconds ensure: [ activityTerminatedSemaphore signal].
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
CcThreadActivityTest >> testRestartUponNormalTermination [
	activeObject := CcThread 
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
CcThreadActivityTest >> testRunUntilCompletness [
	activeObject := CcThread 
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
