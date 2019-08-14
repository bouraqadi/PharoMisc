Class {
	#name : #MmLocalMiddleware,
	#superclass : #MmMiddleware,
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #communicating }
MmLocalMiddleware >> address [
	^nil
]

{ #category : #communicating }
MmLocalMiddleware >> newOutboundChannelTo: anAddress [
	| inboundChannel outboundChannel |
	inboundChannel := MmLocalInboundChannel new.
	inboundChannel exportedObjectsDict: exportedObjectsDict.
	outboundChannel := MmLocalOutboundChannel new.
	inboundChannel targetChannel: outboundChannel.
	outboundChannel targetChannel: inboundChannel.
	^outboundChannel
	
]
