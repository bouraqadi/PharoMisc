Class {
	#name : #EzKeyboardEventsExample,
	#superclass : #EzDrawingApp,
	#instVars : [
		'robot'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #examples }
EzKeyboardEventsExample class >> demoWindow [
	<example>
	^self new openWithSpec 
]

{ #category : #examples }
EzKeyboardEventsExample class >> demoWorld [
	<example>
	(self confirm: 'Are you shure to replace the world with this demo?') ifFalse: [^self].
	^self new openWorldWithSpec 
]

{ #category : #initialization }
EzKeyboardEventsExample >> defaultBoardColor [
	^Color paleBlue
]

{ #category : #initialization }
EzKeyboardEventsExample >> defaultBoardExtent [
	^800@600
]

{ #category : #initialization }
EzKeyboardEventsExample >> initializePresenter [
	| deltaX deltaY |
	super initializePresenter.
	self 
		bindKeyCombination: Character arrowLeft asKeyCombination 
		toAction: [robot angle:  robot angle + 15].
	self 
		bindKeyCombination: Character arrowRight asKeyCombination 
		toAction: [robot angle:  robot angle - 15].
	self 
		bindKeyCombination: Character arrowUp asKeyCombination 
		toAction: [
			deltaX := 10 * robot angle degreeCos.
			deltaY := -10 * robot angle degreeSin.
			robot center: robot center + (deltaX@deltaY)].
	self 
		bindKeyCombination: Character space asKeyCombination 
		toAction: [
			robot angle: 0.
			robot center: self robotInitialCenter].

	
]

{ #category : #initialization }
EzKeyboardEventsExample >> initializeWidgets [
	super initializeWidgets.
	robot := board addRobotAt: self robotInitialCenter radius: 20 fillColor: Color pink borderWidth: 4 borderColor: Color black.	

]

{ #category : #initialization }
EzKeyboardEventsExample >> robotInitialCenter [
	^self defaultBoardExtent // 2
]

{ #category : #api }
EzKeyboardEventsExample >> title [
	^'Easy UI Keyboard Events Example'
]
