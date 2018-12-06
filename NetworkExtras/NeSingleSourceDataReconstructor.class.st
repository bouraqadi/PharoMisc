"
I reconstruct data (byteArray) out of chunks coming from a single source.

Reception order is not important. I am able to reconstruct data even if I receive chunks at random.

If I receive a chunk that is older than chunks I am currently processing, I simply ignore it. The age is based on the chunk timestamp.

Once I have received all chunks of a given data, I reconstruct the data (ByteArray). Then I value a block (IV dataHandlingBlock) which takes as an argument the reconstructed data (ByteArray).

    Instance Variables
	chuncks:		<SortedCollection of NeContentChunk> stores chunks sored based on their indices (see method resetChunks)
	chunkCollectionInfo:		<NeChunkCollectionInfo>
	dataHandlingBlock:		<BlockClosure> Performed once data is reconstructed. Set using method withReconstructedDataDo:

"
Class {
	#name : #NeSingleSourceDataReconstructor,
	#superclass : #Object,
	#instVars : [
		'chuncks',
		'dataHandlingBlock',
		'chunkCollectionInfo'
	],
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

{ #category : #reconstructing }
NeSingleSourceDataReconstructor >> addChunk: aChunk [
	(self doesChunkBelongToOldData: aChunk)
		ifTrue: [ ^ self ].
	(self doesChunkBelongToNewData: aChunk)
		ifTrue: [ self resetChunks ].
	aChunk addTo: self.
	self areAllChunksReceived
		ifFalse: [ ^ self ].
	self reconstructData
]

{ #category : #reconstructing }
NeSingleSourceDataReconstructor >> addChunkCollectionInfo: anUeChunkCollectionInfo [ 
	chunkCollectionInfo := anUeChunkCollectionInfo.

]

{ #category : #reconstructing }
NeSingleSourceDataReconstructor >> addContentChunk: aChunk [
	chuncks add: aChunk.
]

{ #category : #reconstructing }
NeSingleSourceDataReconstructor >> areAllChunksReceived [
	chunkCollectionInfo ifNil: [ ^false ].
	^chuncks size = chunkCollectionInfo contentChunksCount 
]

{ #category : #testing }
NeSingleSourceDataReconstructor >> doesChunkBelongToNewData: aChunk [
	chunkCollectionInfo ifNotNil: [ ^chunkCollectionInfo timestamp < aChunk timestamp ].
	chuncks ifEmpty: [ ^false ].
	^chuncks first timestamp < aChunk timestamp
]

{ #category : #testing }
NeSingleSourceDataReconstructor >> doesChunkBelongToOldData: aChunk [
	chunkCollectionInfo ifNotNil: [ ^ chunkCollectionInfo timestamp > aChunk timestamp ].
	chuncks ifEmpty: [ ^ false ].
	^ chuncks first timestamp > aChunk timestamp
]

{ #category : #'initialize-release' }
NeSingleSourceDataReconstructor >> initialize [
	super initialize.
	self resetChunks.
]

{ #category : #reconstructing }
NeSingleSourceDataReconstructor >> reconstructData [
	| writeStream |
	writeStream := ByteArray new writeStream.
	chuncks do: [: aChunk|
		writeStream nextPutAll: aChunk contents].
	dataHandlingBlock cull: writeStream contents
]

{ #category : #'initialize-release' }
NeSingleSourceDataReconstructor >> resetChunks [
	chuncks := SortedCollection sortBlock: [: first : next | first index < next index].
]

{ #category : #'initialize-release' }
NeSingleSourceDataReconstructor >> withReconstructedDataDo: singleArgBlock [
	dataHandlingBlock := singleArgBlock
]
