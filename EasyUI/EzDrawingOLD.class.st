Class {
	#name : #EzDrawingOLD,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #'instance creation' }
EzDrawingOLD class >> board: aDrawingBoard [
	^self new
		board: aDrawingBoard;
		yourself
]

{ #category : #interacting }
EzDrawingOLD >> angle [
	self subclassResponsibility 
]

{ #category : #interacting }
EzDrawingOLD >> basicMoveTo: aPoint [
	self subclassResponsibility 
]

{ #category : #interacting }
EzDrawingOLD >> basicRotateTo: degreees [
	self subclassResponsibility 
]

{ #category : #accessing }
EzDrawingOLD >> board [
	^ board
]

{ #category : #accessing }
EzDrawingOLD >> board: anObject [
	board := anObject
]

{ #category : #accessing }
EzDrawingOLD >> canvas [
	^self board canvas
]

{ #category : #drawing }
EzDrawingOLD >> draw [
	self drawOn: self canvas
]

{ #category : #drawing }
EzDrawingOLD >> drawOn: aCanvas [
	self subclassResponsibility
]

{ #category : #displaying }
EzDrawingOLD >> hide [
	self board remove: self
]

{ #category : #interacting }
EzDrawingOLD >> moveBy: delta [
	self moveTo: self origin + delta
]

{ #category : #interacting }
EzDrawingOLD >> moveTo: aPoint [
	self basicMoveTo: aPoint.
	self updateDisplay
]

{ #category : #displaying }
EzDrawingOLD >> moveToBack [
	self board moveToBack: self
]

{ #category : #displaying }
EzDrawingOLD >> moveToFront [
	self board moveToFront: self
]

{ #category : #interacting }
EzDrawingOLD >> origin [
	self subclassResponsibility 
]

{ #category : #interacting }
EzDrawingOLD >> rotateBy: deltaDegrees [
	self rotateTo: self angle + deltaDegrees
]

{ #category : #interacting }
EzDrawingOLD >> rotateTo: degrees [
	self basicRotateTo: degrees.
	self updateDisplay
]

{ #category : #displaying }
EzDrawingOLD >> show [
	self board add: self
]

{ #category : #drawing }
EzDrawingOLD >> updateDisplay [
	self board updateDisplay
]
