Class {
	#name : #EzOvalOLD,
	#superclass : #EzBoundedDrawing,
	#category : #'EasyUI-KernelOLD'
}

{ #category : #drawing }
EzOvalOLD >> drawOn: aCanvas [
	aCanvas 
		fillOval: self boundingBox
		color: self fillColor
		borderWidth: self borderWidth
		borderColor: self borderColor
]
