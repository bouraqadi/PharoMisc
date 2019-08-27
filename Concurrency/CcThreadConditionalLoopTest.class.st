Class {
	#name : #CcThreadConditionalLoopTest,
	#superclass : #CcThreadTest,
	#instVars : [
		'count',
		'actionFinishedSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcThreadConditionalLoopTest >> setUp [
	super setUp.
	count := 0.
	actionFinishedSemaphore := Semaphore new.
	activeObject  := CcThread 
						repeat: [ count := count + 1]
						every: 10 milliSeconds 
						while: [ count < 10 ]
						ensure: [actionFinishedSemaphore signal].

]

{ #category : #testing }
CcThreadConditionalLoopTest >> testPerformsOnlyIfWhileConditionIsTrueOnStart [
	count := 20.
	activeObject start.
	self assertSemaphore: actionFinishedSemaphore signaledWithinSeconds: 1.
	self assert: count equals: 20.

]

{ #category : #testing }
CcThreadConditionalLoopTest >> testStopWhenWhileConditionIsFalse [
	activeObject start.
	self assertSemaphore: actionFinishedSemaphore signaledWithinSeconds: 1.
	self assert: count = 10.

]
