Class {
	#name : #EzAtomicDrawing,
	#superclass : #EzDrawing,
	#instVars : [
		'shape'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #rendering }
EzAtomicDrawing >> drawOn: canvas [
	canvas setShape: (self shapeForCanvas: canvas).
	
]

{ #category : #rendering }
EzAtomicDrawing >> newShapeForCanvas: canvas [
	^self subclassResponsibility
]

{ #category : #rendering }
EzAtomicDrawing >> redraw [
	shape := nil.
	super redraw.
]

{ #category : #accessing }
EzAtomicDrawing >> shape [
	^ shape
]

{ #category : #accessing }
EzAtomicDrawing >> shape: anObject [
	shape := anObject.
	self redraw.
]

{ #category : #rendering }
EzAtomicDrawing >> shapeForCanvas: canvas [
	^shape ifNil: [ shape := self newShapeForCanvas: canvas ].

]
