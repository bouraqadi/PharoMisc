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
EzArc class >> radius: radius angleSpan: angleSpan [
	^self new
		radius: radius angleSpan: angleSpan;
		yourself
		
]

{ #category : #accessing }
EzArc >> angleSpan [
	^ angleSpan
]

{ #category : #accessing }
EzArc >> angleSpan: anObject [
	angleSpan := anObject
]

{ #category : #rendering }
EzArc >> newShapeForCanvas: canvas [
	| vertice |
	^canvas createPath: [ : path |
		path absolute.
		path lineTo: radius@0.
		vertice := (radius * angleSpan degreeCos) @ (radius * angleSpan degreeSin).
		path cwArcTo: vertice angle: angleSpan degreesToRadians.
		path lineTo: 0@0.
	].

]

{ #category : #accessing }
EzArc >> radius [
	^ radius
]

{ #category : #accessing }
EzArc >> radius: anObject [
	radius := anObject
]
