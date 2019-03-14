Class {
	#name : #EzShape,
	#superclass : #Object,
	#instVars : [
		'roassalShape',
		'presenter'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzShape class >> roassalShape: aRSShapedObject presenter: aSpecPresenter [
	^self new
		roassalShape: aRSShapedObject;
		presenter: aSpecPresenter;
		yourself
]

{ #category : #'reflective operations' }
EzShape >> doesNotUnderstand: aMessage [
	| result |
	result := aMessage sendTo: self roassalShape.
	self updateDisplay.
	^result
]

{ #category : #accessing }
EzShape >> presenter [
	^ presenter
]

{ #category : #accessing }
EzShape >> presenter: anObject [
	presenter := anObject
]

{ #category : #accessing }
EzShape >> roassalShape [
	^ roassalShape
]

{ #category : #accessing }
EzShape >> roassalShape: anObject [
	roassalShape := anObject
]

{ #category : #'reflective operations' }
EzShape >> updateDisplay [
	self presenter ifNil: [ ^self ].
	self presenter updateDisplay
]
