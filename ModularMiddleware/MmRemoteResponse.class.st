Class {
	#name : #MmRemoteResponse,
	#superclass : #Object,
	#instVars : [
		'id',
		'response'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmRemoteResponse class >> id: id response: response [
	^self new
		id: id;
		response: response;
		yourself
]

{ #category : #accessing }
MmRemoteResponse >> id [
	^ id
]

{ #category : #accessing }
MmRemoteResponse >> id: anObject [
	id := anObject
]

{ #category : #accessing }
MmRemoteResponse >> response [
	^ response
]

{ #category : #accessing }
MmRemoteResponse >> response: anObject [
	response := anObject
]
