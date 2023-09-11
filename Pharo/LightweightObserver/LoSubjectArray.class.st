Class {
	#name : #LoSubjectArray,
	#superclass : #Array,
	#type : #variable,
	#traits : 'LoTSubjectCollection + LoTMapAccessSubjectCollection',
	#classTraits : 'LoTSubjectCollection classTrait + LoTMapAccessSubjectCollection classTrait',
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Collections'
}

{ #category : #accessing }
LoSubjectArray >> dispatcher [
	^ dispatcher
]

{ #category : #accessing }
LoSubjectArray >> dispatcher: anObject [
	dispatcher := anObject
]
