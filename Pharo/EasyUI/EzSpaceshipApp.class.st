Class {
	#name : #EzSpaceshipApp,
	#superclass : #EzApp,
	#traits : 'EzTDemoApp',
	#classTraits : 'EzTDemoApp classTrait',
	#instVars : [
		'spaceship'
	],
	#classVars : [
		'SpaceshipImage'
	],
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #'class initialization' }
EzSpaceshipApp class >> resetSpaceshipImage [
	<script>

	SpaceshipImage := nil
]

{ #category : #accessing }
EzSpaceshipApp >> basicSpaceshipImage [

	| spaceshipImagePath |
	spaceshipImagePath := self spaceShipFilePath.
	spaceshipImagePath exists ifFalse: [ ^ self spaceshipImageNotFound ].
	^ EzImageDrawing imageFromFilePath: spaceshipImagePath pathString
]

{ #category : #initialization }
EzSpaceshipApp >> defaultTitle [
	^ 'Flying Spaceship (Up arrow + Spacebar)'
]

{ #category : #initialization }
EzSpaceshipApp >> initGrass [
	| grass sceneHeight sceneWidth |
	sceneHeight := drawingBoard height.
	sceneWidth := drawingBoard width.
	grass := EzBox
		rectangleCorner: 0 @ (4 * sceneHeight // 5)
		width: sceneWidth
		height: sceneHeight // 5.
	grass fillColor: Color green.
	grass borderWidth: 0.
	^ grass
]

{ #category : #initialization }
EzSpaceshipApp >> initSpaceship [

	| rotationSpeed linearSpeed newAngle deltaX deltaY initialOrigin |
	spaceship := EzImageDrawing image: self spaceshipImage.
	initialOrigin := 50 @ 482.
	spaceship origin: initialOrigin.
	rotationSpeed := 2.
	linearSpeed := 15.
	drawingBoard
		bindKeyCombination: Character space asKeyCombination
		toAction: [
			spaceship
				angle: 0;
				origin: initialOrigin ].
	drawingBoard
		bindKeyCombination: Character arrowUp asKeyCombination
		toAction: [
			newAngle := spaceship angle + rotationSpeed min: 60.
			deltaX := (linearSpeed * newAngle degreeSin) rounded.
			deltaY := (linearSpeed * newAngle degreeCos) rounded * -1.
			spaceship angle: newAngle.
			spaceship origin: spaceship origin + (deltaX @ deltaY) ]
]

{ #category : #initialization }
EzSpaceshipApp >> initialize [
	| grass |
	super initialize.
	drawingBoard backgroundPaint: Color paleBlue .
	grass := self initGrass.
	self initSpaceship.
	drawingBoard
		addAll:
			{grass.
			spaceship}
]

{ #category : #accessing }
EzSpaceshipApp >> spaceShipFilePath [

	^ PmGitBridge resourcesFolder / 'EasyUI' / 'rocket-small.png'
]

{ #category : #accessing }
EzSpaceshipApp >> spaceshipImage [
	^SpaceshipImage ifNil: [ SpaceshipImage := self basicSpaceshipImage ] 
]

{ #category : #accessing }
EzSpaceshipApp >> spaceshipImageNotFound [

	self error: 'Could not find spaceship graphic file for ' , self className.
	
]
