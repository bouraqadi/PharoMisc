Class {
	#name : #EzSimpleDrawing,
	#superclass : #Object,
	#instVars : [
		'shape',
		'fillColor',
		'borderColor',
		'borderWidth',
		'position',
		'angle'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzSimpleDrawing class >> circleCenter: position diameter: diameter [
	^self ellipseCenter: position width: diameter height: diameter
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> circleCenter: position radius: radius [
	^self circleCenter: position diameter: 2 * radius
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> ellipseCenter: position width: width height: height [
	| shape |
	shape := EllipseMorph newBounds: (0 @ 0 corner: width @ height).
	^ self newShape: shape center: position
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> newShape: shape center: center [
	^self new
		shape: shape;
		center: center;
		yourself 
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> newShape: shape origin: position [
	^self new
		position: position;
		shape: shape;
		yourself 
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> rectangleCenter: center width: width height: height [
	^ self newShape: (0 @ 0 corner: width @ height) center: center
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> rectangleOrigin: position width: width height: height [
	^ self newShape: (0 @ 0 corner: width @ height) origin: position
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> squareCenter: center length: length [
	^self rectangleCenter: center width: length height: length
]

{ #category : #'instance creation' }
EzSimpleDrawing class >> squareOrigin: position length: length [
	^self rectangleOrigin: position width: length height: length
]

{ #category : #accessing }
EzSimpleDrawing >> angle [
	^angle
]

{ #category : #accessing }
EzSimpleDrawing >> angle: degrees [
	angle := degrees
]

{ #category : #accessing }
EzSimpleDrawing >> borderColor [
	^ borderColor
]

{ #category : #accessing }
EzSimpleDrawing >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
EzSimpleDrawing >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
EzSimpleDrawing >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #accessing }
EzSimpleDrawing >> bounds [
	^self shape bounds
]

{ #category : #accessing }
EzSimpleDrawing >> center [
	^self shape bounds center + self position
]

{ #category : #accessing }
EzSimpleDrawing >> center: newCenter [
	self position: newCenter - self shape bounds center
]

{ #category : #initialization }
EzSimpleDrawing >> defaultAngle [
	^0
]

{ #category : #initialization }
EzSimpleDrawing >> defaultBorderColor [
	^ Color black
]

{ #category : #initialization }
EzSimpleDrawing >> defaultBorderWidth [
	^ 3
]

{ #category : #initialization }
EzSimpleDrawing >> defaultFillColor [
	^ Color green
]

{ #category : #initialization }
EzSimpleDrawing >> defaultPosition [
	^100@100
]

{ #category : #drawing }
EzSimpleDrawing >> drawOn: canvas [
	canvas pathTransform restoreAfter: [
		canvas pathTransform translateX: position x Y: position y.
		canvas pathTransform rotateByDegrees: angle.
		canvas setShape: shape.
		canvas setPaint: fillColor.
		canvas draw.
		(canvas setStrokePaint: borderColor) width: borderWidth.
		canvas draw.]


]

{ #category : #accessing }
EzSimpleDrawing >> fillColor [
	^ fillColor
]

{ #category : #accessing }
EzSimpleDrawing >> fillColor: anObject [
	fillColor := anObject
]

{ #category : #initialization }
EzSimpleDrawing >> initialize [
	super initialize.
	fillColor := self defaultFillColor.
	borderColor := self defaultBorderColor.
	borderWidth := self defaultBorderWidth.
	angle := self defaultAngle.
	position := self defaultPosition.
]

{ #category : #accessing }
EzSimpleDrawing >> position [
	^position
]

{ #category : #accessing }
EzSimpleDrawing >> position: aPoint [
	position := aPoint
]

{ #category : #accessing }
EzSimpleDrawing >> shape [
	^ shape
]

{ #category : #accessing }
EzSimpleDrawing >> shape: anObject [
	shape := anObject
]
