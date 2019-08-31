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

{ #category : #accessing }
CcStarting >> name [
	^self service name
]

{ #category : #accessing }
CcStarting >> priority [
	^self service priority
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
