Class {
	#name : #EzLandscapeApp,
	#superclass : #EzApp,
	#traits : 'EzTDemoApp',
	#classTraits : 'EzTDemoApp classTrait',
	#instVars : [
		'sunThread',
		'sun',
		'grass'
	],
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #private }
EzLandscapeApp >> closeWindow [
	super closeWindow.
	self stopSunThread
]

{ #category : #initialization }
EzLandscapeApp >> defaultTitle [

	^ 'Sunny Landscape (Spacebar toggles animation)'
]

{ #category : #initialization }
EzLandscapeApp >> initGrass [

	| sceneHeight  height|
	sceneHeight := drawingBoard height.
	height := sceneHeight // 3.
	grass := EzBox
		         rectangleCorner: 0 @ (sceneHeight  - height)
		         width: drawingBoard width
		         height: height.
	grass fillColor: Color green.
	grass borderWidth: 0
]

{ #category : #initialization }
EzLandscapeApp >> initSun [

	| sunRays sunBackground |
	sunBackground := EzOval circleCenter: 0 @ 0 radius: self sunRadius.
	sunBackground fillColor: Color orange.
	sunBackground borderWidth: 0.
	sunRays := EzRays
		           spanAngle: 360
		           radius: self sunRadius
		           raysCount: 288.
	sunRays color: Color yellow.
	sunRays width: 1.
	sun := EzCompositeDrawing withAll: { 
			       sunBackground.
			       sunRays }.
	sun origin: self sunRiseOrigin.
	20 timesRepeat: [ self updateSunPosition ]
]

{ #category : #initialization }
EzLandscapeApp >> initialize [

	super initialize.
	drawingBoard backgroundPaint: Color cyan.
	self initGrass.
	self initSun.
	drawingBoard
		bindKeyCombination: Character space asKeyCombination
		toAction: [ self toggleSunThread ].
	drawingBoard addAll: { 
			sun.
			grass }
]

{ #category : #activiy }
EzLandscapeApp >> startSunThread [

	sunThread := [ 
	             [ 
	             self sunThreadStep ] repeat ] forkAt:
		             Processor userBackgroundPriority
]

{ #category : #activiy }
EzLandscapeApp >> stopSunThread [

	sunThread terminate.
	sunThread := nil 
]

{ #category : #activiy }
EzLandscapeApp >> sunMaxOrigin [
	^drawingBoard width @ grass origin y
]

{ #category : #initialization }
EzLandscapeApp >> sunRadius [
	^drawingBoard height // 5
]

{ #category : #initialization }
EzLandscapeApp >> sunRiseOrigin [

	^ 0 @ (grass origin y + 20)
]

{ #category : #activiy }
EzLandscapeApp >> sunSpeed [

	^self sunSpeedUnit * 2
]

{ #category : #activiy }
EzLandscapeApp >> sunSpeedUnit [

	sun origin x < (drawingBoard width / 2) ifTrue: [ ^ 1 @ -1 ].
	^ 1 @ 1
]

{ #category : #activiy }
EzLandscapeApp >> sunThreadStep [

	self updateSunPosition.
	10 milliSeconds wait
]

{ #category : #activiy }
EzLandscapeApp >> toggleSunThread [
	sunThread ifNil: [ ^self startSunThread ].
	self stopSunThread
]

{ #category : #activiy }
EzLandscapeApp >> updateSunPosition [
	sun origin: sun origin + self sunSpeed.
	sun origin x < self sunMaxOrigin x ifTrue: [ ^self ].
	sun origin y > self sunMaxOrigin y ifTrue: [ ^sun origin: self sunRiseOrigin ]. 

]
