Class {
	#name : #EzDrawingAppOLD,
	#superclass : #ComposablePresenter,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #specs }
EzDrawingAppOLD class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		add: #container;
		yourself
]

{ #category : #'instance creation' }
EzDrawingAppOLD class >> openInWindow [
	<example>
	^self new
		openWithSpec;
		yourself
]

{ #category : #accessing }
EzDrawingAppOLD >> container [
	^ board
]

{ #category : #initialization }
EzDrawingAppOLD >> defaultBoardColor [
	^Color white
]

{ #category : #initialization }
EzDrawingAppOLD >> defaultBoardExtent [
	^800@600
]

{ #category : #accessing }
EzDrawingAppOLD >> defaultWindowModelClass [
	^EzWindowPresenterOLD
]

{ #category : #drawing }
EzDrawingAppOLD >> drawLine: startPoint to: endPoint width: width color: aColor [
	^board addLineFrom: startPoint to: endPoint width: width color: aColor.

]

{ #category : #api }
EzDrawingAppOLD >> initialExtent [
	^self container initialExtent
]

{ #category : #initialization }
EzDrawingAppOLD >> initializeWidgets [
	board := EzDrawingBoardOLD extent: self defaultBoardExtent.
	board backgroundColor: self defaultBoardColor.
]

{ #category : #accessing }
EzDrawingAppOLD >> isWindowResizable [
	^true
]

{ #category : #api }
EzDrawingAppOLD >> title [
	^self className
]
