Class {
	#name : #MmRemoteReference,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
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
