Class {
	#name : #CcStarting,
	#superclass : #CcTransientThreadState,
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcStarting >> doEnterAction [
		self process: self newProcess.
		self process priority: self priority.
		self process name: self name.
		self registerForFinalization.
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
