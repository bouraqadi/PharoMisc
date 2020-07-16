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
EzDrawingBoardTest >> testAddingSeveralTime2Drawings [
	| otherDrawing |
	otherDrawing := EzBox rectangleOrigin: 200@100 width: 20 height: 10.
	10 timesRepeat: [ board addAll: {drawing. otherDrawing} ].
	self assertCollection: board drawings asArray hasSameElements: {drawing. otherDrawing}.
	board drawings do: [ : each |  
		self assert: each container identicalTo: board].
]

{ #category : #running }
EzDrawingBoardTest >> testAddingSeveralTimeTheSameDrawing [
	10 timesRepeat: [ board add: drawing ].
	self assert: board drawings asArray equals: {drawing}.
	self assert: drawing container identicalTo: board.
]

{ #category : #running }
EzDrawingBoardTest >> testRemovingSeveralTimeTheSameDrawing [
	board add: drawing.
	board remove: drawing.
	self assert: board drawings isEmpty.
	10 timesRepeat: [ board remove: drawing ].
	self assert: board drawings isEmpty.
	self assert: drawing container isNil.
]
