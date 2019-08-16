Class {
	#name : #MmRemoteResponse,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #accessing }
MmRemoteResponse >> id [
	^ id
]

{ #category : #accessing }
MmRemoteResponse >> id: anObject [
	id := anObject
]

{ #category : #acting }
MmRemoteResponse >> trigger: aPromise [
	self subclassResponsibility
]
