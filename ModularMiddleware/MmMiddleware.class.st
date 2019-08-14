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

{ #category : #accessing }
MmMiddleware >> exportedObjectsDict [
	^exportedObjectsDict
]

{ #category : #initialization }
MmMiddleware >> initialize [
	super initialize.
	exportedObjectsDict := Dictionary new
]

{ #category : #communicating }
MmMiddleware >> outboundChannelClass [
	self subclassResponsibility
]

{ #category : #communicating }
MmMiddleware >> outboundChannelTo: anAddress [
	^self outboundChannelClass middleware: self address: anAddress 
		
]

{ #category : #communicating }
MmMiddleware >> proxyId: aSymbol address: anAddress [
	| channel |
	channel := self outboundChannelTo: anAddress.
	^ self proxyId: aSymbol channel: channel
]

{ #category : #communicating }
MmMiddleware >> proxyId: aSymbol channel: channel [
	^ MmProxy id: aSymbol channel: channel
]
