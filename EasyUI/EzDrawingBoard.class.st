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

{ #category : #examples }
EzDrawingBoard class >> landscape [
	<example>
	| sceneWidth sceneHeight board grass sun sunCenter sunRadius rays |
	sceneWidth := 800.
	sceneHeight := 600.
	board := self extent: sceneWidth @ sceneHeight.
	board fillColor: Color cyan.
	grass := EzBox
		rectangleOrigin: 0 @ (sceneHeight // 2)
		width: sceneWidth
		height: sceneHeight // 2.
	grass fillColor: Color green.
	grass borderWidth: 0.
	sunCenter := 150 @ 150.
	sunRadius := sceneHeight // 5.
	sun := EzOval circleCenter: sunCenter radius: sunRadius.
	sun fillColor: Color orange.
	sun borderWidth: 0.
	rays := EzRays raysCount: 288 spanAngle: 360 radius: sunRadius.
	rays center: sunCenter.
	rays color: Color yellow.
	rays width: 1.
	board addAll: {grass. sun. rays.}.
	board openWithSpec.

]

{ #category : #specs }
EzDrawingBoard class >> title [
	^'Easy UI Drawing Board'
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

{ #category : #accessing }
EzDrawingBoard >> fillColor [
	^ fillColor
]

{ #category : #accessing }
EzDrawingBoard >> fillColor: anObject [
	fillColor := anObject
]

{ #category : #initialization }
EzDrawingBoard >> initialExtent [
	^surfaceExtent

]

{ #category : #initialization }
EzDrawingBoard >> initialize [
	super initialize.
	self surfaceExtent: self defaultSurfaceExtent.
	self fillColor: self defaultFillColor.
	drawings := OrderedCollection new.
	self drawBlock: [ :canvas | self renderOn: canvas ]
]

{ #category : #drawing }
EzDrawingBoard >> redraw [
	self adapter changed
]

{ #category : #initialization }
EzDrawingBoard >> renderOn: canvas [
	canvas setShape: (0 @ 0 corner: self surfaceExtent).
	canvas setPaint: self fillColor.
	canvas draw.
	drawings do: [ :each | each renderOn: canvas]
]
