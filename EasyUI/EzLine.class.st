Class {
	#name : #EzLine,
	#superclass : #EzDrawingOLD,
	#instVars : [
		'startPoint',
		'endPoint',
		'width',
		'color'
	],
	#category : #'EasyUI-DrawingsOLD'
}

{ #category : #interacting }
EzLine >> basicMoveTo: newPosition [
	| delta |
	delta := newPosition - self startPoint.
	startPoint := newPosition.
	endPoint := endPoint + delta.

]

{ #category : #accessing }
EzLine >> color [
	^ color
]

{ #category : #accessing }
EzLine >> color: anObject [
	color := anObject
]

{ #category : #drawing }
EzLine >> drawOn: aCanvas [
	aCanvas 
		line: self startPoint 
		to: self endPoint 
		width: self width 
		color: self color
]

{ #category : #accessing }
EzLine >> endPoint [
	^ endPoint
]

{ #category : #accessing }
EzLine >> endPoint: anObject [
	endPoint := anObject
]

{ #category : #interacting }
EzLine >> position [
	^self startPoint
]

{ #category : #accessing }
EzLine >> startPoint [
	^ startPoint
]

{ #category : #accessing }
EzLine >> startPoint: anObject [
	startPoint := anObject
]

{ #category : #accessing }
EzLine >> width [
	^ width
]

{ #category : #accessing }
EzLine >> width: anObject [
	width := anObject
]
