Trait {
	#name : #TkTWaitPolling,
	#category : #'Tasks-Public'
}

{ #category : #waiting }
TkTWaitPolling >> defaultActionOnTimeout [
	TkTimeout signal
]

{ #category : #waiting }
TkTWaitPolling >> defaultTimeoutDuration [
	^500 milliSeconds 
]

{ #category : #waiting }
TkTWaitPolling >> iterationDuration [
	^ 50 milliSeconds
]

{ #category : #waiting }
TkTWaitPolling >> waitUntil: conditionBlock [
	self waitUntil: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
TkTWaitPolling >> waitUntil: conditionBlock onTimeout: aDuration do: aBlock [
	self waitWhile: [ conditionBlock value not ] onTimeout: aDuration do: aBlock
]

{ #category : #waiting }
TkTWaitPolling >> waitUntil: conditionBlock timeout: aDuration [
	self waitUntil: conditionBlock onTimeout: aDuration do: [ self fail: 'Timeout' ]
]

{ #category : #waiting }
TkTWaitPolling >> waitWhile: conditionBlock [
	self waitWhile: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
TkTWaitPolling >> waitWhile: conditionBlock onTimeout: aDuration do: aBlock [
	| iterationCount iterationDuration |
	iterationDuration := self iterationDuration.
	iterationCount := (aDuration / iterationDuration) ceiling max: 1.
	iterationCount
		timesRepeat: [ conditionBlock value
				ifFalse: [ ^ self ].
			iterationDuration wait ].
	aBlock value
]

{ #category : #waiting }
TkTWaitPolling >> waitWhile: conditionBlock timeout: aDuration [
	self waitWhile: conditionBlock onTimeout: aDuration do: [self defaultActionOnTimeout]
]
