Class {
	#name : #EzCompositeDrawing,
	#superclass : #EzDrawingOLD,
	#traits : 'EzTDrawingArea',
	#classTraits : 'EzTDrawingArea classTrait',
	#instVars : [
		'drawings'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #drawing }
EzCompositeDrawing >> drawOn: aCanvas [
	self drawings do: [ : each | each drawOn: aCanvas ]
]

{ #category : #accessing }
EzCompositeDrawing >> drawings [
	^drawings
]

{ #category : #initialization }
EzCompositeDrawing >> initialize [
	super initialize.
	drawings := OrderedCollection new.

]

{ #category : #drawing }
EzCompositeDrawing >> newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzOvalOLD board: self)
		center: center halfExtent: (xRadius @ yRadius);
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzCompositeDrawing >> newLineFrom: point1 to: point2 width: anInt color: aColor [
	^(EzPolyLine board: self)
		startPoint: point1; 
		endPoint: point2; 
		width: anInt;
		color: aColor;
		yourself

]
