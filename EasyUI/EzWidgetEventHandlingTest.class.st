Class {
	#name : #EzWidgetEventHandlingTest,
	#superclass : #EzWidgetTest,
	#category : #'EasyUI-TestsOLD'
}

{ #category : #tests }
EzWidgetEventHandlingTest >> keyboardEventType: eventType char: char [
	| event modifierButtons |
	event := KeyboardEvent new.
	modifierButtons := char isLowercase ifTrue: [ 0 ] ifFalse: [ 8 ].
	event
		setType: eventType
		buttons: modifierButtons
		position: nil
		keyValue: nil
		charCode: char asLowercase asciiValue
		hand: nil
		stamp: nil.
	^event
]

{ #category : #tests }
EzWidgetEventHandlingTest >> sendKeyDownEventToWidget: char [
	| event |
	event := self keyboardEventType: #keyStroke char: char.
	window rootMorph keyStroke: event
]

{ #category : #tests }
EzWidgetEventHandlingTest >> sendKeyUpEventToWidget: char [
	| event |
	event := self keyboardEventType: #keyUp char: char.
	window rootMorph 
		keyCombination: event asKeyCombination;
		keyUp: event
]

{ #category : #tests }
EzWidgetEventHandlingTest >> testKeyDownEventHandling [
	| count |
	count := 0.
	widget onKeyDown: $a do: [ count := count + 1 ].
	1 to: 10 do: [: expectedCount |
		self sendKeyDownEventToWidget: $a.
		self assert: count equals: expectedCount].
	10 timesRepeat: [
		self sendKeyUpEventToWidget: $a.
		self assert: count equals: 10].
	10 timesRepeat: [
		self sendKeyDownEventToWidget: $z.
		self sendKeyDownEventToWidget: $A.
		self assert: count equals: 10].

]

{ #category : #tests }
EzWidgetEventHandlingTest >> testKeyUpEventHandling [
	| count |
	count := 0.
	widget onKeyUp: $a do: [ count := count + 1 ].
	1 to: 10 do: [: expectedCount |
		self sendKeyUpEventToWidget: $a.
		self assert: count equals: expectedCount].
	10 timesRepeat: [
		self sendKeyDownEventToWidget: $a.
		self assert: count equals: 10].
	10 timesRepeat: [
		self sendKeyUpEventToWidget: $z.
		self sendKeyUpEventToWidget: $A.
		self assert: count equals: 10].

]
