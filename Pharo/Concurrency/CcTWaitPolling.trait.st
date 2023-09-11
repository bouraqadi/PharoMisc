"
I provide facility methods for waiting some undefined duration, which is typical in networking.
Waiting is done in short iterations (see method waitWhile:onTimeout:do:), hence the polling.
By default, the current thread is suspended for 50 milliseconds on every iteration (see method iterationDuration).

"
Trait {
	#name : #CcTWaitPolling,
	#category : #'Concurrency-Kernel'
}

{ #category : #waiting }
CcTWaitPolling >> defaultActionOnTimeout [
	CcTimeout signal
]

{ #category : #waiting }
CcTWaitPolling >> defaultTimeoutDuration [
	^500 milliSeconds 
]

{ #category : #waiting }
CcTWaitPolling >> iterationDuration [
	^ 50 milliSeconds
]

{ #category : #waiting }
CcTWaitPolling >> waitUntil: conditionBlock [
	self waitUntil: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
CcTWaitPolling >> waitUntil: conditionBlock onTimeout: aDuration do: aBlock [
	self waitWhile: [ conditionBlock value not ] onTimeout: aDuration do: aBlock
]

{ #category : #waiting }
CcTWaitPolling >> waitUntil: conditionBlock timeout: aDuration [
	self waitUntil: conditionBlock onTimeout: aDuration do: [ self fail: 'Timeout' ]
]

{ #category : #waiting }
CcTWaitPolling >> waitWhile: conditionBlock [
	self waitWhile: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
CcTWaitPolling >> waitWhile: conditionBlock onTimeout: aDuration do: aBlock [
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
CcTWaitPolling >> waitWhile: conditionBlock timeout: aDuration [
	self waitWhile: conditionBlock onTimeout: aDuration do: [self defaultActionOnTimeout]
]
