Class {
	#name : #CcStopped,
	#superclass : #CcServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcStopped >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^blockForStopped value
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

{ #category : #accessing }
CcStopped >> priority: anInteger [ 
	^self
]

{ #category : #activity }
CcStopped >> start [
	self transitionTo: CcStarting
	
]

{ #category : #activity }
CcStopped >> stop [
	^self
]
