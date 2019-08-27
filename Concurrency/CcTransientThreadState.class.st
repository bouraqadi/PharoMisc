Class {
	#name : #CcTransientThreadState,
	#superclass : #CcThreadState,
	#instVars : [
		'lock'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcTransientThreadState >> doExitAction [
	lock signalAll

]

{ #category : #activity }
CcTransientThreadState >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	lock wait.
	self currentState ifStarted: blockForStarted ifStopped: blockForStopped 
	
]

{ #category : #initialization }
CcTransientThreadState >> initialize [
	super initialize.
	lock := Monitor new
]

{ #category : #activity }
CcTransientThreadState >> isStarted [
	^false
]

{ #category : #activity }
CcTransientThreadState >> isStopped [
	^false
]
