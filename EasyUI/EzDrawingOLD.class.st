Class {
	#name : #EzDrawingOLD,
	#superclass : #Object,
	#instVars : [
		'board',
		'currentForm',
		'initialForm',
		'center',
		'angle'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawingOLD class >> extent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

{ #category : #pose }
EzDrawingOLD >> angle [
	^angle
]

{ #category : #pose }
EzDrawingOLD >> angle: degrees [
	| newForm |
	angle := degrees % 360.
	angle = 0 ifTrue: [^self currentForm: self initialForm].
	newForm := self initialForm rotateBy: angle negated. "form rotation is clockwise"
	self currentForm: newForm.

]

{ #category : #pose }
EzDrawingOLD >> center [
	^ center
]

{ #category : #pose }
EzDrawingOLD >> center: newCenter [
	self updateDisplayAround: [center := newCenter].

]

{ #category : #accessing }
EzDrawingOLD >> currentBoundingBox [
	^ self position extent: self currentExtent
]

{ #category : #accessing }
EzDrawingOLD >> currentExtent [
	^ self currentForm extent
]

{ #category : #accessing }
EzDrawingOLD >> currentForm [
	^ currentForm
]

{ #category : #accessing }
EzDrawingOLD >> currentForm: newForm [
	self updateDisplayAround: [currentForm := newForm]
]

{ #category : #initialization }
EzDrawingOLD >> defaultBoard [
	^EzNullDrawingBoardPresenter new
]

{ #category : #initialization }
EzDrawingOLD >> defaultCenter [
	^0@0
]

{ #category : #initialization }
EzDrawingOLD >> defaultExtent [
	^100@100

]

{ #category : #drawing }
EzDrawingOLD >> ellipseFillColor: aColor [
	self initialCanvas fillOval: self initialBoundingBox color: aColor
]

{ #category : #initialization }
EzDrawingOLD >> extent: aPoint [ 
	self initialForm: (Form extent: aPoint depth: 8)
]

{ #category : #accessing }
EzDrawingOLD >> initialBoundingBox [
	^self initialForm boundingBox
]

{ #category : #drawing }
EzDrawingOLD >> initialCanvas [
	^ self initialForm getCanvas 
]

{ #category : #accessing }
EzDrawingOLD >> initialForm [
	^ initialForm
]

{ #category : #initialization }
EzDrawingOLD >> initialForm: newForm [
	initialForm := newForm.
	self currentForm: newForm.
]

{ #category : #initialization }
EzDrawingOLD >> initialize [
	super initialize.
	angle := 0.
	center := self defaultCenter.
	self board: self defaultBoard.
	self extent: self defaultExtent.

]

{ #category : #pose }
EzDrawingOLD >> position [
	^self positionForForm: self currentForm center: self center
]

{ #category : #pose }
EzDrawingOLD >> position: newPosition [
	^self center: self center - self position + newPosition
]

{ #category : #pose }
EzDrawingOLD >> positionForForm: aForm [
	^self positionForForm: aForm center: self center
]

{ #category : #pose }
EzDrawingOLD >> positionForForm: aForm center: aPoint [
	^aPoint - (aForm extent//2)
]

{ #category : #drawing }
EzDrawingOLD >> rectangleFillColor: aColor [
	self initialCanvas fillColor: aColor
]

{ #category : #displaying }
EzDrawingOLD >> updateDisplayAround: aBlock [
	aBlock value.
	self board updateDisplay
]
