Trait {
	#name : #TkTConcurrencyTest,
	#traits : 'TkTWaitPolling',
	#classTraits : 'TkTWaitPolling classTrait',
	#category : #'Tasks-Public'
}

{ #category : #tests }
TkTConcurrencyTest >> assert: aBlock takesMoreThan: minExpectedDuration [
	| startTime endTime actualDuration |
	startTime := DateAndTime now.
	self waitUntil: aBlock.
	endTime := DateAndTime now.
	actualDuration := endTime - startTime.
	self assert: actualDuration >= minExpectedDuration description: 'Became true after ', actualDuration humanReadablePrintString, ' instead of ', minExpectedDuration humanReadablePrintString

]
