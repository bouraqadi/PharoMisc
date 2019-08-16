Class {
	#name : #CcPromise,
	#superclass : #Object,
	#instVars : [
		'isFulfilled',
		'isRejected'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcPromise >> fulfillWith: anObject [ 
	isFulfilled := true.
]

{ #category : #initialization }
CcPromise >> initialize [
	super initialize.
	isFulfilled := false.
	isRejected := false.
	
]

{ #category : #state }
CcPromise >> isFulfilled [
	^ isFulfilled
]

{ #category : #state }
CcPromise >> isPending [
	^self isSettled not
]

{ #category : #state }
CcPromise >> isRejected [
	^ isRejected
]

{ #category : #state }
CcPromise >> isSettled [
	^self isFulfilled or: [ self isRejected ]
]

{ #category : #state }
CcPromise >> rejectWith: anException [ 
	isRejected := true.
]
