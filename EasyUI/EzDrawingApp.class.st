Class {
	#name : #EzDrawingApp,
	#superclass : #SpApplication,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #initialization }
EzDrawingApp >> initialize [
	super initialize.
	board := EzDrawingBoard new.
]
