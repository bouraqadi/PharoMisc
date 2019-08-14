Class {
	#name : #MmChannel,
	#superclass : #Object,
	#instVars : [
		'middleware'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmChannel class >> middleware: aMiddleware [
	^self new
		middleware: aMiddleware;
		yourself
]

{ #category : #accessing }
MmChannel >> exportedObjectsDict [
	^self middleware exportedObjectsDict
]

{ #category : #protocol }
MmChannel >> marshall: anObject [ 
	^anObject 


]

{ #category : #protocol }
MmChannel >> materializeFrom: bytes [ 
	^self protocol materializeFromByteArray: bytes
]

{ #category : #accessing }
MmChannel >> middleware [
	^ middleware
]

{ #category : #accessing }
MmChannel >> middleware: anObject [
	middleware := anObject
]

{ #category : #accessing }
MmChannel >> objectAt: id [
	^self exportedObjectsDict at: id
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

{ #category : #protocol }
MmChannel >> unmarshall: anObject [ 
	^anObject
]
