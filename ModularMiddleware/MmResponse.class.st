Class {
	#name : #MmResponse,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #accessing }
MmResponse >> id [
	^ id
]

{ #category : #accessing }
MmResponse >> id: anObject [
	id := anObject
]

{ #category : #acting }
MmResponse >> trigger: aPromise [
	self subclassResponsibility
]
