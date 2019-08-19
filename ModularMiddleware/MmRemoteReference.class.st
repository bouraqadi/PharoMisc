Class {
	#name : #MmRemoteReference,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #accessing }
MmRemoteReference >> id [
	^ id
]

{ #category : #accessing }
MmRemoteReference >> id: anObject [
	id := anObject
]

{ #category : #marshalling }
MmRemoteReference >> unmarshalWith: marshaller [
	^marshaller unmarshalRemoteReference: self
]
