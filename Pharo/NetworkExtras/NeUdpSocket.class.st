"
I am an UDP socket. 
I am an abstract class, use my subclasses
"
Class {
	#name : #NeUdpSocket,
	#superclass : #NeSocket,
	#instVars : [
		'receptionBuffer'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUdpSocket class >> newIfFail: aBlock [
	^self udpCreateIfFail: aBlock
]

{ #category : #initialization }
NeUdpSocket >> defaultBufferSize [
	^ 1500
]

{ #category : #receiving }
NeUdpSocket >> defaultTimeoutSeconds [
	^ 30
]

{ #category : #initialization }
NeUdpSocket >> initReceptionBuffer [
	self receptionBufferSize: self defaultBufferSize
]

{ #category : #receiving }
NeUdpSocket >> listenOn: portNumber [
	self setPort: portNumber.
]

{ #category : #printing }
NeUdpSocket >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' ('.
	self printSocketInfoOn: aStream.
	aStream nextPut: $)
]

{ #category : #printing }
NeUdpSocket >> printSocketInfoOn: aStream [
	self subclassResponsibility
	
]

{ #category : #receiving }
NeUdpSocket >> receive [
	^ self receiveTimeout: self defaultTimeoutSeconds
]

{ #category : #receiving }
NeUdpSocket >> receiveTimeout: seconds [
	| bytesReadCount |
	[self waitForConnectionFor: seconds.
	self waitForDataFor: seconds.
	bytesReadCount := self receiveDataInto: self receptionBuffer.
	^ self receptionBuffer copyFrom: 1 to: bytesReadCount] on: PrimitiveFailed do: [ ^#() ]
]

{ #category : #receiving }
NeUdpSocket >> receptionBuffer [
	receptionBuffer ifNil: [ self initReceptionBuffer ].
	^receptionBuffer
]

{ #category : #initialization }
NeUdpSocket >> receptionBufferSize: bytesCount [
	receptionBuffer := ByteArray new: bytesCount.

]

{ #category : #sending }
NeUdpSocket >> send: anObject [
	self sendData: anObject asByteArray toHost: self targetIp port: self targetPort
]

{ #category : #initialization }
NeUdpSocket >> setPort: portNumber [
	self receptionPort: portNumber.
	super setPort: portNumber.
]

{ #category : #printing }
NeUdpSocket >> socketInfo [
	^String streamContents: [ : stream |
		self printSocketInfoOn: stream ]
]

{ #category : #sending }
NeUdpSocket >> targetIp [
	self subclassResponsibility
]

{ #category : #sending }
NeUdpSocket >> targetPort [
	self subclassResponsibility
]

{ #category : #sending }
NeUdpSocket >> timeToLive [
	"Time To Live (TTL) is also known as the HOP limit. 
	See the write accessor comment for a longuer explaination"	
	^ (self getOption: self timeToLiveOptionId) last
]

{ #category : #sending }
NeUdpSocket >> timeToLive: anInteger [
	"Time To Live (TTL) is also known as the HOP limit.
Each router that receives the packet subtracts at least 1 from the count; if the count remains greater than 0, the router forwards the packet, otherwise it discards it and sends an Internet Control Message Protocol (ICMP) message back to the originating host, which may trigger a resend. 
By convention:
0 is restricted to the same host
1 is restricted to the same subnet
32 is restricted to the same site
64 is restricted to the same region
128 is restricted to the same continent
255 is unrestricted
"
	| resultArray |
	(anInteger between: 0 and: 255) 
		ifFalse: [self error: 'Time-To-Live out of range'].
	resultArray := self setOption: self timeToLiveOptionId value: anInteger.
	^resultArray last

]

{ #category : #sending }
NeUdpSocket >> timeToLiveOptionId [
	^'IP_TTL'
]

{ #category : #'reception ports tracking' }
NeUdpSocket >> usedPortsTracker [
	^NeUdpUsedPortsTracker
]
