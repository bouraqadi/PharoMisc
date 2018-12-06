"
I reconstruct data (byteArray) out of chunks coming from  many sources.

Reception order is not important. I am able to reconstruct data even if I receive chunks from different sources at random.

Public API and Key Messages
-addChunk: aChunk
Handles a new data chunk

-withReconstructedDataDo: aTwoArgsBlock
Sets the data handling block valued  each time  a data is reconstructed. It must  have two arguments one for the sourceId and the second for the reconstructed data

  Instance Variables
dataReconstructorsDict	<Dictionary of  NeSingleSourceDataReconstructor>  on reconstructor for each source
dataHandlingBlock <BlockClosure>  Valued each time  a data is reconstructed. It must  have two arguments one for the sourceId and the second for the reconstructed data

"
Class {
	#name : #NeMultiSourceDataReconstructor,
	#superclass : #Object,
	#instVars : [
		'dataReconstructorsDict',
		'dataHandlingBlock'
	],
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

{ #category : #'data handling' }
NeMultiSourceDataReconstructor >> addChunk: newChunk [
	| reconstructor |
	reconstructor := dataReconstructorsDict at: newChunk sourceId ifAbsentPut: [ self newDataReconstructorId: newChunk sourceId ].
	reconstructor addChunk: newChunk
]

{ #category : #initialization }
NeMultiSourceDataReconstructor >> initialize [
	super initialize.
	dataReconstructorsDict := Dictionary new
]

{ #category : #'data handling' }
NeMultiSourceDataReconstructor >> newDataReconstructorId: sourceId [
	| reconstructor |
	reconstructor := NeSingleSourceDataReconstructor new.
	reconstructor withReconstructedDataDo: [: data | dataHandlingBlock value: sourceId value: data  ].
	^reconstructor
]

{ #category : #'data handling' }
NeMultiSourceDataReconstructor >> withReconstructedDataDo: aTwoArgBlockClosure [ 
	dataHandlingBlock := aTwoArgBlockClosure
]
