Class {
	#name : #NeServer,
	#superclass : #Object,
	#instVars : [
		'thread',
		'serverName'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'initialize-release' }
NeServer >> defaultServerName [
	self subclassResponsibility
]

{ #category : #activity }
NeServer >> isStarted [
	^ thread isStarted
]

{ #category : #activity }
NeServer >> isStopped [
	^ thread isStopped
]

{ #category : #printing }
NeServer >> printThreadNameOn: stream [
	stream nextPutAll: self serverName
]

{ #category : #accessing }
NeServer >> priority [
	^thread priority
]

{ #category : #accessing }
NeServer >> priority: aPriority [
	thread priority: aPriority
]

{ #category : #accessing }
NeServer >> serverName [
	^serverName
]

{ #category : #accessing }
NeServer >> serverName: aString [
	^serverName := aString
]

{ #category : #activity }
NeServer >> stop [
	thread stop
]

{ #category : #printing }
NeServer >> threadName [
	^String streamContents: [: stream |
		self printThreadNameOn: stream]
]
