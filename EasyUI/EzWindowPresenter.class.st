Class {
	#name : #EzWindowPresenter,
	#superclass : #WindowPresenter,
	#category : #'EasyUI-Kernel'
}

{ #category : #windowing }
EzWindowPresenter >> beTopWindow [
	self window beTopWindow.
]

{ #category : #initialization }
EzWindowPresenter >> borderWidth [
	^5
]

{ #category : #initialization }
EzWindowPresenter >> initialExtent [
	^super initialExtent + self windowDeltaExtent
]

{ #category : #initialization }
EzWindowPresenter >> initialize [
	super initialize.
	isResizeable := nil.

]

{ #category : #testing }
EzWindowPresenter >> isMinimized [
	^self window isMinimized
]

{ #category : #initialization }
EzWindowPresenter >> isResizeable [
	isResizeable ifNil: [isResizeable := self model isWindowResizable asValueHolder ].
	^super isResizeable
]

{ #category : #windowing }
EzWindowPresenter >> restore [
	self window restore.
]

{ #category : #initialization }
EzWindowPresenter >> topHeight [
	^28
]

{ #category : #initialization }
EzWindowPresenter >> windowDeltaExtent [
	^(self borderWidth * 2)@(self borderWidth + self topHeight)
]
