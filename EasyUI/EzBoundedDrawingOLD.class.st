Class {
	#name : #EzBoundedDrawingOLD,
	#superclass : #EzClosedDrawingOLD,
	#instVars : [
		'boundingBox'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #interacting }
EzBoundedDrawingOLD >> basicMoveTo: aPoint [
	self center: aPoint
]

{ #category : #accessing }
EzBoundedDrawingOLD >> boundingBox [
	^ boundingBox
]

{ #category : #accessing }
EzBoundedDrawingOLD >> boundingBox: anObject [
	boundingBox := anObject
]

{ #category : #accessing }
EzBoundedDrawingOLD >> center [
	^self boundingBox center
]

{ #category : #accessing }
EzBoundedDrawingOLD >> center: aPoint [
	self center: aPoint halfExtent: self boundingBox extent//2.

]

{ #category : #accessing }
EzBoundedDrawingOLD >> center: center halfExtent: halfExtent [ 
	self boundingBox: ((center - halfExtent) corner: (center + halfExtent))
	
]

{ #category : #interacting }
EzBoundedDrawingOLD >> origin [
	^self center
]

{ #category : #accessing }
EzBoundedDrawingOLD >> origin: origin extent: extent [
	self boundingBox: (origin extent: extent)
]
