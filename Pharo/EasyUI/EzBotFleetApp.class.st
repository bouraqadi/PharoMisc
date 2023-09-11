Class {
	#name : #EzBotFleetApp,
	#superclass : #EzApp,
	#traits : 'EzTDemoApp',
	#classTraits : 'EzTDemoApp classTrait',
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #initialization }
EzBotFleetApp >> defaultTitle [
	^'Bots Moving Around (Spacebar)'
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
		drawingBoard add: bot.
	].
	pathRadius := 20.
	drawingBoard 
		bindKeyCombination: Character space asKeyCombination 
		toAction: [
			drawingBoard drawings do: [: each | 
				delta := (pathRadius * each angle degreeCos) @ (pathRadius * each angle degreeSin).
				each origin: each origin + delta.
				each angle: each angle + 10.
			]
		].

]
