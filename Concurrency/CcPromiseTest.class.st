Class {
	#name : #CcPromiseTest,
	#superclass : #TestCase,
	#traits : 'TConcurrencyTest',
	#classTraits : 'TConcurrencyTest classTrait',
	#instVars : [
		'promise'
	],
	#category : #'Concurrency-Test'
}

{ #category : #running }
CcPromiseTest >> setUp [
	super setUp.
	promise := CcPromise new.
]

{ #category : #tests }
CcPromiseTest >> testFulfillAfterReject [
	promise rejectWith: 0.
	self should: [ promise fulfillWith: 48 ] raise: CcPromiseAlreadySettledError
]

{ #category : #tests }
CcPromiseTest >> testFulfillTwice [
	promise fulfillWith: 123.
	self should: [ promise fulfillWith: 48 ] raise: CcPromiseAlreadySettledError
]

{ #category : #tests }
CcPromiseTest >> testFulfilling [
	promise fulfillWith: 123.
	self deny: promise isPending.
	self assert: promise isFulfilled.
	self deny: promise isRejected.
	self assert: promise isSettled.
]

{ #category : #tests }
CcPromiseTest >> testMultipleFulfillActionPerformed [
	| semaphores |
	semaphores := (1 to: 10) collect: [: index| Semaphore new ].
	semaphores do: [: aSemaphore | 
		promise onFulfillDo: [aSemaphore signal]].
	300 milliSeconds wait.
	self assert: (semaphores allSatisfy: [:aSemaphore | aSemaphore wait: 0 milliSeconds]).
	promise fulfillWith: 456.
	self assert: (semaphores noneSatisfy: [:aSemaphore | aSemaphore wait: 300 milliSeconds]).

]

{ #category : #tests }
CcPromiseTest >> testMultipleRejectActionPerformed [
	| semaphores |
	semaphores := (1 to: 10) collect: [: index| Semaphore new ].
	semaphores do: [: aSemaphore | 
		promise onRejectDo: [aSemaphore signal]].
	300 milliSeconds wait.
	self assert: (semaphores allSatisfy: [:aSemaphore | aSemaphore wait: 0 milliSeconds]).
	promise rejectWith: 456.
	self assert: (semaphores noneSatisfy: [:aSemaphore | aSemaphore wait: 300 milliSeconds]).

]

{ #category : #tests }
CcPromiseTest >> testOneFulfillAction [
	| fulfillSemaphore |
	fulfillSemaphore := Semaphore new.
	promise onFulfillDo: [fulfillSemaphore signal].
	self denySemaphore: fulfillSemaphore signaledWithinMilliseconds: 300.
	promise fulfillWith: 456.
	self assertSemaphore: fulfillSemaphore signaledWithinMilliseconds: 300.

]

{ #category : #tests }
CcPromiseTest >> testOneRejectAction [
	| rejectSemaphore |
	rejectSemaphore := Semaphore new.
	promise onRejectDo: [rejectSemaphore signal].
	self denySemaphore: rejectSemaphore signaledWithinMilliseconds: 300.
	promise rejectWith: 123.
	self assertSemaphore: rejectSemaphore signaledWithinMilliseconds: 300.
	
]

{ #category : #tests }
CcPromiseTest >> testOnlyFulfillActionPerformed [
	| fulfillSemaphore rejectSemaphore |
	fulfillSemaphore := Semaphore new.
	rejectSemaphore := Semaphore new.
	promise 
		onFulfillDo: [fulfillSemaphore signal]
		onRejectDo: [rejectSemaphore signal].
	promise fulfillWith: 123.
	self assertSemaphore: fulfillSemaphore signaledWithinMilliseconds: 300.
	self denySemaphore: rejectSemaphore signaledWithinMilliseconds: 300.
]

{ #category : #tests }
CcPromiseTest >> testOnlyRejectActionPerformed [
	| fulfillSemaphore rejectSemaphore |
	fulfillSemaphore := Semaphore new.
	rejectSemaphore := Semaphore new.
	promise 
		onFulfillDo: [fulfillSemaphore signal]
		onRejectDo: [rejectSemaphore signal].
	promise rejectWith: 123.
	self assertSemaphore: rejectSemaphore signaledWithinMilliseconds: 300.
	self denySemaphore: fulfillSemaphore signaledWithinMilliseconds: 300.

]

{ #category : #tests }
CcPromiseTest >> testPromiseInitiallyPending [
	self assert: promise isPending.
	self deny: promise isFulfilled.
	self deny: promise isRejected.
	self deny: promise isSettled.
]

{ #category : #tests }
CcPromiseTest >> testRegisterActionAfterFulfillment [
	| fulfillSemaphore |
	fulfillSemaphore := Semaphore new.
	promise fulfillWith: 123.
	promise onFulfillDo: [ 
		fulfillSemaphore signal].
	self assertSemaphore: fulfillSemaphore signaledWithinMilliseconds: 300.
	
]

{ #category : #tests }
CcPromiseTest >> testRegisterActionAfterRejection [
	| rejectSemaphore |
	promise rejectWith: 123.
	rejectSemaphore := Semaphore new.
	promise onRejectDo: [ 
		rejectSemaphore signal].
	self assertSemaphore: rejectSemaphore signaledWithinMilliseconds: 300.
	
]

{ #category : #tests }
CcPromiseTest >> testRejectAfterFulfill [
	promise fulfillWith: 48.
	self should: [promise rejectWith: 567] raise: CcPromiseAlreadySettledError
]

{ #category : #tests }
CcPromiseTest >> testRejectTwice [
	promise rejectWith: 44.
	self should: [ promise rejectWith: 77 ] raise: CcPromiseAlreadySettledError
]

{ #category : #tests }
CcPromiseTest >> testRejecting [
	promise rejectWith: 123.
	self deny: promise isPending.
	self deny: promise isFulfilled.
	self assert: promise isRejected.
	self assert: promise isSettled.
]

{ #category : #tests }
CcPromiseTest >> testSuspendActionUntilFulfillment [
	| fulfillSemaphore |
	fulfillSemaphore := Semaphore new.
	promise onFulfillDo: [ 
		fulfillSemaphore signal].
	self denySemaphore: fulfillSemaphore signaledWithinMilliseconds: 300.
	promise fulfillWith: 123.
	self assertSemaphore: fulfillSemaphore signaledWithinMilliseconds: 300.
	
]

{ #category : #tests }
CcPromiseTest >> testSuspendActionUntilRejection [
	| rejectSemaphore |
	rejectSemaphore := Semaphore new.
	promise onRejectDo: [ 
		rejectSemaphore signal].
	self denySemaphore: rejectSemaphore signaledWithinMilliseconds: 300.
	promise rejectWith: 123.
	self assertSemaphore: rejectSemaphore signaledWithinMilliseconds: 300.
	
]
