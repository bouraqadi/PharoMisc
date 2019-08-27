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

{ #category : #testing }
CcThreadState >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	self subclassResponsibility
]

{ #category : #testing }
CcThreadState >> isStarted [
	self subclassResponsibility
]

{ #category : #testing }
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

{ #category : #accessing }
CcThreadState >> processName: aString [
	self subclassResponsibility
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
CcThreadState >> state [
	^self thread state
]

{ #category : #accessing }
CcThreadState >> state: aState [
	self doExitAction.
	self thread state: aState.
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
