Class {
	#name : #EzBox,
	#superclass : #EzBoundedDrawing,
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzBox class >> rectangleCenter: center width: width height: height [
	^ (self width: width height: height)
		center: center;
		yourself
]

{ #category : #'instance creation' }
EzBox class >> rectangleCorner: corner width: width height: height [
	^ (self width: width height: height)
		corner: corner;
		yourself
]

{ #category : #'instance creation' }
EzBox class >> squareCenter: center length: length [
	^self rectangleCenter: center width: length height: length
]

{ #category : #'instance creation' }
EzBox class >> squareCorner: corner length: length [
	^self rectangleCorner: corner width: length height: length
]

{ #category : #rendering }
EzBox >> newShapeForCanvas: canvas [
	^ self bounds
]
