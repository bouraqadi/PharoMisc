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

{ #category : #accessing }
MmMarshaller >> middleware [
	^ middleware
]

{ #category : #accessing }
MmMarshaller >> middleware: anObject [
	middleware := anObject
]

{ #category : #marshalling }
MmMarshaller >> proxyFor: anObject [ 
	^anObject
]

{ #category : #unmarshalling }
MmMarshaller >> unmarshal: anObject [ 
	^anObject unmarshalWith: self
]

{ #category : #unmarshalling }
MmMarshaller >> unmarshalObject: anObject [ 
	^anObject
]
