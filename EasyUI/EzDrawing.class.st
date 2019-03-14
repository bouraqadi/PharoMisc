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
	self view add: aShape.
	self updateDisplay.
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
EzDrawing >> addRectangleCenter: center extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	| rectangle |
	rectangle := (self newRectangleCenter: center extent: extent fillColor: fillColor borderWidth: width borderColor: bColor).
	self add: rectangle.
	^rectangle
]

{ #category : #drawing }
EzDrawing >> addRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	| robot |
	robot := TSGroup new.
	robot add: (self addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor).
	robot add: (self addLineFrom: center to: center + (radius@0) width: width color: borderColor).
	^robot
]

{ #category : #drawing }
EzDrawing >> addSquareCenter: center length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addRectangleCenter: center extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
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

{ #category : #accessing }
EzDrawing >> defaultWindowModelClass [
	^EzWindowPresenter
]

{ #category : #initialization }
EzDrawing >> initialExtent [
	^800@600
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
	^false
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
	| border roassalShape |
	border := self newBorder: borderWidth color: borderColor.
	roassalShape := RSShapeBuilder ellipse
		position: center;
		radius: (xRadius @ yRadius);
		color: fillColor;
		border: border;
		element.
	^EzShape roassalShape: roassalShape presenter: self
]

{ #category : #drawing }
EzDrawing >> newLineFrom: point1 to: point2 width: anInt color: aColor [
	| roassalShape |
	roassalShape := RSEdgeBuilder line
		from: point1; 
		to: point2; 
		width: anInt;
		color: aColor;
		capRound;
		edge.
	^EzShape roassalShape: roassalShape presenter: self
]

{ #category : #drawing }
EzDrawing >> newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	self error: #todo
]

{ #category : #drawing }
EzDrawing >> newRectangleCenter: center extent: extent fillColor: fillColor borderWidth: borderWidth borderColor: borderColor [
	| border roassalShape |
	border := self newBorder: borderWidth color: borderColor.
	roassalShape := RSShapeBuilder rectangle
		position: center;
		extent: extent ;
		color: fillColor;
		border: border;
		element.
	^EzShape roassalShape: roassalShape presenter: self
]

{ #category : #drawing }
EzDrawing >> newSquareCenter: center length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newRectangleCenter: center extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #api }
EzDrawing >> title [
	^self className
]

{ #category : #drawing }
EzDrawing >> updateDisplay [
	self view signalUpdate
]

{ #category : #accessing }
EzDrawing >> view [
	^ view
]

{ #category : #accessing }
EzDrawing >> viewAdapter [
	^self morph asSpecAdapter
]
