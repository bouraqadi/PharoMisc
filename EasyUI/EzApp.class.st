Class {
	#name : #EzApp,
	#superclass : #Object,
	#instVars : [
		'window',
		'drawingBoard'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzApp class >> newOpenWindow [
	^self new
		openWindow;
		yourself
]

{ #category : #'window handling' }
EzApp >> closeWindow [
	window close
]

{ #category : #accessing }
EzApp >> drawingBoard [
	^drawingBoard
]

{ #category : #initialization }
EzApp >> drawingBoardExtent [
	^ 800 @ 600
]

{ #category : #initialization }
EzApp >> initialize [
	super initialize.
	drawingBoard := EzDrawingBoard surfaceExtent: self drawingBoardExtent
]

{ #category : #'window handling' }
EzApp >> openWindow [
	window ifNotNil: [ self closeWindow ].
	window := drawingBoard openWithSpec.
	window title: self title.
]

{ #category : #'window handling' }
EzApp >> title [
	^self className
]

{ #category : #'window handling' }
EzApp >> window [
	^window
]

{ #category : #'window handling' }
EzApp >> windowPosition [
	^self window window position
]

{ #category : #'window handling' }
EzApp >> windowPosition: aPoint [
	self window window position: aPoint.
]
