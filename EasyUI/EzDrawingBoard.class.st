Class {
	#name : #EzDrawingBoard,
	#superclass : #ImagePresenter,
	#instVars : [
		'backgroundColor',
		'drawings'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawingBoard class >> extent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

{ #category : #drawing }
EzDrawingBoard >> add: aDrawing [
	(self drawings includes: aDrawing)
		ifTrue: [ ^ self ].
	self drawings add: aDrawing.
	aDrawing draw.
	self imageHolder valueChanged
]

{ #category : #drawing }
EzDrawingBoard >> addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzDrawingBoard >> addEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	| ellipse |
	ellipse := self newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: ellipse.
	^ellipse
]

{ #category : #drawing }
EzDrawingBoard >> addLineFrom: point1 to: point2 width: anInt color: aColor [
	| newLine |
	newLine := self newLineFrom: point1 to: point2 width: anInt color: aColor.
	self add: newLine.
	^newLine
]

{ #category : #drawing }
EzDrawingBoard >> addPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	| polygon |
	polygon := self newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: polygon.
	^polygon
]

{ #category : #drawing }
EzDrawingBoard >> addRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	| rectangle |
	rectangle := (self newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor).
	self add: rectangle.
	^rectangle
]

{ #category : #drawing }
EzDrawingBoard >> addSquareOrigine: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #accessing }
EzDrawingBoard >> backgroundColor [
	^backgroundColor
]

{ #category : #drawing }
EzDrawingBoard >> backgroundColor: aColor [ 
	backgroundColor := aColor.
	self updateDisplay.
]

{ #category : #accessing }
EzDrawingBoard >> canvas [
	^self image getCanvas
]

{ #category : #initialization }
EzDrawingBoard >> defaultBackgroundColor [
	^Color white
]

{ #category : #initialization }
EzDrawingBoard >> defaultExtent [
	^400@300
]

{ #category : #accessing }
EzDrawingBoard >> drawings [
	^drawings
]

{ #category : #initialization }
EzDrawingBoard >> extent: newExtent [
self flag: #'TODO: Use inherited extentHolder'.
	self image: (Form extent: newExtent depth: 8).
	self updateDisplay
]

{ #category : #api }
EzDrawingBoard >> initialExtent [
	^self image extent
]

{ #category : #initialization }
EzDrawingBoard >> initialize [
	super initialize.
	drawings := OrderedCollection new.
	self backgroundColor: self defaultBackgroundColor.
	self extent: self defaultExtent.

]

{ #category : #drawing }
EzDrawingBoard >> newCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzDrawingBoard >> newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzOval board: self)
		center: center halfExtent: (xRadius @ yRadius);
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzDrawingBoard >> newLineFrom: point1 to: point2 width: anInt color: aColor [
	^(EzLine board: self)
		startPoint: point1; 
		endPoint: point2; 
		width: anInt;
		color: aColor;
		yourself

]

{ #category : #drawing }
EzDrawingBoard >> newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzPolygon board: self)
		vertices: vertices;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzDrawingBoard >> newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzBox board: self)
		origin: origin extent: extent;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzDrawingBoard >> newSquareOrigine: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzDrawingBoard >> remove: aDrawing [
	self drawings remove: aDrawing ifAbsent: [^self].	
	self updateDisplay
	
]

{ #category : #drawing }
EzDrawingBoard >> updateDisplay [
	self image ifNil: [ ^ self ].
	self canvas fillColor: self backgroundColor.
	drawings do: [ :aDrawing | aDrawing draw ].
	self imageHolder valueChanged
]
