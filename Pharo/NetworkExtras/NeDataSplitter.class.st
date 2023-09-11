"
I split a large data into a collection of chunks. The created chunks hold my ID(see Id inherited instance variable). I guarentee that the serialized version of every chunk (See NeChunk>>asByteArray) is a byte array which size is smaller than the maximum size defined by method maxChunkSize

    Instance Variables
	id:		<UUID> 	Unique identifier that used to link created chunks to me
	chunkSize:		<Integer> 
	dataBytes:		<ByeArray> Data being split into chuncks

"
Class {
	#name : #NeDataSplitter,
	#superclass : #Object,
	#instVars : [
		'id',
		'dataBytes',
		'maxChunkSize'
	],
	#category : #'NetworkExtras-UDP-LargeData'
}

{ #category : #splitting }
NeDataSplitter >> chunks [
	| chunks readStream timestamp chunkIndex newChunk |
	chunks := OrderedCollection new.
	timestamp := DateAndTime now.
	readStream := self dataBytes readStream.
	[ readStream atEnd ]
		whileFalse: [ chunkIndex := chunks size + 1.
			newChunk := self
				newChunk: chunkIndex
				from: readStream
				timestamp: timestamp.
			chunks addLast: newChunk ].
	chunks addLast: (self infoFor: chunks timestamp: timestamp).
	^ chunks
]

{ #category : #accessing }
NeDataSplitter >> dataBytes [
	^ dataBytes
]

{ #category : #accessing }
NeDataSplitter >> dataBytes: anObject [

	dataBytes := anObject asByteArray
]

{ #category : #initialization }
NeDataSplitter >> defaultMaxChunkSize [
	^1000
]

{ #category : #accessing }
NeDataSplitter >> id [
	^id
]

{ #category : #accessing }
NeDataSplitter >> id: aSymbol [
	id := aSymbol
]

{ #category : #splitting }
NeDataSplitter >> infoFor: chunks timestamp: timestamp [
	^ NeChunkCollectionInfo new
		contentChunksCount: chunks size;
		timestamp: timestamp;
		sourceId: self id;
		yourself
]

{ #category : #initialization }
NeDataSplitter >> initialize [
	super initialize.
	self maxChunkSize: self defaultMaxChunkSize.
]

{ #category : #accessing }
NeDataSplitter >> maxChunkSize [
	^ maxChunkSize
]

{ #category : #accessing }
NeDataSplitter >> maxChunkSize: anObject [
	maxChunkSize := anObject
]

{ #category : #splitting }
NeDataSplitter >> newChunk: chunkIndex from: readStream timestamp: timestamp [
	^ NeContentChunk new
		index: chunkIndex;
		timestamp: timestamp;
		sourceId: self id;
		contentsFrom: readStream maxFullSize: self maxChunkSize;
		yourself
]
