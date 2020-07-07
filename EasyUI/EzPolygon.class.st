Class {
	#name : #EzPolygon,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'vertices'
	],
	#category : #'EasyUI-Drawings'
}

{ #category : #interacting }
EzPolygon >> basicMoveTo: aPoint [
	| delta newVertices |
	delta := aPoint - self vertices first.
	newVertices := self vertices collect: [ : each | each + delta ].
	self vertices: newVertices
]

{ #category : #drawing }
EzPolygon >> drawOn: aCanvas [
	aCanvas
		drawPolygon: self vertices 
		color: self fillColor 
		borderWidth: self borderWidth
		borderColor: self borderColor
]

{ #category : #interacting }
EzPolygon >> position [
	^self vertices first
]

{ #category : #accessing }
EzPolygon >> vertices [
	^ vertices
]

{ #category : #accessing }
EzPolygon >> vertices: anObject [
	vertices := anObject
]
