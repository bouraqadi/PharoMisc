Class {
	#name : #MmLocalMiddleware,
	#superclass : #MmMiddleware,
	#category : #'ModularMiddleware-Tests'
}

{ #category : #communicating }
MmLocalMiddleware >> address [
	^MmLocalInboundChannel middleware: self
]

{ #category : #communicating }
MmLocalMiddleware >> outboundChannelClass [
	^MmLocalOutboundChannel 
]
