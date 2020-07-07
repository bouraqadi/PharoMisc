Class {
	#name : #EzDrawingBoardOLD,
	#superclass : #ImagePresenter,
	#traits : 'EzTDrawingArea @ {#basicMoveToFront:->#moveToFront:. #basicMoveToBack:->#moveToBack:. #basicRemove:->#remove:}',
	#classTraits : 'EzTDrawingArea classTrait',
	#instVars : [
		'backgroundColor',
		'drawings'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #'instance creation' }
EzDrawingBoardOLD class >> extent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

{ #category : #drawing }
EzDrawingBoardOLD >> add: aDrawing [
	(self drawings includes: aDrawing)
		ifTrue: [ ^ self ].
	self drawings add: aDrawing.
	aDrawing draw.
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

{ #category : #drawing }
EzDrawingBoardOLD >> basicAdd: aDrawing [
	(self drawings includes: aDrawing)
		ifTrue: [ ^ self ].
	self drawings add: aDrawing.

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
EzDrawingBoardOLD >> moveToBack: aDrawing [
	self basicMoveToBack: aDrawing.
	self updateDisplay 

]

{ #category : #drawing }
EzDrawingBoardOLD >> moveToFront: aDrawing [
	self basicMoveToFront: aDrawing.
	self updateDisplay 

]

{ #category : #drawing }
EzDrawingBoardOLD >> newEllipseCenter: center xRadius: xRadius yRadius: yRadius fillColor: fillColor borderWidth: width borderColor: bColor [
	^(EzOvalOLD board: self)
		center: center halfExtent: (xRadius @ yRadius);
		fillColor: fillColor;
		borderWidth: width;
		borderColor: bColor;
		yourself
]

{ #category : #drawing }
EzDrawingBoardOLD >> remove: aDrawing [
	self drawings remove: aDrawing ifAbsent: [^self].	
	self updateDisplay
	
]

{ #category : #drawing }
EzDrawingBoardOLD >> updateDisplay [
	self image ifNil: [ ^ self ].
	self canvas fillColor: self backgroundColor.
	drawings do: [ :aDrawing | aDrawing draw ].
	self imageHolder valueChanged
]
