Class {
	#name : #EzDrawingBoardPresenter,
	#superclass : #ImagePresenter,
	#instVars : [
		'backgroundColor',
		'drawings'
	],
	#category : #'EasyUI-SpecDemo'
}

{ #category : #drawing }
EzDrawingBoardPresenter >> add: aDrawing [
	(self drawings includes: aDrawing) ifTrue: [ ^self ]. 
	self drawings add: aDrawing.	
	self draw: aDrawing.
	self imageHolder valueChanged
]

{ #category : #accessing }
EzDrawingBoardPresenter >> backgroundColor [
	^backgroundColor
]

{ #category : #drawing }
EzDrawingBoardPresenter >> backgroundColor: aColor [ 
	backgroundColor := aColor.
	self updateDisplay.
]

{ #category : #accessing }
EzDrawingBoardPresenter >> canvas [
	^self image getCanvas
]

{ #category : #initialization }
EzDrawingBoardPresenter >> defaultBackgroundColor [
	^Color white
]

{ #category : #initialization }
EzDrawingBoardPresenter >> defaultExtent [
	^400@300
]

{ #category : #drawing }
EzDrawingBoardPresenter >> draw: aDrawing [ 
	self draw: aDrawing with: self newBitBlt

]

{ #category : #drawing }
EzDrawingBoardPresenter >> draw: aDrawing with: copier [
	^ copier
		copy: aDrawing currentBoundingBox
		from: 0 @ 0
		in: aDrawing currentForm
		fillColor: nil
		rule: 25
]

{ #category : #accessing }
EzDrawingBoardPresenter >> drawings [
	^drawings
]

{ #category : #api }
EzDrawingBoardPresenter >> extent: newExtent [
	self image: (Form extent: newExtent depth: 8).
	self updateDisplay
]

{ #category : #initialization }
EzDrawingBoardPresenter >> initialize [
	super initialize.
	drawings := OrderedCollection new.
	self backgroundColor: self defaultBackgroundColor.
	self extent: self defaultExtent.

]

{ #category : #drawing }
EzDrawingBoardPresenter >> newBitBlt [
	^ BitBlt toForm: self image
]

{ #category : #drawing }
EzDrawingBoardPresenter >> remove: aDrawing [
	self drawings remove: aDrawing ifAbsent: [^self].	
	self updateDisplay
	
]

{ #category : #drawing }
EzDrawingBoardPresenter >> updateDisplay [
	| copier |
	self image ifNil: [ ^self ].
	self canvas fillColor: self backgroundColor.
	copier := self newBitBlt.
	drawings do: [ :aDrawing | self draw: aDrawing with: copier ].
	self imageHolder valueChanged
]
