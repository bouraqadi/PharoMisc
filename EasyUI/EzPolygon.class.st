Class {
	#name : #EzPolygon,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'vertices'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #drawing }
EzPolygon >> drawOn: aCanvas [
	aCanvas
		drawPolygon: self vertices 
		color: self fillColor 
		borderWidth: self borderWidth
		borderColor: self borderColor
]

{ #category : #accessing }
EzPolygon >> vertices [
	^ vertices
]

{ #category : #accessing }
EzPolygon >> vertices: anObject [
	vertices := anObject
]
