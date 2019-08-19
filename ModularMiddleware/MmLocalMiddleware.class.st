Class {
	#name : #MmLocalMiddleware,
	#superclass : #MmMiddleware,
	#category : #'ModularMiddleware-Tests'
}

{ #category : #communicating }
MmLocalMiddleware >> outboundChannelClass [
	^MmLocalOutboundChannel 
]

{ #category : #communicating }
MmLocalMiddleware >> outboundChannelTo: remoteReference [
	| inboundChannel |
	inboundChannel := MmLocalInboundChannel middleware: self.
	^(super outboundChannelTo: remoteReference)
		targetChannel: inboundChannel;
		yourself.
	
]
