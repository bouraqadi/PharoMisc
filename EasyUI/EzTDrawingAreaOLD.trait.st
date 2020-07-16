Trait {
	#name : #EzTDrawingAreaOLD,
	#category : #'EasyUI-KernelOLD'
}

{ #category : #drawing }
EzTDrawingAreaOLD >> add: aDrawing [
	(self drawings includes: aDrawing)
		ifTrue: [ ^ self ].
	self drawings add: aDrawing.

]

{ #category : #drawing }
EzTDrawingAreaOLD >> addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzTDrawingAreaOLD >> addEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	| ellipse |
	ellipse := self newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: ellipse.
	^ellipse
]

{ #category : #drawing }
EzTDrawingAreaOLD >> addLineFrom: point1 to: point2 width: anInt color: aColor [
	| newLine |
	newLine := self newLineFrom: point1 to: point2 width: anInt color: aColor.
	self add: newLine.
	^newLine
]

{ #category : #drawing }
EzTDrawingAreaOLD >> addPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	| polygon |
	polygon := self newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor.
	self add: polygon.
	^polygon
]

{ #category : #drawing }
EzTDrawingAreaOLD >> addRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	| rectangle |
	rectangle := (self newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor).
	self add: rectangle.
	^rectangle
]

{ #category : #drawing }
EzTDrawingAreaOLD >> addRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	|robot|
	robot := self newRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor.
	self add: robot.
	^robot
]

{ #category : #drawing }
EzTDrawingAreaOLD >> addSquareOrigine: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self addRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #accessing }
EzTDrawingAreaOLD >> drawings [
	self explicitRequirement
]

{ #category : #drawing }
EzTDrawingAreaOLD >> moveToBack: aDrawing [
	self drawings 
		remove: aDrawing ifAbsent: [];
		addFirst: aDrawing.

]

{ #category : #drawing }
EzTDrawingAreaOLD >> moveToFront: aDrawing [
	self drawings 
		remove: aDrawing ifAbsent: [];
		addLast: aDrawing.

]

{ #category : #drawing }
EzTDrawingAreaOLD >> newCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newEllipseCenter: center xRadius: radius yRadius: radius fillColor:  fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzTDrawingAreaOLD >> newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzOvalOLD container: self)
		center: center halfExtent: (xRadius @ yRadius);
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzTDrawingAreaOLD >> newLineFrom: point1 to: point2 width: anInt color: aColor [
	^(EzPolyLine container: self)
		startPoint: point1; 
		endPoint: point2; 
		width: anInt;
		color: aColor;
		yourself

]

{ #category : #drawing }
EzTDrawingAreaOLD >> newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzPolygon container: self)
		vertices: vertices;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzTDrawingAreaOLD >> newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzBox container: self)
		origin: origin extent: extent;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzTDrawingAreaOLD >> newRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	| robot |
	robot := EzCompositeDrawingOLD container: self.
	robot addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor.
	robot addLineFrom: center to: center + (radius@0) width: width color: borderColor.
	^robot
]

{ #category : #drawing }
EzTDrawingAreaOLD >> newSquareOrigin: origin length: length fillColor: fillColor borderWidth: width borderColor: bColor [
	^self newRectangleOrigine: origin extent: length@length fillColor: fillColor borderWidth: width borderColor: bColor
]

{ #category : #drawing }
EzTDrawingAreaOLD >> remove: aDrawing [
	self drawings remove: aDrawing ifAbsent: [^self].	

]
