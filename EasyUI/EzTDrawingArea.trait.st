Trait {
	#name : #EzTDrawingArea,
	#category : #'EasyUI-Kernel'
}

{ #category : #drawing }
EzTDrawingArea >> add: aDrawing [
	(self drawings includes: aDrawing)
		ifTrue: [ ^ self ].
	self drawings add: aDrawing.

]

{ #category : #drawing }
EzTDrawingArea >> addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzTDrawingArea >> addEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	| ellipse |
	ellipse := self newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: ellipse.
	^ellipse
]

{ #category : #drawing }
EzTDrawingArea >> addLineFrom: point1 to: point2 width: anInt color: aColor [
	| newLine |
	newLine := self newLineFrom: point1 to: point2 width: anInt color: aColor.
	self add: newLine.
	^newLine
]

{ #category : #drawing }
EzTDrawingArea >> addPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	| polygon |
	polygon := self newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: polygon.
	^polygon
]

{ #category : #drawing }
EzTDrawingArea >> addRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	| rectangle |
	rectangle := (self newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor).
	self add: rectangle.
	^rectangle
]

{ #category : #drawing }
EzTDrawingArea >> addRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	|robot|
	robot := self newRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor.
	self add: robot
]

{ #category : #drawing }
EzTDrawingArea >> addSquareOrigine: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #accessing }
EzTDrawingArea >> drawings [
	self explicitRequirement
]

{ #category : #drawing }
EzTDrawingArea >> moveToBack: aDrawing [
	self drawings 
		remove: aDrawing ifAbsent: [];
		addFirst: aDrawing.

]

{ #category : #drawing }
EzTDrawingArea >> moveToFront: aDrawing [
	self drawings 
		remove: aDrawing ifAbsent: [];
		addLast: aDrawing.

]

{ #category : #drawing }
EzTDrawingArea >> newCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzTDrawingArea >> newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzOval board: self)
		center: center halfExtent: (xRadius @ yRadius);
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzTDrawingArea >> newLineFrom: point1 to: point2 width: anInt color: aColor [
	^(EzLine board: self)
		startPoint: point1; 
		endPoint: point2; 
		width: anInt;
		color: aColor;
		yourself

]

{ #category : #drawing }
EzTDrawingArea >> newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzPolygon board: self)
		vertices: vertices;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzTDrawingArea >> newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzBox board: self)
		origin: origin extent: extent;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzTDrawingArea >> newRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	| robot |
	robot := EzCompositeDrawing board: self.
	robot addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor.
	robot addLineFrom: center to: center + (radius@0) width: width color: borderColor.
	^robot
]

{ #category : #drawing }
EzTDrawingArea >> newSquareOrigine: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzTDrawingArea >> remove: aDrawing [
	self drawings remove: aDrawing ifAbsent: [^self].	

]
