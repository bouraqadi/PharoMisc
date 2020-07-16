Class {
	#name : #EzDrawingBoard,
	#superclass : #SpAthensStaticPresenter,
	#traits : 'EzTDrawingContainer',
	#classTraits : 'EzTDrawingContainer classTrait',
	#instVars : [
		'backgroundPaint'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #examples }
EzDrawingBoard class >> botFleet [
	<example>
	| board |
	board := self surfaceExtent: 800 @ 600.
	{ Color green -> (200@200). 
	Color cyan -> (600@300). 
	Color magenta  -> (300@400)} asDictionary keysAndValuesDo: [: color : origin |
		|bot|
		bot := EzTurtleBot new.
		bot fillColor: color.
		bot origin: origin.
		board add: bot.
	].
	board openWithSpec
]

{ #category : #examples }
EzDrawingBoard class >> landscape [
	<example>
	| sceneWidth sceneHeight board grass sunBackground sunRadius sunRays sun |
	sceneWidth := 800.
	sceneHeight := 600.
	board := self surfaceExtent: sceneWidth @ sceneHeight.
	board backgroundPaint: Color cyan.
	grass := EzBox
		rectangleOrigin: 0 @ (sceneHeight // 2)
		width: sceneWidth
		height: sceneHeight // 2.
	grass fillColor: Color green.
	grass borderWidth: 0.
	sunRadius := sceneHeight // 5.
	sunBackground := EzOval circleCenter: 0@0 radius: sunRadius.
	sunBackground fillColor: Color orange.
	sunBackground borderWidth: 0.
	sunRays := EzRays spanAngle: 360 radius: sunRadius raysCount: 288.
	sunRays color: Color yellow.
	sunRays width: 1.
	sun := EzCompositeDrawing withAll: { sunBackground. sunRays }.
	sun origin: 130 @ 130.
	board
		addAll:
			{grass.
			sun}.
	board openWithSpec
]

{ #category : #examples }
EzDrawingBoard class >> pacMan [
	<example>
	| board pacMan |
	board := self surfaceExtent: 800 @ 600.
	board backgroundPaint: Color cyan.
	50 to: 750 by: 50 do: [ :x | 
		50 to: 550 by: 50 do: [ :y | 
			| pebble |
			pebble := EzOval circleCenter: x @ y diameter: 20.
			pebble fillColor: Color magenta.
			board add: pebble. 
		]
	].
	pacMan := EzPacMan new.
	pacMan origin: 400 @ 300.
	board add: pacMan.
	board openWithSpec
]

{ #category : #'instance creation' }
EzDrawingBoard class >> surfaceExtent: extent [
	^self new
		surfaceExtent: extent;
		yourself
]

{ #category : #specs }
EzDrawingBoard class >> title [
	^'Easy UI Drawing Board'
]

{ #category : #accessing }
EzDrawingBoard >> backgroundPaint [
	^ backgroundPaint
]

{ #category : #accessing }
EzDrawingBoard >> backgroundPaint: anObject [
	backgroundPaint := anObject
]

{ #category : #initialization }
EzDrawingBoard >> defaultBackgroundPaint [
	^Color white
]

{ #category : #initialization }
EzDrawingBoard >> defaultSurfaceExtent [
	^800@600
]

{ #category : #initialization }
EzDrawingBoard >> initialExtent [
	^surfaceExtent + self windowDeltaExtent

]

{ #category : #initialization }
EzDrawingBoard >> initialize [
	super initialize.
	self initDrawings.
	self surfaceExtent: self defaultSurfaceExtent.
	self backgroundPaint: self defaultBackgroundPaint.
	self drawBlock: [ :canvas | self renderOn: canvas ]
]

{ #category : #rendering }
EzDrawingBoard >> redraw [
	self adapter changed
]

{ #category : #rendering }
EzDrawingBoard >> renderOn: canvas [
	canvas setShape: (0 @ 0 corner: self surfaceExtent).
	canvas setPaint: self backgroundPaint.
	canvas draw.
	self drawOn: canvas
]

{ #category : #initialization }
EzDrawingBoard >> windowBorderWidth [
	^5
]

{ #category : #initialization }
EzDrawingBoard >> windowDeltaExtent [
	^(self windowBorderWidth * 2)@(self windowBorderWidth + self windowTopHeight)
]

{ #category : #initialization }
EzDrawingBoard >> windowTopHeight [
	^28
]
