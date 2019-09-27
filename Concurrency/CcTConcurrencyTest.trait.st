"
TConcurrencyTest provides methods to ease testing concurrent code with the following pattern.
 
-A semaphore is shared between the process for testcase and the concurrent process under test.

-the concurrent process under test is supposed signal the semaphore upon some condition.

-testcase waits for signals or timeouts to decide whether the test failed or not

"
Trait {
	#name : #CcTConcurrencyTest,
	#traits : 'CcTWaitPolling',
	#classTraits : 'CcTWaitPolling classTrait',
	#category : #'Concurrency-Kernel'
}

{ #category : #testing }
CcTConcurrencyTest >> assertFork: aBlock endsWithinMilliseconds: milliseconds [
	| semaphore |
	semaphore := Semaphore new.
	[ aBlock ensure: [ semaphore signal ] ] fork.
	self assertSemaphore: semaphore signaledWithinMilliseconds: milliseconds
]

{ #category : #testing }
CcTConcurrencyTest >> assertFork: aBlock endsWithinSeconds: seconds [
	| semaphore |
	semaphore := Semaphore new.
	[ aBlock ensure: [ semaphore signal ] ] fork.
	self assertSemaphore: semaphore signaledWithinSeconds: seconds
]

{ #category : #testing }
CcTConcurrencyTest >> assertFork: aBlock raise: exceptionClass withinMilliseconds: milliseconds [
	| semaphore |
	semaphore := Semaphore new.
	[ aBlock on: exceptionClass do: [: ex| semaphore signal ] ] fork.
	self assertSemaphore: semaphore signaledWithinMilliseconds: milliseconds
]

{ #category : #testing }
CcTConcurrencyTest >> assertFork: aBlock raise: exceptionClass withinSeconds: seconds [
	self assertFork: aBlock raise: exceptionClass withinMilliseconds: seconds * 1000
]

{ #category : #testing }
CcTConcurrencyTest >> assertSemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	| isTimeout |
	isTimeout := [(semaphore waitTimeoutMSecs: milliseconds)] on: TestTookTooMuchTime do: [ : ex| true ].
	self deny: isTimeout
]

{ #category : #testing }
CcTConcurrencyTest >> assertSemaphore: semaphore signaledWithinSeconds: seconds [
	self deny: (semaphore waitTimeoutSeconds: seconds)
]

{ #category : #waiting }
CcTConcurrencyTest >> defaultActionOnTimeout [
	self fail: 'Timeout'
]

{ #category : #testing }
CcTConcurrencyTest >> denySemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	self assert: (semaphore waitTimeoutMSecs: milliseconds)
]

{ #category : #testing }
CcTConcurrencyTest >> denySemaphore: semaphore signaledWithinSeconds: seconds [
	self assert: (semaphore waitTimeoutSeconds: seconds)
]
