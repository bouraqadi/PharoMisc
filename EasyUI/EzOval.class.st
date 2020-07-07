Class {
	#name : #EzOval,
	#superclass : #EzBoundedDrawing,
	#category : #'EasyUI-Drawings'
}

{ #category : #drawing }
EzOval >> drawOn: aCanvas [
	aCanvas 
		fillOval: self boundingBox
		color: self fillColor
		borderWidth: self borderWidth
		borderColor: self borderColor
]
