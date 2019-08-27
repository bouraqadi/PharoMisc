"
TConcurrencyTest provides methods to ease testing concurrent code with the following pattern.
 
-A semaphore is shared between the process for testcase and the concurrent process under test.

-the concurrent process under test is supposed signal the semaphore upon some condition.

-testcase waits for signals or timeouts to decide whether the test failed or not

"
Trait {
	#name : #CcTConcurrencyTest,
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
CcTConcurrencyTest >> assertSemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	self deny: (semaphore waitTimeoutMSecs: milliseconds)
]

{ #category : #testing }
CcTConcurrencyTest >> assertSemaphore: semaphore signaledWithinSeconds: seconds [
	self deny: (semaphore waitTimeoutSeconds: seconds)
]

{ #category : #testing }
CcTConcurrencyTest >> denySemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	self assert: (semaphore waitTimeoutMSecs: milliseconds)
]

{ #category : #testing }
CcTConcurrencyTest >> denySemaphore: semaphore signaledWithinSeconds: seconds [
	self assert: (semaphore waitTimeoutSeconds: seconds)
]
