Class {
	#name : #EzCompositeDrawingOLD,
	#superclass : #EzDrawingOLD,
	#traits : 'EzTDrawingAreaOLD',
	#classTraits : 'EzTDrawingAreaOLD classTrait',
	#instVars : [
		'drawings'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #drawing }
EzCompositeDrawingOLD >> drawOn: aCanvas [
	self drawings do: [ : each | each drawOn: aCanvas ]
]

{ #category : #accessing }
EzCompositeDrawingOLD >> drawings [
	^drawings
]

{ #category : #initialization }
EzCompositeDrawingOLD >> initialize [
	super initialize.
	drawings := OrderedCollection new.

]

{ #category : #drawing }
EzCompositeDrawingOLD >> newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzOvalOLD container: self)
		center: center halfExtent: (xRadius @ yRadius);
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzCompositeDrawingOLD >> newLineFrom: point1 to: point2 width: anInt color: aColor [
	^(EzPolyLine container: self)
		startPoint: point1; 
		endPoint: point2; 
		width: anInt;
		color: aColor;
		yourself

]

{ #category : #drawing }
EzCompositeDrawingOLD >> newPolygonVertices: vertices fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzPolygon container: self)
		vertices: vertices;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzCompositeDrawingOLD >> newRectangleOrigine: origin extent: extent fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzBox container: self)
		origin: origin extent: extent;
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzCompositeDrawingOLD >> newRobotAt: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor [
	| robot |
	robot := EzCompositeDrawingOLD container: self.
	robot addCircleCenter: center radius: radius fillColor: fillColor borderWidth: width borderColor: borderColor.
	robot addLineFrom: center to: center + (radius@0) width: width color: borderColor.
	^robot
]
