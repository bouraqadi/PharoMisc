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

{ #category : #protocol }
MmChannel >> marshal: anObject [ 
	^self marshaller marshal: anObject 


]

{ #category : #accessing }
MmChannel >> marshaller [
	^self middleware marshaller
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
	^self middleware objectAt: id
]

{ #category : #protocol }
MmChannel >> protocol [
	^MmProtocol new
]

{ #category : #sending }
MmChannel >> receiveBytes: bytes [
	| receivedObject unmarshalledObject  |
	receivedObject := self materializeFrom: bytes.
	unmarshalledObject := self unmarshal: receivedObject.
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
	marshalledObject := self marshal: anObject.
	bytes := self serialize: marshalledObject.
	self sendBytes: bytes
]

{ #category : #protocol }
MmChannel >> serialize: remoteMessage [ 
	^self protocol serializeToByteArray: remoteMessage
]

{ #category : #protocol }
MmChannel >> unmarshal: anObject [ 
	^self marshaller unmarshal: anObject.
]
