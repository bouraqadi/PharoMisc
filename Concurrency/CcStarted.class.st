Class {
	#name : #CcStarted,
	#superclass : #CcThreadState,
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
CcStarted >> processName: aString [
	self process name: aString
]

{ #category : #activity }
CcStarted >> start [
	^self
]

{ #category : #activity }
CcStarted >> stop [
	self transitionTo: CcStopping
]
