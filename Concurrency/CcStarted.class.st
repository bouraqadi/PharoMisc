Class {
	#name : #CcStarted,
	#superclass : #CcServiceState,
	#instVars : [
		'lock',
		'processStoppedSemaphore'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #testing }
CcStarted >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^blockForStarted value
]

{ #category : #initialization }
CcStarted >> initialize [
	super initialize.
	processStoppedSemaphore := Semaphore new
]

{ #category : #activity }
CcStarted >> isStarted [
	^true
]

{ #category : #activity }
CcStarted >> isStopped [
	^false
]

{ #category : #accessing }
CcStarted >> name: aString [ 
	self process name: aString
]

{ #category : #accessing }
CcStarted >> onProcessStopped [
	self transitionTo: CcStopped.
	processStoppedSemaphore signal
]

{ #category : #accessing }
CcStarted >> priority: anInteger [ 
	self process priority: anInteger.
]

{ #category : #activity }
CcStarted >> start [
	^self
]

{ #category : #printing }
CcStarted >> stateString [
	^'started'
]

{ #category : #activity }
CcStarted >> stop [
	self runner stop.
	processStoppedSemaphore wait.
]
