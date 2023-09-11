Class {
	#name : #LoSingleElementChangeEvent,
	#superclass : #LoEvent,
	#instVars : [
		'element',
		'index'
	],
	#category : #'LightweightObserver-Collections'
}

{ #category : #'instance creation' }
LoSingleElementChangeEvent class >> element: anObject [
	^self new
		element: anObject;
		yourself
]

{ #category : #'instance creation' }
LoSingleElementChangeEvent class >> element: anObject at: index [
	^(self element: anObject)
		index: index;
		yourself
]

{ #category : #accessing }
LoSingleElementChangeEvent >> element [
	^ element
]

{ #category : #accessing }
LoSingleElementChangeEvent >> element: anObject [
	element := anObject
]

{ #category : #accessing }
LoSingleElementChangeEvent >> index [
	^ index
]

{ #category : #accessing }
LoSingleElementChangeEvent >> index: anObject [
	index := anObject
]
