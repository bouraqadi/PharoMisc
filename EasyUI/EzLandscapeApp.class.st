Class {
	#name : #EzLandscapeApp,
	#superclass : #EzApp,
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #examples }
EzLandscapeApp class >> demo [
	<example>
	self newOpenWindow
]

{ #category : #initialization }
EzLandscapeApp >> initialize [
	| sceneHeight sceneWidth grass sunRadius sunBackground sunRays sun sunInitialOrigin delta |
	super initialize.
	sceneHeight := board height.
	sceneWidth := board width.
	board backgroundPaint: Color cyan.
	grass := EzBox
		rectangleCorner: 0 @ (sceneHeight // 2)
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
	sunInitialOrigin := (sceneWidth / 2) @ 130.
	sun origin: sunInitialOrigin.
	delta := 20@0.
	board 
		bindKeyCombination: Character arrowLeft asKeyCombination 
		toAction: [sun origin: sun origin - delta];
		bindKeyCombination: Character arrowRight asKeyCombination 
		toAction: [sun origin: sun origin + delta];
		bindKeyCombination: Character space asKeyCombination 
		toAction: [sun origin: sunInitialOrigin].
	board
		addAll:
			{sun.
			grass.
			}.

]

{ #category : #initialization }
EzLandscapeApp >> title [
	^'Mobile Sun in landscape (left/right arrows + Spacebar)'
]
