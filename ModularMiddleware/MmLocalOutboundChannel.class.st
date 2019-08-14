Class {
	#name : #MmLocalOutboundChannel,
	#superclass : #MmOutboundChannel,
	#instVars : [
		'targetChannel'
	],
	#category : #'ModularMiddleware-Tests'
}

{ #category : #initialization }
MmLocalOutboundChannel >> address: aLocalInboundChannel [
	targetChannel := aLocalInboundChannel.
	aLocalInboundChannel targetChannel: self
]

{ #category : #communicating }
MmLocalOutboundChannel >> sendBytes: bytes [ 
	targetChannel receiveBytes: bytes
]
