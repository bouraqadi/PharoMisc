Class {
	#name : #EzDrawing,
	#superclass : #ComposablePresenter,
	#instVars : [
		'view',
		'morph'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #specs }
EzDrawing class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		add: #viewAdapter;
		yourself
]

{ #category : #'instance creation' }
EzDrawing class >> openInWindow [
	<example>
	^self new
		openWithSpec;
		yourself
]

{ #category : #drawing }
EzDrawing >> add: aShape [
	self view 
		add: aShape;
		signalUpdate.
]

{ #category : #drawing }
EzDrawing >> addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzDrawing >> addEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	| ellipse |
	ellipse := self newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: ellipse.
	^ellipse
]

{ #category : #drawing }
EzDrawing >> addLineFrom: point1 to: point2 width: anInt color: aColor [
	| newLine |
	newLine := self newLineFrom: point1 to: point2 width: anInt color: aColor.
	self add: newLine.
	^newLine
]

{ #category : #drawing }
EzDrawing >> addPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	| polygon |
	polygon := self newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: polygon.
	^polygon
]

{ #category : #drawing }
EzDrawing >> addRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	| rectangle |
	rectangle := (self newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor).
	self add: rectangle.
	^rectangle
]

{ #category : #drawing }
EzDrawing >> addRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	|robot|
	robot := self newRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor.
	self add: robot.
	^robot
]

{ #category : #drawing }
EzDrawing >> addSquareOrigine: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #accessing }
EzDrawing >> backgroundColor: aColor [
	self canvas 
		color: aColor;
		signalUpdate
]

{ #category : #accessing }
EzDrawing >> canvas [
	^ self view canvas
]

{ #category : #initialization }
EzDrawing >> defaultBoardColor [
	^Color white
]

{ #category : #initialization }
EzDrawing >> defaultBoardExtent [
	^800@600
]

{ #category : #accessing }
EzDrawing >> defaultWindowModelClass [
	^EzWindowPresenter
]

{ #category : #api }
EzDrawing >> initialExtent [
	^600@400
]

{ #category : #initialization }
EzDrawing >> initializeWidgets [
	view := RSView new.
	extentHolder whenChangedDo: [ : newExtent | self morph extent: newExtent].
	self backgroundColor: self defaultBoardColor.
	self extent: self initialExtent.
]

{ #category : #accessing }
EzDrawing >> isWindowResizable [
	^true
]

{ #category : #accessing }
EzDrawing >> morph [
	^morph ifNil: [ morph := self canvas morph]
]

{ #category : #drawing }
EzDrawing >> newBorder: width color: color [
	^TSBorder new
		width: width;
		color: color;
		yourself
]

{ #category : #drawing }
EzDrawing >> newCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzDrawing >> newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: borderWidth borderColor: borderColor [
	| border |
	border := self newBorder: borderWidth color: borderColor.
	^RSShapeBuilder ellipse
		position: center;
		radius: (xRadius @ yRadius);
		color: fillColor;
		border: border;
		element
]

{ #category : #drawing }
EzDrawing >> newLineFrom: point1 to: point2 width: anInt color: aColor [
	^RSEdgeBuilder line
		from: point1; 
		to: point2; 
		width: anInt;
		color: aColor;
		edge
]

{ #category : #drawing }
EzDrawing >> newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzPolygon board: self)
		vertices: vertices;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzDrawing >> newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzBox board: self)
		origin: origin extent: extent;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzDrawing >> newRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	| robot |
	robot := EzCompositeDrawing board: self.
	robot addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor.
	robot addLineFrom: center to: center + (radius@0) width: width color: borderColor.
	^robot
]

{ #category : #drawing }
EzDrawing >> newSquareOrigine: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #api }
EzDrawing >> title [
	^self className
]

{ #category : #accessing }
EzDrawing >> view [
	^ view
]

{ #category : #accessing }
EzDrawing >> viewAdapter [
	^self morph asSpecAdapter
]
