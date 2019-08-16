Class {
	#name : #MmExceptionRemoteResponse,
	#superclass : #MmRemoteResponse,
	#instVars : [
		'exception'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmExceptionRemoteResponse class >> id: id exception: exception [
	^self new
		id: id;
		exception: exception;
		yourself
]

{ #category : #accessing }
MmExceptionRemoteResponse >> exception [
	^ exception
]

{ #category : #accessing }
MmExceptionRemoteResponse >> exception: anObject [
	exception := anObject
]

{ #category : #acting }
MmExceptionRemoteResponse >> trigger: aPromise [
	aPromise rejectWith: self exception
]
