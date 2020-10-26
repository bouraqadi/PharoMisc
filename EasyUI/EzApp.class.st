Class {
	#name : #EzApp,
	#superclass : #Object,
	#instVars : [
		'drawingBoard',
		'windowPresenter',
		'title'
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
	windowPresenter ifNil: [ ^self ].
	windowPresenter close
]

{ #category : #'window handling' }
EzApp >> defaultTitle [
	^self className
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
	drawingBoard := EzDrawingBoard surfaceExtent: self drawingBoardExtent.
	title := self defaultTitle.
]

{ #category : #'window handling' }
EzApp >> openWindow [
	windowPresenter ifNotNil: [ self closeWindow ].
	windowPresenter := drawingBoard openWithSpec.
	windowPresenter title: self title.
	self window beUnresizeable.
]

{ #category : #accessing }
EzApp >> title [
	^ title
]

{ #category : #accessing }
EzApp >> title: aString [
	title := aString.
	self windowPresenter ifNil: [ ^self ].
	self windowPresenter title: aString.
]

{ #category : #accessing }
EzApp >> window [
	^self windowPresenter window
]

{ #category : #'window handling' }
EzApp >> windowPosition [
	^self window position
]

{ #category : #'window handling' }
EzApp >> windowPosition: aPoint [
	self window position: aPoint.
]

{ #category : #'window handling' }
EzApp >> windowPresenter [
	^windowPresenter
]
