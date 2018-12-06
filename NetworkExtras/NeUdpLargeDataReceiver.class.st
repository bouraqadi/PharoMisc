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
	#superclass : #NeUdpServer,
	#instVars : [
		'dataReconstructor'
	],
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

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

{ #category : #activity }
NeUdpLargeDataReceiver >> threadName [
	^'Large data receiver over UDP socket ', self socket asString
]

{ #category : #initialization }
NeUdpLargeDataReceiver >> withReceivedDataDo: aTwoArgBlockClosure [ 
	dataReconstructor withReconstructedDataDo: aTwoArgBlockClosure 
]
