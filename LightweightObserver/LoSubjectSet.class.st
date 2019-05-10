Class {
	#name : #LoSubjectSet,
	#superclass : #Set,
	#traits : 'LoTElasticSubjectCollection',
	#classTraits : 'LoTElasticSubjectCollection classTrait',
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Collections'
}

{ #category : #adding }
LoSubjectSet >> add: anObject [
	| initialSize |
	initialSize := self size.
	super add: anObject.
	self size > initialSize ifTrue: [ self dispatchEventAdded: anObject].	
	^anObject
]

{ #category : #accessing }
LoSubjectSet >> dispatcher [
	^dispatcher
]

{ #category : #accessing }
LoSubjectSet >> dispatcher: anObject [
	^dispatcher := anObject
]

{ #category : #removing }
LoSubjectSet >> remove: anObject ifAbsent: aBlock [
	super remove: anObject ifAbsent: [^aBlock value].
	self dispatchEventRemoved: anObject.
	^ anObject
]
