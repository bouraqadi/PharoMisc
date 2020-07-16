Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'board',
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
	angle := degrees.
	self redraw.
]

{ #category : #accessing }
EzDrawing >> board [
	^ board
]

{ #category : #accessing }
EzDrawing >> board: anObject [
	board := anObject.

]

{ #category : #initialization }
EzDrawing >> defaultAngle [
	^0
]

{ #category : #initialization }
EzDrawing >> defaultOrigin [
	^0@0
]

{ #category : #rendering }
EzDrawing >> drawOn: canvas [
	self subclassResponsibility
]

{ #category : #displaying }
EzDrawing >> hide [
	self board remove: self
]

{ #category : #initialization }
EzDrawing >> initialize [
	super initialize.
	angle := self defaultAngle.
	origin := self defaultOrigin.
]

{ #category : #displaying }
EzDrawing >> moveToBack [
	self board moveToBack: self
]

{ #category : #displaying }
EzDrawing >> moveToFront [
	self board moveToFront: self
]

{ #category : #accessing }
EzDrawing >> origin [
	^origin
]

{ #category : #accessing }
EzDrawing >> origin: aPoint [
	origin := aPoint.
	self redraw.
]

{ #category : #rendering }
EzDrawing >> redraw [
	self board ifNil: [ ^self ].
	self board redraw.
]

{ #category : #rendering }
EzDrawing >> renderOn: canvas [
	canvas pathTransform restoreAfter: [
		canvas pathTransform translateX: self origin x Y: self origin y.
		canvas pathTransform rotateByDegrees: self angle.
		canvas setShape: (self shapeForCanvas: canvas).
		self drawOn: canvas.
	]


]

{ #category : #accessing }
EzDrawing >> shape [
	^ shape
]

{ #category : #accessing }
EzDrawing >> shape: anObject [
	shape := anObject.
	self redraw.
]

{ #category : #rendering }
EzDrawing >> shapeForCanvas: canvas [
	^shape
]

{ #category : #displaying }
EzDrawing >> show [
	self board add: self
]
