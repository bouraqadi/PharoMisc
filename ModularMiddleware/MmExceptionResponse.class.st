Class {
	#name : #MmExceptionResponse,
	#superclass : #MmResponse,
	#instVars : [
		'exception'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmExceptionResponse class >> id: id exception: exception [
	^self new
		id: id;
		exception: exception;
		yourself
]

{ #category : #accessing }
MmExceptionResponse >> exception [
	^ exception
]

{ #category : #accessing }
MmExceptionResponse >> exception: anObject [
	exception := anObject
]

{ #category : #'as yet unclassified' }
MmExceptionResponse >> marshallWith: marshaller [
	^self marshallExceptionRensponse: self
]

{ #category : #acting }
MmExceptionResponse >> trigger: aPromise [
	aPromise rejectWith: self exception
]
