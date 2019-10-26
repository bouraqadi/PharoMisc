Class {
	#name : #NeServer,
	#superclass : #Object,
	#instVars : [
		'serverName',
		'socket',
		'service'
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
	service := CcService repeat: [ self servingStep ] ensure: [self destroySocket].
	self name: self defaultServerName.
]

{ #category : #activity }
NeServer >> isRunning [
	^ self isStarted
]

{ #category : #activity }
NeServer >> isStarted [
	^ service isStarted
]

{ #category : #activity }
NeServer >> isStopped [
	^ service isStopped
]

{ #category : #accessing }
NeServer >> name [
	^serverName
]

{ #category : #accessing }
NeServer >> name: aString [
	^serverName := aString
]

{ #category : #activity }
NeServer >> newSocket [
	self subclassResponsibility
]

{ #category : #printing }
NeServer >> printOn: aStream [
	self printServiceNameOn: aStream
]

{ #category : #activity }
NeServer >> printServiceNameOn: stream [
	stream
		nextPutAll: self name;
		nextPut: $(.
	self socket 
		ifNil: [ stream nextPutAll: 'No Socket' ]
		ifNotNil: [self socket printSocketInfoOn: stream].
	stream nextPut: $)
]

{ #category : #accessing }
NeServer >> priority [
	^service priority
]

{ #category : #accessing }
NeServer >> priority: aPriority [
	service priority: aPriority
]

{ #category : #printing }
NeServer >> serviceName [
	^String streamContents: [: stream |
		self printServiceNameOn: stream]
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
	service name: self serviceName.
	service start
]

{ #category : #activity }
NeServer >> stop [
	service stop
]
