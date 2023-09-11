Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'origin',
		'angle',
		'isShowing',
		'container'
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

{ #category : #interacting }
EzDrawing >> bindKeyCombination: aKeyCombination toAction: aBlock [
	self container bindKeyCombination: aKeyCombination toAction: aBlock
]

{ #category : #accessing }
EzDrawing >> container [
	^ container
]

{ #category : #accessing }
EzDrawing >> container: anObject [
	container := anObject.

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

{ #category : #rendering }
EzDrawing >> hide [
	self isShowing: false.

]

{ #category : #initialization }
EzDrawing >> initialize [
	super initialize.
	angle := self defaultAngle.
	origin := self defaultOrigin.
	self show.
]

{ #category : #accessing }
EzDrawing >> isShowing [
	^ isShowing
]

{ #category : #accessing }
EzDrawing >> isShowing: anObject [
	isShowing := anObject.
	self redraw
]

{ #category : #rendering }
EzDrawing >> moveToBack [
	self container moveToBack: self
]

{ #category : #rendering }
EzDrawing >> moveToFront [
	self container moveToFront: self
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
	self container ifNil: [ ^self ].
	self container redraw.
]

{ #category : #rendering }
EzDrawing >> renderOn: canvas [
	self isShowing ifFalse: [ ^self ].
	canvas pathTransform restoreAfter: [
		canvas pathTransform translateX: self origin x Y: self origin y.
		canvas pathTransform rotateByDegrees: self angle.
		self drawOn: canvas.
	]


]

{ #category : #rendering }
EzDrawing >> show [
	self isShowing: true.

]
