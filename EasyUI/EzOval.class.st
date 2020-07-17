Class {
	#name : #EzOval,
	#superclass : #EzBoundedDrawing,
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzOval class >> circleCenter: position diameter: diameter [
	^self ellipseCenter: position width: diameter height: diameter
]

{ #category : #'instance creation' }
EzOval class >> circleCenter: center radius: radius [
	^self circleCenter: center diameter: 2 * radius
]

{ #category : #'instance creation' }
EzOval class >> ellipseCenter: center width: width height: height [
	^ self new
		width: width height: height;
		center: center;
		yourself
]

{ #category : #rendering }
EzOval >> newShapeForCanvas: canvas [
	^EllipseMorph newBounds: self bounds
]
