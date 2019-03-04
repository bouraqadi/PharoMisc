Class {
	#name : #EzDrawingBoard,
	#superclass : #ImagePresenter,
	#traits : 'EzTDrawingArea @ {#basicMoveToFront:->#moveToFront:. #basicMoveToBack:->#moveToBack:}',
	#classTraits : 'EzTDrawingArea classTrait',
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
EzDrawingBoard >> moveToBack: aDrawing [
	self basicMoveToBack: aDrawing.
	self updateDisplay 

]

{ #category : #drawing }
EzDrawingBoard >> moveToFront: aDrawing [
	self basicMoveToFront: aDrawing.
	self updateDisplay 

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
