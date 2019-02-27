Class {
	#name : #EzDrawingBoardPresenter,
	#superclass : #ImagePresenter,
	#instVars : [
		'backgroundColor',
		'drawings'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawingBoardPresenter class >> extent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

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

{ #category : #initialization }
EzDrawingBoardPresenter >> extent: newExtent [
self flag: #'TODO: Use inherited extentHolder'.
	self image: (Form extent: newExtent depth: 8).
	self updateDisplay
]

{ #category : #api }
EzDrawingBoardPresenter >> initialExtent [
	^self image extent
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

{ #category : #'creating drawings' }
EzDrawingBoardPresenter >> newCircleDiameter: diameterInt fillColor: aColor [
	^self newEllipseExtent: diameterInt @ diameterInt fillColor: aColor
]

{ #category : #'creating drawings' }
EzDrawingBoardPresenter >> newCircleDiameter: diameterInt fillColor: fillColor frameColor: frameColor arrowColor: arrowColor [
	| circle radius arrowStart arrowEnd arrowThickness |
	circle := self newCircleDiameter:  diameterInt fillColor: fillColor.
	radius := diameterInt//2.
	arrowThickness := 3.
	arrowStart := radius @ radius.
	arrowEnd := diameterInt @ radius.
	circle initialCanvas 
		line: arrowStart to: arrowEnd width: arrowThickness color: arrowColor;
		frameOval: circle initialBoundingBox color: frameColor.
	^circle
]

{ #category : #'creating drawings' }
EzDrawingBoardPresenter >> newDrawingExtent: aPoint [ 
	^(EzDrawing extent: aPoint)
		board: self;
		yourself
]

{ #category : #'creating drawings' }
EzDrawingBoardPresenter >> newEllipseExtent: aPoint fillColor: aColor [
	^(self newDrawingExtent: aPoint)
		ellipseFillColor: aColor;
		yourself
]

{ #category : #'creating drawings' }
EzDrawingBoardPresenter >> newLine: startPoint to: endPoint width: width color: aColor [
	| boundingBox newDrawing relativeStart relativeEnd |
	boundingBox := startPoint corner: endPoint.
	newDrawing := self newDrawingExtent: boundingBox extent + width.
	relativeStart := startPoint - boundingBox origin.
	relativeEnd := endPoint - boundingBox origin.
	newDrawing initialCanvas
		line: relativeStart
		to: relativeEnd
		width: width
		color: aColor.
	newDrawing position: boundingBox origin.
	^ newDrawing
]

{ #category : #'creating drawings' }
EzDrawingBoardPresenter >> newRectangleExtent: aPoint fillColor: aColor [
	^(self newDrawingExtent: aPoint)
		rectangleFillColor: aColor;
		yourself
]

{ #category : #'creating drawings' }
EzDrawingBoardPresenter >> newSquareLength: lengthInt fillColor: aColor [
	^self newRectangleExtent: lengthInt @ lengthInt fillColor: aColor
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
