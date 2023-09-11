"
I replace objects by placeholders and vice-versa to ensure using the right objects on each middleware and avoid duplications of proxies or building proxies on local objects.

    Instance Variables
	dispatcher:		<SmDispatcher> Used to export objects passed as parameters.
	protocol:		<SmProtocol> Used to initialize new proxies
	proxiesDict:		<Dictionary> Maps remoteReferences  to proxies to avoid duplicating proxies. So == is still valid even for remote objects.
	server:		<SmServer> Used to retrieve Ip and port of the server when building remote references to local objects passed as parameters of remote messages.

"
Class {
	#name : #SmMarshaller,
	#superclass : #Object,
	#instVars : [
		'dispatcher',
		'server',
		'proxiesDict',
		'protocol'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #accessing }
SmMarshaller >> dispatcher [
	^ dispatcher
]

{ #category : #'initialize-release' }
SmMarshaller >> dispatcher: anObject [
	dispatcher := anObject
]

{ #category : #exporting }
SmMarshaller >> export: anObject [ 
	^self dispatcher export: anObject.
]

{ #category : #'initialize-release' }
SmMarshaller >> initialize [
	super initialize.
	proxiesDict := Dictionary new.
]

{ #category : #accessing }
SmMarshaller >> ip [
	^self server ip.
]

{ #category : #unmarshalling }
SmMarshaller >> isRemoteReferenceToLocalObject: aSmRemoteReference [ 
	aSmRemoteReference ip = self ip ifFalse: [ ^false ].
	aSmRemoteReference port = self port ifFalse: [ ^false ].
	^true
]

{ #category : #marshalling }
SmMarshaller >> marshall: anObject [
	^anObject doMarshallingWith: self.
]

{ #category : #marshalling }
SmMarshaller >> marshallAll: objects [
	^objects collect: [ : each | self marshall: each ].
]

{ #category : #marshalling }
SmMarshaller >> marshallBasicObject: anObject [
	^anObject.
]

{ #category : #marshalling }
SmMarshaller >> marshallPlainObject: anObject [
	| id |
	id := self export: anObject.
	^ SmRemoteReference ip: self ip port: self port identifier: id
]

{ #category : #marshalling }
SmMarshaller >> marshallProxyIp: proxyIp port: proxyPort identifier: proxyIdentifier [ 
	^self remoteReferenceClass ip: proxyIp port: proxyPort identifier: proxyIdentifier.
]

{ #category : #marshalling }
SmMarshaller >> marshallRemoteMessage: aRemoteMessage [
	| marshalledArguments |
	marshalledArguments := self marshallAll: aRemoteMessage arguments.
	aRemoteMessage arguments: marshalledArguments.
	^aRemoteMessage.
]

{ #category : #proxies }
SmMarshaller >> newProxyFromRemoteReference: aReference [
	^self newProxyIp: aReference ip port: aReference port identifier: aReference identifier.
]

{ #category : #proxies }
SmMarshaller >> newProxyIp: aString port: aNumber identifier: id [
	^self proxyClass ip: aString port: aNumber identifier: id protocol: self protocol.
]

{ #category : #accessing }
SmMarshaller >> port [
	^self server port.
]

{ #category : #accessing }
SmMarshaller >> protocol [
	^protocol
]

{ #category : #'initialize-release' }
SmMarshaller >> protocol: anObject [
	protocol := anObject
]

{ #category : #proxies }
SmMarshaller >> proxyClass [
	^SmProxy
]

{ #category : #proxies }
SmMarshaller >> proxyFromRemoteReference: aRemoteReference [
	^proxiesDict 
		at: aRemoteReference 
		ifAbsentPut: [self newProxyFromRemoteReference: aRemoteReference]
]

{ #category : #proxies }
SmMarshaller >> proxyIp: aString port: aNumber identifier: id [
	^self proxyFromRemoteReference: (self remoteReferenceClass ip: aString port: aNumber identifier: id)
]

{ #category : #marshalling }
SmMarshaller >> remoteReferenceClass [
	^SmRemoteReference
]

{ #category : #accessing }
SmMarshaller >> server [
	^ server
]

{ #category : #'initialize-release' }
SmMarshaller >> server: anObject [
	server := anObject
]

{ #category : #unmarshalling }
SmMarshaller >> unmarshall: anObject [
	^anObject doUnmarshallingWith: self.
]

{ #category : #unmarshalling }
SmMarshaller >> unmarshallAll: objects [
	^objects collect: [ : each | self unmarshall: each ].
]

{ #category : #unmarshalling }
SmMarshaller >> unmarshallBasicObject: anObject [
	^anObject.
]

{ #category : #unmarshalling }
SmMarshaller >> unmarshallRemoteMessage: aRemoteMessage [
	| unmarshalledArgs |
	unmarshalledArgs := self unmarshallAll: aRemoteMessage arguments.
	aRemoteMessage arguments: unmarshalledArgs.
	^aRemoteMessage.
]

{ #category : #unmarshalling }
SmMarshaller >> unmarshallRemoteRefenrence: aRemoteReference [
	(self isRemoteReferenceToLocalObject: aRemoteReference) ifTrue: [
		^dispatcher objectAt: aRemoteReference identifier].
	^self proxyFromRemoteReference: aRemoteReference.
]
