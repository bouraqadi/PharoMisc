Class {
	#name : #EzDrawingBoardOLD,
	#superclass : #ImagePresenter,
	#instVars : [
		'backgroundColor',
		'drawings'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawingBoardOLD class >> extent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

{ #category : #drawing }
EzDrawingBoardOLD >> add: aDrawing [
	(self drawings includes: aDrawing) ifTrue: [ ^self ]. 
	self drawings add: aDrawing.	
	self draw: aDrawing.
	self imageHolder valueChanged
]

{ #category : #accessing }
EzDrawingBoardOLD >> backgroundColor [
	^backgroundColor
]

{ #category : #drawing }
EzDrawingBoardOLD >> backgroundColor: aColor [ 
	backgroundColor := aColor.
	self updateDisplay.
]

{ #category : #accessing }
EzDrawingBoardOLD >> canvas [
	^self image getCanvas
]

{ #category : #initialization }
EzDrawingBoardOLD >> defaultBackgroundColor [
	^Color white
]

{ #category : #initialization }
EzDrawingBoardOLD >> defaultExtent [
	^400@300
]

{ #category : #drawing }
EzDrawingBoardOLD >> draw: aDrawing [ 
	self draw: aDrawing with: self newBitBlt

]

{ #category : #drawing }
EzDrawingBoardOLD >> draw: aDrawing with: copier [
	^ copier
		copy: aDrawing currentBoundingBox
		from: 0 @ 0
		in: aDrawing currentForm
		fillColor: nil
		rule: 25
]

{ #category : #accessing }
EzDrawingBoardOLD >> drawings [
	^drawings
]

{ #category : #initialization }
EzDrawingBoardOLD >> extent: newExtent [
self flag: #'TODO: Use inherited extentHolder'.
	self image: (Form extent: newExtent depth: 8).
	self updateDisplay
]

{ #category : #api }
EzDrawingBoardOLD >> initialExtent [
	^self image extent
]

{ #category : #initialization }
EzDrawingBoardOLD >> initialize [
	super initialize.
	drawings := OrderedCollection new.
	self backgroundColor: self defaultBackgroundColor.
	self extent: self defaultExtent.

]

{ #category : #drawing }
EzDrawingBoardOLD >> newBitBlt [
	^ BitBlt toForm: self image
]

{ #category : #'creating drawings' }
EzDrawingBoardOLD >> newCircleDiameter: diameterInt fillColor: aColor [
	^self newEllipseExtent: diameterInt @ diameterInt fillColor: aColor
]

{ #category : #'creating drawings' }
EzDrawingBoardOLD >> newCircleDiameter: diameterInt fillColor: fillColor frameColor: frameColor arrowColor: arrowColor [
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
EzDrawingBoardOLD >> newDrawingExtent: aPoint [ 
	^(EzDrawing extent: aPoint)
		board: self;
		yourself
]

{ #category : #'creating drawings' }
EzDrawingBoardOLD >> newEllipseExtent: aPoint fillColor: aColor [
	^(self newDrawingExtent: aPoint)
		ellipseFillColor: aColor;
		yourself
]

{ #category : #'creating drawings' }
EzDrawingBoardOLD >> newLine: startPoint to: endPoint width: width color: aColor [
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
EzDrawingBoardOLD >> newRectangleExtent: aPoint fillColor: aColor [
	^(self newDrawingExtent: aPoint)
		rectangleFillColor: aColor;
		yourself
]

{ #category : #'creating drawings' }
EzDrawingBoardOLD >> newSquareLength: lengthInt fillColor: aColor [
	^self newRectangleExtent: lengthInt @ lengthInt fillColor: aColor
]

{ #category : #drawing }
EzDrawingBoardOLD >> remove: aDrawing [
	self drawings remove: aDrawing ifAbsent: [^self].	
	self updateDisplay
	
]

{ #category : #drawing }
EzDrawingBoardOLD >> updateDisplay [
	| copier |
	self image ifNil: [ ^self ].
	self canvas fillColor: self backgroundColor.
	copier := self newBitBlt.
	drawings do: [ :aDrawing | self draw: aDrawing with: copier ].
	self imageHolder valueChanged
]
