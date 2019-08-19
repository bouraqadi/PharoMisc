Class {
	#name : #MmMarshaller,
	#superclass : #Object,
	#instVars : [
		'middleware'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #marshalling }
MmMarshaller >> marshal: anObject [ 
	^anObject marshalWith: self
]

{ #category : #marshalling }
MmMarshaller >> marshalMessage: message [ 
	|marshalledArgs marshalledReceiver |
	marshalledReceiver := self marshal: message receiver.
	marshalledArgs := message arguments collect: [ : each | self marshal: each ].
	^MmMessage 
		selector: message selector
		arguments: marshalledArgs
		receiver: marshalledReceiver 
		resultId: message resultId.
]

{ #category : #marshalling }
MmMarshaller >> marshalObject: anObject [ 
	^self remoteReferenceFor: anObject
]

{ #category : #marshalling }
MmMarshaller >> marshalRemoteReference: aRemoteReference [
	^aRemoteReference
]

{ #category : #marshalling }
MmMarshaller >> marshalString: aString [
	^aString
]

{ #category : #accessing }
MmMarshaller >> middleware [
	^ middleware
]

{ #category : #accessing }
MmMarshaller >> middleware: anObject [
	middleware := anObject
]

{ #category : #accessing }
MmMarshaller >> objectAt: aRemoteReference [
	^self middleware objectAt: aRemoteReference
]

{ #category : #accessing }
MmMarshaller >> remoteReferenceFor: anObject [ 
	^self middleware remoteReferenceFor: anObject
]

{ #category : #unmarshalling }
MmMarshaller >> unmarshal: anObject [ 
	^anObject unmarshalWith: self
]

{ #category : #unmarshalling }
MmMarshaller >> unmarshalMessage: message [ 
	|unmarshalledArgs unmarshalledReceiver |
	unmarshalledReceiver := self unmarshal: message receiver.
	unmarshalledArgs := message arguments collect: [ : each | self unmarshal: each ].
	^MmMessage 
		selector: message selector
		arguments: unmarshalledArgs
		receiver: unmarshalledReceiver 
		resultId: message resultId.
]

{ #category : #unmarshalling }
MmMarshaller >> unmarshalObject: anObject [ 
	^anObject
]

{ #category : #marshalling }
MmMarshaller >> unmarshalRemoteReference: aRemoteReference [
	^self objectAt: aRemoteReference
]
