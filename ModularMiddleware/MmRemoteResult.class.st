Class {
	#name : #MmRemoteResult,
	#superclass : #Object,
	#instVars : [
		'id',
		'actualValue'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmRemoteResult class >> id: id value: anObject [
	^self new
		id: id;
		actualValue: anObject;
		yourself
]

{ #category : #accessing }
MmRemoteResult >> actualValue [
	^ actualValue
]

{ #category : #accessing }
MmRemoteResult >> actualValue: anObject [
	actualValue := anObject
]

{ #category : #accessing }
MmRemoteResult >> id [
	^ id
]

{ #category : #accessing }
MmRemoteResult >> id: anObject [
	id := anObject
]
