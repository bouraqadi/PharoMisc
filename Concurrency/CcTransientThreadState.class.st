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
	self signalAll

]

{ #category : #activity }
CcTransientThreadState >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	self wait.
	self state ifStarted: blockForStarted ifStopped: blockForStopped 
	
]

{ #category : #initialization }
CcTransientThreadState >> initialize [
	super initialize.
	lock := Monitor new
]

{ #category : #activity }
CcTransientThreadState >> isStarted [
	self wait.
	^self state isStopped
]

{ #category : #activity }
CcTransientThreadState >> isStopped [
	self wait.
	^self state isStopped
]

{ #category : #accessing }
CcTransientThreadState >> processName: aString [
	self wait.
	self state processName: aString
]

{ #category : #initialization }
CcTransientThreadState >> signalAll [
	lock critical: [ lock signalAll ]
]

{ #category : #initialization }
CcTransientThreadState >> wait [
	lock critical: [ lock wait ]
]
