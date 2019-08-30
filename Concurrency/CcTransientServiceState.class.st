Class {
	#name : #CcTransientServiceState,
	#superclass : #CcServiceState,
	#instVars : [
		'lock'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #activity }
CcTransientServiceState >> doExitAction [
	self signalAll

]

{ #category : #activity }
CcTransientServiceState >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	self wait.
	self state ifStarted: blockForStarted ifStopped: blockForStopped 
	
]

{ #category : #initialization }
CcTransientServiceState >> initialize [
	super initialize.
	lock := Monitor new
]

{ #category : #activity }
CcTransientServiceState >> isStarted [
	self wait.
	^self state isStopped
]

{ #category : #activity }
CcTransientServiceState >> isStopped [
	self wait.
	^self state isStopped
]

{ #category : #accessing }
CcTransientServiceState >> processName: aString [
	self wait.
	self state processName: aString
]

{ #category : #initialization }
CcTransientServiceState >> signalAll [
	lock critical: [ lock signalAll ]
]

{ #category : #initialization }
CcTransientServiceState >> wait [
	lock critical: [
		self isCurrentState ifFalse: [ ^self ].
		lock wait]
]
