"
I am a UDP server. I handle incoming UDP data repeatedly in a dedicated thread.

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
	#traits : 'NeTUdpSocketWrapper',
	#classTraits : 'NeTUdpSocketWrapper classTrait',
	#instVars : [
		'thread',
		'socket',
		'actionBlock',
		'receivedDataHandlingPriority'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUdpServer class >> receptionPort: portNumber [
	^self socket: (NeUnicastUdpSocket receptionPort: portNumber)

]

{ #category : #'instance creation' }
NeUdpServer class >> socket: udpSocket [
	^self new
		socket: udpSocket;
		yourself
]

{ #category : #'initialize-release' }
NeUdpServer >> defaultReceivedDataHandlingPriority [
	^Processor userSchedulingPriority
]

{ #category : #'initialize-release' }
NeUdpServer >> destroy [
	self stop.
	self destroySocket
]

{ #category : #activity }
NeUdpServer >> handleReceivedBytes: bytes [
	'UDP server received bytes: ' bytes asString logCr
]

{ #category : #'initialize-release' }
NeUdpServer >> initialize [
	super initialize.
	thread := ActiveObject repeat: [ self receiveData ] ensure: [self socket closeAndDestroy].
	actionBlock := [ : bytes | self handleReceivedBytes: bytes].
	self receivedDataHandlingPriority: self defaultReceivedDataHandlingPriority
]

{ #category : #activity }
NeUdpServer >> isStarted [
	^ thread isStarted
]

{ #category : #activity }
NeUdpServer >> isStopped [
	^ thread isStopped
]

{ #category : #accessing }
NeUdpServer >> onReceptionDo: aBlock [
	actionBlock := aBlock
]

{ #category : #accessing }
NeUdpServer >> port [
	^self socket receptionPort
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
NeUdpServer >> socket [
	^ socket
]

{ #category : #accessing }
NeUdpServer >> socket: anObject [
	socket := anObject
]

{ #category : #activity }
NeUdpServer >> start [
	self isStarted
		ifTrue: [ ^ self ].
	thread name: self threadName.
	thread start
]

{ #category : #activity }
NeUdpServer >> stop [
	thread stop
]

{ #category : #activity }
NeUdpServer >> threadName [
	^ 'UDP server on socket ' , self socket asString
]
