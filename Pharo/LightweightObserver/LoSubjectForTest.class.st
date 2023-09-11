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

{ #category : #accessing }
LoSubjectForTest >> a: anObject [
	a := anObject 
]

{ #category : #accessing }
LoSubjectForTest >> a: objA b: objB [
	a := objA.
	b := objB
]

{ #category : #accessing }
LoSubjectForTest >> b [
	^ b
]

{ #category : #accessing }
LoSubjectForTest >> b: anObject [
	b := anObject
]

{ #category : #accessing }
LoSubjectForTest >> collection [
	^ collection
]

{ #category : #accessing }
LoSubjectForTest >> collection: anObject [
	collection := anObject
]
