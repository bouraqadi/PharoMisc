Class {
	#name : #CcServiceState,
	#superclass : #Object,
	#instVars : [
		'thread'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcServiceState >> doEnterAction [
	^self
]

{ #category : #state }
CcServiceState >> doExitAction [
	^self
]

{ #category : #testing }
CcServiceState >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	self subclassResponsibility
]

{ #category : #testing }
CcServiceState >> isCurrentState [
	^self state == self
]

{ #category : #testing }
CcServiceState >> isStarted [
	self subclassResponsibility
]

{ #category : #testing }
CcServiceState >> isStopped [
	self subclassResponsibility
]

{ #category : #accessing }
CcServiceState >> name [
	^self thread name
]

{ #category : #activity }
CcServiceState >> newProcess [
	^self thread newProcess
]

{ #category : #accessing }
CcServiceState >> priority [
	^self thread priority
]

{ #category : #accessing }
CcServiceState >> process [
	^self thread process
]

{ #category : #accessing }
CcServiceState >> process: aProcess [
	self thread process: aProcess
]

{ #category : #accessing }
CcServiceState >> processName: aString [
	self subclassResponsibility
]

{ #category : #activity }
CcServiceState >> start [
	self subclassResponsibility
]

{ #category : #accessing }
CcServiceState >> state [
	^self thread state
]

{ #category : #accessing }
CcServiceState >> state: aState [
	self doExitAction.
	self thread state: aState.
]

{ #category : #activity }
CcServiceState >> stop [
	self subclassResponsibility
]

{ #category : #accessing }
CcServiceState >> thread [
	^ thread
]

{ #category : #accessing }
CcServiceState >> thread: aThread [
	thread := aThread.
	self doEnterAction
]

{ #category : #state }
CcServiceState >> transitionTo: aStateClass [
	self state: aStateClass new
]
