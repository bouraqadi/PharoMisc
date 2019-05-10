Class {
	#name : #LoCustomEventObserverTest,
	#superclass : #TestCase,
	#instVars : [
		'subject',
		'dispatcher'
	],
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoCustomEventObserverTest >> setUp [
	super setUp.
	subject := LoSubjectForTest new.

]

{ #category : #testing }
LoCustomEventObserverTest >> testEventData [
	| eventData newEvent |
	subject on: LoEvent1ForTest do: [: event | eventData := event data  ].
	newEvent := LoEvent1ForTest new.
	newEvent data: 123.
	subject dispatch: newEvent.
	self assert: eventData equals: newEvent data.
]

{ #category : #testing }
LoCustomEventObserverTest >> testEventInheritanceObserver [
	| eventCounter |
	eventCounter := 0.
	subject on: LoEvent2ForTest do: [eventCounter := eventCounter + 1  ].
	3 timesRepeat: [subject dispatch: LoEvent3ForTest new].
	self assert: eventCounter equals: 3.
]

{ #category : #testing }
LoCustomEventObserverTest >> testSingleEventObserver [
	| eventCounter |
	eventCounter := 0.
	subject on: LoEvent1ForTest do: [eventCounter := eventCounter + 1  ].
	3 timesRepeat: [subject dispatch: LoEvent1ForTest new].
	self assert: eventCounter equals: 3.
]

{ #category : #testing }
LoCustomEventObserverTest >> testTwoObserversForDifferentEvents [
	| counterA counterB |
	counterA := 0.
	subject on: LoEvent1ForTest do: [counterA := counterA + 1  ].
	counterB := 0.
	subject on: LoEvent2ForTest do: [counterB := counterB + 1  ].
	subject dispatch: LoEvent1ForTest new.
	self assert: counterA equals: 1.
	self assert: counterB equals: 0.
	2 timesRepeat: [subject dispatch: LoEvent2ForTest new].
	self assert: counterA equals: 1.
	self assert: counterB equals: 2.

]

{ #category : #testing }
LoCustomEventObserverTest >> testTwoObserversForSameEvent [
	| counterA counterB |
	counterA := 0.
	subject on: LoEvent1ForTest do: [counterA := counterA + 1  ].
	subject dispatch: LoEvent1ForTest new.
	counterB := 0.
	subject on: LoEvent1ForTest do: [counterB := counterB + 1  ].
	subject dispatch: LoEvent1ForTest new.
	self assert: counterA equals: 2.
	self assert: counterB equals: 1.

]

{ #category : #testing }
LoCustomEventObserverTest >> testUnsbscribingAnEventObserver [
	| eventCounter observer |
	eventCounter := 0.
	observer := subject on: LoEvent1ForTest do: [eventCounter := eventCounter + 1  ].
	subject unsubscribe: observer.
	3 timesRepeat: [subject dispatch: LoEvent1ForTest new].
	self assert: eventCounter equals: 0.
]
