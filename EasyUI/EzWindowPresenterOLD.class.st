Class {
	#name : #EzWindowPresenterOLD,
	#superclass : #WindowPresenter,
	#category : #'EasyUI-KernelOLD'
}

{ #category : #initialization }
EzWindowPresenterOLD >> borderWidth [
	^5
]

{ #category : #initialization }
EzWindowPresenterOLD >> initialExtent [
	^super initialExtent + self windowDeltaExtent
]

{ #category : #initialization }
EzWindowPresenterOLD >> initialize [
	super initialize.
	isResizeable := nil.

]

{ #category : #initialization }
EzWindowPresenterOLD >> isResizeable [
	isResizeable ifNil: [isResizeable := self model isWindowResizable asValueHolder ].
	^super isResizeable
]

{ #category : #initialization }
EzWindowPresenterOLD >> topHeight [
	^28
]

{ #category : #initialization }
EzWindowPresenterOLD >> windowDeltaExtent [
	^(self borderWidth * 2)@(self borderWidth + self topHeight)
]
