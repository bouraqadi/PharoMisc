Class {
	#name : #EzBoundedDrawing,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'boundingBox'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzBoundedDrawing >> boundingBox [
	^ boundingBox
]

{ #category : #accessing }
EzBoundedDrawing >> boundingBox: anObject [
	boundingBox := anObject
]

{ #category : #accessing }
EzBoundedDrawing >> center: center halfExtent: halfExtent [ 
	self boundingBox: ((center - halfExtent) corner: (center + halfExtent))
	
]

{ #category : #accessing }
EzBoundedDrawing >> origin: origin extent: extent [
	self boundingBox: (origin extent: extent)
]
