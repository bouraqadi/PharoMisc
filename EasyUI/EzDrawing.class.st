Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawing class >> board: aDrawingBoard [
	^self new
		board: aDrawingBoard;
		yourself
]

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
EzDrawing >> moveToBack [
	self board moveToBack: self
]

{ #category : #displaying }
EzDrawing >> moveToFront [
	self board moveToFront: self
]

{ #category : #displaying }
EzDrawing >> show [
	self board add: self
]
