Class {
	#name : #NeSplitReconstructLargeDataTest,
	#superclass : #TestCase,
	#traits : 'NeTLargeDataProvider',
	#classTraits : 'NeTLargeDataProvider classTrait',
	#instVars : [
		'reconstructor',
		'splitter'
	],
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

{ #category : #testing }
NeSplitReconstructLargeDataTest >> setUp [
	super setUp.
	reconstructor := NeSingleSourceDataReconstructor new.
	splitter := NeDataSplitter new.
	splitter id: #testSplitter.

]

{ #category : #testing }
NeSplitReconstructLargeDataTest >> testReconstructingLargeDataFromChunksReceivedPresorted [
	| originalData reconstructedData |
	reconstructor withReconstructedDataDo: [ : data | reconstructedData := data ].
	originalData := self get10KBytesOfSourceFile asByteArray.
	splitter dataBytes: originalData.
	splitter maxChunkSize: 1000.
	splitter chunks do: [ : aChunk | reconstructor addChunk: aChunk ].
	self assert: reconstructedData equals: originalData.
]

{ #category : #testing }
NeSplitReconstructLargeDataTest >> testReconstructingLargeDataFromChunksReceivedUnsorted [
	| originalData reconstructedData remainingChunks aChunk |
	reconstructor withReconstructedDataDo: [ : data | reconstructedData := data ].
	originalData := self get10KBytesOfSourceFile asByteArray.
	splitter dataBytes: originalData.
	splitter maxChunkSize: 1000.
	remainingChunks := splitter chunks asSet.
	[remainingChunks isEmpty] whileFalse: [ 
		aChunk := remainingChunks atRandom.
		remainingChunks remove: aChunk.
		reconstructor addChunk: aChunk ].
	self assert: reconstructedData equals: originalData.
]

{ #category : #testing }
NeSplitReconstructLargeDataTest >> testReconstructorReceivesChunkFromNewData [
	| reconstructedData oldData oldChunks newData |
	reconstructor withReconstructedDataDo: [ :data | reconstructedData := data ].
	oldData := self get10KBytesOfSourceFile asByteArray.
	splitter maxChunkSize: 1000.
	splitter dataBytes: oldData.
	oldChunks := splitter chunks.
	(oldChunks first: 5) do: [ :aChunk | reconstructor addChunk: aChunk ].
	newData := self get5KBytesOfSourceFile asByteArray.
	splitter dataBytes: newData.
	splitter chunks do: [ :aChunk | reconstructor addChunk: aChunk ].
	self assert: reconstructedData equals: newData
]

{ #category : #testing }
NeSplitReconstructLargeDataTest >> testReconstructorReceivesChunkFromOldData [
	| reconstructedData oldData oldChunks newData newChunks |
	reconstructor withReconstructedDataDo: [ :data | reconstructedData := data ].
	oldData := self get10KBytesOfSourceFile asByteArray.
	splitter maxChunkSize: 1000.
	splitter dataBytes: oldData.
	oldChunks := splitter chunks.
	newData := self get5KBytesOfSourceFile asByteArray.
	splitter dataBytes: newData.
	newChunks := splitter chunks.
	reconstructor addChunk: newChunks first.
	reconstructor addChunk: oldChunks first.
	newChunks allButFirst do: [ :aChunk | reconstructor addChunk: aChunk ].
	self assert: reconstructedData equals: newData
]

{ #category : #testing }
NeSplitReconstructLargeDataTest >> testSplitingLargeDataIntoChunks [
	| timestamp chunks |
	splitter dataBytes: self get10KBytesOfSourceFile.
	splitter maxChunkSize: 11000.
	self assert: splitter chunks size equals: 2. "1 chunk for data + 1 for data info"
	self assert: splitter chunks last contentChunksCount equals: 1.
	splitter maxChunkSize: 10000.
	self assert: splitter chunks size equals: 3.	"Header data is included in the 10000 bytes"
	self assert: splitter chunks last contentChunksCount equals: 2.
	splitter maxChunkSize: 1000.
	chunks := splitter chunks.
	timestamp := chunks first timestamp.
	(chunks allButLast) withIndexDo: [: chunk : expectedIndex |
		self assert: chunk timestamp equals: timestamp.
		self assert: chunk sourceId equals: splitter id.
		self assert: chunk index equals: expectedIndex.
		self assert: chunk asByteArray size <= 1000].

]
