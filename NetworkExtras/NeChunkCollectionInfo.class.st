"
I provide info about a collection of content chunks (NeContentChunk) that are made out of some data by some splitter (NeDataSplitter) at some specific point in time.

    Instance Variables
	contentChunksCount:		<Integer> Number of  content chunks

"
Class {
	#name : #NeChunkCollectionInfo,
	#superclass : #NeChunk,
	#instVars : [
		'contentChunksCount'
	],
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

{ #category : #reconstructing }
NeChunkCollectionInfo >> addTo: reconstructor [
	reconstructor addChunkCollectionInfo: self
]

{ #category : #accessing }
NeChunkCollectionInfo >> contentChunksCount [
	^ contentChunksCount
]

{ #category : #accessing }
NeChunkCollectionInfo >> contentChunksCount: anObject [
	contentChunksCount := anObject
]
