Trait {
	#name : #TkTConcurrencyTest,
	#traits : 'TkTWaitPolling',
	#classTraits : 'TkTWaitPolling classTrait',
	#category : #'Tasks-Public'
}

{ #category : #tests }
TkTConcurrencyTest >> assert: aBlock takesMoreThan: aDuration [
	| startTime endTime |
	startTime := DateAndTime now.
	self waitUntil: aBlock.
	endTime := DateAndTime now.
	self assert:  endTime - startTime > aDuration

]
