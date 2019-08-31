Class {
	#name : #CcStarting,
	#superclass : #CcTransientServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcStarting >> doEnterAction [
	self runner start.
	self transitionTo: CcStarted.

]

{ #category : #activity }
CcStarting >> start [
	^self
]

{ #category : #activity }
CcStarting >> stop [
	self wait.
	self state stop
]
