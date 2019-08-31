Class {
	#name : #CcStarted,
	#superclass : #CcServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #testing }
CcStarted >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^blockForStarted value
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
CcStarted >> priority: anInteger [ 
	self process priority: anInteger.
]

{ #category : #activity }
CcStarted >> start [
	^self
]

{ #category : #activity }
CcStarted >> stop [
	self transitionTo: CcStopping
]
