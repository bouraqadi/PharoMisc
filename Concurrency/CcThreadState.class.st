Class {
	#name : #CcThreadState,
	#superclass : #Object,
	#instVars : [
		'thread'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcThreadState >> doEnterAction [
	^self
]

{ #category : #state }
CcThreadState >> doExitAction [
	^self
]

{ #category : #activity }
CcThreadState >> isStarted [
	self subclassResponsibility 
]

{ #category : #activity }
CcThreadState >> isStopped [
	self subclassResponsibility 
]

{ #category : #accessing }
CcThreadState >> name [
	^self thread name
]

{ #category : #activity }
CcThreadState >> newProcess [
	^self thread newProcess
]

{ #category : #accessing }
CcThreadState >> priority [
	^self thread priority
]

{ #category : #accessing }
CcThreadState >> process [
	^self thread process
]

{ #category : #accessing }
CcThreadState >> process: aProcess [
	self thread process: aProcess
]

{ #category : #activity }
CcThreadState >> registerForFinalization [
	self thread registerForFinalization
]

{ #category : #activity }
CcThreadState >> start [
	self subclassResponsibility
]

{ #category : #accessing }
CcThreadState >> state: aState [
	self doExitAction.
	aState thread: self thread.
]

{ #category : #activity }
CcThreadState >> stop [
	self subclassResponsibility
]

{ #category : #accessing }
CcThreadState >> thread [
	^ thread
]

{ #category : #accessing }
CcThreadState >> thread: aThread [
	thread := aThread.
	self doEnterAction
]

{ #category : #state }
CcThreadState >> transitionTo: aStateClass [
	self state: aStateClass new
]
