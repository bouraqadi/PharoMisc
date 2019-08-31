Class {
	#name : #CcStopping,
	#superclass : #CcTransientServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcStopping >> doEnterAction [
	self runner stop.
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
