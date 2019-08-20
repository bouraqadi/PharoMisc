Class {
	#name : #MmMiddleware,
	#superclass : #Object,
	#instVars : [
		'outboundChannelsDict',
		'exportedObjectsDict',
		'marshaller',
		'proxiesDict'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #exporting }
MmMiddleware >> export: anObject [
	^self export: anObject id: self newExportId
]

{ #category : #exporting }
MmMiddleware >> export: anObject id: id [ 
	| reference |
	reference := self newRemoteReferenceWithId: id.
	exportedObjectsDict at: reference put: anObject.
	^reference
]

{ #category : #exporting }
MmMiddleware >> exportedObjectsDict [
	^exportedObjectsDict
]

{ #category : #initialization }
MmMiddleware >> initialize [
	super initialize.
	exportedObjectsDict := Dictionary new.
	proxiesDict := Dictionary new.
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
MmMiddleware >> newExportId [
	^UUID new asString
]

{ #category : #proxies }
MmMiddleware >> newProxyTo: remoteReference [
	| channel |
	channel := self outboundChannelTo: remoteReference.
	^ self newProxyVia: channel to: remoteReference
]

{ #category : #proxies }
MmMiddleware >> newProxyVia: channel to: remoteReference [
	^ MmProxy channel: channel remoteReference: remoteReference
]

{ #category : #exporting }
MmMiddleware >> newRemoteReferenceWithId: id [
	^self remoteReferenceClass new
		objectId: id;
		yourself
]

{ #category : #exporting }
MmMiddleware >> objectAt: aRemoteReference [
	^self exportedObjectsDict at: aRemoteReference ifAbsent: [ self proxyAt: aRemoteReference ]
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

{ #category : #'as yet unclassified' }
MmMiddleware >> proxyAt: remoteReference [ 
	^proxiesDict at: remoteReference ifAbsentPut: [ self newProxyTo: remoteReference]
]

{ #category : #proxies }
MmMiddleware >> proxyAtId: id [
	| reference |
	reference := self newRemoteReferenceWithId: id.
	^self newProxyTo: reference
]

{ #category : #exporting }
MmMiddleware >> remoteReferenceClass [
	^MmRemoteReference
]

{ #category : #exporting }
MmMiddleware >> remoteReferenceFor: anObject [
	^self exportedObjectsDict keyAtValue: anObject ifAbsent: [ self export: anObject ]
]
