Class {
	#name : #CcStopping,
	#superclass : #CcTransientServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcStopping >> doEnterAction [
	self process terminate.
	self transitionTo: CcStopped
]

{ #category : #activity }
CcStopping >> start [
	self wait.
	self state start
]

{ #category : #activity }
CcStopping >> stop [
	^self
]
