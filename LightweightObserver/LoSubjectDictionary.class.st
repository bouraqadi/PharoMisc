Class {
	#name : #LoSubjectDictionary,
	#superclass : #Dictionary,
	#traits : 'LoTSubjectCollection + LoTMapAccessSubjectCollection',
	#classTraits : 'LoTSubjectCollection classTrait + LoTMapAccessSubjectCollection classTrait',
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Collections'
}

{ #category : #accessing }
LoSubjectDictionary >> dispatcher [
	^ dispatcher
]

{ #category : #accessing }
LoSubjectDictionary >> dispatcher: anObject [
	dispatcher := anObject
]
