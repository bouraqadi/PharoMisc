Class {
	#name : #MmMiddleware,
	#superclass : #Object,
	#instVars : [
		'outboundChannelsDict',
		'exportedObjectsDict'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #communicating }
MmMiddleware >> address [
	self subclassResponsibility
]

{ #category : #communicating }
MmMiddleware >> export: anObject as: id [ 
	exportedObjectsDict at: id put: anObject
]

{ #category : #initialization }
MmMiddleware >> initialize [
	super initialize.
	outboundChannelsDict := Dictionary new.
	exportedObjectsDict := Dictionary new
]

{ #category : #communicating }
MmMiddleware >> newOutboundChannelTo: anAddress [
	self subclassResponsibility
]

{ #category : #communicating }
MmMiddleware >> outboundChannelAt: anAddress [
	^outboundChannelsDict at: anAddress ifAbsentPut: [ self newOutboundChannelTo: anAddress]
]

{ #category : #communicating }
MmMiddleware >> proxyId: aSymbol address: anAddress [
	| channel |
	channel := self outboundChannelAt: anAddress.
	^ self proxyId: aSymbol channel: channel
]

{ #category : #communicating }
MmMiddleware >> proxyId: aSymbol channel: channel [
	^ MmProxy id: aSymbol channel: channel
]
