Class {
	#name : #MmLocalOutboundChannel,
	#superclass : #MmOutboundChannel,
	#instVars : [
		'targetChannel'
	],
	#category : #'ModularMiddleware-Tests'
}

{ #category : #communicating }
MmLocalOutboundChannel >> sendBytes: bytes [ 
	targetChannel receiveBytes: bytes
]

{ #category : #accessing }
MmLocalOutboundChannel >> targetChannel [
	^ targetChannel
]

{ #category : #accessing }
MmLocalOutboundChannel >> targetChannel: inboundChannel [
	targetChannel := inboundChannel.
	inboundChannel targetChannel: self
]
