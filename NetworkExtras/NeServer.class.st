Class {
	#name : #NeServer,
	#superclass : #Object,
	#instVars : [
		'thread',
		'serverName',
		'socket'
	],
	#category : #'NetworkExtras-Kernel'
}

{ #category : #'initialize-release' }
NeServer >> defaultServerName [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
NeServer >> destroySocket [
	self socket closeAndDestroy
]

{ #category : #'initialize-release' }
NeServer >> initialize [
	super initialize.
	thread := CcThread repeat: [ self servingStep ] ensure: [self destroySocket].
	self serverName: self defaultServerName.
]

{ #category : #activity }
NeServer >> isStarted [
	^ thread isStarted
]

{ #category : #activity }
NeServer >> isStopped [
	^ thread isStopped
]

{ #category : #activity }
NeServer >> newSocket [
	self subclassResponsibility
]

{ #category : #printing }
NeServer >> printOn: aStream [
	self printThreadNameOn: aStream
]

{ #category : #activity }
NeServer >> printThreadNameOn: stream [
	stream
		nextPutAll: self serverName;
		nextPut: $(.
	self socket 
		ifNil: [ stream nextPutAll: 'No Socket' ]
		ifNotNil: [self socket printSocketInfoOn: stream].
	stream nextPut: $)
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
NeServer >> servingStep [
	self subclassResponsibility
]

{ #category : #accessing }
NeServer >> socket [
	^socket
]

{ #category : #activity }
NeServer >> start [
	self isStarted
		ifTrue: [ ^ self ].
	socket := self newSocket.
	thread name: self threadName.
	thread start
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
