Class {
	#name : #EzDrawingBoard,
	#superclass : #SpAthensStaticPresenter,
	#instVars : [
		'drawings'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #adding }
EzDrawingBoard >> add: aDrawing [
	drawings add: aDrawing
]

{ #category : #initialization }
EzDrawingBoard >> defaultSurfaceExtent [
	^800@600
]

{ #category : #initialization }
EzDrawingBoard >> drawOn: canvas [
	canvas setShape: (0 @ 0 corner: self surfaceExtent).
	canvas setPaint: Color white.
	canvas draw.
	drawings do: [ :each | each drawOn: canvas]
]

{ #category : #initialization }
EzDrawingBoard >> initialize [
	super initialize.
	self surfaceExtent: self defaultSurfaceExtent.
	drawings := OrderedCollection new.
	self drawBlock: [ :canvas | self drawOn: canvas ]
]

{ #category : #drawing }
EzDrawingBoard >> redraw [
	self adapter changed
]
