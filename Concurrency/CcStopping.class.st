Class {
	#name : #CcStopping,
	#superclass : #CcTransientServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcStopping >> doEnterAction [
	self runner stop
]

{ #category : #state }
CcStopping >> onProcessTermination [
	self transitionTo: CcStopped
]

{ #category : #activity }
CcStopping >> start [
	self wait.
	self state start
]

{ #category : #printing }
CcStopping >> stateString [
	^'stopping'
]

{ #category : #activity }
CcStopping >> stop [
	^self
]
