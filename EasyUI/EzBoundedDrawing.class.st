Class {
	#name : #EzBoundedDrawing,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'bounds'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzBoundedDrawing >> bounds [
	^bounds
]

{ #category : #accessing }
EzBoundedDrawing >> center [
	^self bounds center + self origin
]

{ #category : #accessing }
EzBoundedDrawing >> center: newCenter [
	self origin: newCenter - self center + self origin
]

{ #category : #initialization }
EzBoundedDrawing >> width: width height: height [
	bounds := 0 @ 0 corner: width @ height.

]
