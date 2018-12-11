"
I am a UDP server that reconstructs data sent in chunks (instances of NeChunk). 
I can hundle data coming from multiple sources (NeUdpLargeDataSender) since I rely on NeMultiSourceDataReconstructor.

Public API and Key Messages
-withReceivedDataDo: aTwoArgsBlock
Sets the data handling block valued  each time  a data is reconstructed. It must  have two arguments one for the sourceId and the second for the reconstructed data

    Instance Variables
	dataReconstructor:		<NeMultiSourceDataReconstructor>

"
Class {
	#name : #NeUdpLargeDataReceiver,
	#superclass : #Object,
	#instVars : [
		'dataReconstructor',
		'server'
	],
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

{ #category : #'instance creation' }
NeUdpLargeDataReceiver class >> multicastGroup: ipOrName port: portNumber [
	^self server: (NeUdpServer multicastGroup: ipOrName port: portNumber)
]

{ #category : #'instance creation' }
NeUdpLargeDataReceiver class >> server: newServer [
	^self new
		server: newServer;
		yourself
]

{ #category : #'instance creation' }
NeUdpLargeDataReceiver class >> unicastPort: portNumber [
	^self server: (NeUdpServer unicastPort: portNumber)
]

{ #category : #activity }
NeUdpLargeDataReceiver >> handleReceivedBytes: receivedBytes [
	| chunk |
	chunk := FLMaterializer materializeFromByteArray: receivedBytes.
	dataReconstructor addChunk: chunk
]

{ #category : #initialization }
NeUdpLargeDataReceiver >> initialize [
	super initialize.
	dataReconstructor := NeMultiSourceDataReconstructor new.
	self withReceivedDataDo: [ : sourceId : reconstructedData | 
		Transcript 
			cr; 
			show: sourceId; 
			show: ' sent: ';
			show: reconstructedData asString]
]

{ #category : #acting }
NeUdpLargeDataReceiver >> priority: anInteger [ 
	self server priority: anInteger
]

{ #category : #accessing }
NeUdpLargeDataReceiver >> server [
	^ server
]

{ #category : #accessing }
NeUdpLargeDataReceiver >> server: udpServer [
	server := udpServer.
	server serverName: self serverName.
	server onReceptionDo: [: byteArray | self handleReceivedBytes: byteArray ]
]

{ #category : #accessing }
NeUdpLargeDataReceiver >> serverName [
	^'UDP large data receiver'
]

{ #category : #acting }
NeUdpLargeDataReceiver >> start [
	self server start.
]

{ #category : #acting }
NeUdpLargeDataReceiver >> stop [
	self server stop.
]

{ #category : #initialization }
NeUdpLargeDataReceiver >> withReceivedDataDo: aTwoArgBlockClosure [ 
	dataReconstructor withReconstructedDataDo: aTwoArgBlockClosure 
]
