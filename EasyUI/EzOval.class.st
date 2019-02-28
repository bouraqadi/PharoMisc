Class {
	#name : #EzOval,
	#superclass : #EzBoundedDrawing,
	#category : #'EasyUI-Kernel'
}

{ #category : #drawing }
EzOval >> drawOn: aCanvas [
	aCanvas 
		fillOval: self boundingBox
		color: self fillColor
		borderWidth: self borderWidth
		borderColor: self borderColor
]
