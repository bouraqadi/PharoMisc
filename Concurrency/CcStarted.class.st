Class {
	#name : #CcStarted,
	#superclass : #CcServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #testing }
CcStarted >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^blockForStarted value
]

{ #category : #accessing }
CcStarted >> name: aString [ 
	self process name: aString
]

{ #category : #accessing }
CcStarted >> onProcessStopped [
	self transitionTo: CcStopped.
	self signalProcessStopped
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
	self waitProcessStopped
]
