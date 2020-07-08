Class {
	#name : #EzDrawingBoard,
	#superclass : #SpAthensStaticPresenter,
	#instVars : [
		'drawings',
		'fillColor'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawingBoard class >> extent: extent [
	^self new
		surfaceExtent: extent;
		yourself
]

{ #category : #adding }
EzDrawingBoard >> add: aDrawing [
	drawings add: aDrawing.
	self redraw.
]

{ #category : #adding }
EzDrawingBoard >> addAll: newDrawings [
	drawings addAll: newDrawings.
	self redraw.
]

{ #category : #initialization }
EzDrawingBoard >> defaultFillColor [
	^Color white
]

{ #category : #initialization }
EzDrawingBoard >> defaultSurfaceExtent [
	^800@600
]

{ #category : #initialization }
EzDrawingBoard >> drawOn: canvas [
	canvas setShape: (0 @ 0 corner: self surfaceExtent).
	canvas setPaint: self fillColor.
	canvas draw.
	drawings do: [ :each | each drawOn: canvas]
]

{ #category : #accessing }
EzDrawingBoard >> fillColor [
	^ fillColor
]

{ #category : #accessing }
EzDrawingBoard >> fillColor: anObject [
	fillColor := anObject
]

{ #category : #initialization }
EzDrawingBoard >> initialize [
	super initialize.
	self surfaceExtent: self defaultSurfaceExtent.
	self fillColor: self defaultFillColor.
	drawings := OrderedCollection new.
	self drawBlock: [ :canvas | self drawOn: canvas ]
]

{ #category : #drawing }
EzDrawingBoard >> redraw [
	self adapter changed
]
