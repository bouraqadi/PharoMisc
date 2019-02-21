Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'board',
		'currentForm',
		'initialForm',
		'center'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawing class >> extent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

{ #category : #pose }
EzDrawing >> angle: degrees [
	| newForm newAngle |
	newAngle := degrees % 360.
	newAngle = 0 ifTrue: [^self currentForm: self initialForm].
	newForm := self initialForm rotateBy: degrees negated. "form rotation is clockwise"
	self currentForm: newForm.

]

{ #category : #accessing }
EzDrawing >> board [
	^ board
]

{ #category : #accessing }
EzDrawing >> board: anObject [
	board := anObject
]

{ #category : #pose }
EzDrawing >> center [
	^ center
]

{ #category : #pose }
EzDrawing >> center: newCenter [
	self updateDisplayAround: [center := newCenter].

]

{ #category : #accessing }
EzDrawing >> currentBoundingBox [
	^self currentPosition extent: self currentForm extent
]

{ #category : #accessing }
EzDrawing >> currentForm [
	^ currentForm
]

{ #category : #accessing }
EzDrawing >> currentForm: newForm [
	self updateDisplayAround: [currentForm := newForm]
]

{ #category : #pose }
EzDrawing >> currentPosition [
	^self positionForForm: self currentForm center: self center
]

{ #category : #initialization }
EzDrawing >> defaultBoard [
	^EzNullDrawingBoardPresenter new
]

{ #category : #initialization }
EzDrawing >> defaultCenter [
	^0@0
]

{ #category : #initialization }
EzDrawing >> defaultExtent [
	^100@100

]

{ #category : #drawing }
EzDrawing >> ellipseFillColor: aColor [
	self initialCanvas fillOval: self initialBoundingBox color: aColor
]

{ #category : #initialization }
EzDrawing >> extent: aPoint [ 
	self initialForm: (Form extent: aPoint depth: 8)
]

{ #category : #displaying }
EzDrawing >> hide [
	self currentForm ifNil: [ ^self ].
	self board remove: self

]

{ #category : #accessing }
EzDrawing >> initialBoundingBox [
	^self initialForm boundingBox
]

{ #category : #drawing }
EzDrawing >> initialCanvas [
	^ self initialForm getCanvas 
]

{ #category : #accessing }
EzDrawing >> initialForm [
	^ initialForm
]

{ #category : #initialization }
EzDrawing >> initialForm: newForm [
	initialForm := newForm.
	self currentForm: newForm.
]

{ #category : #initialization }
EzDrawing >> initialize [
	super initialize.
	center := self defaultCenter.
	self board: self defaultBoard.
	self extent: self defaultExtent.

]

{ #category : #pose }
EzDrawing >> positionForForm: aForm [
	^self positionForForm: aForm center: self center
]

{ #category : #pose }
EzDrawing >> positionForForm: aForm center: aPoint [
	^aPoint - (aForm extent//2)
]

{ #category : #drawing }
EzDrawing >> rectangleFillColor: aColor [
	self initialCanvas fillColor: aColor
]

{ #category : #displaying }
EzDrawing >> show [
	self board add: self
]

{ #category : #displaying }
EzDrawing >> updateDisplayAround: aBlock [
	aBlock value.
	self board updateDisplay
]
