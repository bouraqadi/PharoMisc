Class {
	#name : #CcStarting,
	#superclass : #CcTransientServiceState,
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcStarting >> doEnterAction [
		self process: self newProcess.
		self process priority: self priority.
		self process name: self name.
		self process resume.
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
