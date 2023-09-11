Class {
	#name : #LoSubjectOrderedCollection,
	#superclass : #OrderedCollection,
	#traits : 'LoTSequeceableSubjectCollection + LoTMapAccessSubjectCollection',
	#classTraits : 'LoTSequeceableSubjectCollection classTrait + LoTMapAccessSubjectCollection classTrait',
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Collections'
}

{ #category : #adding }
LoSubjectOrderedCollection >> addFirst: anObject [
	super addFirst: anObject.
	self dispatchEventAdded: anObject at: 1.
	^ anObject
]

{ #category : #accessing }
LoSubjectOrderedCollection >> dispatcher [
	^ dispatcher
]

{ #category : #accessing }
LoSubjectOrderedCollection >> dispatcher: anObject [
	dispatcher := anObject
]
