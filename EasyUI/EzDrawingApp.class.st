Class {
	#name : #EzDrawingApp,
	#superclass : #ComposablePresenter,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #specs }
EzDrawingApp class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		add: #board;
		yourself
]

{ #category : #'instance creation' }
EzDrawingApp class >> openInWindow [
	<example>
	^self new
		openWithSpec;
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

{ #category : #drawing }
EzDrawingApp >> drawLine: startPoint to: endPoint width: width color: aColor [
	^board addLineFrom: startPoint to: endPoint width: width color: aColor.

]

{ #category : #api }
EzDrawingApp >> initialExtent [
	^self board initialExtent
]

{ #category : #initialization }
EzDrawingApp >> initializeWidgets [
	board := EzDrawingBoardOLD extent: self defaultBoardExtent.
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
