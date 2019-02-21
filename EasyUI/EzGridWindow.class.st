"
I represent a grid. Widgets positions are cells of the grid.
Indices of visible cells start at 1@1.

See class EzWindowWithWigetsExample class>>#gridWindowExample


"
Class {
	#name : #EzGridWindow,
	#superclass : #EzWindow,
	#instVars : [
		'pixelsPerPoint'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #initialization }
EzGridWindow >> defaultPixelsPerPoint [
	^42
]

{ #category : #initialization }
EzGridWindow >> initialize [
	super initialize.
	self pixelsPerPoint: self defaultPixelsPerPoint.

]

{ #category : #accessing }
EzGridWindow >> pixelsPerPoint [
	^ pixelsPerPoint
]

{ #category : #accessing }
EzGridWindow >> pixelsPerPoint: anObject [
	pixelsPerPoint := anObject
]

{ #category : #accessing }
EzGridWindow >> referencePosition [
	^super referencePosition - (self pixelsPerPoint//2)
]
