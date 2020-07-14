Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'origin',
		'angle',
		'shape'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzDrawing >> angle [
	^angle
]

{ #category : #accessing }
EzDrawing >> angle: degrees [
	angle := degrees
]

{ #category : #initialization }
EzDrawing >> defaultAngle [
	^0
]

{ #category : #initialization }
EzDrawing >> defaultOrigin [
	^100@100
]

{ #category : #rendering }
EzDrawing >> drawOn: canvas [
	self subclassResponsibility
]

{ #category : #initialization }
EzDrawing >> initialize [
	super initialize.
	angle := self defaultAngle.
	origin := self defaultOrigin.
]

{ #category : #accessing }
EzDrawing >> origin [
	^origin
]

{ #category : #accessing }
EzDrawing >> origin: aPoint [
	origin := aPoint
]

{ #category : #rendering }
EzDrawing >> renderOn: canvas [
	canvas pathTransform restoreAfter: [
		canvas pathTransform translateX: origin x Y: origin y.
		canvas pathTransform rotateByDegrees: angle.
		canvas setShape: (self shapeForCanvas: canvas).
		self drawOn: canvas.
	]


]

{ #category : #rendering }
EzDrawing >> shapeForCanvas: canvas [
	^shape
]
