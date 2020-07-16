Class {
	#name : #EzOval,
	#superclass : #EzClosedDrawing,
	#traits : 'EzTCenteredDrawing',
	#classTraits : 'EzTCenteredDrawing classTrait',
	#instVars : [
		'bounds'
	],
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

{ #category : #accessing }
EzOval >> bounds [
	^bounds
]

{ #category : #initialization }
EzOval >> width: width height: height [
	"EllipseMorph bounds are shiftted compared to the actual bounds"
	bounds := 0 @ 0 corner: width @ height.
	self shape: (EllipseMorph newBounds: bounds).
]
