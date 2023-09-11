Class {
	#name : #EzArc,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'radius',
		'angleSpan'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzArc class >> center: center radius: radius angleSpan: angleSpan [
	^(self radius: radius angleSpan: angleSpan)
		center: center;
		yourself
		
]

{ #category : #'instance creation' }
EzArc class >> radius: radius angleSpan: angleSpan [
	^self new
		radius: radius;
		angleSpan: angleSpan;
		yourself
		
]

{ #category : #accessing }
EzArc >> angleSpan [
	^ angleSpan
]

{ #category : #accessing }
EzArc >> angleSpan: anObject [
	angleSpan := anObject.
	self redraw
]

{ #category : #rendering }
EzArc >> newShapeForCanvas: canvas [
	| vertice |
	^canvas createPath: [ : path |
		path absolute.
		vertice := (radius * angleSpan degreeCos) @ (radius * angleSpan degreeSin).
		path lineTo: vertice.
		path ccwArcTo: radius@0 angle: angleSpan degreesToRadians.
		path lineTo: 0@0.
	].

]

{ #category : #accessing }
EzArc >> radius [
	^ radius
]

{ #category : #accessing }
EzArc >> radius: anObject [
	radius := anObject.
	self redraw
]
