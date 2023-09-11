"
I represent a unique part of some data split at some specific point in time by a specific spliter. 

    Instance Variables
	contents:		<ByteArray> data fragment
	index:		<Integer> position relative to other content chunks belonging to the same collection

"
Class {
	#name : #NeContentChunk,
	#superclass : #NeChunk,
	#instVars : [
		'index',
		'contents'
	],
	#category : #'NetworkExtras-UDP-LargeData'
}

{ #category : #reconstructing }
NeContentChunk >> addTo: reconstructor [
	reconstructor addContentChunk: self
]

{ #category : #accessing }
NeContentChunk >> contents [
	^ contents
]

{ #category : #accessing }
NeContentChunk >> contents: aCollection [
	^ contents := aCollection asByteArray
]

{ #category : #'initialize-release' }
NeContentChunk >> contentsFrom: aReadStream maxFullSize: maxFullSize [
	| maxContentsSize sizeWithoutContents |
	self resetContents.
	sizeWithoutContents := self asByteArray size.
	maxContentsSize := maxFullSize - sizeWithoutContents.
	self contents: (aReadStream next: maxContentsSize) 
]

{ #category : #'initialize-release' }
NeContentChunk >> defaultContents [
	^#[]
]

{ #category : #accessing }
NeContentChunk >> index [
	^ index
]

{ #category : #accessing }
NeContentChunk >> index: anInteger [ 
	index := anInteger
]

{ #category : #'initialize-release' }
NeContentChunk >> resetContents [
	self contents: self defaultContents
]
