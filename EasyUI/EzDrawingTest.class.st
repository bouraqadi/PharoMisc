Class {
	#name : #EzDrawingTest,
	#superclass : #TestCase,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #running }
EzDrawingTest >> setUp [
	super setUp.
	board := EzDrawingBoard new.
]

{ #category : #running }
EzDrawingTest >> testAddingSeveralTimeTheSameDrawing [
	| drawing |
	drawing := board newLineFrom: 100@100 to: 700@500 width: 10 color: Color red.
	10 timesRepeat: [ board add: drawing ].
	self assert: board drawings asArray equals: {drawing}
]

{ #category : #running }
EzDrawingTest >> testRemovingSeveralTimeTheSameDrawing [
	| drawing |
	drawing := board newLineFrom: 100@100 to: 700@500 width: 10 color: Color red.
	board add: drawing.
	board remove: drawing.
	self assert: board drawings isEmpty.
	10 timesRepeat: [ board remove: drawing ].
	self assert: board drawings isEmpty
]

{ #category : #running }
EzDrawingTest >> testRotateHorizontalLine [
	| line start0 end0 |
	start0 := 100@100.
	end0 := 200@100.
	line := board newLineFrom: start0 to: end0 width: 10 color: Color red.
	line rotateBy: 90 about: start0.
	self assert: line angle equals: 90.
	self assert: line startPoint equals: start0.
	self assert: line endPoint equals: 100@ -100.
	line rotateBy: 90 about: start0.
	self assert: line angle equals: 180.
	self assert: line startPoint equals: start0.
	self assert: line endPoint equals: -100@ 100.
	line rotateBy: 90 about: start0.
	self assert: line angle equals: 270.
	self assert: line startPoint equals: start0.
	self assert: line endPoint equals: 100@ 200.
	line rotateBy: 90 about: start0.
	self assert: line angle equals: 0.
	self assert: line startPoint equals: start0.
	self assert: line endPoint equals: end0.

]
