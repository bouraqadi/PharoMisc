Class {
	#name : #EzDrawingApp,
	#superclass : #ComposablePresenter,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #specs }
EzDrawingApp class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		add: #board;
		yourself
]

{ #category : #accessing }
EzDrawingApp >> board [
	^ board
]

{ #category : #initialization }
EzDrawingApp >> defaultBoardColor [
	^Color white
]

{ #category : #initialization }
EzDrawingApp >> defaultBoardExtent [
	^800@600
]

{ #category : #accessing }
EzDrawingApp >> defaultWindowModelClass [
	^EzWindowPresenter
]

{ #category : #api }
EzDrawingApp >> initialExtent [
	^self board initialExtent
]

{ #category : #initialization }
EzDrawingApp >> initializeWidgets [
	board := EzDrawingBoardPresenter extent: self defaultBoardExtent.
	board backgroundColor: self defaultBoardColor.
]

{ #category : #accessing }
EzDrawingApp >> isWindowResizable [
	^true
]

{ #category : #api }
EzDrawingApp >> title [
	^self className
]
