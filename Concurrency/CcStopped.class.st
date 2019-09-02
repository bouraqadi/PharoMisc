Class {
	#name : #CcStopped,
	#superclass : #CcServiceState,
	#instVars : [
		'processStartedSemaphore'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcStopped >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^blockForStopped value
]

{ #category : #initialization }
CcStopped >> initialize [
	super initialize.
	processStartedSemaphore := Semaphore new.

]

{ #category : #activity }
CcStopped >> isStarted [
	^false
]

{ #category : #activity }
CcStopped >> isStopped [
	^true
]

{ #category : #accessing }
CcStopped >> name: aString [ 
	^self
]

{ #category : #activity }
CcStopped >> onProcessStarted [
	self transitionTo: CcStarted.
	processStartedSemaphore signal

]

{ #category : #accessing }
CcStopped >> priority: anInteger [ 
	^self
]

{ #category : #activity }
CcStopped >> start [
	self runner start.
	processStartedSemaphore wait.

]

{ #category : #printing }
CcStopped >> stateString [
	^'stopped'
]

{ #category : #activity }
CcStopped >> stop [
	^self
]
