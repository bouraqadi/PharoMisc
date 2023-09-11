Class {
	#name : #EzPacmanMovingApp,
	#superclass : #EzApp,
	#traits : 'EzTDemoApp',
	#classTraits : 'EzTDemoApp classTrait',
	#instVars : [
		'grass',
		'pacman'
	],
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #'window handling' }
EzPacmanMovingApp >> defaultTitle [

	^ 'Move Pacman: left/right arrows - Jump: Shift'
]

{ #category : #actions }
EzPacmanMovingApp >> downDelta [

	pacman origin y < self initialY ifFalse: [ ^ 0 @ 0 ].
	^ self jumpDelta
]

{ #category : #initialization }
EzPacmanMovingApp >> initGrass [

	| sceneHeight height |
	sceneHeight := drawingBoard height.
	height := 100.
	grass := EzBox
		         rectangleCorner: 0 @ (sceneHeight - height)
		         width: drawingBoard width
		         height: height.
	grass fillColor: Color green.
	grass borderWidth: 0
]

{ #category : #actions }
EzPacmanMovingApp >> initialY [

	^ grass origin y - 150
]

{ #category : #initialization }
EzPacmanMovingApp >> initialize [

	| leftArrow shiftLeftArrow rightArrow shiftRightArrow shiftLeftOrRightArrow |
	super initialize.
	drawingBoard backgroundPaint: Color cyan.
	self initGrass.
	pacman := EzPacManSprite new.
	pacman origin: 400 @ self initialY.
	drawingBoard addAll: { 
			grass.
			pacman }.
	leftArrow := Character arrowLeft asKeyCombination.
	rightArrow := Character arrowRight asKeyCombination.
	drawingBoard
		bindKeyCombination: leftArrow
		toAction: [ self moveLeft ].
	drawingBoard
		bindKeyCombination: rightArrow
		toAction: [ self moveRight ].
	shiftLeftArrow := leftArrow modifiedBy: KMModifier shift.
	shiftRightArrow := rightArrow modifiedBy: KMModifier shift.

	shiftLeftOrRightArrow := KMKeyCombinationChoice withShortcuts: { shiftLeftArrow . shiftRightArrow}.
	drawingBoard
		bindKeyCombination: shiftLeftOrRightArrow
		toAction: [ self jump ].

]

{ #category : #actions }
EzPacmanMovingApp >> jump [

	pacman origin y > self minY ifFalse: [ ^ self ].
	pacman origin: pacman origin - self jumpDelta
]

{ #category : #actions }
EzPacmanMovingApp >> jumpDelta [

	^ 0 @ 10
]

{ #category : #actions }
EzPacmanMovingApp >> minY [

	^ 50
]

{ #category : #actions }
EzPacmanMovingApp >> moveLeft [

	| stepLeftDelta |
	pacman lookLeft.
	stepLeftDelta := self stepDownDelta x negated @ self stepDownDelta y.
	pacman origin: pacman origin + stepLeftDelta
]

{ #category : #actions }
EzPacmanMovingApp >> moveRight [

	pacman lookRight.
	pacman origin: pacman origin + self stepDownDelta
]

{ #category : #actions }
EzPacmanMovingApp >> stepDelta [
	^10 @ 0
]

{ #category : #actions }
EzPacmanMovingApp >> stepDownDelta [

	^ self stepDelta + self downDelta 
]
