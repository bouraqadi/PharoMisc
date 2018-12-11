"
A chunk is a fragment of information. It allows to reconstruct some large data (ByteArray) split in parts.

There exist different kinds of chunks depending of the kind of information they embed. All they have in common sourceId to identify the entity that split data (NeDataSplitter) and when the split has been performed. This information allows reconstructing data coming from different sources (different spliters) at different times, even if chunks are delivered  mixed.

Every data is split in one or more instances of NeContentChunk as well as one single instance of NeChunkCollectionInfo. 

Each NeContentChunk includes a unique part (ByteArray) of the split data. 
The unique  NeChunkCollectionInfo includes info about the NeContentChunks.

  Instance Variables
	timestamp	<DateAndTime> When the data was split
	sourceId		<UUID> Allows identifying the source

"
Class {
	#name : #NeChunk,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'sourceId'
	],
	#category : #'NetworkExtras-UDP-LargeData'
}

{ #category : #reconstructing }
NeChunk >> addTo: reconstructor [
	self subclassResponsibility
]

{ #category : #converting }
NeChunk >> asByteArray [
	^FLSerializer serializeToByteArray: self
]

{ #category : #accessing }
NeChunk >> sourceId [
	^ sourceId
]

{ #category : #accessing }
NeChunk >> sourceId: anObject [
	sourceId := anObject
]

{ #category : #accessing }
NeChunk >> timestamp [
	^ timestamp
]

{ #category : #accessing }
NeChunk >> timestamp: anObject [
	timestamp := anObject
]
