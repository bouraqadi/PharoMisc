Class {
	#name : #EzPacManSprite,
	#superclass : #EzCompositeDrawing,
	#instVars : [
		'leftward',
		'rightward'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #initialization }
EzPacManSprite >> initialize [
	super initialize.
	leftward := EzPacManFaceLeftward new.
	rightward := EzPacManFaceRightward new.
	self lookRight.
	self addAll: {leftward. rightward}.
]

{ #category : #actions }
EzPacManSprite >> lookDown [
	rightward hide.
	leftward show.
	leftward angle: -90.
	
]

{ #category : #actions }
EzPacManSprite >> lookLeft [
	rightward hide.
	leftward show.
	leftward angle: 0.
	
]

{ #category : #actions }
EzPacManSprite >> lookRight [
	leftward hide.
	rightward show.
	rightward angle: 0.
	
]

{ #category : #actions }
EzPacManSprite >> lookUp [
	leftward hide.
	rightward show.
	rightward angle: -90.
	
]
