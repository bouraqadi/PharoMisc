Class {
	#name : #MmProxy,
	#superclass : #Object,
	#instVars : [
		'id',
		'channel'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmProxy class >> id: aSymbol channel: aChannel [
	^ self new
		id: aSymbol channel: aChannel;
		yourself
]

{ #category : #'reflective operations' }
MmProxy >> doesNotUnderstand: aMessage [
	^channel send: aMessage receiverId: id
]

{ #category : #'initialize-release' }
MmProxy >> id: aSymbol channel: aChannel [
	id := aSymbol. 
	channel := aChannel.
]
