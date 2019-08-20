Class {
	#name : #MmRemoteReference,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'objectId'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #accessing }
MmRemoteReference >> objectId [
	^ objectId
]

{ #category : #accessing }
MmRemoteReference >> objectId: anObject [
	objectId := anObject
]

{ #category : #printing }
MmRemoteReference >> printOn: aStream [
	aStream 
		<< 'ID: '
		<< self objectId
]

{ #category : #marshalling }
MmRemoteReference >> unmarshalWith: marshaller [
	^marshaller unmarshalRemoteReference: self
]
