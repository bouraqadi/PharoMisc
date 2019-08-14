Class {
	#name : #MmLocalInboundChannel,
	#superclass : #MmInboundChannel,
	#instVars : [
		'targetChannel'
	],
	#category : #'ModularMiddleware-Tests'
}

{ #category : #sending }
MmLocalInboundChannel >> sendBytes: bytes [ 
	targetChannel receiveBytes: bytes
]

{ #category : #accessing }
MmLocalInboundChannel >> targetChannel [
	^ targetChannel
]

{ #category : #accessing }
MmLocalInboundChannel >> targetChannel: anObject [
	targetChannel := anObject
]
