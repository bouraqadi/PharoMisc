Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'board',
		'currentForm',
		'initialForm',
		'center'
	],
	#category : #'EasyUI-SpecDemo'
}

{ #category : #pose }
EzDrawing >> angle: degrees [
	| newForm newAngle |
	newAngle := degrees % 360.
	newAngle = 0 ifTrue: [^self currentForm: self initialForm].
	newForm := self initialForm rotateBy: degrees.
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
	self hide.
	center := newCenter.
	self show.
]

{ #category : #accessing }
EzDrawing >> currentForm [
	^ currentForm
]

{ #category : #accessing }
EzDrawing >> currentForm: newForm [
	self hide.
	currentForm := newForm.
	self show.

]

{ #category : #pose }
EzDrawing >> currentPosition [
	^self positionForForm: self currentForm center: self center
]

{ #category : #initialization }
EzDrawing >> defaultBoard [
	^EzNullBoardPresenter new
]

{ #category : #initialization }
EzDrawing >> defaultCenter [
	^0@0
]

{ #category : #initialization }
EzDrawing >> defaultExtent [
	^100@100

]

{ #category : #initialization }
EzDrawing >> extent: aPoint [ 
	self initialForm: (Form extent: aPoint depth: 8)
]

{ #category : #displaying }
EzDrawing >> hide [
	self currentForm ifNil: [ ^self ].
	self board delete: self currentForm at: self currentPosition

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

{ #category : #displaying }
EzDrawing >> show [
	self board draw: self currentForm at: self currentPosition

]
