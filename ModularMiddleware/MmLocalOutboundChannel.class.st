Class {
	#name : #MmLocalOutboundChannel,
	#superclass : #MmOutboundChannel,
	#instVars : [
		'targetChannel'
	],
	#category : #'ModularMiddleware-Kernel'
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
MmLocalOutboundChannel >> targetChannel: anObject [
	targetChannel := anObject
]
