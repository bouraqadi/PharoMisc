Class {
	#name : #EzPolygon,
	#superclass : #EzClosedDrawingOLD,
	#instVars : [
		'vertices'
	],
	#category : #'EasyUI-KernelOLD'
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
EzPolygon >> origin [
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
