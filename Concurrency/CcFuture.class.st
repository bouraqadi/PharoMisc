"
A future is an object returned as a placeholder of the actual result of an asynchronous computation. 
It allows threads to progress until we send a message to the result.
Messages are suspended until the actual result is available.

Once the actual result is available, all references to the future are replaced by references to the result.
This relies on becomeForward: which does not work for some basic objects such small integers or floats.
In this case, the value is wrapped into an instance of a CcBox.

Public API and Key Messages
- value: anObject
sets the actual value of the future. All threads that were waiting for the actual value are resumed
"
Class {
	#name : #CcFuture,
	#superclass : #Object,
	#instVars : [
		'accessLock',
		'waitingProcessesCount',
		'valueLock'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #'reflective operations' }
CcFuture >> becomeForward: anObject [
	| box |
	[ super becomeForward: anObject] 
		on: PrimitiveFailed
		do: [ 
			box := CcBox value: anObject.
			super becomeForward: box ]
]

{ #category : #'reflective operations' }
CcFuture >> doesNotUnderstand: aMessage [
	self incrementWaitingProcessesCount.
	valueLock wait.
	^aMessage sendTo: self

]

{ #category : #accessing }
CcFuture >> incrementWaitingProcessesCount [
	accessLock critical: [
		waitingProcessesCount := waitingProcessesCount + 1]
]

{ #category : #'initialize-release' }
CcFuture >> initialize [
	super initialize.
	valueLock := Semaphore new.
	accessLock := Mutex new.
	waitingProcessesCount := 0.
]

{ #category : #accessing }
CcFuture >> value: actualValue [
	"We need to use temporaries to store results of messages to future and access to its IVs first.
	Since after becomeForward: the receiver becomes a different object with a different sturcture (IVs) and behavior (methods)."
	|signalsCount lock|
	signalsCount := self waitingProcessesCount.
	lock := valueLock.
	self becomeForward: actualValue.
	signalsCount timesRepeat: [ lock signal ].

]

{ #category : #accessing }
CcFuture >> valueBlock: aBlock [
	| evaluator |
	evaluator := CcBlockEvaluator valueBlock: aBlock.
	self value: evaluator
]

{ #category : #accessing }
CcFuture >> waitingProcessesCount [
	^accessLock critical: [waitingProcessesCount]
]
