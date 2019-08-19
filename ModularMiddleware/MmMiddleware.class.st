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

{ #category : #exporting }
MmMiddleware >> export: anObject id: id [ 
	| reference |
	reference := self remoteReferenceWithId: id.
	exportedObjectsDict at: reference put: anObject
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

{ #category : #initialization }
MmMiddleware >> marshallerClass [
	^MmMarshaller
]

{ #category : #exporting }
MmMiddleware >> objectAt: aRemoteReference [
	^self exportedObjectsDict at: aRemoteReference
]

{ #category : #communicating }
MmMiddleware >> outboundChannelClass [
	self subclassResponsibility
]

{ #category : #communicating }
MmMiddleware >> outboundChannelTo: remoteReference [
	^self outboundChannelClass new
				middleware: self
				yourself
]

{ #category : #proxies }
MmMiddleware >> proxyTo: remoteReference [
	| channel |
	channel := self outboundChannelTo: remoteReference.
	^ self proxyVia: channel to: remoteReference
]

{ #category : #proxies }
MmMiddleware >> proxyVia: channel to: remoteReference [
	^ MmProxy channel: channel remoteReference: remoteReference
]

{ #category : #proxies }
MmMiddleware >> proxyWithId: id [
	| reference |
	reference := self remoteReferenceWithId: id.
	^self proxyTo: reference
]

{ #category : #exporting }
MmMiddleware >> remoteReferenceClass [
	^MmRemoteReference
]

{ #category : #exporting }
MmMiddleware >> remoteReferenceWithId: id [
	^self remoteReferenceClass new
		id: id;
		yourself
]
