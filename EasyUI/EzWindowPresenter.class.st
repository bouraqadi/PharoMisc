Class {
	#name : #EzWindowPresenter,
	#superclass : #WindowPresenter,
	#category : #'EasyUI-Kernel'
}

{ #category : #api }
EzWindowPresenter >> initialExtent [
	^super initialExtent + (10@33)
]
