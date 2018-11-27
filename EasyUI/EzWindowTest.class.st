Class {
	#name : #EzWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'window'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #tests }
EzWindowTest >> sendKeyDownEventToWindow: char [
	| event |
	event := KeyboardEvent new.
	event
		setType: #keyDown
		buttons: 2
		position: nil
		keyValue: nil
		charCode: char asciiValue
		hand: nil
		stamp: nil
]

{ #category : #running }
EzWindowTest >> setUp [
	super setUp.
	window := self windowClass openLabelled: self className.
	
]

{ #category : #running }
EzWindowTest >> tearDown [
	super tearDown.
	window close
	
]

{ #category : #tests }
EzWindowTest >> testColor [
	{Color red. Color green. Color blue. Color orange. Color black } do: [ : aColor |
		window backgroundColor: aColor.
		self assert: window backgroundColor equals: aColor.
		self assert: window rootMorph color equals: aColor.
	]
	 
]

{ #category : #tests }
EzWindowTest >> testKeyDownEventHandling [
	| count |
	count := 0.
	window onKeyDown: $a do: [ count := count + 1 ].
	1 to: 10 do: [: expectedCount |
		self sendKeyDownEventToWindow: $a.
		self assert: count equals: expectedCount].
	10 timesRepeat: [
		self sendKeyUpEventToWindow: $a.
		self assert: count equals: 10].
	10 timesRepeat: [
		self sendKeyDownEventToWindow: $z.
		self sendKeyDownEventToWindow: $A.
		self assert: count equals: 10].

]

{ #category : #running }
EzWindowTest >> windowClass [
	^EzWindow
]
