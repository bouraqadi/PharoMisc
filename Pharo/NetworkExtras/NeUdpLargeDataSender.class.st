"
I split data in chunks that I send over a UDP socket. 

Each chunk is a serialized version of  an instance of NeChunk. It includes then also data to materialize it.

Public API and Key Messages
- send: aByteArray
-id: aUUID 
Sets the unique ID that identifies me. It is sent along with the data
-maxChunkSize: anInteger 
Sets the size of each chunk. It should be greater  than the size required to serialize a chunk, which is coupled to the size of the ID. Usually its less than 400 bytes.

    Instance Variables
	socket:		<NeUdpSocket>
	splitter:		<NeDataSplitter>


"
Class {
	#name : #NeUdpLargeDataSender,
	#superclass : #Object,
	#instVars : [
		'splitter',
		'socket'
	],
	#category : #'NetworkExtras-UDP-LargeData'
}

{ #category : #'instance creation' }
NeUdpLargeDataSender class >> broadcastIp: ipStringOrByteArray port: portNumber [
	^ self socket: (NeBroadcastSocket ip: ipStringOrByteArray port: portNumber)
]

{ #category : #'instance creation' }
NeUdpLargeDataSender class >> broadcastPort: portNumber [
	^ self socket: (NeBroadcastSocket port: portNumber)
]

{ #category : #'instance creation' }
NeUdpLargeDataSender class >> multicastSocketGroup: groupIp port: port [
	| socket |
	socket := NeMulticastSocket group: groupIp port: port.
	^ self socket: socket
]

{ #category : #'instance creation' }
NeUdpLargeDataSender class >> socket: udpSocket [
	^self new
		socket: udpSocket;
		yourself
]

{ #category : #'instance creation' }
NeUdpLargeDataSender class >> target: ipStringOrByteArray port: portNumber [
	^ self socket: (NeUnicastUdpSocket target: ipStringOrByteArray port: portNumber)
]

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> defaultMaxChunkSize [
	^1500
]

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> destroySocket [
	self socket closeAndDestroy
]

{ #category : #accessing }
NeUdpLargeDataSender >> id [
	^splitter id
]

{ #category : #accessing }
NeUdpLargeDataSender >> id: anId [
	splitter id: anId
]

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> initialize [
	super initialize.
	splitter := NeDataSplitter new.
	self maxChunkSize: self defaultMaxChunkSize.
]

{ #category : #accessing }
NeUdpLargeDataSender >> maxChunkSize: anInteger [
	splitter maxChunkSize: anInteger
]

{ #category : #sending }
NeUdpLargeDataSender >> send: data [
	splitter dataBytes: data.
	splitter chunks
		do: [ :aChunk | socket send: aChunk asByteArray ]
]

{ #category : #accessing }
NeUdpLargeDataSender >> socket [
	^ socket
]

{ #category : #accessing }
NeUdpLargeDataSender >> socket: anObject [
	socket := anObject
]
