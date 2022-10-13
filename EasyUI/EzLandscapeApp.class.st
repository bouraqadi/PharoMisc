Class {
	#name : #EzLandscapeApp,
	#superclass : #EzApp,
	#traits : 'EzTDemoApp',
	#classTraits : 'EzTDemoApp classTrait',
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #initialization }
EzLandscapeApp >> defaultTitle [
	^'Mobile Sun in landscape (left/right arrows + Spacebar)'
]

{ #category : #initialization }
EzLandscapeApp >> initialize [
	| sceneHeight sceneWidth grass sunRadius sunBackground sunRays sun sunInitialOrigin delta |
	super initialize.
	sceneHeight := drawingBoard height.
	sceneWidth := drawingBoard width.
	drawingBoard backgroundPaint: Color cyan.
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
	drawingBoard 
		bindKeyCombination: Character arrowLeft asKeyCombination 
		toAction: [sun origin: sun origin - delta];
		bindKeyCombination: Character arrowRight asKeyCombination 
		toAction: [sun origin: sun origin + delta];
		bindKeyCombination: Character space asKeyCombination 
		toAction: [sun origin: sunInitialOrigin].
	drawingBoard
		addAll:
			{sun.
			grass.
			}.

]
