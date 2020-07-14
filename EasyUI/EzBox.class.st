Class {
	#name : #EzBox,
	#superclass : #EzClosedDrawing,
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzBox class >> rectangleCenter: center width: width height: height [
	^ self new
		width: width height: height;
		center: center;
		yourself
]

{ #category : #'instance creation' }
EzBox class >> rectangleOrigin: origin width: width height: height [
	^ self new
		width: width height: height;
		origin: origin;
		yourself
]

{ #category : #'instance creation' }
EzBox class >> squareCenter: center length: length [
	^self rectangleCenter: center width: length height: length
]

{ #category : #'instance creation' }
EzBox class >> squareOrigin: origin length: length [
	^self rectangleOrigin: origin width: length height: length
]

{ #category : #accessing }
EzBox >> bounds [
	^shape
]

{ #category : #initialize }
EzBox >> width: width height: height [
	shape := 0 @ 0 corner: width @ height
]
