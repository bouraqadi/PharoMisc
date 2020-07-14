Class {
	#name : #EzBoundedDrawing,
	#superclass : #EzClosedDrawingOLD,
	#instVars : [
		'boundingBox'
	],
	#category : #'EasyUI-DrawingsOLD'
}

{ #category : #interacting }
EzBoundedDrawing >> basicMoveTo: aPoint [
	self center: aPoint
]

{ #category : #accessing }
EzBoundedDrawing >> boundingBox [
	^ boundingBox
]

{ #category : #accessing }
EzBoundedDrawing >> boundingBox: anObject [
	boundingBox := anObject
]

{ #category : #accessing }
EzBoundedDrawing >> center [
	^self boundingBox center
]

{ #category : #accessing }
EzBoundedDrawing >> center: aPoint [
	self center: aPoint halfExtent: self boundingBox extent//2.

]

{ #category : #accessing }
EzBoundedDrawing >> center: center halfExtent: halfExtent [ 
	self boundingBox: ((center - halfExtent) corner: (center + halfExtent))
	
]

{ #category : #interacting }
EzBoundedDrawing >> origin [
	^self center
]

{ #category : #accessing }
EzBoundedDrawing >> origin: origin extent: extent [
	self boundingBox: (origin extent: extent)
]
