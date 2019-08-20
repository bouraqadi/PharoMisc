Class {
	#name : #MmLocalMiddleware,
	#superclass : #MmMiddleware,
	#classVars : [
		'Registry'
	],
	#category : #'ModularMiddleware-Tests'
}

{ #category : #accessing }
MmLocalMiddleware class >> registry [
	^ Registry ifNil: [Registry := WeakValueDictionary new ]
]

{ #category : #exporting }
MmLocalMiddleware >> export: anObject id: id [
	| reference |
	reference := super export: anObject id: id.
	self registry at: reference put: self.
	^reference
]

{ #category : #communicating }
MmLocalMiddleware >> newInboundChannel [
	^MmLocalInboundChannel middleware: self.
]

{ #category : #communicating }
MmLocalMiddleware >> outboundChannelClass [
	^MmLocalOutboundChannel 
]

{ #category : #communicating }
MmLocalMiddleware >> outboundChannelTo: remoteReference [
	| otherMiddleware inboundChannel |
	otherMiddleware := self registry at: remoteReference.
	inboundChannel := otherMiddleware newInboundChannel.
	^(super outboundChannelTo: remoteReference)
		targetChannel: inboundChannel;
		yourself.
	
]

{ #category : #accessing }
MmLocalMiddleware >> registry [
	^self class registry
]
