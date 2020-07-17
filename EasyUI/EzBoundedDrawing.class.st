Class {
	#name : #EzBoundedDrawing,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'width',
		'height'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzBoundedDrawing class >> width: width height: height [
	^ self new
		width: width height: height;
		yourself
]

{ #category : #rendering }
EzBoundedDrawing >> bounds [
	^ (self width/ -2) @ (self height/ -2) extent: self width @ self height.
]

{ #category : #initialization }
EzBoundedDrawing >> corner: newCorner [
	| previousCorner |
	previousCorner :=  (self width/ -2) @ (self height/ -2).
	self center: self center +  newCorner - previousCorner.
]

{ #category : #accessing }
EzBoundedDrawing >> height [
	^height
]

{ #category : #accessing }
EzBoundedDrawing >> width [
	^width
]

{ #category : #initialization }
EzBoundedDrawing >> width: newWidth height: newHeight [
	width := newWidth.
	height := newHeight.
	self redraw.


]
