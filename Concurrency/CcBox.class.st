Class {
	#name : #CcBox,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #'instance creation' }
CcBox class >> value: anObject [
	^self new
		value: anObject;
		yourself
]

{ #category : #'reflective operations' }
CcBox >> doesNotUnderstand: aMessage [
	^aMessage sendTo: value
]

{ #category : #'reflective operations' }
CcBox >> value: anObject [
	^value := anObject
]
