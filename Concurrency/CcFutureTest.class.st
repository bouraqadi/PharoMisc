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
	| result processStarted processDone |
	future := CcFuture new.
	processStarted := Semaphore new.
	processDone := Semaphore new.
	process := [
		processStarted signal. 
		result := aBlock value.
		processDone signal] fork.
	self assertSemaphore: processStarted signaledWithinMilliseconds: 300.
	future value: value.
	self assertSemaphore: processDone signaledWithinMilliseconds: 300.
	self assert: result equals: expectedResult
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
	self assertFutureValue: #(10) withBlock: [future = #(10)] leadsToResult: true.

]

{ #category : #tests }
CcFutureTest >> testException [
	| capturedException doneSemaphore |
	doneSemaphore := Semaphore new.
	[
		[future foo] on: Exception do: [ : ex | capturedException := ex ].
		doneSemaphore signal.
	] fork.
	future exceptionBlock: [ZeroDivide signal].
	self assertSemaphore: doneSemaphore signaledWithinMilliseconds:  300.
	self assert: (capturedException isKindOf: ZeroDivide)
]

{ #category : #tests }
CcFutureTest >> testFloatValue [
	self assertFutureValue: 3.14 withBlock: [future] leadsToResult: 3.14.
	self assertFutureValue: 3.14 withBlock: [future asInteger] leadsToResult: 3.

]

{ #category : #tests }
CcFutureTest >> testHash [
	| actualValue |
	actualValue := Object new.
	self assertFutureValue: actualValue withBlock: [future hash] leadsToResult: actualValue hash.

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
	| processStarts processStops |
	processStarts := Semaphore new.
	processStops := Semaphore new.
	process := [
		processStarts signal.
		future asByteArray.
		processStops signal] fork.
	processStarts wait.
	future value: 'abc'.
	self assertSemaphore: processStops signaledWithinMilliseconds: 300.

]

{ #category : #tests }
CcFutureTest >> testProcessSuspendedUponMessageToFuture [
	| processStarts processStops |
	processStarts := Semaphore new.
	processStops := Semaphore new.
	process := [
		processStarts signal.
		future + 1.
		processStops signal] fork.
	self assertSemaphore: processStarts signaledWithinMilliseconds:  300.
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
