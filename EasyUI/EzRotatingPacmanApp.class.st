Class {
	#name : #EzRotatingPacmanApp,
	#superclass : #EzApp,
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #examples }
EzRotatingPacmanApp class >> demo [
	<example>
	self newOpenWindow
]

{ #category : #'window handling' }
EzRotatingPacmanApp >> defaultTitle [
	^'Rotating Pacman (All four arrows)'
]

{ #category : #initialization }
EzRotatingPacmanApp >> initialize [
	| pacman |
	super initialize.
	drawingBoard backgroundPaint: Color cyan.
	50 to: 750 by: 50 do: [ :x | 
		50 to: 550 by: 50 do: [ :y | 
			| pebble |
			pebble := EzOval circleCenter: x @ y diameter: 20.
			pebble fillColor: Color magenta.
			drawingBoard add: pebble. 
		]
	].
	pacman := EzPacManSprite new.
	pacman origin: 400 @ 300.
	drawingBoard add: pacman.
	drawingBoard bindKeyCombination: Character arrowLeft asKeyCombination toAction: [ pacman lookLeft ].
	drawingBoard bindKeyCombination: Character arrowRight asKeyCombination toAction: [ pacman lookRight ].
	drawingBoard bindKeyCombination: Character arrowUp asKeyCombination toAction: [ pacman lookUp ].
	drawingBoard bindKeyCombination: Character arrowDown asKeyCombination toAction: [ pacman lookDown ].

]
