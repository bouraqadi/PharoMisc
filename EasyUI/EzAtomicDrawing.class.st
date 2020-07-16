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
	^shape
]
