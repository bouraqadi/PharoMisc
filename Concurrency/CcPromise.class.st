"
I manage the outcome of a single asynchronous computation, i.e. asynchronous message send. 
Callbacks can be registered for triggering either upon computation normal termination, or upon failure, such as exceptions.

Public API and Key Messages
- onFulfillDo: aBlock
Store aBlock to be valued upon normal termination of the computation.
The block can take an argument which is the result of the computation.

- onRejectDo: aBlock
Store aBlock to be valued upon computation failure.
The block can take an argument which is the exception that ends the computation.

- fulfillWith: result
Trigger callbacks waiting for normal termination.

- rejectWith: anObject  
Trigger callbacks waiting for termination failure. The argument is typically the exception raised by the execution.

Instance Variables
	fulfillActions:		<Set of BlockClosure>
	fulfillResult:		<Object>
	isFulfilled:		<Boolean>
	isRejected:		<Boolean>
	rejectActions:		<Set of BlockClosure>
	rejectResult:		<Object>
	stateLock:		<Mutex>


    Implementation Points
"
Class {
	#name : #CcPromise,
	#superclass : #Object,
	#instVars : [
		'isFulfilled',
		'isRejected',
		'fulfillActions',
		'rejectActions',
		'fulfillResult',
		'rejectResult',
		'stateLock'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #'instance creation' }
CcPromise class >> onFulfillDo: aBlockClosure [
	^self new
		onFulfillDo: aBlockClosure;
		yourself
]

{ #category : #'instance creation' }
CcPromise class >> onFulfillDo: fulfillBlock onRejectDo: rejectBlock [
	^self new
		onFulfillDo: fulfillBlock onRejectDo: rejectBlock;
		yourself
]

{ #category : #'instance creation' }
CcPromise class >> onRejectDo: aBlockClosure [
	^self new
		onRejectDo: aBlockClosure;
		yourself
]

{ #category : #state }
CcPromise >> fulfillWith: anObject [
	stateLock critical: [
		fulfillResult := anObject.
		self isSettled ifTrue: [ CcPromiseAlreadySettledError signal ]. 
		isFulfilled := true.
		fulfillActions do: [ : aBlock | self valueFulfillAction: aBlock]
	]
]

{ #category : #initialization }
CcPromise >> initialize [
	super initialize.
	isFulfilled := false.
	isRejected := false.
	fulfillActions := Set new.
	rejectActions := Set new.
	stateLock := Mutex new.
]

{ #category : #state }
CcPromise >> isFulfilled [
	^stateLock critical: [isFulfilled]
]

{ #category : #state }
CcPromise >> isPending [
	^stateLock critical: [self isSettled not]
]

{ #category : #state }
CcPromise >> isRejected [
	^stateLock critical: [isRejected] 
]

{ #category : #state }
CcPromise >> isSettled [
	^stateLock critical: [self isFulfilled or: [self isRejected]]
]

{ #category : #acting }
CcPromise >> onFulfillDo: aBlockClosure [ 
	stateLock critical: [
		self isFulfilled ifTrue: [^self valueFulfillAction: aBlockClosure].
		fulfillActions add: aBlockClosure
	]
]

{ #category : #acting }
CcPromise >> onFulfillDo: fulfillActionBlock onRejectDo: rejectActionBlock [
	self onFulfillDo: fulfillActionBlock.
	self onRejectDo: rejectActionBlock.
]

{ #category : #acting }
CcPromise >> onRejectDo: aBlockClosure [ 
	stateLock critical: [
		self isRejected ifTrue: [^self valueRejectAction: aBlockClosure].
		rejectActions add: aBlockClosure
	]
]

{ #category : #state }
CcPromise >> rejectWith: anObject [ 
	stateLock critical: [
		rejectResult := anObject.
		self isSettled ifTrue: [ CcPromiseAlreadySettledError signal ]. 
		isRejected := true.
		rejectActions do: [ : aBlock | self valueRejectAction: aBlock ]
	]
]

{ #category : #acting }
CcPromise >> valueFulfillAction: aBlock [
	aBlock cull: fulfillResult
]

{ #category : #acting }
CcPromise >> valueRejectAction: aBlock [
	aBlock cull: rejectResult
]
