Class {
	#name : #EzPolygonOLD,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'vertices'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #drawing }
EzPolygonOLD >> drawOn: aCanvas [
	aCanvas
		drawPolygon: self vertices 
		color: self fillColor 
		borderWidth: self borderWidth
		borderColor: self borderColor
]

{ #category : #accessing }
EzPolygonOLD >> vertices [
	^ vertices
]

{ #category : #accessing }
EzPolygonOLD >> vertices: anObject [
	vertices := anObject
]
