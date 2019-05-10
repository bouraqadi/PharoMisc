Class {
	#name : #LoSingleElementReplaceEvent,
	#superclass : #LoSingleElementChangeEvent,
	#instVars : [
		'addedElement',
		'key'
	],
	#category : #'LightweightObserver-Collections'
}

{ #category : #'instance creation' }
LoSingleElementReplaceEvent class >> at: key replaced: oldObject by: newObject [
	^self new
		key: key;
		removedElement: oldObject;
		addedElement: newObject;
		yourself
]

{ #category : #accessing }
LoSingleElementReplaceEvent >> addedElement [
	^ addedElement
]

{ #category : #accessing }
LoSingleElementReplaceEvent >> addedElement: anObject [
	addedElement := anObject
]

{ #category : #accessing }
LoSingleElementReplaceEvent >> key [
	^ key
]

{ #category : #accessing }
LoSingleElementReplaceEvent >> key: anObject [
	key := anObject
]

{ #category : #accessing }
LoSingleElementReplaceEvent >> removedElement [
	^ self element
]

{ #category : #accessing }
LoSingleElementReplaceEvent >> removedElement: anObject [
	^ self element: anObject
]
