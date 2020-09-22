Class {
	#name : #EzBotFleetApp,
	#superclass : #EzApp,
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #examples }
EzBotFleetApp class >> demo [
	<example>
	self newOpenWindow
]

{ #category : #initialization }
EzBotFleetApp >> initialize [
	| pathRadius delta |
	super initialize.
	{ Color green -> (200@100). 
	Color cyan -> (600@200). 
	Color magenta  -> (300@300)} asDictionary keysAndValuesDo: [: color : origin |
		|bot|
		bot := EzRoundBot new.
		bot fillColor: color.
		bot origin: origin.
		board add: bot.
	].
	pathRadius := 20.
	board 
		bindKeyCombination: Character space asKeyCombination 
		toAction: [
			board drawings do: [: each | 
				delta := (pathRadius * each angle degreeCos) @ (pathRadius * each angle degreeSin).
				each origin: each origin + delta.
				each angle: each angle + 10.
			]
		].

]

{ #category : #initialization }
EzBotFleetApp >> title [
	^'Bots Moving Around (Spacebar)'
]
