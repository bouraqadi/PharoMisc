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
	^message 
		arguments: marshalledArgs;
		receiver: marshalledReceiver; 
		yourself.
]

{ #category : #marshalling }
MmMarshaller >> marshalNormalResponse: response [ 
	| marshalledResult |
	marshalledResult := self marshal: response result.
	^response
		result: marshalledResult;
		yourself
]

{ #category : #marshalling }
MmMarshaller >> marshalObject: anObject [ 
	anObject isPassByCopy ifTrue: [ ^anObject ].
	^self remoteReferenceFor: anObject
]

{ #category : #marshalling }
MmMarshaller >> marshalRemoteReference: aRemoteReference [
	^aRemoteReference
]

{ #category : #marshalling }
MmMarshaller >> marshallExceptionResponse: aMmExceptionResponse [ 
	| marshalledException |
	marshalledException := MmRemoteException on: aMmExceptionResponse exception.
	^aMmExceptionResponse
		exception: marshalledException;
		yourself
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

{ #category : #marshalling }
MmMarshaller >> unmarshal: anObject [ 
	^anObject unmarshalWith: self
]

{ #category : #marshalling }
MmMarshaller >> unmarshalMessage: message [ 
	|unmarshalledArgs unmarshalledReceiver |
	unmarshalledReceiver := self unmarshal: message receiver.
	unmarshalledArgs := message arguments collect: [ : each | self unmarshal: each ].
	^MmRemoteMessage 
		selector: message selector
		arguments: unmarshalledArgs
		receiver: unmarshalledReceiver 
		resultId: message resultId.
]

{ #category : #marshalling }
MmMarshaller >> unmarshalNormalResponse: response [ 
	| unmarshalledResult |
	unmarshalledResult := self unmarshal: response result.
	^response
		result: unmarshalledResult;
		yourself
]

{ #category : #marshalling }
MmMarshaller >> unmarshalObject: anObject [ 
	^anObject
]

{ #category : #marshalling }
MmMarshaller >> unmarshalRemoteReference: aRemoteReference [
	^self objectAt: aRemoteReference
]
