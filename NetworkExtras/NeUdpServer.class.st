"
I am a UDP server. I handle incoming UDP data repeatedly in a dedicated thread.

Creation methods allow creating both unicast UDP servers and multicast ones.
Examples
	NeUdpServer multicastGroup: '236.1.2.13' port: 22333.
	NeUdpServer unicastPort: 14444.

I am an abstract class.
Servers created as in the above examples are actually instances of my subclasses.

    Instance Variables
	actionBlock:		<BlockClosure> block to handle incoming data
	socket:		<NeUdpSocket> socket listening on the UDP port
	thread:		<ActiveObject>  handles the repeated action. 
			
Since we realy on ActiveObjects, the thread is garbage collected if it's not referenced any more.		
Upon termination, it closes the socket ensuring releasing related resources.


"
Class {
	#name : #NeUdpServer,
	#superclass : #Object,
	#instVars : [
		'thread',
		'socket',
		'actionBlock',
		'receivedDataHandlingPriority',
		'serverName'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUdpServer class >> multicastGroup: ipOrName port: portNumber [
	^NeMulticastServer group: ipOrName port: portNumber
]

{ #category : #'instance creation' }
NeUdpServer class >> unicastPort: portNumber [
	^NeUnicastUdpServer port: portNumber

]

{ #category : #'initialize-release' }
NeUdpServer >> defaultReceivedDataHandlingPriority [
	^Processor userSchedulingPriority
]

{ #category : #'initialize-release' }
NeUdpServer >> defaultServerName [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
NeUdpServer >> destroySocket [
	self socket closeAndDestroy
]

{ #category : #activity }
NeUdpServer >> handleReceivedBytes: bytes [
	'UDP server received bytes: ' bytes asString logCr
]

{ #category : #'initialize-release' }
NeUdpServer >> initialize [
	super initialize.
	thread := ActiveObject repeat: [ self receiveData ] ensure: [self destroySocket].
	actionBlock := [ : bytes | self handleReceivedBytes: bytes].
	self receivedDataHandlingPriority: self defaultReceivedDataHandlingPriority.
	self serverName: self defaultServerName.
]

{ #category : #activity }
NeUdpServer >> isStarted [
	^ thread isStarted
]

{ #category : #activity }
NeUdpServer >> isStopped [
	^ thread isStopped
]

{ #category : #activity }
NeUdpServer >> newSocket [
	self subclassResponsibility
]

{ #category : #accessing }
NeUdpServer >> onReceptionDo: aBlock [
	actionBlock := aBlock
]

{ #category : #accessing }
NeUdpServer >> priority [
	^thread priority
]

{ #category : #accessing }
NeUdpServer >> priority: aPriority [
	thread priority: aPriority
]

{ #category : #activity }
NeUdpServer >> receiveData [
	| receivedData |
	receivedData := [self socket receive] on: ConnectionTimedOut do: [: ex| ^self].
	receivedData ifEmpty: [ ^ self ].
	[actionBlock cull: receivedData] forkAt: self receivedDataHandlingPriority
]

{ #category : #accessing }
NeUdpServer >> receivedDataHandlingPriority [
	^receivedDataHandlingPriority
]

{ #category : #accessing }
NeUdpServer >> receivedDataHandlingPriority: anInteger [
	^receivedDataHandlingPriority := anInteger
]

{ #category : #accessing }
NeUdpServer >> serverName [
	^serverName
]

{ #category : #accessing }
NeUdpServer >> serverName: aString [
	^serverName := aString
]

{ #category : #accessing }
NeUdpServer >> socket [
	^socket
]

{ #category : #activity }
NeUdpServer >> start [
	self isStarted
		ifTrue: [ ^ self ].
	socket := self newSocket.
	thread name: self threadName.
	thread start
]

{ #category : #activity }
NeUdpServer >> stop [
	thread stop
]

{ #category : #activity }
NeUdpServer >> threadName [
	^String streamContents: [: stream |
		stream 
			nextPutAll: self serverName;
			nextPut: $(.
		self socket printSocketInfoOn: stream.
		stream nextPut: $)]
]
