Class {
	#name : #CcServiceConditionalLoopTest,
	#superclass : #CcServiceTest,
	#instVars : [
		'count',
		'actionFinishedSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcServiceConditionalLoopTest >> setUp [
	super setUp.
	count := 0.
	actionFinishedSemaphore := Semaphore new.
	service  := CcService 
						repeat: [ count := count + 1]
						every: 10 milliSeconds 
						while: [ count < 10 ]
						ensure: [actionFinishedSemaphore signal].

]

{ #category : #testing }
CcServiceConditionalLoopTest >> testPerformsOnlyIfWhileConditionIsTrueOnStart [
	count := 20.
	service start.
	self assertSemaphore: actionFinishedSemaphore signaledWithinSeconds: 1.
	self assert: count equals: 20.

]

{ #category : #testing }
CcServiceConditionalLoopTest >> testStopWhenWhileConditionIsFalse [
	service start.
	self assertSemaphore: actionFinishedSemaphore signaledWithinSeconds: 1.
	self assert: count = 10.

]
