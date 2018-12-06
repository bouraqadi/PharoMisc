Class {
	#name : #ActiveObjectConditionalLoopTest,
	#superclass : #ActiveObjectTest,
	#instVars : [
		'count',
		'actionFinishedSemaphore'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
ActiveObjectConditionalLoopTest >> setUp [
	super setUp.
	count := 0.
	actionFinishedSemaphore := Semaphore new.
	activeObject  := ActiveObject 
						repeat: [ count := count + 1]
						every: 10 milliSeconds 
						while: [ count < 10 ]
						ensure: [actionFinishedSemaphore signal].

]

{ #category : #testing }
ActiveObjectConditionalLoopTest >> testPerformsOnlyIfWhileConditionIsTrueOnStart [
	count := 20.
	activeObject start.
	self assertSemaphore: actionFinishedSemaphore signaledWithinSeconds: 1.
	self assert: count equals: 20.

]

{ #category : #testing }
ActiveObjectConditionalLoopTest >> testStopWhenWhileConditionIsFalse [
	activeObject start.
	self assertSemaphore: actionFinishedSemaphore signaledWithinSeconds: 1.
	self assert: count = 10.

]
