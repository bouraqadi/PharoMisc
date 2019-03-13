Class {
	#name : #EzMorphicExample,
	#superclass : #ComposablePresenter,
	#instVars : [
		'morph'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #specs }
EzMorphicExample class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		add: #morph;
		yourself
]

{ #category : #initialization }
EzMorphicExample >> initializeWidgets [
	| canvas |
	canvas := TSCanvas new.
	canvas addShape: (TSBox new
		extent: 100@100;
		yourself).
	canvas addShape: (TSBox new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	morph := canvas morph
		extent: 500@500;
		 asSpecAdapter
]

{ #category : #accessing }
EzMorphicExample >> morph [
	^morph
]
