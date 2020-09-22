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

{ #category : #initialization }
EzRotatingPacmanApp >> initialize [
	| pacman |
	super initialize.
	board backgroundPaint: Color cyan.
	50 to: 750 by: 50 do: [ :x | 
		50 to: 550 by: 50 do: [ :y | 
			| pebble |
			pebble := EzOval circleCenter: x @ y diameter: 20.
			pebble fillColor: Color magenta.
			board add: pebble. 
		]
	].
	pacman := EzPacManSprite new.
	pacman origin: 400 @ 300.
	board add: pacman.
	board bindKeyCombination: Character arrowLeft asKeyCombination toAction: [ pacman lookLeft ].
	board bindKeyCombination: Character arrowRight asKeyCombination toAction: [ pacman lookRight ].
	board bindKeyCombination: Character arrowUp asKeyCombination toAction: [ pacman lookUp ].
	board bindKeyCombination: Character arrowDown asKeyCombination toAction: [ pacman lookDown ].

]

{ #category : #'window handling' }
EzRotatingPacmanApp >> title [
	^'Rotating Pacman (All four arrows)'
]
