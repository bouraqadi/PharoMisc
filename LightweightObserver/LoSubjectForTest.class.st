Class {
	#name : #LoSubjectForTest,
	#superclass : #LoSubject,
	#instVars : [
		'a',
		'b',
		'set',
		'array',
		'dict',
		'sortedCol',
		'collection'
	],
	#category : #'LightweightObserver-Test'
}

{ #category : #accessing }
LoSubjectForTest >> a [
	^ a
]

{ #category : #'private-generated' }
LoSubjectForTest >> a: anObject [
	a := anObject 
]

{ #category : #'private-generated' }
LoSubjectForTest >> a: objA b: objB [
	a := objA.
	b := objB
]

{ #category : #accessing }
LoSubjectForTest >> b [
	^ b
]

{ #category : #'private-generated' }
LoSubjectForTest >> b: anObject [
	b := anObject
]

{ #category : #accessing }
LoSubjectForTest >> collection [
	^ collection
]

{ #category : #'private-generated' }
LoSubjectForTest >> collection: anObject [
	collection := anObject
]
