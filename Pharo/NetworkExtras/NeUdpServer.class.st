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
	#superclass : #NeServer,
	#instVars : [
		'receivedDataHandlingPriority',
		'receptionHandlingBlock'
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
NeUdpServer >> defaultReceptionHandlingBlock [
	^ [ :bytes | self traceCrBytes: bytes]
]

{ #category : #'initialize-release' }
NeUdpServer >> initialize [
	super initialize.
	receptionHandlingBlock := self defaultReceptionHandlingBlock.
	self
		receivedDataHandlingPriority: self defaultReceivedDataHandlingPriority
]

{ #category : #accessing }
NeUdpServer >> onReceptionDo: aBlock [
	receptionHandlingBlock := aBlock
]

{ #category : #accessing }
NeUdpServer >> receivedDataHandlingPriority [
	^receivedDataHandlingPriority
]

{ #category : #accessing }
NeUdpServer >> receivedDataHandlingPriority: anInteger [
	^receivedDataHandlingPriority := anInteger
]

{ #category : #activity }
NeUdpServer >> servingStep [
	| receivedData |
	receivedData := [self socket receive] on: ConnectionTimedOut do: [: ex| ^self].
	receivedData ifEmpty: [ ^ self ].
	[receptionHandlingBlock cull: receivedData] forkAt: self receivedDataHandlingPriority
]

{ #category : #activity }
NeUdpServer >> traceCrBytes: bytes [
	self traceCr: bytes asString
]
