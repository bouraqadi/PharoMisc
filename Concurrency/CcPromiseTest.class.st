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
	promise rejectWith: Error new.
	self should: [ promise fulfillWith: 48 ] raise: CcPromiseSettledError
]

{ #category : #tests }
CcPromiseTest >> testFulfillTwice [
	promise fulfillWith: 123.
	self should: [ promise fulfillWith: 48 ] raise: CcPromiseSettledError
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
CcPromiseTest >> testPromiseInitiallyPending [
	self assert: promise isPending.
	self deny: promise isFulfilled.
	self deny: promise isRejected.
	self deny: promise isSettled.
]

{ #category : #tests }
CcPromiseTest >> testRejectAfterFulfill [
	promise fulfillWith: 48.
	self should: [promise rejectWith: Error new] raise: CcPromiseSettledError
]

{ #category : #tests }
CcPromiseTest >> testRejectTwice [
	promise rejectWith: Error new.
	self should: [ promise rejectWith: MessageNotUnderstood new ] raise: CcPromiseSettledError
]

{ #category : #tests }
CcPromiseTest >> testRejecting [
	promise rejectWith: Error new.
	self deny: promise isPending.
	self deny: promise isFulfilled.
	self assert: promise isRejected.
	self assert: promise isSettled.
]
