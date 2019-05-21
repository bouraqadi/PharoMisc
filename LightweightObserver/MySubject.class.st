Class {
	#name : #MySubject,
	#superclass : #LoSubject,
	#instVars : [
		'a',
		'b',
		'set',
		'dict',
		'collection'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #accessing }
MySubject >> a [
	^ a
]

{ #category : #accessing }
MySubject >> a: anObject [
	a := anObject
]

{ #category : #accessing }
MySubject >> a: newA b: newB [
	a := newA.
	b := newB.
]

{ #category : #accessing }
MySubject >> b [
	^ b
]

{ #category : #accessing }
MySubject >> b: anObject [
	b := anObject
]

{ #category : #accessing }
MySubject >> collection [
	^ collection
]

{ #category : #accessing }
MySubject >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
MySubject >> dict [
	^ dict
]

{ #category : #accessing }
MySubject >> dict: anObject [
	dict := anObject
]

{ #category : #accessing }
MySubject >> set [
	^ set
]

{ #category : #accessing }
MySubject >> set: anObject [
	set := anObject
]
