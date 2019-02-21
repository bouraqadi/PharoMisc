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
	self updateDisplay.
]

{ #category : #accessing }
EzDrawingBoardPresenter >> canvas [
	^self image getCanvas
]

{ #category : #drawing }
EzDrawingBoardPresenter >> copy: aDrawing with: copier [
	^ copier
		copy: aDrawing currentBoundingBox
		from: 0 @ 0
		in: aDrawing currentForm
		fillColor: nil
		rule: 25
]

{ #category : #initialization }
EzDrawingBoardPresenter >> defaultBackgroundColor [
	^Color white
]

{ #category : #initialization }
EzDrawingBoardPresenter >> defaultExtent [
	^400@300
]

{ #category : #api }
EzDrawingBoardPresenter >> extent: newExtent [
	self image: (Form extent: newExtent depth: 8).
	self updateDisplay
]

{ #category : #drawing }
EzDrawingBoardPresenter >> hide: aDrawing [
	drawings remove: aDrawing ifAbsent: [^self].	
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
EzDrawingBoardPresenter >> newFormCopier [
	^ BitBlt toForm: self image
]

{ #category : #drawing }
EzDrawingBoardPresenter >> show: aDrawing [
	drawings add: aDrawing.	
	self updateDisplay
	
]

{ #category : #drawing }
EzDrawingBoardPresenter >> updateDisplay [
	| copier |
	self image ifNil: [ ^self ].
	self canvas fillColor: self backgroundColor.
	copier := self newFormCopier.
	drawings do: [ :aDrawing | self copy: aDrawing with: copier ].
	self imageHolder valueChanged
]
