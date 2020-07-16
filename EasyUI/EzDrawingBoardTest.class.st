Class {
	#name : #EzDrawingBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'board',
		'drawing'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #running }
EzDrawingBoardTest >> setUp [
	super setUp.
	board := EzDrawingBoard new.
	drawing := EzPolyLine from: 100@100 to: 700@500.

]

{ #category : #running }
EzDrawingBoardTest >> testAddingSeveralTimeTheSameDrawing [
	10 timesRepeat: [ board add: drawing ].
	self assert: board drawings asArray equals: {drawing}
]

{ #category : #running }
EzDrawingBoardTest >> testRemovingSeveralTimeTheSameDrawing [
	board add: drawing.
	board remove: drawing.
	self assert: board drawings isEmpty.
	10 timesRepeat: [ board remove: drawing ].
	self assert: board drawings isEmpty
]
