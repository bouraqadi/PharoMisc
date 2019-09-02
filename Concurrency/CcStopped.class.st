Class {
	#name : #CcStopped,
	#superclass : #CcServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcStopped >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^blockForStopped value
]

{ #category : #accessing }
CcStopped >> name: aString [ 
	^self
]

{ #category : #activity }
CcStopped >> onProcessStarted [
	self transitionTo: CcStarted.
	self signalProcessStarted

]

{ #category : #accessing }
CcStopped >> priority: anInteger [ 
	^self
]

{ #category : #activity }
CcStopped >> start [
	self runner start.
	self waitProcessStarted.

]

{ #category : #printing }
CcStopped >> stateString [
	^'stopped'
]

{ #category : #activity }
CcStopped >> stop [
	^self
]
