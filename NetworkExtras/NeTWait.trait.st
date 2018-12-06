"
I provide facility methods for tests that require waiting some undefined duration, which is typical in networking
"
Trait {
	#name : #NeTWait,
	#category : #'NetworkExtras-Kernel'
}

{ #category : #waiting }
NeTWait >> defaultTimeoutDuration [
	^500 milliSeconds 
]

{ #category : #waiting }
NeTWait >> waitUntil: conditionBlock [
	self waitUntil: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
NeTWait >> waitUntil: conditionBlock onTimeout: aDuration do: aBlock [
	self waitWhile: [ conditionBlock value not ] onTimeout: aDuration do: aBlock
]

{ #category : #waiting }
NeTWait >> waitUntil: conditionBlock timeout: aDuration [
	self waitUntil: conditionBlock onTimeout: aDuration do: [ self fail: 'Timeout' ]
]

{ #category : #waiting }
NeTWait >> waitWhile: conditionBlock [
	self waitWhile: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #waiting }
NeTWait >> waitWhile: conditionBlock onTimeout: aDuration do: aBlock [
	| iterationCount iterationDuration |
	iterationDuration := 50 milliSeconds.
	iterationCount := (aDuration / iterationDuration) asFloat rounded + 1.
	iterationCount
		timesRepeat: [ conditionBlock value
				ifFalse: [ ^ self ].
			iterationDuration wait ].
	aBlock value
]

{ #category : #waiting }
NeTWait >> waitWhile: conditionBlock timeout: aDuration [
	self waitWhile: conditionBlock onTimeout: aDuration do: [self fail: 'Timeout']
]
