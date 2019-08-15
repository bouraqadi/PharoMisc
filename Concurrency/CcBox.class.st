"
This is an object wrapper. It is used for forwardBecome in future objects when the actual value is a basic objects such as an integer. This is a workaround to the bug that forbides some basic objects to be used as arguments of becomeForward: 
"
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

{ #category : #comparing }
CcBox >> = anObject [
	^self value = anObject
]

{ #category : #'reflective operations' }
CcBox >> doesNotUnderstand: aMessage [
	^aMessage sendTo: value
]

{ #category : #comparing }
CcBox >> hash [ 
	^self value hash
]

{ #category : #'reflective operations' }
CcBox >> value [
	^value
]

{ #category : #'reflective operations' }
CcBox >> value: anObject [
	^value := anObject
]
