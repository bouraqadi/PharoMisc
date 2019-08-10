"
Handles communications sockets of a given middleware.

    Instance Variables
	connectionSocket:		<Socket> TCP socket waiting for connections
	dispatcher:		<SmDispatcher> Dispatches received messages to actual receivers
	ip:		<String> Hostname or Ip of the host machine
	port:		<Number> Port for incomming connections
	protocol:		<SmProtocol> Converts objects to bytes and bytes to objects
	thread:		<Process> Process for handling incoming connections

"
Class {
	#name : #SmServer,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'connectionSocket',
		'thread',
		'protocol',
		'dispatcher'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #communications }
SmServer >> communicateVia: interactionSocket [
	| socketStream  message localResponse   |
	interactionSocket ifNil: [ ^self ].
	socketStream := SocketStream on: interactionSocket.
	[
		message := self readObjectFrom: socketStream.
		localResponse := self dispatch: message.
		self writeObject: localResponse into: socketStream.
	] ensure: [
		socketStream close].
	

]

{ #category : #initialize }
SmServer >> defaultIp [
	^'127.0.0.1'
]

{ #category : #initialize }
SmServer >> defaultPort [
	^54321
]

{ #category : #communications }
SmServer >> dispatch: aRemoteMessage [
	^self dispatcher dispatch: aRemoteMessage
]

{ #category : #accessing }
SmServer >> dispatcher [
	^ dispatcher
]

{ #category : #initialize }
SmServer >> dispatcher: anObject [
	dispatcher := anObject
]

{ #category : #initialize }
SmServer >> initialize [
	super initialize.
	self ip: self defaultIp.
	self port: self defaultPort.

]

{ #category : #accessing }
SmServer >> ip [
	^ ip
]

{ #category : #initialize }
SmServer >> ip: aString [
	ip := aString
]

{ #category : #testing }
SmServer >> isStarted [
	^thread notNil.
]

{ #category : #accessing }
SmServer >> port [
	^ port
]

{ #category : #initialize }
SmServer >> port: anInteger [
	port := anInteger.
]

{ #category : #activity }
SmServer >> priority [
	^Processor userInterruptPriority.
]

{ #category : #accessing }
SmServer >> protocol [
	^protocol 
]

{ #category : #initialize }
SmServer >> protocol: aProtocol [
	protocol := aProtocol.
]

{ #category : #communications }
SmServer >> readObjectFrom: socketStream [
	^self protocol readObjectFrom: socketStream.
]

{ #category : #activity }
SmServer >> start [
	self isStarted ifTrue: [ ^self error: 'Already started!' ].
	connectionSocket := Socket newTCP. 
	thread := [self waitForConnections] forkAt: self priority.

]

{ #category : #activity }
SmServer >> stop [
	self isStarted ifFalse: [^self].
	thread terminate.
	thread := nil.
]

{ #category : #communications }
SmServer >> waitForConnections [
	| interactionSocket |
	[
		connectionSocket listenOn: self port backlogSize: 10. 
		[
			interactionSocket := connectionSocket waitForAcceptFor: 120.
			[self communicateVia: interactionSocket] forkAt: self priority
		] repeat.
	] ensure: [connectionSocket closeAndDestroy.]. 

]

{ #category : #communications }
SmServer >> writeObject: anObject into: socketStream [
	^self protocol writeObject: anObject into: socketStream
]
