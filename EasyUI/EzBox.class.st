Class {
	#name : #EzBox,
	#superclass : #EzBoundedDrawing,
	#category : #'EasyUI-Drawings'
}

{ #category : #drawing }
EzBox >> drawOn: aCanvas [
	aCanvas frameAndFillRectangle: self boundingBox
			fillColor: self fillColor
			borderWidth: self borderWidth
			borderColor: self borderColor
]
