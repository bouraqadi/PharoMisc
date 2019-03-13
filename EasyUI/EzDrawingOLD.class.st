Class {
	#name : #EzDrawingOLD,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawingOLD class >> board: aDrawingBoard [
	^self new
		board: aDrawingBoard;
		yourself
]

{ #category : #accessing }
EzDrawingOLD >> board [
	^ board
]

{ #category : #accessing }
EzDrawingOLD >> board: anObject [
	board := anObject
]

{ #category : #accessing }
EzDrawingOLD >> canvas [
	^self board canvas
]

{ #category : #drawing }
EzDrawingOLD >> draw [
	self drawOn: self canvas
]

{ #category : #drawing }
EzDrawingOLD >> drawOn: aCanvas [
	self subclassResponsibility
]

{ #category : #displaying }
EzDrawingOLD >> hide [
	self board remove: self
]

{ #category : #displaying }
EzDrawingOLD >> moveToBack [
	self board moveToBack: self
]

{ #category : #displaying }
EzDrawingOLD >> moveToFront [
	self board moveToFront: self
]

{ #category : #displaying }
EzDrawingOLD >> show [
	self board add: self
]
