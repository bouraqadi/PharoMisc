Class {
	#name : #LoSubjectSortedCollection,
	#superclass : #SortedCollection,
	#traits : 'LoTSequeceableSubjectCollection',
	#classTraits : 'LoTSequeceableSubjectCollection classTrait',
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Collections'
}

{ #category : #adding }
LoSubjectSortedCollection >> add: addedObject [
	super add: addedObject.
	self dispatchEventAdded: addedObject at: (self indexOf: addedObject).
	^addedObject
]

{ #category : #accessing }
LoSubjectSortedCollection >> dispatcher [
	^dispatcher 
]

{ #category : #accessing }
LoSubjectSortedCollection >> dispatcher: anObject [
	^dispatcher := anObject
]
