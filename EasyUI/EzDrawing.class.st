Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzDrawing >> board [
	^ board
]

{ #category : #accessing }
EzDrawing >> board: anObject [
	board := anObject
]

{ #category : #accessing }
EzDrawing >> canvas [
	^self board canvas
]

{ #category : #drawing }
EzDrawing >> draw [
	self drawOn: self canvas
]

{ #category : #drawing }
EzDrawing >> drawOn: aCanvas [
	self subclassResponsibility
]

{ #category : #displaying }
EzDrawing >> hide [
	self board remove: self
]

{ #category : #displaying }
EzDrawing >> show [
	self board add: self
]
