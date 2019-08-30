Class {
	#name : #CcServiceActivityTest,
	#superclass : #CcServiceTest,
	#instVars : [
		'counter',
		'activityTerminatedSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcServiceActivityTest >> assertEnsureBlockRunUponFinalizationForPriority: activeObjPriority [
	| activityStartedSemaphore process |
	activityStartedSemaphore := Semaphore new.
	service := CcService 
		do: [ 
			activityStartedSemaphore signal.
			[50 milliSeconds wait] repeat]
		ensure: [ activityTerminatedSemaphore signal ].
	service 
		priority: activeObjPriority;
		start.
	self assertSemaphore: activityStartedSemaphore  signaledWithinSeconds:  2.
	process := self activeObjProcess.
	service := nil.
	Smalltalk garbageCollect.
	self assertSemaphore: activityTerminatedSemaphore  signaledWithinSeconds:  2.
	self assert: process isTerminated 

]

{ #category : #testing }
CcServiceActivityTest >> assertEnsureBlockRunUponStopForPriority: activeObjPriority [
	| activityStartedSemaphore |
	activityStartedSemaphore := Semaphore new.
	service := CcService 
		do: [ 
			activityStartedSemaphore signal.
			[50 milliSeconds wait] repeat]
		ensure: [ activityTerminatedSemaphore signal ].
	service 
		priority: activeObjPriority;
		start.
	self assertSemaphore: activityStartedSemaphore signaledWithinSeconds:  2.
	service stop.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinSeconds:  2.
	self assert: self activeObjProcess isTerminated 

]

{ #category : #testing }
CcServiceActivityTest >> setUp [
	super setUp.
	counter := 0.
	activityTerminatedSemaphore := Semaphore new.

]

{ #category : #testing }
CcServiceActivityTest >> testDoesActivity [
	service := CcService do: [
			counter := 1.
			activityTerminatedSemaphore signal
	].
	service start.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 1.
	
]

{ #category : #testing }
CcServiceActivityTest >> testDoesEnsureBlock [
	service := CcService 
		do: [counter := 1]
		ensure:	 [activityTerminatedSemaphore signal].
	service start.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 1.
	
]

{ #category : #testing }
CcServiceActivityTest >> testDoesEnsureBlockUponFinalizationForHighestPriority [
	self assertEnsureBlockRunUponFinalizationForPriority: Processor highestPriority
]

{ #category : #testing }
CcServiceActivityTest >> testDoesEnsureBlockUponFinalizationForLowestPriority [
	self assertEnsureBlockRunUponFinalizationForPriority: Processor lowestPriority
]

{ #category : #testing }
CcServiceActivityTest >> testDoesEnsureBlockUponStopForHighestPriority [
	self assertEnsureBlockRunUponStopForPriority: Processor highestPriority
]

{ #category : #testing }
CcServiceActivityTest >> testDoesEnsureBlockUponStopForLowestPriority [
	self assertEnsureBlockRunUponStopForPriority: Processor lowestPriority
]

{ #category : #testing }
CcServiceActivityTest >> testRestartUponForcedStop [
	| previousCounter |
	service := CcService repeat: [counter := counter + 1] every: 50 milliSeconds ensure: [ activityTerminatedSemaphore signal].
	service start.
	self denySemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	service stop.
	self assertSemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter >  0.
	previousCounter := counter.
	service start.
	self denySemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter > previousCounter
	
	
]

{ #category : #testing }
CcServiceActivityTest >> testRestartUponNormalTermination [
	service := CcService 
		do: [counter := counter + 1] 
		ensure: [activityTerminatedSemaphore signal].
	service priority: Processor userSchedulingPriority.
	service start.
	self assertSemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter equals: 1.
	service start.
	self assertSemaphore:  activityTerminatedSemaphore signaledWithinMilliseconds: 500.
	self assert: counter equals: 2
	
	
]

{ #category : #testing }
CcServiceActivityTest >> testRunUntilCompletness [
	service := CcService 
		repeat: [counter := counter + 1]
		every: 10 milliSeconds
		while: [ counter < 10 ]
		ensure: [ activityTerminatedSemaphore signal].
	service runTillDone.
	service := nil. "Unreference the active object"
	Smalltalk garbageCollectMost.
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds:  500.
	self assert: counter = 10.
	
]
