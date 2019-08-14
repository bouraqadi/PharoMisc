Class {
	#name : #MmChannel,
	#superclass : #Object,
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #protocol }
MmChannel >> marshall: anObject [ 
	^anObject 


]

{ #category : #protocol }
MmChannel >> materializeFrom: bytes [ 
	^self protocol materializeFromByteArray: bytes
]

{ #category : #protocol }
MmChannel >> protocol [
	^MmProtocol new
]

{ #category : #sending }
MmChannel >> receiveBytes: bytes [
	| receivedObject unmarshalledObject  |
	receivedObject := self materializeFrom: bytes.
	unmarshalledObject := self unmarshall: receivedObject.
	self receiveObject: unmarshalledObject
]

{ #category : #sending }
MmChannel >> receiveObject: anObject [
	self subclassResponsibility
]

{ #category : #sending }
MmChannel >> sendBytes: aCollection [ 
	self subclassResponsibility
]

{ #category : #sending }
MmChannel >> sendObject: anObject [
	| marshalledObject bytes |
	marshalledObject := self marshall: anObject.
	bytes := self serialize: marshalledObject.
	self sendBytes: bytes
]

{ #category : #protocol }
MmChannel >> serialize: remoteMessage [ 
	^self protocol serializeToByteArray: remoteMessage
]

{ #category : #'as yet unclassified' }
MmChannel >> unmarshall: anObject [ 
	^anObject
]
