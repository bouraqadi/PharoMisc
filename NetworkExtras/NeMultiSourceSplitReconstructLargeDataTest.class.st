Class {
	#name : #NeMultiSourceSplitReconstructLargeDataTest,
	#superclass : #TestCase,
	#traits : 'NeTLargeDataProviderForTest',
	#classTraits : 'NeTLargeDataProviderForTest classTrait',
	#instVars : [
		'reconstructor',
		'splitter1',
		'splitter2'
	],
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeMultiSourceSplitReconstructLargeDataTest >> setUp [
	super setUp.
	reconstructor := NeMultiSourceDataReconstructor new.
	splitter1 := NeDataSplitter new.
	splitter1 id: #testSplitter1.
	splitter2 := NeDataSplitter new.
	splitter2 id: #testSplitter2.

]

{ #category : #testing }
NeMultiSourceSplitReconstructLargeDataTest >> testReconstructingLargeDataFromChunksReceivedUnsorted [
	| reconstructedDataDict originalData1 originalData2 remainingChunks aChunk |
	reconstructedDataDict := Dictionary new.
	reconstructor withReconstructedDataDo: [: sourceId : data | reconstructedDataDict at: sourceId put:  data].
	originalData1 := self get10KBytesOfSourceFile asByteArray.
	splitter1 dataBytes: originalData1.
	splitter1 maxChunkSize: 1000.
	originalData2 := (self get50KBytesOfSourceFile last: originalData1 size) asByteArray.
	splitter2 dataBytes: originalData2.
	splitter2 maxChunkSize: 1000.
	remainingChunks := splitter1 chunks asSet, splitter2 chunks asSet.
	[remainingChunks isEmpty] whileFalse: [ 
		aChunk := remainingChunks atRandom.
		remainingChunks remove: aChunk.
		reconstructor addChunk: aChunk ].
	self assert: (reconstructedDataDict at: splitter1 id) equals: originalData1.
	self assert: (reconstructedDataDict at: splitter2 id) equals: originalData2.
]
