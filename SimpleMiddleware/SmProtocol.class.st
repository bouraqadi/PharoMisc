"
I take care of converting an object into bytes that are sent over the network and converts bytes received to an object. 

    Instance Variables
	marshaller:		<SmMarshaller> replaces objects by others before serialization or after materialization

"
Class {
	#name : #SmProtocol,
	#superclass : #Object,
	#instVars : [
		'marshaller'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #writing }
SmProtocol >> marshall: anObject [
	^self marshaller marshall: anObject
]

{ #category : #accessing }
SmProtocol >> marshaller [
	^ marshaller
]

{ #category : #'initialize-release' }
SmProtocol >> marshaller: aSmMarshaller [ 
	marshaller := aSmMarshaller
]

{ #category : #reading }
SmProtocol >> materializeObjectFrom: socketStream [
	| bytes bytesSize |
	bytesSize := socketStream nextLineCrLf asInteger.
	bytes := (socketStream next: bytesSize) asByteArray.
	^ FLMaterializer materializeFromByteArray: bytes
]

{ #category : #reading }
SmProtocol >> readObjectFrom: socketStream [
	| rawObject |
	rawObject := self materializeObjectFrom: socketStream.
	^ self unmarshall: rawObject
]

{ #category : #writing }
SmProtocol >> serializeObject: replacement into: socketStream [
	| bytes |
	bytes := FLSerializer serializeToByteArray: replacement.
	socketStream sendCommand: bytes size asString.
	socketStream nextPutAllFlush: bytes
]

{ #category : #reading }
SmProtocol >> unmarshall: anObject [ 
	^self marshaller unmarshall: anObject
]

{ #category : #writing }
SmProtocol >> writeObject: anObject into: socketStream [
	| replacement |
	replacement := self marshall: anObject.
	self serializeObject: replacement into: socketStream
]
