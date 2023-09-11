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

{ #category : #accessing }
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
EzBoundedDrawing >> height: aNumber [

	self width: width height: aNumber
]

{ #category : #accessing }
EzBoundedDrawing >> validLengthFrom: newLength [ 

	newLength < 1 ifTrue: [ ^ 1 ].
	^ newLength rounded
]

{ #category : #accessing }
EzBoundedDrawing >> width [
	^width
]

{ #category : #accessing }
EzBoundedDrawing >> width: aNumber [

	self width: aNumber height: height
]

{ #category : #accessing }
EzBoundedDrawing >> width: newWidth height: newHeight [

	width := self validLengthFrom: newWidth.
	height := self validLengthFrom: newHeight.
	self redraw
]
