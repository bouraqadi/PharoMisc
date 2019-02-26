Class {
	#name : #EzWindowPresenter,
	#superclass : #WindowPresenter,
	#category : #'EasyUI-Kernel'
}

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

{ #category : #initialization }
EzWindowPresenter >> isResizeable [
	isResizeable ifNil: [isResizeable := self model isWindowResizable asValueHolder ].
	^super isResizeable
]

{ #category : #initialization }
EzWindowPresenter >> topHeight [
	^28
]

{ #category : #initialization }
EzWindowPresenter >> windowDeltaExtent [
	^(self borderWidth * 2)@(self borderWidth + self topHeight)
]
