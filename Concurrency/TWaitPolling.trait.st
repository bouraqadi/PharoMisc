"
I provide facility methods for waiting some undefined duration, which is typical in networking.
Waiting is done in short iterations (see method waitWhile:onTimeout:do:), hence the polling.
By default, the current thread is suspended for 50 milliseconds on every iteration (see method iterationDuration).

"
Trait {
	#name : #TWaitPolling,
	#category : #'Concurrency-Kernel'
}

{ #category : #waiting }
TWaitPolling >> defaultTimeoutDuration [
	^500 milliSeconds 
]

{ #category : #waiting }
TWaitPolling >> iterationDuration [
	^ 50 milliSeconds
]

{ #category : #waiting }
TWaitPolling >> waitUntil: conditionBlock [
	self waitUntil: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
TWaitPolling >> waitUntil: conditionBlock onTimeout: aDuration do: aBlock [
	self waitWhile: [ conditionBlock value not ] onTimeout: aDuration do: aBlock
]

{ #category : #waiting }
TWaitPolling >> waitUntil: conditionBlock timeout: aDuration [
	self waitUntil: conditionBlock onTimeout: aDuration do: [ self fail: 'Timeout' ]
]

{ #category : #waiting }
TWaitPolling >> waitWhile: conditionBlock [
	self waitWhile: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
TWaitPolling >> waitWhile: conditionBlock onTimeout: aDuration do: aBlock [
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
TWaitPolling >> waitWhile: conditionBlock timeout: aDuration [
	self waitWhile: conditionBlock onTimeout: aDuration do: [self fail: 'Timeout']
]
