Class {
	#name : #MmMiddleware,
	#superclass : #Object,
	#instVars : [
		'outboundChannelsDict',
		'exportedObjectsDict',
		'marshaller'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #communicating }
MmMiddleware >> address [
	self subclassResponsibility
]

{ #category : #exporting }
MmMiddleware >> export: anObject as: id [ 
	exportedObjectsDict at: id put: anObject
]

{ #category : #exporting }
MmMiddleware >> exportedObjectsDict [
	^exportedObjectsDict
]

{ #category : #initialization }
MmMiddleware >> initialize [
	super initialize.
	exportedObjectsDict := Dictionary new.
	marshaller := self marshallerClass new.
	marshaller middleware: self
]

{ #category : #accessing }
MmMiddleware >> marshaller [
	^ marshaller
]

{ #category : #'initialize-release' }
MmMiddleware >> marshallerClass [
	^MmMarshaller
]

{ #category : #exporting }
MmMiddleware >> objectAt: id [
	^self exportedObjectsDict at: id
]

{ #category : #communicating }
MmMiddleware >> outboundChannelClass [
	self subclassResponsibility
]

{ #category : #communicating }
MmMiddleware >> outboundChannelTo: anAddress [
	^self outboundChannelClass middleware: self address: anAddress 
		
]

{ #category : #proxies }
MmMiddleware >> proxyId: aSymbol address: anAddress [
	| channel |
	channel := self outboundChannelTo: anAddress.
	^ self proxyId: aSymbol channel: channel
]

{ #category : #proxies }
MmMiddleware >> proxyId: aSymbol channel: channel [
	^ MmProxy id: aSymbol channel: channel
]
