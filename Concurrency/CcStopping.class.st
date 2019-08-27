Class {
	#name : #CcStopping,
	#superclass : #CcTransientThreadState,
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcStopping >> doEnterAction [
	self process terminate.
	self transitionTo: CcStopped
]

{ #category : #activity }
CcStopping >> isStarted [
	^false
]

{ #category : #activity }
CcStopping >> isStopped [
	^false
]

{ #category : #activity }
CcStopping >> start [
	lock wait
]

{ #category : #activity }
CcStopping >> stop [
	^self
]
