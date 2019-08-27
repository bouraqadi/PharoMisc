Class {
	#name : #CcStopped,
	#superclass : #CcThreadState,
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

{ #category : #activity }
CcStopped >> start [
	self transitionTo: CcStarting
	
]

{ #category : #activity }
CcStopped >> stop [
	^self
]
