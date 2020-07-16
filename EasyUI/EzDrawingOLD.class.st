Class {
	#name : #EzDrawingOLD,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #'instance creation' }
EzDrawingOLD class >> container: aDrawingBoard [
	^self new
		container: aDrawingBoard;
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
EzDrawingOLD >> canvas [
	^self container canvas
]

{ #category : #accessing }
EzDrawingOLD >> container [
	^ board
]

{ #category : #accessing }
EzDrawingOLD >> container: anObject [
	board := anObject
]

{ #category : #drawing }
EzDrawingOLD >> draw [
	self drawOn: self canvas
]

{ #category : #drawing }
EzDrawingOLD >> drawOn: aCanvas [
	self subclassResponsibility
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

{ #category : #drawing }
EzDrawingOLD >> updateDisplay [
	self container updateDisplay
]
