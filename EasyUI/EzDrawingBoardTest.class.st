Class {
	#name : #EzDrawingBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #running }
EzDrawingBoardTest >> setUp [
	super setUp.
	board := EzDrawingBoardOLD new.
]

{ #category : #running }
EzDrawingBoardTest >> testAddingSeveralTimeTheSameDrawing [
	| drawing |
	drawing := board newLineFrom: 100@100 to: 700@500 width: 10 color: Color red.
	10 timesRepeat: [ board add: drawing ].
	self assert: board drawings asArray equals: {drawing}
]

{ #category : #running }
EzDrawingBoardTest >> testRemovingSeveralTimeTheSameDrawing [
	| drawing |
	drawing := board newLineFrom: 100@100 to: 700@500 width: 10 color: Color red.
	board add: drawing.
	board remove: drawing.
	self assert: board drawings isEmpty.
	10 timesRepeat: [ board remove: drawing ].
	self assert: board drawings isEmpty
]
