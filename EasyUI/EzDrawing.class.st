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

{ #category : #interacting }
EzDrawing >> angle [
	self subclassResponsibility 
]

{ #category : #interacting }
EzDrawing >> basicMoveTo: aPoint [
	self subclassResponsibility 
]

{ #category : #interacting }
EzDrawing >> basicRotateTo: degreees [
	self subclassResponsibility 
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

{ #category : #interacting }
EzDrawing >> moveBy: delta [
	self moveTo: self position + delta
]

{ #category : #interacting }
EzDrawing >> moveTo: aPoint [
	self basicMoveTo: aPoint.
	self updateDisplay
]

{ #category : #displaying }
EzDrawing >> moveToBack [
	self board moveToBack: self
]

{ #category : #displaying }
EzDrawing >> moveToFront [
	self board moveToFront: self
]

{ #category : #interacting }
EzDrawing >> position [
	self subclassResponsibility 
]

{ #category : #interacting }
EzDrawing >> rotateBy: deltaDegrees [
	self rotateTo: self angle + deltaDegrees
]

{ #category : #interacting }
EzDrawing >> rotateTo: degrees [
	self basicRotateTo: degrees.
	self updateDisplay
]

{ #category : #displaying }
EzDrawing >> show [
	self board add: self
]

{ #category : #drawing }
EzDrawing >> updateDisplay [
	self board updateDisplay
]
