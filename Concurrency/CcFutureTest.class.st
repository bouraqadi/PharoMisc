Class {
	#name : #CcFutureTest,
	#superclass : #TestCase,
	#traits : 'TConcurrencyTest',
	#classTraits : 'TConcurrencyTest classTrait',
	#instVars : [
		'future',
		'process'
	],
	#category : #'Concurrency-Test'
}

{ #category : #tests }
CcFutureTest >> assertFutureValue: value withBlock: aBlock leadsToResult: expectedResult [
	| result  |
	future := CcFuture new.
	self assertTerminationOfForkedBlock: [result := aBlock value] afterValueOf: [future value: value]. 
	self assert: result equals: expectedResult
]

{ #category : #tests }
CcFutureTest >> assertTerminationOfForkedBlock: blockToFork afterValueOf: mainBlock [ 
	| processDone |
	future := CcFuture new.
	processDone := self semaphoreSingaledAfterForkedBlock: blockToFork.
	mainBlock value.
	self assertSemaphore: processDone signaledWithinMilliseconds: 300.

]

{ #category : #tests }
CcFutureTest >> semaphoreSingaledAfterForkedBlock: aBlock [
	| processStarts processStops |
	processStarts := Semaphore new.
	processStops := Semaphore new.
	process := [
		processStarts signal.
		aBlock value.
		processStops signal] fork.
	self assertSemaphore: processStarts signaledWithinMilliseconds:  300.
	^processStops
]

{ #category : #tests }
CcFutureTest >> setUp [
	super setUp.
	future := CcFuture new.

]

{ #category : #tests }
CcFutureTest >> testBlockClosureValue [
	self assertFutureValue: [10] withBlock: [future value] leadsToResult: 10.
	self assertFutureValue: [10] withBlock: [future value + 1] leadsToResult: 11.

]

{ #category : #tests }
CcFutureTest >> testBooleanValue [
	self assertFutureValue: true withBlock: [future not] leadsToResult: false.
	self assertFutureValue: false withBlock: [future not] leadsToResult: true.

]

{ #category : #tests }
CcFutureTest >> testEquality [
	{Object new. 1. 92.78. $q. 'text'. #(10)} do: [ : actualValue |
		self assertFutureValue: actualValue withBlock: [future = actualValue] leadsToResult: true].

]

{ #category : #tests }
CcFutureTest >> testException [
	| capturedException |
	self 
		assertTerminationOfForkedBlock: [[future foo] on: Exception do: [ : ex | capturedException := ex ]]
		afterValueOf: [future exceptionBlock: [ZeroDivide signal]].
	self assert: (capturedException isKindOf: ZeroDivide)
]

{ #category : #tests }
CcFutureTest >> testFloatValue [
	self assertFutureValue: 3.14 withBlock: [future] leadsToResult: 3.14.
	self assertFutureValue: 3.14 withBlock: [future asInteger] leadsToResult: 3.

]

{ #category : #tests }
CcFutureTest >> testHash [
	{1. 92.78. $q. 'text'. #(10)} do: [ : actualValue |
		self assertFutureValue: actualValue withBlock: [future hash] leadsToResult: actualValue hash.
	]

]

{ #category : #tests }
CcFutureTest >> testLargeIntegerValue [
	self assertFutureValue: SmallInteger maxVal + 100 withBlock: [future - 100] leadsToResult: SmallInteger maxVal.

]

{ #category : #tests }
CcFutureTest >> testMultipleProcessUsingASameFuture [
	| results doneSemaphores |
	results := Array new: 10.
	doneSemaphores := (1 to: 10) collect: [: each| Semaphore new ].
	1 to: 10 do: [: index |
		[ 
			results at: index put: future + index.
			(doneSemaphores at: index) signal] fork
	].
	future value: 100.
	doneSemaphores do: [ : each |
		 self assertSemaphore: each signaledWithinMilliseconds: 300].
	self assert: results equals: (101 to: 110) asArray.
]

{ #category : #tests }
CcFutureTest >> testProcessResumedWhenFutureValueSet [
	self assertTerminationOfForkedBlock: [future asByteArray] afterValueOf: [future value: 'abc'] 

]

{ #category : #tests }
CcFutureTest >> testProcessSuspendedUponMessageToFuture [
	| processStops |
	processStops := self semaphoreSingaledAfterForkedBlock: [future + 1].
	self denySemaphore: processStops signaledWithinMilliseconds: 300
]

{ #category : #tests }
CcFutureTest >> testSmallIntegerValue [
	self assertFutureValue: 10 withBlock: [future] leadsToResult: 10.
	self assertFutureValue: 10 withBlock: [future + 1] leadsToResult: 11.

]

{ #category : #tests }
CcFutureTest >> testStringValue [
	self assertFutureValue: 'Hello' withBlock: [future, ' ', 'Pharo'] leadsToResult: 'Hello Pharo'.

]
