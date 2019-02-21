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
	board := EzDrawingBoardPresenter new.
]

{ #category : #running }
EzDrawingBoardTest >> testAddingSeveralTimeTheSameDrawing [
	| drawing |
	drawing := EzDrawing new.
	10 timesRepeat: [board add: drawing].
	self assert: board drawings asArray equals: { drawing }.
]

{ #category : #running }
EzDrawingBoardTest >> testRemovingSeveralTimeTheSameDrawing [
	| drawing |
	drawing := EzDrawing new.
	board add: drawing.
	board remove: drawing.
	self assert: board drawings isEmpty.
	10 timesRepeat: [board remove: drawing].
	self assert: board drawings isEmpty.
]
