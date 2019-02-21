Class {
	#name : #EzDrawingBoardPresenter,
	#superclass : #ImagePresenter,
	#instVars : [
		'backgroundColor',
		'drawings'
	],
	#category : #'EasyUI-SpecDemo'
}

{ #category : #accessing }
EzDrawingBoardPresenter >> backgroundColor [
	^backgroundColor
]

{ #category : #drawing }
EzDrawingBoardPresenter >> backgroundColor: aColor [ 
	backgroundColor := aColor.
	self image ifNil: [ ^self ].
	self fillColor: aColor.
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
EzDrawingBoardPresenter >> delete: aDrawing [
	self canvas fillRectangle: aDrawing currentBoundingBox color: self backgroundColor.
	self updateDisplay
]

{ #category : #drawing }
EzDrawingBoardPresenter >> draw: aDrawing [
	| copier |
	copier := BitBlt toForm: self image.
	copier copy: aDrawing currentBoundingBox from: 0@0 in: aDrawing currentForm fillColor: nil rule: 25.
	self updateDisplay
	
]

{ #category : #api }
EzDrawingBoardPresenter >> extent: newExtent [
	self image: (Form extent: newExtent depth: 8).
	self fillColor: self backgroundColor.
]

{ #category : #drawing }
EzDrawingBoardPresenter >> fillColor: aColor [ 
	self canvas fillColor: aColor.
	self updateDisplay.
]

{ #category : #initialization }
EzDrawingBoardPresenter >> initialize [
	super initialize.
	self backgroundColor: self defaultBackgroundColor.
	self extent: self defaultExtent.
	drawings := OrderedCollection new.
]

{ #category : #drawing }
EzDrawingBoardPresenter >> updateDisplay [
	self imageHolder valueChanged.
]
